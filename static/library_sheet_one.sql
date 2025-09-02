-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 31, 2025 at 10:41 AM
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
-- Database: `library_sheet_one`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(100) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `publish_year` year(4) DEFAULT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `copies` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `title`, `author`, `category`, `publish_year`, `isbn`, `copies`) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', '1925', '9780743273565', 3),
(2, '1984', 'George Orwell', 'Dystopian', '1949', '9780451524935', 2),
(3, 'To Kill a Mockingbird', 'Harper Lee', 'Classic', '1960', '9780060935467', 4),
(4, 'The Catcher in the Rye', 'J.D. Salinger', 'Classic', '1951', '9780316769488', 2),
(5, 'Moby Dick', 'Herman Melville', 'Adventure', '0000', '9780142437247', 1),
(6, 'Pride and Prejudice', 'Jane Austen', 'Romance', '0000', '9780141040349', 5),
(7, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', '1937', '9780547928227', 4),
(8, 'Brave New World', 'Aldous Huxley', 'Science Fiction', '1932', '9780060850524', 2),
(9, 'Fahrenheit 451', 'Ray Bradbury', 'Science Fiction', '1953', '9781451673319', 3),
(10, 'Jane Eyre', 'Charlotte Brontë', 'Romance', '0000', '9780141441146', 3),
(11, 'Wuthering Heights', 'Emily Brontë', 'Drama', '0000', '9780141439556', 2),
(12, 'Animal Farm', 'George Orwell', 'Political Satire', '1945', '9780451526342', 6),
(13, 'The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', '1954', '9780544003415', 2),
(14, 'The Alchemist', 'Paulo Coelho', 'Philosophy', '1988', '9780061122415', 4),
(15, 'The Book Thief', 'Markus Zusak', 'Historical Fiction', '2005', '9780375842207', 2),
(16, 'A Tale of Two Cities', 'Charles Dickens', 'Historical Fiction', '0000', '9780486417769', 3),
(17, 'Dracula', 'Bram Stoker', 'Horror', '0000', '9780486411095', 2),
(18, 'Frankenstein', 'Mary Shelley', 'Horror', '0000', '9780486282114', 3),
(19, 'The Da Vinci Code', 'Dan Brown', 'Thriller', '2003', '9780307474278', 5),
(20, 'The Hunger Games', 'Suzanne Collins', 'Dystopian', '2008', '9780439023528', 4),
(21, '', '', '', '0000', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `borrow_records`
--

CREATE TABLE `borrow_records` (
  `record_id` int(11) NOT NULL,
  `member_id` int(11) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL,
  `borrow_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `status` enum('borrowed','returned') DEFAULT 'borrowed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrow_records`
--

INSERT INTO `borrow_records` (`record_id`, `member_id`, `book_id`, `borrow_date`, `return_date`, `status`) VALUES
(1, 1, 2, '2024-01-01', '2024-01-15', 'returned'),
(2, 2, 5, '2024-01-03', NULL, 'borrowed'),
(3, 3, 1, '2024-01-10', '2024-01-20', 'returned'),
(4, 4, 8, '2024-01-12', NULL, 'borrowed'),
(5, 5, 7, '2024-01-15', NULL, 'borrowed'),
(6, 6, 10, '2024-01-20', '2024-02-05', 'returned'),
(7, 1, 3, '2024-02-01', NULL, 'borrowed'),
(8, 3, 6, '2024-02-10', '2024-02-28', 'returned'),
(9, 7, 12, '2024-02-20', NULL, 'borrowed'),
(10, 9, 4, '2024-03-01', NULL, 'borrowed');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `member_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `register_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`member_id`, `name`, `email`, `phone`, `address`, `register_date`) VALUES
(1, 'John Doe', 'john@example.com', '0812345678', '123 Main St, BKK', '2023-01-10'),
(2, 'Jane Smith', 'jane@example.com', '0898765432', '456 Second Rd, CM', '2023-02-05'),
(3, 'Alice Johnson', 'alice@example.com', '0823456789', '789 Third Ln, Phuket', '2023-03-01'),
(4, 'Bob Brown', 'bob@example.com', '0834567890', '321 Fourth Ave, Khon Kaen', '2023-04-10'),
(5, 'Charlie Lee', 'charlie@example.com', '0845678901', '987 Fifth Blvd, Udon Thani', '2023-05-15'),
(6, 'Diana King', 'diana@example.com', '0856789012', '654 Sixth St, Hat Yai', '2023-06-20'),
(7, 'Ethan Young', 'ethan@example.com', '0867890123', '147 Seventh Pl, Rayong', '2023-07-01'),
(8, 'Fiona White', 'fiona@example.com', '0878901234', '258 Eighth Dr, Nakhon Pathom', '2023-08-12'),
(9, 'George Green', 'george@example.com', '0889012345', '369 Ninth Ct, Nakhon Ratchasima', '2023-09-18'),
(10, 'Hannah Black', 'hannah@example.com', '0890123456', '741 Tenth Way, Chiang Rai', '2023-10-25');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `borrow_records`
--
ALTER TABLE `borrow_records`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`member_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `borrow_records`
--
ALTER TABLE `borrow_records`
  MODIFY `record_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `member_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `borrow_records`
--
ALTER TABLE `borrow_records`
  ADD CONSTRAINT `borrow_records_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`),
  ADD CONSTRAINT `borrow_records_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
