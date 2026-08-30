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
  created_at   timestamptz default now()          -- ເວລາທີ່ແຈ້ງເຫດ
);

-- ຖ້າເຄີຍສ້າງຕາຕະລາງແລ້ວ (ບໍ່ມີ column category) ໃຫ້ເພີ່ມ column ນີ້:
alter table public.requests add column if not exists category text default 'request';

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

-- ອະນຸຍາດໃຫ້ອັບເດດ (UPDATE) — ໃຊ້ສຳລັບປຸ່ມ "ໝາຍວ່າຊ່ວຍເຫຼືອແລ້ວ"
drop policy if exists "public can update requests" on public.requests;
create policy "public can update requests"
  on public.requests for update
  to anon, authenticated
  using (true)
  with check (true);

-- ໝາຍເຫດ: ບໍ່ໄດ້ເປີດ DELETE ໃຫ້ anon ເພື່ອປ້ອງກັນຄົນລົບຂໍ້ມູນຄົນອື່ນ
--         ຖ້າຕ້ອງການໃຫ້ admin ລົບ/ຈັດການເຕັມ ໃຫ້ໃຊ້ service_role key ຫຼື ສ້າງ policy ເພີ່ມຕາມສິດ
