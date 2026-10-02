# Wildroot — agenda kerja dan belajar

Diperbarui 2026-10-01. Pair Mode menjadi default. Rancangan besar ada di `WILDROOT_GAME_DESIGN.md`; alasan eksperimen ada di `DESIGN_REVIEW.md`. Dokumen ini menjadi satu tempat untuk target aktif, status tugas, dan langkah sesi berikutnya.

## Posisi sekarang

Gerakan dan animasi dasar sudah ada; pemilik melaporkan WASD bekerja. Pemahaman kode dan collision belum dinyatakan selesai. Verifikasi Godot Windows dan onboarding MiniMax selesai dengan batas pemeriksaan di `PROJECT_CONTEXT.md`. Ekologi dan modul di bawah belum diimplementasikan atau diuji pemain.

Arah kerja awal: buktikan satu petak hutan sebelum memperluas isi Prototype 0.1. Aturan rinci serta angka balance tetap hipotesis yang boleh berubah.

## Sprint pribadi

Satu sprint berisi satu tujuan kecil. Untuk percobaan pertama, gunakan **tiga sesi kerja lalu review**, meskipun target belum selesai. Panjang sesi mengikuti waktu pemilik; tiga sesi adalah ritme awal yang boleh disesuaikan, bukan janji durasi pengerjaan.

1. Awal sprint: pilih hasil yang bisa dimainkan, konsep yang dipelajari, dan bagian yang ditulis/dibuat pemilik.
2. Kerjakan satu tugas aktif. Status: Siap → Dikerjakan → Review → Selesai. Gunakan Terhambat bila ada kendala dan tulis penyebabnya.
3. Awal sesi: baca handoff, cek kondisi file, pilih satu langkah sesuai waktu tersedia.
4. Codex menjelaskan bagian yang relevan; pemilik mencoba. Jika macet, mulai dengan petunjuk, lalu contoh kecil atau perbaikan yang dijelaskan.
5. Akhir sesi: jalankan hasil, catat satu pengamatan dan satu langkah berikutnya. Codex membantu memperbarui status berdasarkan bukti.
6. Setelah tiga sesi: mainkan hasil dan tinjau pemahaman/kendala. Pilih melanjutkan sisa target, mengecilkannya, atau memperbaiki desain. Tugas belum selesai tidak otomatis lulus.

Tidak perlu daily meeting, story point, velocity, dashboard, atau laporan terpisah per sesi. Git menyimpan riwayat perubahan; tabel ini menyimpan pekerjaan saat ini. MiniMax digunakan untuk ketidakpastian penting setelah ada bahan konkret, bukan sebagai gerbang setiap tugas.

## Peta modul

Modul adalah hasil belajar dan game; satu modul dapat membutuhkan beberapa sprint. Hanya modul aktif yang dirinci menjadi tugas. Urutan ini rencana awal, bukan kontrak fitur atau tanggal rilis.

| Modul | Hasil yang bisa dimainkan | Konsep utama | Bukti untuk maju |
| --- | --- | --- | --- |
| M1 — Petak hutan dan berry | Bergerak, tertahan batu, memetik semak dari dekat | Scene/node, collision, InputMap, Area2D, signal, fungsi, kondisi | Interaksi dekat/jauh dan pemetikan ulang sesuai aturan; pemilik menjelaskan alurnya |
| M2 — Hari dan pertumbuhan | Majukan hari; berry tumbuh kembali | State, variabel, fungsi pembaruan, batas nilai | Satu pergantian hari memicu satu pembaruan; pemilik memprediksi satu aturan |
| M3 — Hubungan ekologi | Wolf/rabbit/berry saling memengaruhi dan perubahan terlihat | Populasi sederhana, snapshot, data dan tampilan, catatan pengamatan | Pemain melihat akibat dan mencoba tindakan kedua berdasarkan dugaan; kebutuhan petunjuk dicatat |
| M4 — Pilihan dan pemulihan | Dua tujuan membuat keadaan berbeda berguna; keadaan bisa dipulihkan | Trade-off, reward kecil, aturan pemulihan | Tujuan memengaruhi strategi; tidak ada kebuntuan yang tidak disengaja |
| M5 — Pertarungan sebagai intervensi | Satu serangan dan satu makhluk terhubung dengan ekologi | HP, hitbox/hurtbox, damage, perilaku, umpan balik | Satu hasil perburuan memberi satu dampak ekologis; serangan terbaca |
| M6 — Sawah percobaan | Rice/pest/fish membentuk hubungan yang bisa dimanfaatkan | Pemakaian ulang aturan, habitat sederhana, petunjuk | Pemain menggunakan cara berpikir dari hutan pada sawah |

