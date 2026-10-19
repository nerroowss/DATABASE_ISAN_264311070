-- =====================================================
-- SOAL 2: Operasi CRUD Dasar
-- (SCPMK0720802 - CRUD Dasar)
-- Manipulasi baris data dasar
-- Nama : Ikhzaniero Ardyana Juniar | NIM : 264311070
-- =====================================================

USE etle_db_uts;

-- 1. [CREATE] INSERT minimal 3 baris dummy per tabel (total 9 baris)
INSERT INTO kamera (id_kamera, lokasi_kamera, batas_kecepatan) VALUES
('CAM-TOL-548', 'SPEEDCAM TOL KM 548+450 A JSN', 120),
('CAM-TOL-549', 'SPEEDCAM TOL KM 549+100 A JSN', 100),
('CAM-SIM-001', 'SIMPANG A MADIUN', 40);

INSERT INTO aturan_pasal (kode_pelanggaran, kategori_pelanggaran, pasal_pelanggaran) VALUES
('PLG-01', 'Melanggar Batas Kecepatan', 'Pasal 287 (5) jo Pasal 106'),
('PLG-02', 'Tidak Menggunakan Sabuk Pengaman', 'Pasal 289'),
('PLG-03', 'Menerobos Lampu Merah', 'Pasal 287 (2)');

INSERT INTO detail_pelanggaran
(no_referensi_sistem, id_kamera, kode_pelanggaran, nomor_polisi, waktu_capture, kecepatan, status_verifikasi) VALUES
('910-50639-AE1270CR', 'CAM-TOL-548', 'PLG-01', 'AE1270CR', '2026-03-04 09:42:11', 144, 'Menunggu'),
('910-50640-AE1270CR', 'CAM-TOL-548', 'PLG-02', 'AE1270CR', '2026-03-04 09:42:11', 144, 'Menunggu'),
('910-50700-N4321AB',  'CAM-TOL-549', 'PLG-01', 'N4321AB',  '2026-03-05 07:15:20', 131, 'Menunggu');

-- 2. [READ] Tampilkan seluruh isi salah satu Tabel Induk
SELECT * FROM kamera;

-- 3. [UPDATE] Ubah satu nilai pada Tabel Transaksi (WHERE pakai Primary Key)
UPDATE detail_pelanggaran
SET status_verifikasi = 'Terverifikasi'
WHERE no_referensi_sistem = '910-50639-AE1270CR';

-- 4. [DELETE] Hapus satu baris dummy pada Tabel Transaksi (wajib WHERE)
DELETE FROM detail_pelanggaran
WHERE no_referensi_sistem = '910-50640-AE1270CR';
