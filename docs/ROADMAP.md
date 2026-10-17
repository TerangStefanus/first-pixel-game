# Wildroot — agenda kerja dan belajar

Diperbarui 2026-10-08. Pair Mode menjadi default. Rancangan besar ada di `WILDROOT_GAME_DESIGN.md`; alasan eksperimen ada di `DESIGN_REVIEW.md`. Dokumen ini menjadi satu tempat untuk target aktif, status tugas, dan langkah sesi berikutnya.

## Posisi sekarang

Gerakan dan animasi dasar sudah ada; pemilik melaporkan WASD bekerja. Pemahaman kode dan collision belum dinyatakan selesai. Verifikasi Godot Windows dan onboarding MiniMax selesai dengan batas pemeriksaan di `PROJECT_CONTEXT.md`. Ekologi dan modul di bawah belum diimplementasikan atau diuji pemain.

Arah kerja awal: buktikan satu petak hutan sebelum memperluas isi Prototype 0.1. Aturan rinci serta angka balance tetap hipotesis yang boleh berubah.

Pemilik meminta sesi persiapan untuk belajar mekanik, cerita, dan strategi mengenalkan/menjual game, dengan gameplay serta story sama-sama penting. Style visual dikembangkan dari karya dan selera pemilik; referensi dianalisis berdasarkan prinsip, bukan dijadikan gaya wajib.

## Bab cerita sebagai agenda pembangunan dan belajar

Permintaan pemilik, 2026-10-08: cerita berkembang per bab sesuai kebutuhan game, dengan langkah jelas, kebutuhan aset/sistem, serta target belajar. Codex menyusun urutan, menjelaskan dependensi, memberi saran dan review; pemilik menentukan cerita, mencoba implementasi utama, menggambar, serta memainkan hasil. Bantuan eksekusi bertambah saat pemilik kesulitan: petunjuk → contoh kecil → perbaikan bersama yang dijelaskan. Sistem belajar utama tidak dibangun diam-diam oleh AI.

Susun kerangka cerita keseluruhan secara pendek terlebih dahulu: siapa protagonis, apa yang ia inginkan, apa yang menghalangi, bagaimana ekologi/The Root berhubungan dengan konflik, dan arah perubahan karakter atau akhir yang mungkin. Jawaban boleh sementara; jangan tulis semua dialog atau mengunci semua bab. Hanya bab aktif yang dipecah menjadi pekerjaan terperinci.

Peta berikut adalah **urutan kerja usulan, bukan plot atau daftar bab final game**. Bab mengikat pengalaman cerita; modul M1–M6 tetap menjadi paket belajar/implementasi yang bisa dipakai lintas bab. Satu bab tidak harus sama dengan satu sesi atau satu modul.

| Bab kerja | Target cerita dan pengalaman | Kebutuhan game / belajar | Bukti untuk maju |
| --- | --- | --- | --- |
| B0 — Arah dan pembuka | Kerangka pendek cerita keseluruhan dan satu masalah lokal yang membuat pemain ingin bertindak | P0-01/02; motivasi, konflik, tindakan dan konsekuensi; belum memerlukan sistem baru | Pemilik memilih alasan karakter bertindak, tujuan pembuka, dan satu akibat yang ingin diuji |
| B1 — Satu kejadian selesai | Pemain bertemu satu kebutuhan, melakukan satu tindakan, lalu melihat akibat dan tanggapan | M1; M2 bila akibat perlu pergantian hari; interaksi, kondisi/state, dialog singkat, art batu/semak; NPC sementara boleh placeholder | Awal → tindakan → akibat → tanggapan dapat dimainkan; pemilik memahami kode utama; dua pendekatan penuh belum wajib |
| B2 — Pilihan dengan akibat | Petunjuk cerita membantu pemain mencoba pendekatan lain terhadap masalah ekologi | M3/M4; hubungan sederhana, dua pendekatan, feedback dan pemulihan; kebutuhan detail ditentukan setelah B1 | Pemain memahami alasan pilihan dan mengamati keadaan berbeda; catat jika petunjuk membingungkan |
| B3 — Tantangan dan intervensi | Uji satu momen menegangkan yang terhubung dengan konflik, petunjuk dan akibat | M5; satu ancaman/serangan dan cara menghadapi situasi; aturan risiko dipilih pemilik | Pemilik memainkan dan menilai ketegangan, keterbacaan, serta peluang mencoba lagi |
| B4 — Perluasan setelah bukti | Uji apakah prinsip yang dipelajari menarik di situasi baru | Kandidat M6 atau kelanjutan konflik; pilih berdasarkan hasil bab sebelumnya | Perluasan punya alasan cerita dan gameplay; bila inti belum menarik, revisi bab sebelumnya dahulu |

