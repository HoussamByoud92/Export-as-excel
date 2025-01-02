-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 02 jan. 2025 à 15:16
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `hotelmanagementsystem`
--

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `ClientID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`ClientID`, `Name`, `Email`, `Phone`, `Address`, `CreatedAt`) VALUES
(1, 'osama', 'mansouri@s.do', '098124124', 'Marrakehc', '2025-01-01 18:20:14'),
(2, 'anas', 'anas@hotlam.s', '4234234', 'Marrkehc', '2025-01-02 01:02:57');

-- --------------------------------------------------------

--
-- Structure de la table `dataoperations`
--

CREATE TABLE `dataoperations` (
  `OperationID` int(11) NOT NULL,
  `OperationType` enum('Import','Export') NOT NULL,
  `FileName` varchar(255) DEFAULT NULL,
  `OperationDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `emailnotifications`
--

CREATE TABLE `emailnotifications` (
  `EmailID` int(11) NOT NULL,
  `ReservationID` int(11) NOT NULL,
  `EmailType` enum('Confirmation','Cancellation') DEFAULT NULL,
  `SentAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `logs`
--

CREATE TABLE `logs` (
  `LogID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `Action` varchar(255) DEFAULT NULL,
  `LogDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `payments`
--

CREATE TABLE `payments` (
  `PaymentID` int(11) NOT NULL,
  `ReservationID` int(11) NOT NULL,
  `AmountPaid` decimal(10,2) NOT NULL,
  `PaymentDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reservations`
--

CREATE TABLE `reservations` (
  `ReservationID` int(11) NOT NULL,
  `RoomID` int(11) NOT NULL,
  `ClientID` int(11) NOT NULL,
  `CheckInDate` date NOT NULL,
  `CheckOutDate` date NOT NULL,
  `NumberOfGuests` int(11) NOT NULL,
  `TotalPrice` decimal(10,2) NOT NULL,
  `Status` enum('Pending','Confirmed','Ended','Cancelled') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reservations`
--

INSERT INTO `reservations` (`ReservationID`, `RoomID`, `ClientID`, `CheckInDate`, `CheckOutDate`, `NumberOfGuests`, `TotalPrice`, `Status`) VALUES
(1, 4, 1, '2025-01-01', '2025-01-03', 3, 2400.00, 'Cancelled'),
(3, 1, 1, '2024-12-31', '2025-01-01', 2, 240.00, 'Ended'),
(4, 4, 1, '2025-01-04', '2025-01-05', 2, 400.00, 'Pending'),
(5, 1, 2, '2025-01-02', '2025-01-01', 2, 0.00, 'Ended');

-- --------------------------------------------------------

--
-- Structure de la table `rooms`
--

CREATE TABLE `rooms` (
  `RoomID` int(11) NOT NULL,
  `RoomNumber` varchar(50) NOT NULL,
  `RoomTypeID` int(11) NOT NULL,
  `Status` enum('Available','Occupied','Under Maintenance') DEFAULT 'Available',
  `PricePerNight` decimal(10,2) NOT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `rooms`
--

INSERT INTO `rooms` (`RoomID`, `RoomNumber`, `RoomTypeID`, `Status`, `PricePerNight`, `Description`) VALUES
(1, '101', 1, 'Available', 120.00, 'A cozy single room with great lighting'),
(2, '102', 2, 'Occupied', 150.00, 'A spacious suite with ocean view'),
(3, '103', 3, 'Under Maintenance', 200.00, 'A double room undergoing maintenance'),
(4, '104', 4, 'Available', 400.00, 'A luxurious presidential suite');

-- --------------------------------------------------------

--
-- Structure de la table `roomtypes`
--

CREATE TABLE `roomtypes` (
  `RoomTypeID` int(11) NOT NULL,
  `TypeName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `roomtypes`
--

INSERT INTO `roomtypes` (`RoomTypeID`, `TypeName`) VALUES
(5, 'Connecting Rooms'),
(6, 'Deluxe Room'),
(3, 'Double Room'),
(7, 'Junior Suite'),
(9, 'Penthouse Suite'),
(4, 'Presidential Suite'),
(1, 'Single Room'),
(2, 'Suite'),
(8, 'Triple Room');

-- --------------------------------------------------------

--
-- Structure de la table `tasks`
--

CREATE TABLE `tasks` (
  `TaskID` int(11) NOT NULL,
  `RoomID` int(11) NOT NULL,
  `Description` text NOT NULL,
  `AssignedTo` int(11) DEFAULT NULL,
  `Status` enum('Pending','In Progress','Completed') NOT NULL DEFAULT 'Pending',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `CompletedAt` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `tasks`
--

INSERT INTO `tasks` (`TaskID`, `RoomID`, `Description`, `AssignedTo`, `Status`, `CreatedAt`, `CompletedAt`) VALUES
(7, 1, 'Clean the bathroom', 20, 'In Progress', '2025-01-02 13:38:14', NULL),
(8, 2, 'Clean the toilet', 20, 'Completed', '2025-01-02 13:45:16', '2025-01-02 13:45:48'),
(9, 2, 'Deep clean the kitchen area.', 20, 'In Progress', '2025-01-02 14:03:13', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Role` enum('Admin','Receptionist','Housekeeping Staff','Room Service Staff') DEFAULT 'Receptionist',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`UserID`, `Name`, `Email`, `Password`, `Role`, `CreatedAt`) VALUES
(2, 'Admin User', 'admin@hotel.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Admin', '2024-12-31 01:23:12'),
(8, 'receptionist', 'receptionist@hotel.com', 'a27dce9d8b5488238487ca36967563b7487b12232e3d1cb98442360f033cfbd7', 'Receptionist', '2025-01-01 12:58:01'),
(11, 'receptionist2', 'receptionist2@hotel.com', '2d3abe11a58a01ad00ad18672c6cdff82fcccbb3e7a88f34f19c8c59e3ea8534', 'Receptionist', '2025-01-01 16:29:04'),
(19, 'Front Office Manager', 'admin@hotelme.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'Admin', '2025-01-02 11:07:42'),
(20, 'Amine', 'housekeeping@hotelme.com', 'c26871f992648a4801848b93f9ccb46f32b89005efed76c83b09f742da142478', 'Housekeeping Staff', '2025-01-02 11:08:31'),
(21, 'Anas', 'roomservice@hotelme.com', '333afe3b4a3ad9199a68026887f192e9ccf5291bf0fdc31b2e2a4897498795e0', 'Room Service Staff', '2025-01-02 11:09:08');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`ClientID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Index pour la table `dataoperations`
--
ALTER TABLE `dataoperations`
  ADD PRIMARY KEY (`OperationID`);

--
-- Index pour la table `emailnotifications`
--
ALTER TABLE `emailnotifications`
  ADD PRIMARY KEY (`EmailID`),
  ADD KEY `ReservationID` (`ReservationID`);

--
-- Index pour la table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`LogID`),
  ADD KEY `UserID` (`UserID`);

--
-- Index pour la table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`PaymentID`),
  ADD KEY `ReservationID` (`ReservationID`);

--
-- Index pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`ReservationID`),
  ADD KEY `RoomID` (`RoomID`),
  ADD KEY `ClientID` (`ClientID`);

--
-- Index pour la table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`RoomID`),
  ADD UNIQUE KEY `RoomNumber` (`RoomNumber`),
  ADD KEY `RoomTypeID` (`RoomTypeID`);

--
-- Index pour la table `roomtypes`
--
ALTER TABLE `roomtypes`
  ADD PRIMARY KEY (`RoomTypeID`),
  ADD UNIQUE KEY `TypeName` (`TypeName`);

--
-- Index pour la table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`TaskID`),
  ADD KEY `RoomID` (`RoomID`),
  ADD KEY `AssignedTo` (`AssignedTo`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `clients`
--
ALTER TABLE `clients`
  MODIFY `ClientID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `dataoperations`
--
ALTER TABLE `dataoperations`
  MODIFY `OperationID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `emailnotifications`
--
ALTER TABLE `emailnotifications`
  MODIFY `EmailID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `logs`
--
ALTER TABLE `logs`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `payments`
--
ALTER TABLE `payments`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `ReservationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `RoomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `roomtypes`
--
ALTER TABLE `roomtypes`
  MODIFY `RoomTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `TaskID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `emailnotifications`
--
ALTER TABLE `emailnotifications`
  ADD CONSTRAINT `emailnotifications_ibfk_1` FOREIGN KEY (`ReservationID`) REFERENCES `reservations` (`ReservationID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`ReservationID`) REFERENCES `reservations` (`ReservationID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`RoomID`) REFERENCES `rooms` (`RoomID`),
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`ClientID`) REFERENCES `clients` (`ClientID`);

--
-- Contraintes pour la table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`RoomTypeID`) REFERENCES `roomtypes` (`RoomTypeID`);

--
-- Contraintes pour la table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`RoomID`) REFERENCES `rooms` (`RoomID`),
  ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`AssignedTo`) REFERENCES `users` (`UserID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
