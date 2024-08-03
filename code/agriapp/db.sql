create table if not exists public.users (
  id uuid references auth.users on delete cascade not null primary key,
  frist_name varchar(20) not null unique,
  last_name varchar(20) not null unique,
  avater_url text,

  constraint username_validation check (char_length(name) >= 1)
);
comment on table public.users is 'Holds all of users profile information';

alter table public.users enable row level security;
create policy "Public profiles are viewable by everyone." on public.users for select using (true);
create policy "Can insert user" on public.users for insert with check (auth.uid() = id);
create policy "Can update user" on public.users for update using (auth.uid() = id) with check (auth.uid() = id);
create policy "Can delete user" on public.users for delete using (auth.uid() = id);


-- Configure storage
insert into storage.buckets (id, name) values ('profiles', 'profiles');
create policy "Profiles buckets are public" on storage.objects for select using (bucket_id = 'profiles');
create policy "uid has to be the first element in path_tokens" on storage.objects for insert with check (auth.uid()::text = path_tokens[1] and array_length(path_tokens, 1) = 2);
update storage.buckets set public = true where id = 'profiles';