Untuk setiap bab aktif, isi satu kartu singkat di roadmap ini: tujuan cerita; tindakan pemain dan akibat; hasil minimum yang bisa dimainkan; kebutuhan kode/art; satu atau dua konsep belajar pada tugas aktif; bagian pemilik dan bantuan Codex; bukti selesai; pertanyaan desain yang masih terbuka. Tandai usulan, keputusan pemilik, implementasi, dan hasil playtest secara berbeda. Jangan menganggap bab selesai hanya karena semua kode berjalan.

**Tugas aktif berikutnya: B0-01 / P0-01.** Pemilik menulis lima jawaban kasar: (1) siapa tokoh yang dimainkan, (2) apa yang ia inginkan, (3) masalah pertama yang ia hadapi, (4) tindakan pertama pemain, (5) perasaan yang ingin muncul. Jika belum tahu, tulis “belum tahu”; Codex menawarkan pilihan beserta konsekuensinya. Hasilnya adalah kerangka pembuka untuk ditinjau bersama, bukan naskah final. Setelah cukup jelas untuk satu tindakan, lanjut M1-01; lore, nama final, dan ending rinci tidak menahan latihan game pertama.

Setiap awal sesi, Codex menyebut bab/tugas aktif, hasil sesi, konsep yang diperlukan, dan bagian yang dicoba pemilik. Setiap akhir sesi, review hasil nyata dan beri satu langkah berikutnya. Setelah satu kejadian bisa dimainkan, pemilik playtest sebelum cakupan diperluas. MiniMax dipanggil hanya untuk pertanyaan penting dengan bahan konkret; Orca, agen permanen, dan dashboard tambahan belum diperlukan.

## P0 — Persiapan pengalaman pemain dan arah produk

Status: siap dibahas; belum ada keputusan protagonis, konflik pembuka, target pemain, atau strategi penjualan yang dikonfirmasi. The Root dan dunia ekologi pada desain tetap menjadi bahan awal. Sesi ini menghasilkan jawaban kerja pendek dan eksperimen, bukan naskah seluruh game atau janji penjualan.

| Sesi / tugas | Materi belajar dan pertanyaan | Kontribusi pemilik | Hasil kerja / bukti |
| --- | --- | --- | --- |
| P0-01 — Identitas, pemain, dan pengalaman pembuka | Bedakan genre, kegiatan pemain, motivasi karakter, suasana, dan alasan calon pemain tertarik. Analisis satu momen konkret dari referensi: tindakan → pilihan → akibat → perasaan. | Ceritakan pengalaman yang disukai/kurang; pilih perasaan utama dan alasan karakter bertindak. | Pitch satu kalimat, dugaan target pemain, motivasi protagonis, satu tujuan pembuka, dan satu hal yang sengaja tidak ditiru. Tidak mengklaim audience sudah tervalidasi. |
| P0-02 — Cerita yang terjadi lewat gameplay | Bedakan lore latar, alur cerita yang ditulis, dan kejadian hasil sistem. Rancang satu kebutuhan NPC yang berhubungan dengan berry/ekologi; pikirkan tindakan pemain, konsekuensi, dan tanggapan karakter. | Tulis versi pendek situasi/percakapan; pilih konflik serta perubahan yang ingin dirasakan. | Satu situasi cerita dengan awal → pilihan/tindakan → akibat → tanggapan. Tinjau apakah interaksi tetap menarik dan cerita tetap terbaca tanpa penjelasan panjang. |
| P0-03 — Memperkenalkan dan menjual game | Positioning, janji kepada pemain, perbedaan produk, bahan bukti gameplay, feedback, lalu pengenalan store page/demo/wishlist ketika relevan. Bedakan penemuan audiens secara organik dari penjualan yang sudah terjadi. | Pilih pengalaman yang ingin ditunjukkan dan komunitas yang relevan; jelaskan game dengan kata sendiri. | Draft deskripsi pendek, satu ide klip yang bisa dibuktikan prototipe, dan satu pertanyaan calon pemain. Tidak menetapkan tanggal/harga atau proyeksi penjualan sebelum ada dasar. |

