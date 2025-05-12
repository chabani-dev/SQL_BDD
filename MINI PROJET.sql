-------------------MINI PROJET--------------------

-- 1.creez une base de données magasin

-- 2. creez 3 table: 
-- 	- client : id (INT , NOT NULL,AUTO_INCREMENT), nom (VARCHAR(50),NOT NULL) , adresse (VARCHAR(100),NOT NULL), PRIMARY KEY (id)
-- 	- commande : id (INT , NOT NULL,AUTO_INCREMENT),client_id (INT, NOT NULL),produit_id(INT, NOT NULL),quantite (INT ,NOT NULL), PRIMARY KEY (id)
-- 	- produit : id (INT , NOT NULL,AUTO_INCREMENT) ,nom (VARCHAR(50)),prix (DECIMAL(10, 2) NOT NULL),PRIMARY KEY (id)

-- 3. inserer ces données:

-- inserez 5 client avec leurs adresse
-- 5 produits (des type de vetements ou accessoires) et leurs tarifs

-- 10 commande composé donc d'un client_id , d'un produit_id et d'une quantité



-- 4. creez 3 fonction:

-- Fonction 1 : fn_CountOrdersByClient(client_id) : Cette fonction retourne le nombre de commandes passées par un client donné.

-- Fonction 2 : fn_GetTotalPriceByOrder(order_id) : Cette fonction retourne le prix total d'une commande donnée (quantité * prix unitaire).

-- Fonction 3 : fn_GetAveragePriceByClient(client_id) : Cette fonction retourne le prix moyen des commandes passées par un client donné.


-- 5. Question(en utilisant les fonctions)

-- combien de commmande ont effectuer les clients 2 et 3 ?

-- quel est le total de la commande 5 ?

-- quel est le prix moyen du panier du client 1 ?


-- 6.requetes 

-- 1.Affichez tous les clients qui ont passé une commande 
-- 2.Affichez  les produits commandés par le client avec l'ID 3 
-- 3.Affichez  les clients qui ont commandé un produit dont le prix est supérieur à 30 
-- 4.Affichez  les produits avec leur quantité commandée pour chaque commande 
-- 5.Affichez  les clients qui n'ont pas passé de commande 
-- 6.Affichez  le prix moyen des produits 
-- 7.Affichez les produits qui n'ont pas été commandés 
-- 8.Affichez les clients avec le montant total de leurs commandes 


--reponse projet
--création  de la base de donnée 

CREATE DATABASE magasin IF NOT EXISTS
-- création les tables
USE magasin;

CREATE TABLE client
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    prenom VARCHAR (50) ,
    adresse VARCHAR(200) NOT NULL
);

CREATE TABLE commande
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    quantite INT NOT NULL,
    client_id INT NOT NULL,
    produit_id INT NOT NULL
);

CREATE TABLE produit
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prix DECIMAL(10, 2) NOT NULL
);



-- 3. inserer ces données:

-- inserez 5 client avec leurs adresse

INSERT INTO `client` (`prenom`, `adresse`) VALUES
('Gustave', 'Paris'),
('Gustave', 'Marseille'),
('Emilien','Toulouse'),
('Emilien' , 'Saint-Etienne');

-- 5 produits (des type de vetements ou accessoires) et leurs tarifs


INSERT INTO `produit` (`nom`, `prix`) VALUES
('chaussure', 23),
('chemise' ,45 ),
('robe', 77),
('veste', 102);

-- 10 commande composé donc d'un client_id , d'un produit_id et d'une quantité

INSERT INTO `commande` (`quantite`, `client_id` , `produit_id` ) VALUES
(24, 1 ,1 ),
(44, 1, 2),
(66 , 2,3);

-- 4. creez 3 fonction:
-- Fonction 1 : fn_CountOrdersByClient(client_id) : Cette fonction retourne le nombre de commandes passées par un client donné.

