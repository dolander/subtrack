create table if not exists public.subtrack_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.subtrack_data enable row level security;
create policy "read own subscriptions" on public.subtrack_data for select to authenticated using ((select auth.uid()) = user_id);
create policy "insert own subscriptions" on public.subtrack_data for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "update own subscriptions" on public.subtrack_data for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
grant select, insert, update on public.subtrack_data to authenticated;
