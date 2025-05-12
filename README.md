1. CREATE DATABASE et CREATE TABLE
Ces commandes permettent de créer une base de données et des tables.

CREATE DATABASE MaBase;
USE MaBase;

CREATE TABLE Utilisateurs (
    id INT PRIMARY KEY,
    nom VARCHAR(50),
    age INT
);
Cela crée une base de données MaBase et une table Utilisateurs avec trois colonnes.
2. La jointure (JOIN)
Les jointures permettent de relier des tables entre elles.
CREATE TABLE Commandes (
    id INT PRIMARY KEY,
    utilisateur_id INT,
    produit VARCHAR(50),
    FOREIGN KEY (utilisateur_id) REFERENCES Utilisateurs(id)
);

SELECT Utilisateurs.nom, Commandes.produit 
FROM Utilisateurs 
JOIN Commandes ON Utilisateurs.id = Commandes.utilisateur_id;

Cela récupère le nom de l'utilisateur et le produit qu'il a commandé.
3. INSERT INTO ... SELECT FROM
Cette commande permet d'insérer des données issues d'une autre table.
INSERT INTO Utilisateurs (id, nom, age)
SELECT id, nom, age FROM Clients;
****DELIMITER $$
CREATE FUNCTION CalculerAge(annee_naissance INT) RETURNS INT 
BEGIN
    RETURN YEAR(CURDATE()) - annee_naissance;
END $$
****DELIMITER ;

Cette fonction calcule l'âge à partir de l'année de naissance.

5. Les triggers
Un trigger est un mécanisme qui exécute une action lorsqu'un événement se produit (INSERT, UPDATE, DELETE).
****DELIMITER $$
CREATE TRIGGER AvantInsertionCommande 
BEFORE INSERT ON Commandes 
FOR EACH ROW 
BEGIN
    IF NEW.produit = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Le produit ne peut pas être vide';
    END IF;
END $$
****DELIMITER ;
Ce trigger empêche l'insertion d'une commande si le champ produit est vide.
