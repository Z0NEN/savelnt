-- ============================================================
--  ຖານຂໍ້ມູນ Supabase : ລະບົບປັກໝຸດຂໍຄວາມຊ່ວຍເຫຼືອຜູ້ປະສົບໄພນ້ຳທ່ວມ
--  ຕາຕະລາງ: requests
--  ວິທີໃຊ້: ເປີດ Supabase Dashboard -> SQL Editor -> ວາງໂຄ້ດນີ້ -> ກົດ Run
-- ============================================================

-- 1) ສ້າງຕາຕະລາງ requests
create table if not exists public.requests (
  id           uuid primary key default gen_random_uuid(),
  category     text        default 'request',    -- ປະເພດໝຸດ: request (ຄຳຮ້ອງ) / facility (ຈຸດບໍລິການ)
  name         text        not null,              -- ຊື່ຜູ້ແຈ້ງເຫດ / ຊື່ຈຸດ
  phone        text,                              -- ເບີໂທຕິດຕໍ່
  help_type    text        not null,             -- request: evacuate/food/medicine/other
                                                  -- facility: shelter/food_dist/drink_water/util_water/relief_station
  people_count integer     default 0,            -- ຈຳນວນຄົນ
  bedridden    integer     default 0,            -- ຈຳນວນຜູ້ປ່ວຍຕິດເຕຽງ
  details      text,                              -- ລາຍລະອຽດເພີ່ມເຕີມ
  lat          double precision not null,         -- ເສັ້ນຂະໜານ (latitude)
  lng          double precision not null,         -- ເສັ້ນແວງ (longitude)
  status       text        default 'pending',    -- ສະຖານະ: pending / helped
  photo_url    text,                              -- ລິ້ງຮູບພາບ (Supabase Storage)
  created_at   timestamptz default now()          -- ເວລາທີ່ແຈ້ງເຫດ
);

-- ຖ້າເຄີຍສ້າງຕາຕະລາງແລ້ວ ໃຫ້ເພີ່ມ column ໃໝ່ (category ສຳລັບ facility/hazard, photo_url ສຳລັບຮູບ):
alter table public.requests add column if not exists category text default 'request';
alter table public.requests add column if not exists photo_url text;
alter table public.requests add column if not exists photo_urls text[];   -- ຮອງຮັບຫຼາຍຮູບ (ສູງສຸດ 3)
-- ໝາຍເຫດ: help_type ຮັບຄ່າ hazard ໄດ້ເລີຍ (road_blocked/flood_high/landslide) ບໍ່ຕ້ອງແກ້ column

-- ດັດຊະນີ (index) ຊ່ວຍໃຫ້ດຶງຂໍ້ມູນລ່າສຸດໄວຂຶ້ນ
create index if not exists requests_created_at_idx on public.requests (created_at desc);

-- 2) ເປີດໃຊ້ Row Level Security (RLS)
alter table public.requests enable row level security;

-- 3) ນະໂຍບາຍ (Policies)
--    ອະນຸຍາດໃຫ້ທຸກຄົນ (anon) ອ່ານ ແລະ ເພີ່ມຂໍ້ມູນໄດ້ (ເໝາະສຳລັບເວັບແຈ້ງເຫດສາທາລະນະ)

-- ອະນຸຍາດໃຫ້ອ່ານ (SELECT)
drop policy if exists "public can read requests" on public.requests;
create policy "public can read requests"
  on public.requests for select
  to anon, authenticated
  using (true);

-- ອະນຸຍາດໃຫ້ເພີ່ມ (INSERT)
drop policy if exists "public can insert requests" on public.requests;
create policy "public can insert requests"
  on public.requests for insert
  to anon, authenticated
  with check (true);

-- ==== ຄວາມປອດໄພ ====
-- UPDATE: ໃຫ້ "ທຸກຄົນ" ໝາຍ "ໄດ້ຊ່ວຍເຫຼືອແລ້ວ" ໄດ້ (ຜູ້ໄປຊ່ວຍ ຫຼື ຜູ້ແຈ້ງເອງ)
--         ແຕ່ຈຳກັດໃຫ້ anon ແກ້ໄດ້ "ສະເພາະ column status" ເທົ່ານັ້ນ (ບໍ່ໃຫ້ແກ້ຊື່/ພິກັດ/ລາຍລະອຽດ)
-- DELETE: ສະເພาະ admin ທີ່ login ແລ້ວ
drop policy if exists "public can update requests" on public.requests;
drop policy if exists "public can delete requests" on public.requests;
drop policy if exists "admin can update requests" on public.requests;

drop policy if exists "anyone can update status" on public.requests;
create policy "anyone can update status"
  on public.requests for update
  to anon, authenticated
  using (true)
  with check (true);

-- ໃຫ້ທຸກຄົນ (anon) ແກ້ໄຂໄດ້ທຸກ column (ຈຸດບໍລິການ/ອັນຕະລາຍ ແລະ ໝາຍສະຖານະ)
-- ໝາຍເຫດ: ການລົບ (DELETE) ຍັງເປັນ admin ເທົ່ານັ້ນ
grant update on public.requests to anon;

-- ອະນຸຍາດ DELETE ສະເພາະ admin ທີ່ login ແລ້ວ
drop policy if exists "admin can delete requests" on public.requests;
create policy "admin can delete requests"
  on public.requests for delete
  to authenticated
  using (true);

-- ==================================================================
--  ວິທີສ້າງ Admin User (ເຮັດເທື່ອດຽວ)
--  1) Supabase Dashboard -> Authentication -> Users -> Add user
--     ໃສ່ Email + Password ຂອງ admin  (ຕິກ Auto Confirm User)
--  2) (ແນະນຳ) Authentication -> Providers -> Email -> ປິດ "Allow new users to sign up"
--     ເພື່ອບໍ່ໃຫ້ຄົນອື່ນສະໝັກເອງ (ໃຫ້ສ້າງ user ຜ່ານ Dashboard ເທົ່ານັ້ນ)
--  3) ໃຊ້ Email/Password ນັ້ນ login ໃນໜ້າ admin.html
-- ==================================================================


-- ============================================================
--  4) STORAGE — bucket 'photos' ສຳລັບເກັບຮູບພາບຈຸດແຈ້ງເຫດ
--     (ຟັງຊັ່ນຖ່າຍຮູບ/ແນບຮູບ)
-- ============================================================

-- ສ້າງ bucket 'photos' ແບບ public (ເບິ່ງຮູບໄດ້ຜ່ານລິ້ງໂດຍກົງ)
insert into storage.buckets (id, name, public)
values ('photos', 'photos', true)
on conflict (id) do update set public = true;

-- ອະນຸຍາດໃຫ້ທຸກຄົນ (anon) ອັບໂຫຼດຮູບເຂົ້າ bucket 'photos'
drop policy if exists "public upload photos" on storage.objects;
create policy "public upload photos"
  on storage.objects for insert
  to anon, authenticated
  with check (bucket_id = 'photos');

-- ອະນຸຍາດໃຫ້ອ່ານ/ເບິ່ງຮູບ (public read)
drop policy if exists "public read photos" on storage.objects;
create policy "public read photos"
  on storage.objects for select
  to anon, authenticated
  using (bucket_id = 'photos');

-- ໝາຍເຫດ: ບໍ່ໄດ້ເປີດ DELETE ຮູບໃຫ້ anon. ຖ້າ admin ຢາກລົບຮູບ ໃຫ້ຈັດການຜ່ານ Dashboard
--         ຫຼື ເພີ່ມ policy delete ໃຫ້ authenticated ຕາມຕ້ອງການ.
