# Wildroot: tinjauan desain dan rencana pembuktian

Tanggal: 2026-09-30. Status: analisis desain, bukan hasil playtest. Setelah pemilik meminta modul dan agenda kerja, urutan awal dijabarkan di `ROADMAP.md`; mekanik dan balance yang diusulkan di sini tetap memerlukan pengujian.

Sumber: seluruh `WILDROOT_GAME_DESIGN.md` dari pemilik (bagian 0–56), konteks proyek, dan scene/script pemain saat review. Desain disalin utuh dari lampiran untuk review; sesudahnya ditambahkan catatan rencana kerja di bagian atas tanpa menghapus isi awal. Codex menilai sumber dan implementasi yang ada. MiniMax M3 menerima seluruh desain, tujuan belajar pemilik, serta ringkasan baseline melalui review baru tanpa putusan Codex. MiniMax menyatakan tidak membaca langsung script/scene pada review desain ini dan tidak menjalankan game. Prototipe ekologi belum ada.

## Pemahaman konsep

Wildroot adalah action RPG pixel top-down tentang memahami hubungan ekologi, sengaja mengubah kondisi dunia, lalu menggunakan konsekuensinya untuk memperoleh material, perlengkapan, akses, dan pertemuan baru. Farm adalah tempat eksperimen yang lebih terkendali; alam liar memperluas risiko dan kemungkinan. Pertarungan adalah salah satu cara intervensi. Identitas ini lebih spesifik daripada sekadar gabungan farming dan combat.

Pertahankan: dunia kecil buatan tangan, pengetahuan sebagai kemajuan, makhluk dengan peran selain musuh, keadaan dunia yang berbeda memiliki kegunaan berbeda, eksperimen yang bisa dipulihkan, dan petunjuk lewat lingkungan. The Root dapat menghubungkan semuanya secara naratif. Detail akhir cerita dapat menunggu pembuktian pengalaman awal.

## Kekurangan yang perlu diperjelas

Tindak lanjut setiap keresahan, jawaban sementara, modul pengujian, dan bukti yang diperlukan dilacak pada bagian **Keresahan desain → jawaban sementara → pembuktian** di `ROADMAP.md`. Termasuk pertanyaan jamur dan boss yang belum masuk modul awal. Statusnya belum diuji sampai ada pengamatan nyata.