P0-01 dapat dikerjakan dalam sesi awal 30–60 menit sebagai panduan. Setelah cukup jelas untuk satu tindakan pertama, M1 bisa mulai; P0-02/03 dapat diselingi sesi coding/art dan ditinjau lagi saat ada hasil. Jangan menunggu seluruh cerita atau rencana pemasaran selesai untuk membuat prototipe.

Jawaban yang disepakati masuk ke bagian relevan `WILDROOT_GAME_DESIGN.md`; keputusan penting dicatat di `DECISIONS.md`. Simpan ringkasan terbaru, bukan transkrip semua diskusi. Codex bertindak sebagai tutor/editor dan membantu riset sumber; pemilik menentukan cerita, mekanik, style, serta apa yang dipublikasikan. MiniMax diminta mengkritisi satu proposal konkret bila ada ketidakpastian, bukan dipanggil untuk setiap sesi.

Contoh untuk dibahas, bukan plot yang diputuskan: seorang peramu membutuhkan berry, sementara warga lain ingin predator dikurangi. Pemain mencari cara memenuhi kebutuhan, melihat akibat pada hutan, lalu mendapat tanggapan yang mencerminkan keadaan itu. The Root dapat muncul sebagai petunjuk kecil. Uji satu tanggapan tertulis dahulu; tidak perlu sistem dialog bercabang besar.

**Catatan masukan P0, 2026-10-07:** pemilik mengonfirmasi referensi [How Many Dudes?](https://store.steampowered.com/app/3934270/How_Many_Dudes_The_Roguelike_Autobattler/) dan menyukai gameplay Stoneshard yang brutal serta mekaniknya yang kompleks. Hal spesifik yang disukai dari How Many Dudes? dan arti “organic” belum diperjelas. Belum ada keputusan kadar tantangan atau playtest. Ketertarikan pribadi bukan bukti cara pemasaran referensi itu bekerja.

Pertanyaan P0-01 berikutnya: seberapa menantang Wildroot ingin terasa? Desain awal menawarkan kegagalan yang dapat dipulihkan; ketertarikan pada Stoneshard belum otomatis mengubahnya menjadi game keras. Bandingkan kedalaman pilihan/persiapan dan konsekuensi yang terbaca dengan hukuman kehilangan progres. Stoneshard memakai pertarungan berbasis giliran, sementara Wildroot dirancang sebagai action RPG: prinsip keputusan dapat dipelajari tanpa menyalin sistemnya. Untuk How Many Dudes?, analisis satu kombinasi efek yang disukai pemilik, lalu coba terjemahkan prinsip interaksi itu ke ekologi; jangan menambah koleksi unit atau roguelike hanya karena referensinya demikian.

Sumber belajar pemasaran untuk dibaca saat dibutuhkan: [Steam Coming Soon](https://partner.steamgames.com/doc/store/coming_soon), [Steam Playtest](https://partner.steamgames.com/doc/features/playtest), dan [wishlists](https://partner.steamgames.com/doc/marketing/wishlist). Ini penjelasan fitur platform, bukan bukti Wildroot akan berhasil menjual.

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
- Saat situasi cerita P0-02 masuk prototipe M3/M4, periksa kedua sisi: pemain memahami pilihan/akibat mekaniknya, serta mengerti alasan karakter dan tanggapannya. Buat satu kejadian cerita yang selesai, bukan banyak halaman lore sebagai pengganti pengujian.

Catatan playtest cukup: situasi/tindakan → yang terlihat → dugaan → percobaan berikutnya. Jangan menulis hasil sebelum dimainkan. Keputusan penting beserta alasan masuk `DECISIONS.md`; pengaturan angka sementara tetap dekat kode.

## Handoff

- **Berikutnya: B0-01 / P0-01 singkat.** Pemilik memberi lima jawaban kasar tentang tokoh, keinginan, masalah pembuka, tindakan pertama, dan perasaan pemain. Codex membantu menilai lingkup dan hubungan cerita–mekanik. Setelah pembuka cukup jelas, lanjut M1-01: telusuri gerakan pemain dan susun penanda lingkungan.
- Pemilik menyusun penanda/petak di editor dan menjelaskan satu pengaruh speed. Codex memandu langkah kecil dan memeriksa hasil.
- Pilihan awal yang sesuai minat art: kerjakan latihan batu di atas lalu pasang hasilnya sebagai penanda dunia. Gerakan pemain yang sudah ada tetap dipakai sebagai fondasi.
- Belum ada pengamatan belajar atau playtest modul yang dicatat.
- GitHub publication dan handoff Mac tetap terpisah dan belum diverifikasi; tidak menghalangi sesi belajar Windows.
