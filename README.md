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
| `index.html` | ຕົວເວັບແອັບ (ໄຟລ໌ດຽວ) |
| `supabase_schema.sql` | SQL ສ້າງຕາຕະລາງ `requests` |
| `start-server.bat` | ເປີດ local web server ສຳລັບທົດລອງ |

## 📄 License

MIT
