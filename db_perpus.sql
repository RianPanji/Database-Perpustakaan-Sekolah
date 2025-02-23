-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 23, 2025 at 02:55 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpus`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteBuku` (IN `p_id` INT)   BEGIN
    DELETE FROM Buku
    WHERE ID_Buku = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePeminjaman` (IN `p_id` INT)   BEGIN
    DELETE FROM Peminjaman
    WHERE ID_Peminjaman = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteSiswa` (IN `p_id` INT)   BEGIN
    DELETE FROM Siswa
    WHERE ID_Siswa = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDataBuku` ()   BEGIN
    INSERT INTO buku (judul_buku, penulis, kategori, stok) VALUES
    ('Algoritma dan Pemrograman', 'Andi Wijaya', 'Teknologi', 5),
    ('Dasar-dasar Database', 'Budi Santoso', 'Teknologi', 7),
    ('Matematika Diskrit', 'Rina Sari', 'Matematika', 4),
    ('Sejarah Dunia', 'Novi Indah', 'Sejarah', 6),
    ('Pemrograman Web dengan PHP', 'Eko Prasetyo', 'Teknologi', 3),
    ('Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 5),
    ('Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 8),
    ('Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 5),
    ('Biologi Dasar', 'Budi Rahman', 'Sains', 7),
    ('Statistika Dasar', 'Sinta Agustin', 'Matematika', 6);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDataPeminjaman` ()   BEGIN
    INSERT INTO Peminjaman (ID_Siswa, ID_Buku, Tanggal_Pinjam, Tanggal_Kembali, Status) VALUES
    (1, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
    (2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
    (3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
    (4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan'),
    (5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan'),
    (6, 1, '2025-02-03', '2025-02-10', 'Dipinjam'),
    (7, 4, '2025-02-05', '2025-02-12', 'Dikembalikan'),
    (8, 6, '2025-02-06', '2025-02-13', 'Dipinjam'),
    (9, 7, '2025-02-07', '2025-02-14', 'Dikembalikan'),
    (10, 9, '2025-02-08', '2025-02-15', 'Dipinjam');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertSiswa` ()   BEGIN
    INSERT INTO Siswa (Nama, Kelas) VALUES
    ('Andi Saputra', 'X-RPL'),
    ('Budi Wijaya', 'X-TKJ'),
    ('Citra Lestari', 'XI-RPL'),
    ('Dewi Kurniawan', 'XI-TKJ'),
    ('Eko Prasetyo', 'XII-RPL'),
    ('Farhan Maulana', 'X-RPL'),
    ('Gita Permata', 'X-TKJ'),
    ('Hadi Sucipto', 'XI-RPL'),
    ('Intan Permadi', 'XI-TKJ'),
    ('Joko Santoso', 'XII-RPL');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `KembalikanBuku` (IN `p_id_peminjaman` INT)   BEGIN
    UPDATE Peminjaman
    SET Status = 'Dikembalikan',
        Tanggal_Kembali = CURRENT_DATE()
    WHERE ID_Peminjaman = p_id_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllBuku` ()   BEGIN
    SELECT * FROM Buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllBukuWithPeminjaman` ()   BEGIN
    SELECT 
        b.ID_Buku, 
        b.Judul_Buku, 
        b.Penulis, 
        b.Kategori, 
        b.Stok, 
        p.ID_Peminjaman, 
        p.Status, 
        p.Tanggal_Pinjam, 
        p.Tanggal_Kembali
    FROM Buku b
    LEFT JOIN Peminjaman p ON b.ID_Buku = p.ID_Buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllPeminjaman` ()   BEGIN
    SELECT * FROM Peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllSiswa` ()   BEGIN
    SELECT * FROM Siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllSiswaWithPeminjaman` ()   BEGIN
    SELECT s.ID_Siswa, s.Nama, s.Kelas, p.ID_Peminjaman, p.Tanggal_Pinjam, p.Tanggal_Kembali, p.Status
    FROM Siswa s
    LEFT JOIN Peminjaman p ON s.ID_Siswa = p.ID_Siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectSiswaPernahPinjam` ()   BEGIN
    SELECT DISTINCT s.ID_Siswa, s.Nama, s.Kelas
    FROM Siswa s
    INNER JOIN Peminjaman p ON s.ID_Siswa = p.ID_Siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBuku` (IN `p_id` INT, IN `p_judul` VARCHAR(100), IN `p_penulis` VARCHAR(50), IN `p_kategori` VARCHAR(30), IN `p_stok` INT)   BEGIN
   	 UPDATE Buku
  SET Judul_Buku = p_judul,
       Penulis = p_penulis,
      	  Kategori = p_kategori,
        	Stok = p_stok
    WHERE ID_Buku = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePeminjaman` (IN `p_id` INT, IN `p_id_siswa` INT, IN `p_id_buku` INT, IN `p_tanggal_pinjam` DATE, IN `p_tanggal_kembali` DATE, IN `p_status` VARCHAR(20))   BEGIN
    UPDATE Peminjaman
    SET ID_Siswa = p_id_siswa,
        ID_Buku = p_id_buku,
        Tanggal_Pinjam = p_tanggal_pinjam,
        Tanggal_Kembali = p_tanggal_kembali,
        Status = p_status
    WHERE ID_Peminjaman = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateSiswa` (IN `p_id` INT, IN `p_nama` VARCHAR(50), IN `p_kelas` VARCHAR(10))   BEGIN
    UPDATE Siswa
    SET Nama = p_nama,
        Kelas = p_kelas
    WHERE ID_Siswa = p_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL,
  `judul_buku` varchar(50) DEFAULT NULL,
  `penulis` varchar(50) DEFAULT NULL,
  `kategori` varchar(50) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id_buku`, `judul_buku`, `penulis`, `kategori`, `stok`) VALUES
(1, 'Algoritma dan Pemrograman', 'Andi Wijaya', 'Teknologi', 5),
(2, 'Dasar-dasar Database', 'Budi Santoso', 'Teknologi', 7),
(3, 'Matematika Diskrit', 'Rina Sari', 'Matematika', 4),
(4, 'Sejarah Dunia', 'John Smith', 'Sejarah', 3),
(5, 'Pemrograman Web dengan PHP', 'Eko Prasetyo', 'Teknologi', 8);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_siswa` int(11) DEFAULT NULL,
  `id_buku` int(11) DEFAULT NULL,
  `tanggal_pinjam` date DEFAULT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_siswa`, `id_buku`, `tanggal_pinjam`, `tanggal_kembali`, `status`) VALUES
(1, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(2, 3, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(3, 5, 3, '2025-02-03', '2025-02-09', 'Dipinjam'),
(4, 10, 10, '2025-02-10', '2025-02-18', 'Dikembalikan'),
(5, 3, 8, '2025-01-25', '2025-01-29', 'Dipinjam');

--
-- Triggers `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `after_peminjaman_insert` AFTER INSERT ON `peminjaman` FOR EACH ROW BEGIN
    IF NEW.Status = 'Dipinjam' THEN
        UPDATE Buku
        SET Stok = Stok - 1
        WHERE ID_Buku = NEW.ID_Buku;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_peminjaman_update` AFTER UPDATE ON `peminjaman` FOR EACH ROW BEGIN
    IF NEW.Status = 'Dikembalikan' AND OLD.Status <> 'Dikembalikan' THEN
        UPDATE Buku
        SET Stok = Stok + 1
        WHERE ID_Buku = NEW.ID_Buku;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `kelas` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id`, `nama`, `kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari', 'XI-RPL'),
(4, 'Dewi Kurniawan', 'XI-TKJ'),
(5, 'Eko Prasetyo', 'XII-RPL');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