DELIMITER //
CREATE FUNCTION fn_CountOrdersByClient(client_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE nombreCommande INT;

    SELECT COUNT(*) INTO nombreCommande FROM commande WHERE client_id = client_id;

    RETURN nombreCommande;
END //
DELIMITER ;


-- Fonction 2 : fn_GetTotalPriceByOrder(order_id) : Cette fonction retourne le prix total d'une commande donnée (quantité * prix unitaire).

DELIMITER //
CREATE FUNCTION fn_GetTotalPriceByOrder(order_id INT)
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE prixTotal DECIMAL(10, 2);

    SELECT SUM(quantite * prix) INTO prixTotal 
    FROM commande 
    WHERE id = order_id;

    RETURN prixTotal;
END //
DELIMITER ;

-- Fonction 3 : fn_GetAveragePriceByClient(client_id) : Cette fonction retourne le prix moyen des commandes passées par un client donné.

DELIMITER //

CREATE FUNCTION fn_GetAveragePriceByClient(p_client_id INT)
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
  DECLARE prixMoyen DECIMAL(10, 2);
  
  SELECT AVG(quantite * prix) INTO prixMoyen
  FROM commande
  WHERE client_id = p_client_id;

  RETURN prixMoyen;
END //

DELIMITER ;


--combien de commmande ont effectuer les clients 2 et 3 
SELECT client_id, COUNT(*) AS nombreCommandes
FROM commande
WHERE client_id IN (2, 3)
GROUP BY client_id;

--quel est le total de la commande 5 ?

SELECT SUM(c.quantite * p.prix) AS totalCommande
FROM commande client
INNER JOIN produit p ON c.produit_id = p.id
WHERE c.id = 3;


--quel est le prix moyen du panier du client 1 ?

SELECT AVG(prixTotal) AS prixMoyenPanier
FROM (
    SELECT SUM(client.quantite * produit.prix) AS prixTotal
    FROM commande c
    INNER JOIN produit p ON client.produit_id = produit.id
    WHERE client.client_id = 1
    GROUP BY client.id
) prixTotals;

--1.Affichez tous les clients qui ont passé une commande 
SELECT DISTINCT c.id, c.prenom, c.adresse
FROM client c
JOIN commande cmd ON c.id = cmd.client_id;

-- 2.Affichez  les produits commandés par le client avec l'ID 3 
SELECT prduit.nom 
FROM produit
inner JOIN commande ON produit_id = commande.prduit.id
WHERE c.client_id = 3;

-- 3.Affichez  les clients qui ont commandé un produit dont le prix est supérieur à 30 

SELECT DISTINCT client.prenom , produit.prix
FROM client c , produit.p
INNER JOIN commande ON produit.id = commande.produit_id
WHERE p.prix > 30;



-- 4.Affichez  les produits avec leur quantité commandée pour chaque commande 
SELECT commande.id AS commande_id, p.id AS produit_id, prduit.nom AS nom_produit, cmd.quantite
FROM commande cmd
JOIN produit p ON cmd.produit_id = p.id
ORDER BY cmd.id, p.id;


-- 5.Affichez  les clients qui n'ont pas passé de commande 
SELECT c.id, c.prenom, c.adresse
FROM client c
LEFT JOIN commande cmd ON c.id = cmd.client_id
WHERE cmd.client_id IS NULL;


-- 6.Affichez  le prix moyen des produits 
SELECT AVG(prix) AS prixMoyenProduits
FROM produit;


-- 7.Affichez les produits qui n'ont pas été commandés 

SELECT p.id, p.nom, p.prix
FROM produit p
LEFT JOIN commande cmd ON p.id = cmd.produit_id
WHERE cmd.produit_id IS NULL;

-- 8.Affichez les clients avec le montant total de leurs commandes 

SELECT c.id, c.prenom, c.adresse, SUM(cmd.quantite * p.prix) AS montantTotal
FROM client c
LEFT JOIN commande cmd ON c.id = cmd.client_id
LEFT JOIN produit p ON cmd.produit_id = p.id
GROUP BY c.id, c.prenom, c.adresse
ORDER BY montantTotal DESC;