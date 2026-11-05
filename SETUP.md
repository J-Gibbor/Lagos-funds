# LagosLife login + admin dashboard

This project uses HTML, CSS, Bootstrap 5, vanilla JavaScript and Supabase Auth/database.
It is a real authentication starter, not a localStorage-only mock-up.

## 1. Create a Supabase project
1. Open https://supabase.com and create a project.
2. In Project Settings → API, copy the Project URL and the `anon` / publishable key.
3. Open `js/config.js` and replace `https://YOUR-PROJECT.supabase.co` and `YOUR_SUPABASE_ANON_KEY`.
   Never paste a `service_role` key into this website.

## 2. Create the database
1. In Supabase, open SQL Editor → New query.
2. Open `sql/schema.sql` from this project.
3. Copy all its contents into the SQL Editor and click Run.

## 3. Make your account an administrator
1. Open the website and register using your own email.
2. Confirm your email if Supabase asks you to.
3. In Supabase → SQL Editor, run this command after replacing the email:
   ```sql
   update public.profiles
   set role = 'admin'
   where id = (select id from auth.users where email = 'obojohnson60@yahoo.com');
   ```
4. Sign out and sign in again. The Admin dashboard will appear.

## 4. Run locally
Use VS Code Live Server, or from the project folder run:
`python -m http.server 8000`
Then visit http://localhost:8000

## 5. Deploy to Vercel
1. Push the project folder to a GitHub repository.
2. Import the repository into Vercel.
3. Framework Preset: Other. Build command: leave empty. Output Directory: `.`.
4. Deploy. The site entry is `index.html`; admin/member dashboard is `dashboard.html`.

## Security notes
- Passwords are handled by Supabase Auth and are never displayed in the admin dashboard.
- Do not use a client-side hidden URL as the security boundary. The database uses Row Level Security.
- Do not let users choose their own role during registration.
- Only promote trusted accounts to admin from the Supabase SQL Editor.
- For a public production deployment, configure Supabase Auth Site URL and Redirect URLs to include your Vercel domain.
