# Panduan sumber Aseprite dan referensi Wildroot

Mulai dari file arah yang berlayer untuk memperbaiki tangan atau kaki. Master gabungan berguna untuk melihat semua tag dan urutan animasi. Karakter Wanderer memakai kanvas 64×64 dan enam warna; lari atas/bawah terakhir masih ditolak pemilik karena tangan/badan tampak terpisah. File terbaru menunjukkan kondisi yang perlu diperbaiki, bukan artwork yang telah disetujui.

## File yang dibuka dahulu

| Kebutuhan | Sumber yang dibuka | Isi dan hubungan |
| --- | --- | --- |
| Lari ke bawah yang perlu diperbaiki | [run_down_reference.aseprite](../assets/sprites/wanderer_64/source/run_down_reference.aseprite) | Enam frame, lima layer badan/kaki/lengan/kepala terpisah, 90 ms per frame |
| Lari ke atas yang perlu diperbaiki | [run_up_reference.aseprite](../assets/sprites/wanderer_64/source/run_up_reference.aseprite) | Enam frame dengan lima layer, 90 ms per frame |
| Lari kanan dengan ayunan lengan | [run_right_redraw.aseprite](../assets/sprites/wanderer_64/source/run_right_redraw.aseprite) | Tiga layer termasuk lengan jauh dan tangan dekat; enam frame |
| Lari kiri | [run_left.aseprite](../assets/sprites/wanderer_64/source/run_left.aseprite) | Enam frame satu layer hasil pencerminan kanan; periksa arah cahaya/identitas ketika mengedit |
| Semua arah lari dalam satu file | [wanderer_64_run.aseprite](../assets/sprites/wanderer_64/source/wanderer_64_run.aseprite) | Master gabungan 24 frame, empat tag run; satu layer gabungan |
| Semua idle dan jalan | [wanderer_64.aseprite](../assets/sprites/wanderer_64/source/wanderer_64.aseprite) | Master gabungan 28 frame, delapan tag idle/walk |
| Kaki jalan kanan yang bisa diedit terpisah | [walk_right_chunky.aseprite](../assets/sprites/wanderer_64/source/walk_right_chunky.aseprite) | Delapan frame, layer kaki gelap, kaki cokelat, dan tubuh atas |
| Kaki jalan kiri yang bisa diedit terpisah | [walk_left_chunky.aseprite](../assets/sprites/wanderer_64/source/walk_left_chunky.aseprite) | Delapan frame dengan identitas kedua kaki dipertahankan |
| Bentuk dasar yang disukai | [approved-original.aseprite](../assets/sprites/wanderer_64/source/approved-original.aseprite) | Satu frame referensi identitas dan proporsi; base empat arah ada di base_down/left/right/up.aseprite |

`run_down.aseprite`, `run_down_native.aseprite`, dan `run_down_reference.aseprite` saat audit mempunyai SHA256 yang sama. Begitu juga tiga nama untuk arah atas. `run_right.aseprite` sama dengan `run_right_redraw.aseprite`. Master `wanderer_64_run_redraw.aseprite` sama dengan `wanderer_64_run.aseprite`. Nama tersebut adalah salinan/alias kondisi yang sama, bukan versi baru yang lebih bagus. Setelah mengedit satu file, salinan lain tidak ikut berubah otomatis.

File arah kanan/kiri jalan bernama `_gait`, `_chunky`, dan nama dasar juga mempunyai salinan dengan hash yang sama saat audit. Inventaris menyimpan hash dan layer supaya perbedaannya dapat diperiksa setelah kamu mengedit di Windows.

## Yang dipakai Godot

Ada dua jalur proyek yang perlu dibedakan:

- **F5, main yang dikonfigurasi:** [main.tscn](../scenes/main.tscn) memakai [player.tscn](../scenes/player.tscn), controller lama dan PNG di `assets/sprites/player/`. Sumber lamanya [player.aseprite](../assets/sprites/player.aseprite); [player_down_anim_backup.aseprite](../assets/sprites/player_down_anim_backup.aseprite) adalah cadangan. Mengedit Wanderer tidak otomatis mengganti karakter F5.
- **F6, map woodland dan Wanderer:** buka [wanderer_run_preview.tscn](../scenes/previews/wanderer_run_preview.tscn). Ini tampilan map/UI yang sudah diterima, dengan karakter 64×64 yang masih perlu perbaikan lari vertikal.

Wanderer membaca PNG melalui [wanderer_64.tres](../resources/sprite_frames/wanderer_64.tres). Godot tidak membaca perubahan file `.aseprite` secara langsung dan tidak otomatis mengikuti JSON ekspor.