| Pertanyaan | Dasar dalam desain | Usulan dan cara mengujinya |
| --- | --- | --- |
| Apa keputusan menarik dalam beberapa menit pertama? | Bagian 9 mencatat banyak kegiatan, tetapi biaya kesempatan dan tujuan awal belum konkret. | Beri satu tujuan sederhana dan dua intervensi yang berbeda. Amati apakah pemain bisa menyebut alasan pilihannya. |
| Bagaimana pemain tahu perubahan disebabkan tindakannya? | Bagian 10/22 menjadwalkan pembaruan; 30/42 memberi bentuk umpan balik. Jeda dan hubungan petunjuk dengan kejadian belum ditetapkan. | Gunakan satu hubungan utama dahulu, keadaan awal yang dapat diulang, transisi hari atas perintah pemain, dan perbandingan sebelum/sesudah. Jangan tambah musim atau cuaca acak pada uji awal. |
| Mengapa mempertahankan keadaan berbeda sama-sama berguna? | Pilar menolak satu keadaan paling benar; banyak manfaat dan risiko masih berupa contoh. | Tetapkan dua kebutuhan konkret, misalnya berry vs material hasil perburuan, dengan biaya pemulihan yang terlihat. Uji apakah perubahan tujuan mengubah pilihan, atau satu strategi selalu unggul. |
| Bagaimana pemain memulihkan perubahan? | Bagian 42 menjanjikan pemulihan; tindakan, waktu, dan batas minimum populasi belum ditentukan. | Uji satu cara langsung seperti mengurangi herbivor dan satu aturan pemulihan predator yang terjelaskan, misalnya migrasi dari luar area. Pastikan angka nol tidak menyebabkan kebuntuan permanen. Jangan menyamakan tombol reset pengembang dengan pemulihan dalam game. |
| Apa arti satu makhluk yang diburu bagi populasi abstrak? | Bagian 11 memisahkan node dan populasi; bagian 51 memakai skala 0–100 serta kill count. | Putuskan apakah nilai adalah jumlah atau indeks. Catat dampak per tindakan tepat sekali. Keluar/masuk area tidak boleh membuat sumber loot/populasi baru tanpa aturan. Visual mewakili keadaan secara konsisten. |
| Bagaimana pengetahuan ditemukan dan digunakan? | Bagian 13 sudah menyediakan NPC, observasi, dan jurnal, tetapi kondisi membuka entri/resep belum rinci. | Pisahkan catatan pengamatan dari hipotesis dan petunjuk. Hindari memberi jawaban sebelum eksperimen. Tentukan apakah resep wajib dibuka lewat entri atau pemain boleh berhasil lebih dulu lewat penemuannya sendiri. |
| Mengapa vegetasi berkurang lalu jamur meningkat? | Bagian 47 membuat rantai tersebut; bagian 51 juga menyebut kesuburan dan kelembapan. Penghubungnya belum pasti. | Tetapkan aturan fantasi yang dapat diamati, misalnya sisa organik tertentu bersama kondisi lembap. Pilih aturan untuk diuji; jangan menganggap panah dalam konsep sudah membuktikan hubungan. Tunda rantai jamur dari percobaan pertama. |
| Apa yang terjadi setelah anomali dan boss selesai? | Bagian 20/47 menyambung kondisi, boss, dan senjata; aturan pascaboss belum ada. | Sebelum membangun boss, tentukan apakah keadaan tetap bertahan, apa pemicu kemunculan ulang, dan apa biaya mempertahankannya. Uji reward kecil terlebih dahulu untuk melihat apakah pemain hanya mengulang pemicu secara mekanis. |

Informasi kualitatif tidak otomatis membuat hubungan mudah dipahami. Pemain tetap perlu tahu arah perubahan, dugaan penyebab, dan kesempatan merespons. Angka debug boleh terlihat bagi pengembang; tampilan pemain diuji terpisah. Dunia boleh mengejutkan, tetapi aturan lokal perlu cukup konsisten agar hipotesis pemain berguna.

## Scope dan ketidaksesuaian yang nyata

- Bagian 36/55 menyebut tiga peta, tiga makhluk, dua tanaman, farming, senjata, UI, save, anomali, dan boss. Itu kandidat gabungan beberapa eksperimen; terlalu banyak ketergantungan untuk pengujian pertama hubungan ekologi oleh pemula solo. Durasi bermain 20–40 menit tidak menunjukkan biaya produksi.
- Target 1.0 (6–8 region, 20–28 spesies, empat senjata, empat musim, banyak boss/NPC) sebaiknya tetap menjadi visi yang dievaluasi ulang setelah slice kecil selesai. Animasi, variasi lingkungan, perilaku, dan kombinasi keadaan semuanya memerlukan produksi serta pemeriksaan. Belum ada data untuk menjanjikan jadwal.
- Bagian 32/33/52 adalah arah arsitektur masa depan. Jangan membuat semua folder, resource, event bus global, atau base state machine sekaligus. Mulai dari script pemain yang ada, satu scene uji, dan satu tempat yang menyimpan/memperbarui keadaan ekologi; pisahkan ketika tanggung jawabnya sudah nyata.
- Save disebut pada fondasi (38), tetapi implementasinya ditempatkan terakhir pada daftar tugas (39). Mulai dengan state eksplisit yang mudah di-reset; lakukan satu uji save/load kecil saat percobaan lintas hari perlu dilanjutkan antarsesi. Sistem save untuk seluruh game belum diperlukan.
- Bagian 29/49 menyebut art karakter saat ini sekitar 56×56. Frame `assets/sprites/player/idle_down_01.png` di repo terverifikasi 32×32. Perlakukan 48–64 px sebagai arah yang diusulkan sampai pemilik mengonfirmasi aset/skalanya. Uji proporsi pemain, objek, dan jejak collision dalam satu layar sebelum memproduksi banyak art. Jangan memperbesar ulang aset otomatis.