Slime, jamur, anomali, boss, peta tambahan, dan produksi art besar ditinjau setelah bukti modul relevan tersedia. Save kecil masuk ketika perlu melanjutkan eksperimen antarsesi.

## Keresahan desain → jawaban sementara → pembuktian

Tabel ini menghubungkan temuan review ke modul. Semua jawaban di bawah masih **hipotesis belum diuji**; pencantuman di modul tidak berarti masalah sudah selesai. Pemilik menentukan keputusan desain akhir. Jika hasil berbeda dari dugaan, revisi jawaban atau percobaannya sebelum memperluas sistem terkait.

| ID / keresahan | Jawaban awal yang dicoba | Modul / kapan | Bukti yang dicari |
| --- | --- | --- | --- |
| R1 — Apa yang menarik dilakukan pemain? | Mulai dengan memetik berry; kemudian beri tujuan memperoleh berry saat jumlahnya menurun sehingga pemain perlu memilih intervensi. | M1 memberi fondasi; M3–M4 menguji keputusan | Pemain bisa menyebut tujuan, alasan tindakan, dan tindakan berikutnya. Berhasil memetik saja belum membuktikan ekologi menarik. |
| R2 — Sebab perubahan tidak terbaca | Tampilkan bekas aktivitas/keadaan semak, perbedaan kemunculan makhluk, dan catatan pengamatan singkat. Bandingkan kondisi awal yang sama dengan dan tanpa intervensi. | M3 | Pemain mengidentifikasi arah hubungan tanpa diberi jawabannya dan memakai dugaan itu pada percobaan kedua. Bila keliru, perbaiki petunjuk sebelum menambah spesies. |
| R3 — Akibat terlalu lama, pemain hanya menunggu | Gunakan transisi hari manual untuk percobaan; beri tanda langsung saat tindakan terjadi dan akibat populasi pada transisi berikutnya sesuai aturan. Bandingkan jeda pendek dan lebih panjang. | M2 menyiapkan waktu; M3 menguji jeda | Catat jumlah transisi sampai perubahan disadari, tindakan saat menunggu, dan apakah penyebab masih diingat. Jeda final dipilih dari hasil, bukan asumsi 3–7 hari. |
| R4 — Satu keadaan selalu paling menguntungkan | Beri dua kebutuhan, misalnya berry dan material perburuan, dengan biaya kesempatan/pemulihan berbeda. Untuk sawah, bandingkan penanganan hama langsung dengan kebutuhan merawat habitat ikan. | M4; diulang pada M6 | Saat tujuan/kondisi berubah, pilihan pemain dapat berubah dengan alasan yang dipahami. Jika satu strategi selalu unggul, revisi biaya/manfaat. |
| R5 — Takut bereksperimen atau dunia buntu | Coba intervensi mengurangi herbivor serta pemulihan predator melalui migrasi yang diberi petunjuk. Tentukan syaratnya saat M4; jangan mengandalkan reset pengembang. | M4 | Dari kondisi buruk termasuk nilai nol, ada jalan pemulihan dalam game yang dapat dipahami; catat usaha/waktunya dan apakah pemain berani mencoba lagi. |
| R6 — Makhluk terlihat tidak cocok dengan populasi / bisa dieksploitasi | Hipotesis awal: 0–100 adalah indeks kelimpahan; node adalah wakilnya. Satu intervensi memberi satu dampak yang ditetapkan, dan menyegarkan tampilan tidak mengubah state. | M3; integrasi perburuan M5 | Dampak tercatat sekali, jumlah/tanda visual sesuai indeks, serta keluar/masuk area tidak menggandakan hasil atau mereset populasi ketika transisi area mulai tersedia. |
| R7 — Jurnal memberi jawaban terlalu cepat atau hanya jadi koleksi | Catat yang benar-benar terlihat, bedakan dari dugaan, sediakan petunjuk bertahap bila diperlukan. Coba mengizinkan keberhasilan eksperimen sebelum entri lengkap; syarat resep diputuskan ketika crafting mulai diperlukan. | M3 untuk observasi; M4 untuk kegunaan pengetahuan | Pemain memakai pengamatan untuk prediksi baru; catat bantuan yang dibutuhkan. Klik jurnal saja tidak dihitung sebagai pemahaman. |
| R8 — Hubungan vegetasi turun → jamur naik terasa sewenang-wenang | Kandidat: perantara sisa organik dan kelembapan memberi peluang jamur. Pilih satu aturan fantasi yang konsisten, lalu perlihatkan perantaranya. | Ditunda; wajib ditinjau sebelum modul slime/jamur disusun | Pemain mengenali kondisi yang diperlukan dan memprediksi peluang jamur. Jangan langsung menganggap vegetasi rendah selalu menghasilkan jamur. |
| R9 — Anomali/boss menjadi mesin reward berulang | Kandidat: mengalahkan boss tidak otomatis mereset ekologi; kemunculan ulang memerlukan rangkaian perubahan/kondisi baru yang terbaca. Nilai alternatif sebelum implementasi. | M4 menguji reward kecil; aturan lengkap ditunda sampai sebelum anomali/boss | Uji pemicu/reward sederhana dahulu: mengulang aksi tanpa memenuhi ulang syarat tidak memberi reward baru; biaya mengubah/menjaga kondisi tetap bermakna. |

