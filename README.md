# 🌱 Tanamin Mobile

Aplikasi mobile berbasis **Flutter** untuk pengingat perawatan tanaman yang terintegrasi dengan layanan web **Tanamin (PWS)**, membantu pemula dan pecinta tanaman merawat tanamannya secara konsisten melalui jadwal otomatis dan skor **Jejak Hijau**.

---

## 📖 Deskripsi Aplikasi

**Tanamin** adalah aplikasi pengingat perawatan tanaman berbasis mobile yang membantu pemula *urban farming* dan pecinta tanaman hias agar tidak lagi kehilangan tanaman karena lupa jadwal penyiraman atau pemupukan. Banyak orang mulai tertarik berkebun di rumah, tetapi berhenti di tengah jalan karena tanamannya mati akibat jadwal perawatan yang terlewat—bukan karena kurang niat, melainkan karena tidak adanya sistem pengingat yang disesuaikan dengan kebutuhan tiap jenis tanaman.

Aplikasi Flutter ini menghadirkan akses mobile yang praktis ke seluruh ekosistem Tanamin, memungkinkan pengguna memantau jadwal perawatan harian langsung dari smartphone, mencatat perkembangan tanaman kapan saja, dan mempertahankan konsistensi lewat sistem gamifikasi skor **"Jejak Hijau"**. Aplikasi ini mendukung gaya hidup *Sustainable Living* pada sub-tema **Urban Farming & Biodiversity**.

---

## 👥 Anggota Kelompok

| Nama | NPM |
|---|---|
| Finna Aprilia | 2506538110 |
| Rebeccaniaga Napitupulu | 2506598394 |
| Nicholas | 2506537165 |
| Wien Muhammad Hafizhurrohman | 2506624461 |
| Faiz Kusumadinata | 2406426196 |

---

## 🧩 Daftar Modul & Pembagian Kerja

Berikut adalah daftar modul yang diimplementasikan pada aplikasi Flutter beserta pembagian tanggung jawab masing-masing anggota kelompok:

| No. | Modul | Deskripsi Fungsionalitas | Penanggung Jawab | NPM |
|---|---|---|---|---|
| 1 | **Autentikasi & Profil Pengguna** | Registrasi akun baru, login berbasis sesi/cookie, logout, serta melihat dan memperbarui profil pengguna. | Finna Aprilia | 2506538110 |
| 2 | **Catatan & Jurnal Pribadi (Plant Notes)** | Pencatatan jurnal teks sederhana untuk mendokumentasikan progres pertumbuhan atau kejadian penting pada tiap tanaman. | Rebeccaniaga Napitupulu | 2506598394 |
| 3 | **Jadwal & Pengingat Perawatan** | Mengatur interval penyiraman dan pemupukan per tanaman, tampilan halaman *"Tugas Hari Ini"*, serta pencatatan log riwayat perawatan. | Nicholas | 2506537165 |
| 4 | **Integrasi Public API Data Tanaman** | Pencarian spesies tanaman beserta informasi kebutuhan cahaya & air dari API eksternal, pengisian otomatis rekomendasi jadwal, dan CRUD data tanaman pribadi. | Wien Muhammad Hafizhurrohman | 2506624461 |
| 5 | **Skor Jejak Hijau, Statistik & Admin** | Sistem gamifikasi (skor dan *badge* konsistensi perawatan), tampilan statistik pribadi, serta fitur moderasi data dan pemantauan statistik global untuk Admin. | Faiz Kusumadinata | 2406426196 |

---

## 👤 Peran Pengguna (Aktor)

1. **Pengguna (Member)**
   - Melakukan registrasi dan login ke dalam aplikasi.
   - Menambahkan, mengubah, dan menghapus koleksi tanaman pribadi (baik secara manual maupun dari rekomendasi data tanaman).
   - Melihat daftar jadwal perawatan harian (*Tugas Hari Ini*) dan menandai tugas yang telah selesai.
   - Membuat, membaca, mengedit, dan menghapus catatan jurnal perkembangan tanaman (*Plant Notes*).
   - Memantau skor **Jejak Hijau**, *badge*, serta statistik konsistensi perawatan pribadi.