## Percobaan berurutan yang disarankan

### E1 — Mengamati, memprediksi, lalu mengubah hutan

Pertanyaan: dapatkah pemain memahami hubungan wolf → rabbit → berry dan memakai pemahaman itu untuk mencapai tujuan?

Isi minimum: satu petak hutan, pemain yang sudah ada, representasi wolf/rabbit, beberapa semak berry, tiga nilai ekologi, satu intervensi untuk mengurangi predator, dan transisi hari manual. Gunakan placeholder atau gambar sederhana pemilik. Intervensi sementara boleh berupa interaksi; kebutuhan combat diuji tersendiri. Tidak perlu AI makhluk yang lengkap.

Urutan uji: amati keadaan awal → pilih tindakan → majukan hari → perhatikan perubahan → tuliskan dugaan → lakukan percobaan kedua. Sediakan reset keadaan awal bagi pengembang. Mulai dari aturan deterministik; hitung perubahan hari dari snapshot yang sama agar urutan perhitungan tidak menciptakan akibat tersembunyi.

Bandingkan dengan keadaan awal yang sama tanpa intervensi. Uji coba jeda satu sampai beberapa transisi sebagai parameter, bukan keputusan balance final. Sasaran sesi singkat sekitar 5–10 menit adalah rancangan pengujian, bukan durasi yang sudah terbukti.

Sinyal untuk maju: pemain melihat perubahan tanpa diberi jawabannya, menyebut arah hubungan yang masuk akal, dan mencoba tindakan kedua untuk hasil yang diinginkan. Jika hanya melihat perubahan tetapi salah menyimpulkan penyebab, perbaiki petunjuk/jeda sebelum menambah spesies. Catat juga kebutuhan bantuan. Tes dengan pemilik dahulu, lalu 2–3 orang yang belum diberi rumus bila tersedia; ini sinyal awal, bukan validasi pasar.

### E2 — Memilih tujuan dan memulihkan akibat

Pertanyaan: apakah mengubah ekologi menghasilkan pilihan yang menarik dan dapat diperbaiki?

Gunakan scene E1. Tambahkan cara mengurangi rabbit, aturan kembalinya predator yang terbaca, dan dua tujuan kecil yang membuat keadaan berbeda berguna. Contoh sementara: persediaan berry vs material hasil perburuan. Satu hasil digunakan langsung, misalnya makanan untuk memulihkan HP; jangan membuat inventory/crafting lengkap hanya untuk uji ini.

Amati apakah pemain mengubah strategi ketika tujuannya berubah, dapat memulihkan keadaan tanpa instruksi langkah demi langkah, dan merasa konsekuensi bisa diperkirakan. Bila satu strategi memenuhi semua kebutuhan tanpa pengorbanan, perbaiki trade-off. Bila pemain hanya menekan tidur berulang kali, perbaiki waktu tunggu dan kegiatan antarperubahan.

### E3 — Menyatukan aksi dengan ekologi

Pertanyaan: apakah satu serangan, satu makhluk, dan akibat ekologinya terasa sebagai satu kegiatan?

Tambahkan satu serangan sederhana, satu musuh dengan tanda sebelum menyerang, HP/damage dan umpan balik secukupnya. Hubungkan hasil perburuan ke aturan E1/E2 tepat sekali. Amati apakah pemain memahami dampak buruannya dan masih mau mengamati makhluk, atau hanya melihat semua makhluk sebagai loot. Baru kemudian pertimbangkan reward berbasis kondisi, slime/jamur, dan satu anomali kecil; boss menyusul setelah pemicu serta reward masuk akal.

### E4 — Sawah sebagai eksperimen terkendali