Risiko scope ditangani lewat satu petak dan perincian hanya modul aktif. Pada review sprint, lihat beban nyata sebelum menambah isi. Skala art diuji dengan aset saat ini pada M1 sebelum produksi besar; arsitektur dan save bertambah ketika kebutuhan implementasi muncul. Ini tindakan pembatasan awal, bukan bukti bahwa seluruh rencana 1.0 sudah layak diproduksi.

Saat modul dimulai, pilih keresahan terkait dan ubah pengujiannya menjadi tugas konkret. Saat ditinjau, isi satu catatan di bawah; bila belum diuji, tetap nyatakan belum diuji. R8/R9 tidak boleh hilang hanya karena berada di luar enam modul awal.

**Catatan bukti saat ini:** belum ada playtest ekologi. Format untuk catatan nyata nanti: ID keresahan → situasi/tindakan → pengamatan → tetap/revisi hipotesis → percobaan berikutnya. Catatan dapat diganti dengan ringkasan terbaru; keputusan yang bertahan dicatat di `DECISIONS.md`.

## Sprint 01 — Satu interaksi nyata di hutan

**Status: siap dimulai.** Belum ada tugas modul yang selesai.

Tujuan: pemain berjalan di petak hutan, tertahan satu batu, lalu memetik berry dari dekat. Ini menyediakan tempat dan tindakan dasar untuk eksperimen ekologi.

Aturan sementara M1: satu semak berisi satu hasil panen; tombol interaksi bekerja dari dekat; semak kosong tidak bisa dipanen lagi pada sesi yang sama. Pertumbuhan ulang masuk M2. Kontrol dipilih saat mengatur InputMap. Gunakan aset yang ada atau placeholder; ukuran art akhir belum diputuskan.

| ID | Tugas dan bagian pemilik | Peran Codex | Bukti selesai | Status |
| --- | --- | --- | --- | --- |
| M1-01 | Telusuri input → velocity → gerak; susun penanda/petak hutan di editor | Tunjukkan node/file dan jelaskan alur script yang ada | Gerak terlihat relatif terhadap penanda; pemilik menjelaskan pengaruh speed | Siap |
| M1-02 | Buat batu dengan StaticBody2D dan shape; atur posisi/ukuran | Jelaskan bentuk visual vs fisik; bantu debug | Pemain tertahan dari beberapa arah dan bergeser saat bergerak menyerong | Siap |
| M1-03 | Susun scene semak; tulis kondisi jarak/isi dan fungsi interaksi bertahap | Bantu InputMap/signal; review percobaan pemilik | Dekat bisa memetik, jauh tidak; semak menunjukkan kosong; tekan ulang tidak menggandakan hasil | Siap |
| M1-04 | Mainkan kasus di atas, jelaskan satu jalur aksi, dan catat kebingungan | Verifikasi sesuai perubahan, review diff, bantu checkpoint | Bukti manual tercatat; error relevan ditangani; perubahan utama dipahami | Siap |

Agenda awal: sesi 1 menargetkan M1-01/02; sesi 2 memulai M1-03; sesi 3 melanjutkan lalu mengevaluasi M1-04. Jika belum selesai, review tetap dilakukan dan sisanya direncanakan ulang. Kecilkan langkah untuk sesi pendek.

### Mulai sekarang — langkah pertama M1-01

Tidak ada blocker setup yang teridentifikasi untuk langkah ini. Sasaran satu langkah pendek: tambahkan satu penanda cokelat, jalankan game, dan lihat gerak karakter relatif terhadapnya.

- Buka `scenes/main.tscn`. Pemain saat ini mulai di (320, 180), dengan kamera mengikuti dan zoom 2. Latar polos membuat gerak relatif sulit dilihat.
- Buat `ColorRect` sebagai anak `Main`, sejajar dengan `Player`, beri nama `RockMarker`, posisi (400, 180), ukuran (32, 32), dan warna cokelat. Ini placeholder visual yang dibuat pemilik; collision ditambahkan pada M1-02.
- Untuk M1, cukup rencanakan satu batu di kanan pemain dan satu semak di kiri sekitar (240, 180). Ukuran peta penuh belum perlu diputuskan; jumlah objek ini adalah scope latihan, bukan populasi ekologi.
- Simpan dan jalankan game. Bergerak mendekati serta menjauhi penanda. Amati gerak relatif meskipun kamera mengikuti pemain.
- Tulis satu pengamatan singkat sebelum menandai tugas selesai. Belum ada hasil langkah ini yang dilaporkan.

