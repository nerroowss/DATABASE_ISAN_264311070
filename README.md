## Bukti Soal 1 (DDL & Relasi)

### 1. Struktur tabel kamera
![kamera](bukti/bukti1_struktur_kamera.png)

### 2. Struktur tabel aturan_pasal
![aturan_pasal](bukti/bukti2_struktur_aturan_pasal.png)

### 3. Struktur tabel detail_pelanggaran
![detail_pelanggaran](bukti/bukti3_struktur_detail_pelanggaran.png)

### 4. Foreign Key (Relation view)
![relasi](bukti/bukti4_relation_view.png)

### 5. SHOW CREATE TABLE
![show create](bukti/bukti5_show_create_table.png)


## Bukti Soal 2 (CRUD)

### 1. CREATE - Insert 9 baris
![insert kamera](bukti/soal2_1_insert_kamera.png)
![insert aturan pasal](bukti/soal2_2_insert_aturan_pasal.png)
![insert detail](bukti/soal2_3_insert_detail.png)

### 2. READ - SELECT * FROM kamera
![read](bukti/soal2_4_read_kamera.png)

### 3. UPDATE - dengan WHERE Primary Key
![sebelum update](bukti/soal2_5_sebelum_update.png)
![update](bukti/soal2_6_update.png)
![sesudah update](bukti/soal2_7_sesudah_update.png)

### 4. DELETE - dengan WHERE
![delete](bukti/soal2_8_delete.png)
![sesudah delete](bukti/soal2_9_sesudah_delete.png)

## Bukti Soal 3 (Query Kompleks & Agregasi)

### Data sumber
![data sumber](bukti/soal3_1_data_sumber.png)

### Hasil query laporan
![hasil query](bukti/soal3_2_hasil_query.png)


# UTS: Fitur Riwayat Notifikasi Tilang

---

## Pemodelan Fisik: Implementasi Tabel riwayat_notifikasi (uts.sql)

### 1. Data tabel induk (detail_pelanggaran)
![data induk](bukti_uts/uts_1_data_detail_pelanggaran.png)

### 2. CREATE TABLE riwayat_notifikasi
![create table](bukti_uts/uts_2_create_table.png)

### 3. INSERT data
![insert](bukti_uts/uts_3_insert.png)

### 4. Isi tabel
![isi tabel](bukti_uts/uts_4_isi_tabel.png)

### 5. Struktur tabel (Primary Key)
![struktur](bukti_uts/uts_5_struktur.png)

### 6. Relasi (Foreign Key)
![relasi](bukti_uts/uts_6_relasi.png)


# UTS: Fitur Riwayat Notifikasi Tilang

## 1. Pemodelan Konseptual: ERD Fitur Riwayat Notifikasi Tilang

```mermaid
erDiagram
    KAMERA ||--o{ DETAIL_PELANGGARAN : menangkap
    ATURAN_PASAL ||--o{ DETAIL_PELANGGARAN : mengatur
    DETAIL_PELANGGARAN ||--o{ RIWAYAT_NOTIFIKASI : memiliki

    KAMERA {
        varchar id_kamera PK
        varchar lokasi_kamera
        int batas_kecepatan
    }
    ATURAN_PASAL {
        varchar kode_pelanggaran PK
        varchar kategori_pelanggaran
        varchar pasal_pelanggaran
    }
    DETAIL_PELANGGARAN {
        varchar no_referensi_sistem PK
        varchar id_kamera FK
        varchar kode_pelanggaran FK
        varchar nomor_polisi
        datetime waktu_capture
        int kecepatan
        varchar status_verifikasi
    }
    RIWAYAT_NOTIFIKASI {
        int id_notifikasi PK
        varchar no_referensi_sistem FK
        varchar media_kirim
        datetime tgl_kirim
        varchar status_kirim
        varchar keterangan
    }
```

**Aturan bisnis fitur Riwayat Notifikasi Tilang:**

1. Setelah pelanggaran direkam kamera dan diverifikasi petugas, pemilik kendaraan wajib diberi tahu lewat surat atau pesan.
2. Pemberitahuan bisa dikirim lebih dari sekali untuk satu pelanggaran. Contohnya pelanggaran `910-50700-N4321AB`: WhatsApp gagal terkirim karena nomor tidak aktif, sehingga bisa dikirim ulang lewat Pos.
3. Setiap pengiriman dicatat sendiri: lewat media apa (Pos, SMS, WhatsApp, atau Email), kapan dikirim, dan hasilnya (Terkirim, Gagal, atau Diterima).
4. Satu catatan notifikasi hanya untuk satu pelanggaran, jadi tidak ada catatan yang tidak jelas asalnya.
5. Riwayat disimpan dan tidak dihapus, supaya bisa menjadi bukti bahwa pemilik sudah diberi tahu.


## 2. Pemodelan Logis: Normalisasi UNF hingga 3NF

### UNF (Unnormalized Form)
Dokumen mentah "Log Pengiriman Notifikasi Tilang" memuat semua data dalam satu baris, dengan beberapa nilai dalam satu sel:

| no_referensi_sistem | nomor_polisi | kategori_pelanggaran | pasal | id_kamera | lokasi_kamera | media_kirim | tgl_kirim | status_kirim |
|---|---|---|---|---|---|---|---|---|
| 910-50639-AE1270CR | AE1270CR | Melanggar Batas Kecepatan | Pasal 287 (5) jo Pasal 106 | CAM-TOL-548 | SPEEDCAM TOL KM 548+450 A JSN | WhatsApp, Pos | 2026-03-05, 2026-03-06 | Gagal, Diterima |

### 1NF
Setiap sel hanya berisi satu nilai (atomik), satu baris per pengiriman:

| no_referensi_sistem | nomor_polisi | kategori_pelanggaran | pasal | id_kamera | lokasi_kamera | media_kirim | tgl_kirim | status_kirim |
|---|---|---|---|---|---|---|---|---|
| 910-50639-AE1270CR | AE1270CR | Melanggar Batas Kecepatan | Pasal 287 (5) jo Pasal 106 | CAM-TOL-548 | SPEEDCAM TOL KM 548+450 A JSN | WhatsApp | 2026-03-05 | Gagal |
| 910-50639-AE1270CR | AE1270CR | Melanggar Batas Kecepatan | Pasal 287 (5) jo Pasal 106 | CAM-TOL-548 | SPEEDCAM TOL KM 548+450 A JSN | Pos | 2026-03-06 | Diterima |

Kandidat Primary Key: (no_referensi_sistem, media_kirim, tgl_kirim).

### 2NF
Ketergantungan parsial: nomor_polisi, kategori_pelanggaran, pasal, id_kamera, dan lokasi_kamera hanya bergantung pada `no_referensi_sistem` (sebagian dari PK). Tabel dipecah:
- `detail_pelanggaran` (PK: no_referensi_sistem)
- `riwayat_notifikasi` (PK: id_notifikasi, FK: no_referensi_sistem)

### 3NF
Ketergantungan transitif dipisah:
- no_referensi_sistem → id_kamera → lokasi_kamera, batas_kecepatan, sehingga dibentuk tabel `kamera`
- no_referensi_sistem → kode_pelanggaran → kategori_pelanggaran, pasal, sehingga dibentuk tabel `aturan_pasal`

### Hasil akhir 3NF
| Tabel | Primary Key | Foreign Key |
|---|---|---|
| kamera | id_kamera | - |
| aturan_pasal | kode_pelanggaran | - |
| detail_pelanggaran | no_referensi_sistem | id_kamera, kode_pelanggaran |
| riwayat_notifikasi | id_notifikasi | no_referensi_sistem |
