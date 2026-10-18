# Referensi dan bahan diskusi Wildroot

Dokumen dan gambar yang disertakan pemilik proyek dalam pembahasan 17–18 Oktober 2026. Pembaruan 18 Oktober menambahkan Bible v2 dan koleksi novel A/B/C. Salinan DOCX dan gambar lampiran dipertahankan tanpa perubahan isi. Folder ini diabaikan importer Godot melalui `.gdignore` agar gambar diskusi tidak ikut menjadi aset runtime.

## Rujukan terbaru

- [Bible v2](documents/Wildroot_Bible_v2.docx): rujukan desain kerja terpadu terbaru. Penanda keputusan, rekomendasi, contoh dan pertanyaan terbuka tetap berlaku; panjangnya uraian tidak membuat semuanya canon.
- [Kumpulan novel A/B/C](documents/Wildroot_Kumpulan_Novel_Jalur_A_B_C_v1.docx): tiga kemungkinan playthrough, bukan tiga kejadian berturut-turut atau tiga campaign yang wajib dibuat. Jalur A masih membawa premis v1; B/C memakai penguatan v2.
- [Review integrasi](../../DESIGN_REVIEW.md#pembaruan-18-oktober-2026) mencatat pemahaman, perbedaan naskah, dan risiko yang perlu dibahas. [Roadmap aktif](../../ROADMAP.md) menyimpan satu langkah berikutnya.

Bible v2 dipakai untuk membandingkan rancangan sistem terbaru. GDD dan v1 tetap menjadi riwayat; perbedaan plot tidak otomatis diselesaikan dengan memilih satu novel sebagai canon final. **Pilihan B genre** berarti action-adventure + farming seimbang secara fungsi; itu berbeda dari **ending B**, Regulated Harness.

## Dokumen sebelumnya

| Dokumen | Status / kegunaan |
| --- | --- |
| [World & Narrative Bible v1](documents/Wildroot_World_Bible_v1.docx) | Dokumen kerja dunia, karakter, kontrak, mitologi, scope dan keputusan terbuka. Draf, bukan canon final. |
| [Novel Jalur A](documents/Wildroot_Novel_Jalur_A_v1.docx) | Prototipe narasi jalur Stewardship. Nama file v1 dipertahankan; judul di dalam dokumen menyebut v1.1. Draf eksplorasi, bukan canon final. |

Isi dokumen adalah bahan desain untuk dibahas. Penanda usulan/keputusan terbuka di dalamnya tidak otomatis berarti fitur sudah disetujui atau diimplementasikan.

## Referensi visual

| Gambar | Konteks |
| --- | --- |
| [Karakter awal](images/characters/wanderer-original-reference.png) | Referensi karakter berambut gelap, scarf, pakaian hijau dan ransel yang dikirim pengguna. |
| [Karakter sederhana](images/characters/wanderer-simplified-reference.png) | Referensi penyederhanaan karakter. Target aset game yang kemudian dipilih adalah kanvas 64×64 dengan enam warna. |
| [Mosscoil Ruins](images/world/mosscoil-ruins-concept.png) | Gambar konsep lingkungan, karakter dan UI untuk pembahasan arah visual; bukan screenshot implementasi game. |
| [Sampul / menu Wildroot](images/world/novel-jalur-a-illustration.png) | Ilustrasi yang diekstrak tanpa perubahan dari `word/media/image1.png` dalam DOCX novel. |

Gambar konsep disertakan sebagai bahan diskusi; pencantumannya tidak mengubah status lisensi menjadi CC0. Provenance aset pihak ketiga tetap mengikuti SOURCE.md masing-masing.

## Screenshot pembahasan gameplay

Screenshot berikut adalah kondisi **sebelum** revamp woodland/UI, bukan tampilan game paling baru:

- [22:20:03](images/gameplay-review/2026-10-17-222003.png)
- [22:20:17](images/gameplay-review/2026-10-17-222017.png)
- [22:20:27](images/gameplay-review/2026-10-17-222027.png)
- [22:20:38](images/gameplay-review/2026-10-17-222038.png)
- [22:24:37](images/gameplay-review/2026-10-17-222437.png)
- [22:24:51](images/gameplay-review/2026-10-17-222451.png)
- [22:25:05](images/gameplay-review/2026-10-17-222505.png)

Masalah yang dibahas: style karakter tidak cocok dengan tileset lama, ukuran pohon terhadap karakter, kamera terlalu dekat, karakter tertutup pohon, dan keterbacaan lari depan/belakang.

## Catatan untuk melanjutkan di Windows

- Pengguna sudah menyatakan woodland/tileset dan UI versi revamp oke. Jangan merombaknya sebagai efek samping perbaikan karakter.
- Base karakter 64×64/enam warna dan proporsi pendek menjadi acuan identitas.
- **Lari atas/bawah pada commit `30c5b39` belum diterima pengguna.** Keluhan terakhir: tangan dan badan terlihat terpisah; sebelumnya telapak hilang/terpotong dan ayunan/proposi juga bermasalah. Lolosnya pemeriksaan piksel/timing tidak berarti kualitas visualnya diterima.
- Pengguna meminta pekerjaan animasi dihentikan di Mac dan akan melanjutkan beberapa perbaikan di Windows. Penambahan folder referensi ini tidak mengubah animasi.
- Referensi gerak gratis yang sudah dikumpulkan ada di [MetroCity](../../../assets/sprites/wanderer_64/reference/metrocity/SOURCE.md). Gunakan untuk studi, bukan alasan menganggap hasil adaptasi sudah bagus.
- Master run yang diekspor: [wanderer_64_run.aseprite](../../../assets/sprites/wanderer_64/source/wanderer_64_run.aseprite). Sumber arah berlayer dan skripnya berada di folder `source` yang sama.

Hash salinan sumber tersedia di [SHA256SUMS.txt](SHA256SUMS.txt).