Setelah hubungan hutan terbaca, uji satu petak rice → pest → fish dengan dua cara mengatasi pest dan satu biaya merawat habitat. Uji apakah pemain membawa cara berpikir dari hutan ke sawah. Perubahan air sederhana boleh dicoba; empat musim dan seluruh farm belum diperlukan. Timing penempatan rice-fish dalam tutorial akhir tetap terbuka: awal cerita dapat berbeda dari urutan eksperimen pengembangan.

## Jalur belajar yang menghasilkan bagian game

| Langkah | Hasil game | Konsep yang dipelajari | Bagian yang dikerjakan pemilik |
| --- | --- | --- | --- |
| 1 | Petak hutan dengan batu pembatas dan semak berry | Node, scene, transform, collision; alur script pemain yang ada | Tata petak hutan dan collision satu batu, lalu mainkan |
| 2 | Mendekati dan mengamati/memetik satu semak | Input action, `Area2D`, signal, kondisi, fungsi | Tulis satu fungsi interaksi dan aturan berry tersedia/habis |
| 3 | Hari berganti dan keadaan berry diperbarui | Variabel, state, fungsi pembaruan, batas nilai | Tulis satu aturan pertumbuhan berry dan prediksi hasilnya |
| 4 | Hubungan wolf/rabbit/berry terlihat | Hubungan antarvariabel, snapshot, pemisahan data dan visual | Tambahkan satu hubungan konsumsi/predasi, uji sebelum/sesudah |
| 5 | Pengamatan membantu keputusan berikutnya | UI sederhana, signal, observasi vs kesimpulan | Buat satu catatan jurnal dari kejadian yang benar-benar terjadi |
| 6 | Perburuan dan pemulihan mengubah dunia | HP, hit detection, transisi perilaku, debugging | Kerjakan satu bagian combat; telusuri dampaknya ke ekologi |

Codex menjelaskan dan meninjau bagian kecil, membantu diagnosis serta pekerjaan berulang. Pemilik tetap memilih rasa permainan, membuat art, menulis logika belajar yang disepakati, dan memainkan hasilnya. Satu sesi cukup menghasilkan satu perilaku yang dapat dilihat dan dijelaskan.

## MiniMax: masukan yang dipakai dan yang ditolak

Masukan berguna: waktu munculnya akibat perlu diuji; pemain memerlukan petunjuk dekat dengan kejadian; preserve/exploit harus memiliki alasan praktis; mengubah dan memulihkan keadaan layak menjadi eksperimen terpisah. Ini sejalan dengan analisis Codex, tetapi belum merupakan hasil pemain.

Bagian yang tidak diadopsi:

- Klaim perubahan memerlukan 3–7 hari tidak berasal dari rumus atau playtest; jadwal dan konstanta belum dibuat.
- Klaim petunjuk bertahap tidak ada terlalu kuat: bagian 13 dan 45 sudah menyebut NPC/jurnal/observasi. Kekurangannya adalah aturan penyampaian dan pembuktiannya.
- Anggapan tiga peta/tiga makhluk cukup kecil untuk solo mengabaikan keseluruhan isi prototype 0.1 dan tujuan belajar. Codex menyarankan satu petak dahulu.
- Meminta penguji memilih hutan mana yang “sehat” tidak menguji filosofi tanpa satu keadaan paling benar. Tanyakan apa yang berubah dan keadaan mana yang berguna untuk tujuan tertentu.
- Event tick per kill bukan pilihan yang otomatis lebih baik; dapat mengaburkan gagasan perubahan populasi. Transisi hari manual dapat menguji jeda tanpa mengganti aturan waktu sejak awal.
- Uji final boss dua varian terlalu dini bagi proyek ini. Tunda sampai perubahan keadaan dan reward kecil terbukti terbaca.

## Langkah diskusi berikutnya

Agenda kerja di `ROADMAP.md` memulai fondasi E1 lewat petak hutan dan interaksi berry. Pilih aturan intervensi ekologi ketika modul tersebut mendekat; tidak perlu memutuskan semua mekanik sekarang. Keputusan penting dicatat singkat di `DECISIONS.md`. Adanya agenda tidak berarti seluruh rekomendasi review sudah disetujui atau terbukti.