| Yang diedit | PNG yang perlu diekspor untuk preview Wanderer |
| --- | --- |
| Base/idle arah tertentu | `assets/sprites/wanderer_64/base/idle_down.png`, `idle_left.png`, `idle_right.png`, atau `idle_up.png` |
| Walk down/up | `assets/sprites/wanderer_64/animations/walk_down.png` atau `walk_up.png`, strip horizontal empat sel 64×64 |
| Walk left/right | `assets/sprites/wanderer_64/animations/walk_left.png` atau `walk_right.png`, strip horizontal delapan sel 64×64 |
| Run setiap arah | `assets/sprites/wanderer_64/animations/run_down.png`, `run_left.png`, `run_right.png`, atau `run_up.png`, strip horizontal enam sel 64×64 |

Ekspor pada ukuran native dengan transparansi, tanpa mengubah ukuran kanvas atau menambah padding antarframe. Jika jumlah frame atau timing berubah, sesuaikan SpriteFrames Godot juga. Lari kanan/kiri saat ini memakai 80/55/125/80/55/125 ms; atas/bawah 90 ms per frame. Walk samping 100 ms per frame, depan/belakang 125 ms. Ini parameter kondisi sekarang, bukan kewajiban mempertahankan animasi yang tidak kamu suka.

Untuk alur edit sederhana, jadikan file arah berlayer sebagai tempat kerja. Ekspor arah tersebut ke PNG strip yang dipakai Godot, kemudian salin frame hasilnya ke tag master gabungan bila ingin kedua sumber tetap sinkron. Simpan versi sebelum edit. Skrip `build-animations.lua`, `build-run.lua`, dan `publish-run-redraw.lua` membangun ulang dari konsep/pose lama serta dapat menimpa file native; jangan menjalankannya untuk sekadar menerbitkan edit manual baru.

## Map dan tileset yang aktif

Semua sepuluh sumber woodland sudah berada di [assets/tilesets/wildroot/source](../assets/tilesets/wildroot/source). Mereka mempunyai pasangan PNG dengan nama yang sama di folder induknya.

| Sumber | Kegunaan |
| --- | --- |
| [ground_32.aseprite](../assets/tilesets/wildroot/source/ground_32.aseprite) | Atlas rumput/tanah 32×32 per tile; pertahankan posisi sel agar TileSet tidak menunjuk gambar yang salah |
| [oak_a.aseprite](../assets/tilesets/wildroot/source/oak_a.aseprite), [oak_b.aseprite](../assets/tilesets/wildroot/source/oak_b.aseprite) | Pohon daun lebar |
| [pine_a.aseprite](../assets/tilesets/wildroot/source/pine_a.aseprite), [pine_b.aseprite](../assets/tilesets/wildroot/source/pine_b.aseprite) | Pohon tinggi |
| [bush.aseprite](../assets/tilesets/wildroot/source/bush.aseprite), [flower_bush.aseprite](../assets/tilesets/wildroot/source/flower_bush.aseprite) | Semak dan semak berbunga |
| [rocks.aseprite](../assets/tilesets/wildroot/source/rocks.aseprite), [fern.aseprite](../assets/tilesets/wildroot/source/fern.aseprite), [flower.aseprite](../assets/tilesets/wildroot/source/flower.aseprite) | Batu, pakis, dan bunga kecil |

Letak objek dan tile map diedit pada scene woodland di Godot, bukan pada satu file Aseprite map raksasa. [wildroot_ground.tres](../resources/tilesets/wildroot_ground.tres) mengatur atlas ground. Padding kanvas pohon dan titik kaki dipakai untuk penempatan/collision; mengganti padding atau posisi pangkal memerlukan pemeriksaan posisi dan collider.

Sumber lain yang tetap tersedia: [red_wyvern_128.aseprite](../assets/sprites/red_wyvern_128.aseprite) adalah aset monster terpisah yang belum dirujuk scene aktif, dan [flowers.aseprite](../assets/tilesets/ninja_adventure/flowers.aseprite) adalah contoh animasi bunga dari sample Ninja Adventure lama.

## Referensi untuk diamati

Referensi di bawah mempunyai provenance masing masing. File gambar dapat dibuka di Aseprite. Ambil prinsip pose, kontak kaki, overlap lengan/badan, serta timing; pertahankan desain, palet, dan proporsi Wanderer ketika membuat versi sendiri.

### MetroCity