---

## 🔄 Alur Pengintegrasian Data (Flutter ↔ Django PWS)

Aplikasi mobile **Tanamin (Flutter)** terhubung langsung dengan situs web **Tanamin** dari Proyek Tengah Semester (PTS) yang di-deploy pada **PWS (Pacil Web Service)** menggunakan arsitektur *client-server* melalui **Web Service Django / Django REST Framework (DRF)** dengan pertukaran data berformat **JSON**.

### 1. Mekanisme Autentikasi & Manajemen Sesi (`pbp_django_auth`)
- Aplikasi Flutter menggunakan paket `pbp_django_auth` (`CookieRequest`) untuk berkomunikasi dengan *endpoint* autentikasi pada server Django di PWS.
- Saat pengguna melakukan **Login** atau **Register** di Flutter, aplikasi mengirimkan kredensial melalui HTTP `POST` ke *endpoint* autentikasi Django (misalnya `/auth/login/` atau `/api/auth/login/`).
- Server Django memvalidasi kredensial dan mengembalikan respons JSON beserta *session cookie* (`sessionid` dan `csrftoken`).
- `CookieRequest` menyimpan *cookie* sesi tersebut secara lokal di perangkat sehingga setiap permintaan HTTP berikutnya otomatis menyertakan identitas dan hak akses pengguna (*Member* atau *Admin*).

### 2. Pertukaran Data CRUD (JSON Serialization)
- **Pengambilan Data (`GET`):** Saat membuka halaman daftar tanaman, jadwal hari ini, catatan (*Plant Notes*), atau statistik skor Jejak Hijau, aplikasi Flutter mengirimkan permintaan HTTP `GET` ke *endpoint* JSON/DRF di server PWS. Server mengembalikan respons JSON yang kemudian di-*parse* menjadi objek model Dart (menggunakan `fromJson`).
- **Pembuatan, Pembaruan, & Penghapusan Data (`POST` / `PUT` / `DELETE`):** Saat pengguna menambah tanaman baru, menandai jadwal siram/pupuk selesai, atau menulis catatan jurnal, Flutter mengonversi input pengguna menjadi payload JSON (`toJson`) dan mengirimkannya ke *endpoint* terkait di Django. Server memvalidasi data, memperbarui basis data, menghitung ulang skor **Jejak Hijau** jika relevan, dan mengembalikan status keberhasilan beserta data terbaru dalam format JSON.

### 3. Integrasi Data Spesies Tanaman (Public API)
- Untuk modul pencarian jenis tanaman, aplikasi Flutter mengakses *endpoint* pencarian pada backend Django PWS (yang bertindak sebagai *proxy* maupun penyedia data *seeding* dari **Perenual Plant API**).
- Hasil pencarian berupa informasi kebutuhan air dan cahaya dikirimkan dalam format JSON ke Flutter untuk mengisi formulir jadwal perawatan tanaman secara otomatis.

### 4. Sinkronisasi Lintas Platform
- Karena aplikasi Flutter dan situs web Tanamin di PWS mengakses **basis data dan backend Django yang sama**, setiap perubahan data yang dilakukan melalui aplikasi mobile (seperti menyelesaikan jadwal penyiraman atau menambah catatan baru) akan langsung tersinkronisasi dan terlihat secara *real-time* ketika pengguna membuka situs web Tanamin di browser, begitu pula sebaliknya.

---

## 🎨 Desain Antarmuka (Figma)

Tautan desain UI/UX aplikasi mobile Tanamin dapat diakses melalui Figma berikut:
- 🔗 **[Desain Figma Tanamin Mobile]**
