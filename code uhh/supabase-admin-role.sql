-- Run this in Supabase SQL Editor.
-- This app stores user profile data in public.profiles, so the admin role is checked there.

alter table public.profiles
add column if not exists role text not null default 'user'
check (role in ('admin', 'user'));

-- Prevent browser clients from changing their own role.
-- Admin assignment should be done from Supabase SQL Editor/service role only.
revoke update(role) on table public.profiles from anon, authenticated;

-- Replace this email with the authorized admin email.
update public.profiles
set role = 'admin'
where email = 'admin@example.com';

-- Optional sanity check:
select id, email, full_name, role
from public.profiles
order by role desc, email asc;
