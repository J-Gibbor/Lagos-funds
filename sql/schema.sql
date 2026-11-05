-- Run this in Supabase SQL Editor.
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  role text not null default 'member' check (role in ('member','admin')),
  created_at timestamptz not null default now()
);
alter table public.profiles enable row level security;

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data ->> 'full_name',''));
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();

drop policy if exists "Users can read own profile" on public.profiles;
create policy "Users can read own profile" on public.profiles
for select to authenticated using (auth.uid() = id);

drop policy if exists "Admins can read all profiles" on public.profiles;
create policy "Admins can read all profiles" on public.profiles
for select to authenticated using (
  exists (select 1 from public.profiles me where me.id = auth.uid() and me.role = 'admin')
);

-- Admin-only view. Email is sourced from auth.users; passwords are never exposed.
create or replace view public.admin_user_list
with (security_invoker = true) as
select p.id, p.full_name, p.role, p.created_at, u.email
from public.profiles p
join auth.users u on u.id = p.id;

grant select on public.profiles to authenticated;
grant select on public.admin_user_list to authenticated;

-- After registering your own account, promote it to admin by running:
-- update public.profiles
-- set role = 'admin'
-- where id = (select id from auth.users where email = 'YOUR-EMAIL@example.com');
