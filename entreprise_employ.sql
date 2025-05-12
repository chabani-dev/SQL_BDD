--requete de selection des employes--
SHOW DATABASES; --affiche la base de données--

USE entreprise; -- selectionné une base de données--

CREATE DATABASE test; -- crée une base de données --

DROP DATABASE test ; -- supprimé une base de données --

--SELECT --

SELECT * FROM employes; --afficher tous les employés

SELECT nom , prenom, service FROM `employes`;

--affiche tout les service  de la table employes --

SELECT service FROM `employes`;

--affiche tout les service  de la table employes sans doublons --
SELECT DISTINCT service FROM employes;

-- selection des employes du service informatique --
SELECT * FROM where service = 'informatique';

-- where permet de filtrer les données (condition) à condition que --
-- where n'apparait qu'une seul fois dans une requete 

-- exo Affichage des employés ayant été  recruter entre 2010 et aujourd'hui --

SELECT * FROM employes WHERE date_embauche BETWEEN '2010-07-05' AND '2024-04-22';-- la date dur --

SELECT * FROM employes WHERE date_embauche BETWEEN DATE_SUB(CURDATE(), INTERVAL 14 YEAR) AND CURDATE();

-- CURDATE me permet de récupérer la date du jour 

-- exo Affichage des employés ayant un prénom commencant par la lettre 's'.

SELECT * FROM employes WHERE nom LIKE 's%';
-- like permet de faire  une recherche sur une chaine de caréctaire
-- % permet de dire que la caractère peut être suivi de n'importe quel caractère

-- exo affichage des employé ayant un  prénom composé

SELECT * FROM employes WHERE prenom LIKE '%-%';

/*
OPERATEURS DE COMPARAISON 
= égal
< inférieur
> supérieur
<= inférieur ou égal
>= supérieur ou égal
!= ou <> différent
OR ou 
AND  et
*/
-- Affichage de tous les employes (sauf les informaticiens) 
SELECT prenom, nom, service FROM employes WHERE service != 'informatique';

-- Affichage de tous les employés gagnant un salaire supérieur à 3000€ 
SELECT prenom, nom, salaire FROM employes WHERE salaire > 3000;

-- Affichage des employes dans l'ordre alphabétique
SELECT prenom FROM employes ORDER BY prenom ASC;
--ASC permet de trier par ordre croissant
--DESC permet de trier par ordre décroissant

--exo Affichage des employés 3 par 3 --

SELECT prenom FROM employes ORDER BY prenom LIMIT 0,3;

SELECT prenom FROM employes ORDER BY prenom LIMIT 3,3;

SELECT prenom FROM employes prenom LIMIT 3 OFFSET 3;

-- SELECT nom, prenom, service FROM ( SELECT nom, prenom, service, ROW_NUMBER() OVER (ORDER BY nom) AS row_num FROM employes ) AS subquery GROUP BY row_num DIV 3 ORDER BY row_num;


-- exo afficher le salaire annuel employer

SELECT nom, prenom , salaire * 12 AS salaire_annuel FROM employes ;

-- exo afficher la masse salariale

SELECT nom, prenom, salaire SUM(salaire * 12) AS masse_salariale FROM employes;

-- calculer le salaire moyen

SELECT ROUND(AVG(salaire),2) AS 'Salaire moyen' FROM employes;


--SUM (fonction prédéfinie SQL)-> permet de faire la somme
--AVG (fonction prédéfinie SQL)-> permet de faire la moyenne
--ROUND (fonction prédéfinie SQL)-> permet d'arrondir ex : ROUND(3.14159,2) = 3.14


-- affiche le nombre de  femme dans l'entreprise

SELECT COUNT (*) AS 'Nbre de femme' FROM employer where sexe= 'f';


-- afficher le salaire min et max 

SELECT min(salaire) AS 'salaire min' FROM employer;
SELECT max (salaire) AS 'salaire max' FROM employer;

--MIN (fonction prédéfinie SQL)-> permet de trouver le minimum
--MAX (fonction prédéfinie SQL)-> permet de trouver le maximum

-- Affichage des employés travaillant au service comptabilité et informatique
-- SELECT prenom, nom, service FROM employes WHERE service = 'comptabilité' OR service = 'informatique';
SELECT prenom, nom, service FROM employes WHERE service IN ('comptabilité', 'informatique');
-- IN permet de faire une recherche sur plusieurs valeurs

-- afficher des employés du service commercial gagnant de 2300 ou 1900

SELECT nom FROM employes WHERE service = 'service commercial' AND salaire IN (2300, 1900);

-- exo Affichage des employés du service commercial gagnant un salaire de 2300€ ou 1900€
SELECT prenom, nom, salaire, service FROM employes WHERE service = 'commercial' AND (salaire = 2300 OR salaire = 1900);
-- SELECT prenom, nom, salaire, service FROM employes WHERE service = 'commercial' GROUP BY salaire HAVING salaire = 2300 OR salaire = 1900;

-- exo Affichage du nombre d'employé(s) par service 
SELECT service, COUNT(*) AS 'Nbre par service' FROM employes GROUP BY service; -- GROUP BY va ré-assoxier les nombres +1 par service 

-- UPDATE --

--exo Augmentation de 100 EURO pour les employés du service informatique
UPDATE employes SET salaire = salaire + 100 WHERE service = 'informatique';
--exo diminution de 2000 euro pour la direction jean pierre
UPDATE employes SET salaire = salaire - 2000 WHERE id_employes = 350;

-- REQUETES DE SUPPRESSION DES EMPLOYES --
--suppression de l'employé ayant l'id 350

DELETE FROM employes WHERE id_employes = 350;

--SUPPRESION DE LA TABLE EMPLOYES
DELETE FROM employes; 
TRUNCATE TABLE employes; -- Supprime les données de la table mais pas la table

DROP TABLE employes; -- Supprime la table employes

-- insertion de données dans la table employes 

INSERT INTO employes (nom, prenom, sexe, date_embauche, salaire, service) VALUES ('Doe', 'John', 'm', '2010-01-01', 2000, 'comptabilité');





