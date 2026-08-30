# 🚨 Save LNT — ລະບົບແຈ້ງເຫດຂໍຄວາມຊ່ວຍເຫຼືອຜູ້ປະສົບໄພນ້ຳທ່ວມ

ເວັບແອັບແຜນທີ່ສຳລັບປັກໝຸດຂໍຄວາມຊ່ວຍເຫຼືອ ແລະ ຈຸດບໍລິການ ໃນເຫດການໄພນ້ຳທ່ວມ — ໜ້າເວັບເປັນ **ພາສາລາວ** ທັງໝົດ.

## ✨ ຄຸນສົມບັດ (Features)

- 🗺️ ແຜນທີ່ Leaflet (OpenStreetMap) — Responsive ເໝາະກັບມືຖື
- 📡 ດຶງພິກັດ GPS ປັດຈຸບັນ ຫຼື ແຕະເລືອກຈຸດເທິງແຜນທີ່
- 🆘 **ຄຳຮ້ອງຂໍຄວາມຊ່ວຍເຫຼືອ** (ແບ່ງສີຕາມຄວາມເລ່ງດ່ວນ): ອົບພະຍົບດ່ວນ, ອາຫານ/ນ້ຳດື່ມ, ຢາ/ເວຊະພັນ, ອື່ນໆ
- 📍 **ຈຸດບໍລິການ**: ຈຸດພັກພິງ 🏠, ຈຸດແຈກອາຫານ 🍚, ຈຸດແຈກນ້ຳດື່ມ 🚰, ຈຸດແຈກນ້ຳໃຊ້ 🪣, ຈຸດປະຈຳການຊ່ວຍເຫຼືອ ⛑️
- 🔎 ກັ່ນຕອງໝຸດຕາມປະເພດ (filter chips)
- ✅ ປຸ່ມ "ໝາຍວ່າຊ່ວຍເຫຼືອແລ້ວ" ໃນ popup
- 💾 ຖານຂໍ້ມູນ Supabase (insert / select / update)

## 🛠️ Tech Stack

HTML5, CSS3, Vanilla JavaScript, [Leaflet.js](https://leafletjs.com/), [Supabase](https://supabase.com/)

## 🚀 ວິທີໃຊ້ງານ

1. ສ້າງ Project ໃນ [Supabase](https://supabase.com) → SQL Editor → Run ໄຟລ໌ `supabase_schema.sql`
2. ເປີດ `index.html` ໃສ່ຄ່າ `SUPABASE_URL` ແລະ `SUPABASE_ANON_KEY` (Project Settings → API)
3. Deploy ຂຶ້ນ [Vercel](https://vercel.com) (import repo ນີ້) ຫຼື host ໃສ່ບ່ອນໃດກໍໄດ້

> ⚠️ ໝາຍເຫດ: ປຸ່ມ GPS ໃຊ້ໄດ້ສະເພາະເວັບທີ່ເປັນ **HTTPS** ຫຼື localhost ເທົ່ານັ້ນ.

## 📁 ໄຟລ໌

| ໄຟລ໌ | ລາຍລະອຽດ |
|------|----------|
| `index.html` | ຕົວເວັບແອັບແຜນທີ່ (ໜ້າຫຼັກ) |
| `admin.html` | ໜ້າຈັດການ Admin (ອັບເດດສະຖານະ / ລົບ / ຄົ້ນຫາ) |
| `supabase_schema.sql` | SQL ສ້າງຕາຕະລາງ `requests` + policies |
| `start-server.bat` | ເປີດ local web server ສຳລັບທົດລອງ |

## 🛠️ ໜ້າ Admin (`admin.html`) — ໃຊ້ Supabase Auth ຈິງ

ເປີດຈາກປຸ່ມ **🛠️ Admin** ເທິງໜ້າແຜນທີ່. ໃສ່ຄ່າ `SUPABASE_URL`, `SUPABASE_ANON_KEY` (ດຽວກັນກັບ `index.html`). Admin ຕ້ອງ **login ດ້ວຍ Email/ລະຫັດຜ່ານ** ຈຶ່ງຈັດການໄດ້: ໝາຍ "ຊ່ວຍແລ້ວ", ນຳທາງ (Google Maps), ຄົ້ນຫາ/ກັ່ນຕອງ, ແລະ ລົບໝຸດ.

**ຄວາມປອດໄພ (RLS):** ປະຊາຊົນທົ່ວໄປ (anon) ພຽງແຕ່ **ອ່ານ + ແຈ້ງເຫດ** ໄດ້; ການ **ອັບເດດ/ລົບ** ອະນຸຍາດສະເພາະ admin ທີ່ login ແລ້ວ. ໃນໜ້າແຜນທີ່ ປຸ່ມ "ໝາຍວ່າຊ່ວຍເຫຼືອແລ້ວ" ຈະສະແດງກໍຕໍ່ເມື່ອ admin login ຢູ່ (browser ດຽວກັນ) ເທົ່ານັ້ນ.

**ສ້າງ Admin User (ເຮັດເທື່ອດຽວ):**
1. Supabase Dashboard → **Authentication → Users → Add user** → ໃສ່ Email + Password (ຕິກ *Auto Confirm User*)
2. (ແນະນຳ) Authentication → Providers → Email → ປິດ *Allow new users to sign up*
3. ໃຊ້ Email/Password ນັ້ນ login ໃນ `admin.html`

## 📄 License

MIT
