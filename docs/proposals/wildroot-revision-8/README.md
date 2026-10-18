# Paket usulan revisi Wildroot

Pembaruan pembahasan di Windows: `proposal.md` memuat penyuntingan bahasa pada awal R1 dan usulan nama kerja baru beserta tabel nama sebelumnya. Nama pengganti belum final. DOCX dalam paket ini masih memakai versi sebelum pembaruan tersebut; Bible dan novel sumber belum diubah. Untuk pembahasan penamaan terbaru, baca `proposal.md`.

Baca Wildroot_Usulan_Revisi_8_Poin_v1.docx dahulu. Dokumen 16 halaman berisi hasil delapan pekerjaan, petikan pengganti, serta ruang ACC atau catatan per ID. proposal.md memuat isi yang sama dalam teks yang mudah diedit. Semua usulan menunggu keputusan Stefanus Terang.

## Mencoba prototipe

Ekstrak paket, lalu buka prototype/index.html dengan browser Mac atau Windows. Satu file HTML ini mandiri dan dapat dipindah sendiri. Tidak perlu server, akun, jaringan, atau memasang Node. Pilih kebutuhan awal, amati kebun, pilih pendekatan, tanam dan siram. Hari maju hanya melalui tombol Hari berikutnya. Ekspor catatan menyimpan JSON lokal. Refresh atau Ulangi memulai keadaan baru; belum ada penyimpanan progres otomatis.

Coba metode lain dengan kebutuhan awal berbeda. Prototipe menguji biaya, aturan, dan pemahaman keputusan. Ia belum merupakan scene Godot atau pengujian rasa combat dan farming pada map. Tidak ada art karakter baru dalam paket ini.

## Hasil yang benar benar diperiksa

Sebelas kasus aturan model lulus, termasuk 4500 langkah aksi untuk batas state. Uji fixture DOM terhadap HTML yang dikirim juga lulus untuk tombol, penghitung, bukti, panen penuh, ekspor Blob, ulang, dan relokasi. verification.json dan dua file test-results.txt mencatat hasilnya.

Pemeriksaan visual seluruh 16 halaman DOCX selesai. Tampilan prototipe di browser belum berhasil diverifikasi secara visual melalui alat; pemeriksaan fixture DOM bukan pemeriksaan CSS. Belum ada playtest manusia atau kesimpulan tentang kesenangan bermain. Kolom pengamatan di dokumen sengaja belum diisi.

## Sumber prototipe

engine.cjs memuat aturan biaya dan perubahan keadaan, app.js menghubungkan aturan ke tampilan, dan template.html memuat kerangka serta gaya. index.html merupakan gabungan persis ketiganya. Jika ingin menjalankan pengujian pada mesin dengan Node, dari folder prototype jalankan node test-model.cjs lalu node test-interface.cjs. Tidak ada paket tambahan.

## Jejak MiniMax

minimax-round1.txt adalah usulan awal independen. minimax-round2.txt adalah tanggapan pada draf Codex. Keduanya mempertahankan keluaran asli termasuk ide yang ditolak dan beberapa kekeliruan kutipan. Dokumen usulan merangkum hasil penyaringan; transkrip mentah tidak menjadi canon atau spesifikasi.

## Memberi keputusan

Gunakan R1 sampai R8. Contoh: R1 ACC DENGAN CATATAN alasan lahan diganti; R2 TUNDA; R5 ACC hanya adegan biaya. Boleh menambahkan kebutuhan atau menolak satu subbagian. Paket ini disimpan sebagai proposal untuk ditinjau. Usulan belum diterapkan ke Bible, novel sumber, atau game utama.

## Membuka dari PC

Setelah menyimpan pekerjaan lokal dan memastikan worktree bersih, jalankan git pull --ff-only pada branch main. Buka dokumen Word di folder ini atau klik dua kali prototype/index.html dari File Explorer. Tidak perlu mengubah scene utama Godot.

Rujukan asli: [Bible v2](../../references/wildroot/documents/Wildroot_Bible_v2.docx) dan [novel A/B/C](../../references/wildroot/documents/Wildroot_Kumpulan_Novel_Jalur_A_B_C_v1.docx). [Roadmap aktif](../../ROADMAP.md) tetap menyimpan tugas belajar berikutnya.
