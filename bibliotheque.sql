-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  mer. 30 oct. 2019 à 12:00
-- Version du serveur :  10.1.31-MariaDB
-- Version de PHP :  7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `bibliotheque`
--

-- --------------------------------------------------------

--
-- Structure de la table `abonne`
--

CREATE TABLE `abonne` (
  `id_abonne` int(3) NOT NULL,
  `prenom` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `abonne`
--

INSERT INTO `abonne` (`id_abonne`, `prenom`) VALUES
(1, 'Guillaume'),
(2, 'Benoit'),
(3, 'Chloé'),
(4, 'Laura');

-- --------------------------------------------------------

--
-- Structure de la table `emprunt`
--

CREATE TABLE `emprunt` (
  `id_emprunt` int(3) NOT NULL,
  `livre_id` int(3) NOT NULL,
  `abonne_id` int(3) NOT NULL,
  `date_sortie` date NOT NULL,
  `date_rendu` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `emprunt`
--

INSERT INTO `emprunt` (`id_emprunt`, `livre_id`, `abonne_id`, `date_sortie`, `date_rendu`) VALUES
(1, 100, 1, '2014-12-17', '2014-12-18'),
(2, 101, 2, '2014-12-18', '2014-12-20'),
(3, 100, 3, '2014-12-19', '2014-12-22'),
(4, 103, 4, '2014-12-19', '2014-12-22'),
(5, 104, 1, '2014-12-19', '2014-12-28'),
(6, 105, 2, '2015-03-20', '2015-03-26'),
(7, 105, 3, '2015-06-13', NULL),
(8, 100, 2, '2015-06-15', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `livre`
--

CREATE TABLE `livre` (
  `id_livre` int(3) NOT NULL,
  `auteur` varchar(20) NOT NULL,
  `titre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `livre`
--

INSERT INTO `livre` (`id_livre`, `auteur`, `titre`) VALUES
(100, 'GUY DE MAUPASSANT', 'Une vie'),
(101, 'GUY DE MAUPASSANT', 'Bel-Ami'),
(102, 'HONORE DE BALZAC', 'Le pere Goriot'),
(103, 'ALPHONSE DAUDET', 'Le Petit chose'),
(104, 'ALEXANDRE DUMAS', 'La Reine Margot'),
(105, 'ALEXANDRE DUMAS', 'Les Trois Mousquetaires');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `abonne`
--
ALTER TABLE `abonne`
  ADD PRIMARY KEY (`id_abonne`);

--
-- Index pour la table `emprunt`
--
ALTER TABLE `emprunt`
  ADD PRIMARY KEY (`id_emprunt`);

--
-- Index pour la table `livre`
--
ALTER TABLE `livre`
  ADD PRIMARY KEY (`id_livre`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `abonne`
--
ALTER TABLE `abonne`
  MODIFY `id_abonne` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `emprunt`
--
ALTER TABLE `emprunt`
  MODIFY `id_emprunt` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `livre`
--
ALTER TABLE `livre`
  MODIFY `id_livre` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
