-- =====================================================
-- UTS: Penambahan Fitur Riwayat Notifikasi Tilang
-- Nama : Ikhzaniero Ardyana Juniar | NIM : 264311070
-- Dijalankan setelah soal1_ddl.sql dan soal2_crud.sql
-- =====================================================

USE etle_db_uts;

CREATE TABLE riwayat_notifikasi (
    id_notifikasi        INT          NOT NULL AUTO_INCREMENT,
    no_referensi_sistem  VARCHAR(30)  NOT NULL,
    media_kirim          VARCHAR(20)  NOT NULL,
    tgl_kirim            DATETIME     NOT NULL,
    status_kirim         VARCHAR(20)  NOT NULL DEFAULT 'Terkirim',
    keterangan           VARCHAR(200) NULL,
    PRIMARY KEY (id_notifikasi),
    FOREIGN KEY (no_referensi_sistem) REFERENCES detail_pelanggaran(no_referensi_sistem),
    CONSTRAINT chk_media CHECK (media_kirim IN ('Pos', 'SMS', 'WhatsApp', 'Email')),
    CONSTRAINT chk_status_kirim CHECK (status_kirim IN ('Terkirim', 'Gagal', 'Diterima'))
);

-- Data dummy
INSERT INTO riwayat_notifikasi
(no_referensi_sistem, media_kirim, tgl_kirim, status_kirim, keterangan) VALUES
('910-50639-AE1270CR', 'Pos',      '2026-03-06 10:00:00', 'Diterima', 'Surat konfirmasi diterima pemilik'),
('910-50700-N4321AB',  'WhatsApp', '2026-03-07 09:30:00', 'Gagal',    'Nomor tujuan tidak aktif');

SELECT * FROM riwayat_notifikasi;