Review tambahan tidak menunda langkah tersebut. Saran save sejak M1, migrasi folder, dan keputusan scope rilis tidak menjadi prasyaratnya. Handoff di dokumen ini sudah menyimpan posisi kerja antar sesi; file session state terpisah tidak diperlukan saat ini.

## Agenda sesuai waktu

| Waktu | Pembagian perhatian |
| --- | --- |
| 30 menit | 3 orientasi + 5 penjelasan + 15 mencoba satu langkah + 5 menjalankan hasil + 2 handoff |
| 60 menit | 5 orientasi + 10 penjelasan + 30 implementasi + 10 main/review + 5 handoff |
| 120 menit | 10 orientasi + 15 konsep + 35 mencoba + 10 istirahat + 30 melanjutkan + 15 main/review + 5 handoff |

Ini panduan, bukan pengukur kemampuan. Bila bingung, kecilkan langkah. Art boleh menjadi sesi tersendiri ketika aset diperlukan; pemilik menggambar di Aseprite dan memeriksa hasil di Godot.

### Latihan art pertama — batu untuk petak hutan

Pemilik ingin belajar menggambar sambil membuat hasil game yang menarik untuk dilanjutkan. Gunakan latihan ini pada M1 bila ingin memulai dari art: buat canvas transparan 32×32 di Aseprite, gambar satu batu dengan tiga warna (dasar, sisi terang, sisi gelap), lalu periksa apakah bentuknya terbaca pada zoom 100%. Canvas ini ukuran latihan, bukan keputusan skala final seluruh game.

Batasi latihan awal sekitar 10–15 menit; waktu tersebut panduan agar tidak terjebak merapikan detail. Simpan sumber sebagai `assets/sprites/rock_test.aseprite` dan ekspor PNG `assets/sprites/rock_test.png`. Setelah pemilik membuatnya, pandu pemasangan `Sprite2D` sebagai anak Main di sekitar (400, 180) untuk menggantikan placeholder visual bila ada. Periksa hasil dalam game sebelum menambah collision pada M1-02.

Konsep art pertama: siluet dan arah cahaya. Hasil yang dicari: pemilik mengenali batu buatannya di dunia game. Codex memberi petunjuk dan kritik berdasarkan gambar aktual; aset, keterampilan, dan hasil pengujian belum dinyatakan selesai. Latihan berikutnya mengikuti kebutuhan game (semak/berry, variasi lingkungan, kemudian animasi).

## Arti selesai

- Perilaku memenuhi bukti selesai di tabel dengan pemeriksaan otomatis/manual yang sesuai.
- Pemilik mengerjakan bagian bermakna dan dapat menjelaskan atau memprediksi satu akibat dari logika yang diubah; tidak perlu menghafal seluruh kode.
- Perubahan direview, kendala tersisa disebutkan, dan langkah berikutnya dicatat.
- Implementasi yang bekerja belum membuktikan desain menyenangkan. Jika membingungkan pemain, revisi petunjuk/aturan sebelum menambah fitur.
- Untuk modul yang menguji desain, tinjau ID keresahan terkait: sebutkan bukti yang didapat atau tandai masih terbuka. Jangan menganggap masalah terjawab hanya karena fiturnya selesai dibuat.

Catatan playtest cukup: situasi/tindakan → yang terlihat → dugaan → percobaan berikutnya. Jangan menulis hasil sebelum dimainkan. Keputusan penting beserta alasan masuk `DECISIONS.md`; pengaturan angka sementara tetap dekat kode.

## Handoff

- **Berikutnya: M1-01.** Buka `scenes/main.tscn` dan `scripts/player.gd`; telusuri bagaimana W menghasilkan gerak, lalu susun penanda lingkungan agar gerak mudah dilihat.
- Pemilik menyusun penanda/petak di editor dan menjelaskan satu pengaruh speed. Codex memandu langkah kecil dan memeriksa hasil.
- Pilihan awal yang sesuai minat art: kerjakan latihan batu di atas lalu pasang hasilnya sebagai penanda dunia. Gerakan pemain yang sudah ada tetap dipakai sebagai fondasi.
- Belum ada pengamatan belajar atau playtest modul yang dicatat.
- GitHub publication dan handoff Mac tetap terpisah dan belum diverifikasi; tidak menghalangi sesi belajar Windows.
