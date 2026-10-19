-- =====================================================
-- SOAL 3: Query Kompleks & Agregasi Laporan
-- (SCPMK0720803 - WHERE, JOIN, Aggregasi)
-- Ekstraksi penarikan data
-- Nama : Ikhzaniero Ardyana Juniar | NIM : 264311070
-- =====================================================

USE etle_db_uts;

-- Laporan Ringkasan: total pelanggaran & rata-rata kecepatan per lokasi kamera
SELECT
    k.lokasi_kamera,                                   
    COUNT(d.no_referensi_sistem) AS total_pelanggaran,  
    AVG(d.kecepatan) AS rata_rata_kecepatan
FROM detail_pelanggaran d
JOIN kamera k ON d.id_kamera = k.id_kamera             
WHERE d.kecepatan > k.batas_kecepatan                  
GROUP BY k.lokasi_kamera;                               