- Mulai dari [official-models-preview.gif](../assets/sprites/wanderer_64/reference/metrocity/official-models-preview.gif), 18 frame. Frame 1–6 depan, 7–12 samping, 13–18 belakang; 110 ms per frame.
- Tambahan preview yang sudah tersimpan lokal kini tersedia di [assets/references/metrocity](../assets/references/metrocity): GIF arah, GIF run, gambar base, dan gambar gambaran paket. Preview GIF berukuran 360×360 bukan ukuran kanvas karakter Wanderer.
- Sumber dan lisensi: [MetroCity oleh JIK-A-4](https://jik-a-4.itch.io/metrocity-free-topdown-character-pack), CC0. Referensi visual di repo bukan seluruh paket RAR. [Catatan sumber](../assets/references/metrocity/SOURCE.md).

Untuk lari vertikal, amati kapan kaki menapak dan terlipat, bagian lengan yang tertutup tubuh, serta hubungan bahu dengan tangan. Gunakan frame 1 dan 4 sebagai pembanding fase, kemudian 2/3 dengan 5/6 untuk langkah yang bergantian. Jangan menganggap lolos pemeriksaan jumlah piksel tangan membuktikan tangan sudah tersambung secara visual.

### Sora

[Folder Sora](../assets/references/sora) berisi seluruh 13 PNG dari arsip `sora.zip` yang sebelumnya dipelajari. `Walking_Left.png`, `Walking_Right.png`, `IdleDownWalking.png`, dan `IdleUpWalking.png` mempunyai ukuran 256×64 sehingga bisa diamati sebagai empat sel horizontal 64×64. Nama file dipertahankan dari pembuatnya.

Sumber: [Simple animated character oleh Danilo Mattos](https://opengameart.org/content/simple-animated-character), CC0. Paket ini menyertakan pose idle, gerak, melee, dan ranged; tidak semuanya memakai susunan/ukuran sel yang sama. [Catatan sumber](../assets/references/sora/SOURCE.md).

### Ninja Adventure

[Folder Ninja Adventure](../assets/references/ninja-adventure) memuat 31 PNG dari folder `content` pada contoh Godot resmi yang sudah diunduh. Termasuk atlas lantai/interior, karakter, prop, UI, partikel, dan senjata. Ini isi art dari snapshot contoh Godot, bukan klaim menyertakan seluruh asset pack terbaru.

Sumber: [Pixel-Boy dan AAA](https://pixel-boy.itch.io/ninja-adventure-asset-pack), CC0. Cocok untuk mempelajari bentuk tile dan sprite kecil. Woodland aktif memakai aset Wildroot, sehingga perubahan referensi ini tidak mengubah map sekarang. [Catatan sumber](../assets/references/ninja-adventure/SOURCE.md).

### Mana Seed

Unduh kembali **FREE Mana Seed Character Base Demo 2.0.zip** melalui [halaman resmi Seliel](https://seliel-the-shaper.itch.io/character-base) di PC. Demo lokal yang sebelumnya dipelajari tidak disalin ke repo karena [lisensi Mana Seed](https://selieltheshaper.weebly.com/user-license.html) melarang redistribusi file mentah kepada pihak di luar tim. Lisensi itu juga memuat pembatasan penggunaan bersama GenAI; gunakan sumber resmi untuk menilai penggunaan yang kamu rencanakan. Ini tautan studi, bukan aset runtime Wildroot.

## Arsip semua versi lokal yang ditemukan

[assets/source-history/wanderer](../assets/source-history/wanderer) menyimpan 28 salinan Aseprite dengan hash biner unik yang sebelumnya hanya ada di folder output Mac. Ini mencakup sketsa Sprite-0003, karakter 96×96, walk sebelum perbaikan proporsi/kaki/ketebalan, run awal, serta run vertikal sebelum revisi referensi.

Nama diberi nomor dan potongan hash untuk menghindari benturan. [archive-manifest.json](../assets/source-history/wanderer/archive-manifest.json) mencatat asal relatif, kanvas, jumlah frame, layer, tag dan SHA256. Salinan dengan biner identik tidak diduplikasi. Biner yang berbeda belum tentu mempunyai artwork berbeda; metadata Aseprite juga dapat mengubah hash.

Arsip berfungsi untuk membandingkan dan mengambil kembali bagian gambar yang disukai. Jangan memilihnya sebagai master hanya karena namanya mengandung `native`, `redraw`, atau `gait`. Untuk revisi lari sekarang, mulai dari file pada tabel pertama. Arsip dan referensi dikecualikan dari import Godot dengan `.gdignore`.

[Inventaris semua sumber Aseprite](../assets/ASEPRITE_INVENTORY.json) menyimpan metadata dan hash setiap file native di repo setelah sinkronisasi. Sumber aktif dan arsip dipisahkan tanpa menimpa artwork yang sudah ada.

## Langkah di PC

1. Simpan perubahan lokal lalu ambil `main` terbaru dengan worktree bersih memakai `git pull --ff-only`.
2. Buka `run_down_reference.aseprite` atau `run_up_reference.aseprite` untuk masalah tangan/badan. Tampilkan layer satu per satu sambil membandingkan GIF MetroCity atau empat frame Sora.
3. Pertahankan kanvas 64×64 serta identitas base yang disukai. Buat salinan sebelum merombak pose.
4. Ekspor arah yang diedit ke strip PNG pada tabel runtime. Buka scene woodland dan jalankan F6 untuk memeriksa gerak, ukuran, dan occlusion pada map.
5. Commit sumber Aseprite bersama PNG hasil edit. Bila frame/timing atau posisi pangkal berubah, sertakan perubahan SpriteFrames/scene/collision yang memang dibutuhkan.
