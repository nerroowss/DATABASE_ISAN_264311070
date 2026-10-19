-- =====================================================
-- SOAL 1: Data Definition & Relasi
-- (SCPMK0720801 - DDL & Relasi)
-- Pembuatan struktur fisik dan ketepatan relasi
-- Nama : Ikhzaniero Ardyana Juniar | NIM : 264311070
-- =====================================================

CREATE DATABASE IF NOT EXISTS etle_db;
USE etle_db;

DROP TABLE IF EXISTS detail_pelanggaran;
DROP TABLE IF EXISTS aturan_pasal;
DROP TABLE IF EXISTS kamera;

-- TABEL INDUK 1
CREATE TABLE kamera (
    id_kamera        VARCHAR(20)  NOT NULL,
    lokasi_kamera    VARCHAR(100) NOT NULL,
    batas_kecepatan  INT          NOT NULL,
    PRIMARY KEY (id_kamera)
);

-- TABEL INDUK 2
CREATE TABLE aturan_pasal (
    kode_pelanggaran      VARCHAR(10)  NOT NULL,
    kategori_pelanggaran  VARCHAR(100) NOT NULL,
    pasal_pelanggaran     VARCHAR(100) NOT NULL,
    PRIMARY KEY (kode_pelanggaran)
);

-- TABEL TRANSAKSI (anak dari kedua induk)
CREATE TABLE detail_pelanggaran (
    no_referensi_sistem VARCHAR(30)  NOT NULL,
    id_kamera           VARCHAR(20)  NOT NULL,
    kode_pelanggaran    VARCHAR(10)  NOT NULL,
    nomor_polisi        VARCHAR(12)  NOT NULL,
    waktu_capture       DATETIME     NOT NULL,
    kecepatan           INT,
    status_verifikasi   VARCHAR(20)  NOT NULL DEFAULT 'Menunggu',
    PRIMARY KEY (no_referensi_sistem),
    FOREIGN KEY (id_kamera) REFERENCES kamera(id_kamera),
    FOREIGN KEY (kode_pelanggaran) REFERENCES aturan_pasal(kode_pelanggaran)
);
