-----------JOINTURE EXPLICITE----------------

--left join

--On souhaite recuperer tout les abonne et leurs emprunt ,si ils n'en n'ont pas,
--alors la valeur d'emprunt sera null

SELECT abonne.prenom , emprunt.livre_id
FROM abonne 
LEFT JOIN emprunt ON abonne.id_abonne=emprunt.abonne_id; 


---EXERCICE-----

-- 1.Afficher les prénoms des abonnés qui ont emprunté un livre le 12/12/2016 :

-- 2.Combien de livres Guillaume a emprunté à la bibliothèque ?

-- 3.Afficher la liste des abonnés ayant déjà emprunté un livre d'ALEXANDRE DUMAS :

-- 4.Afficher le titre du livre que Benoit a emprunté à la bibliothèque :

-- 5.Afficher les titres des livres que Chloé n'a pas encore empruntés :

-- 6.Afficher le titre des livres que Chloé n'a pas encore rendus à la bibliothèque :

-- 7.Qui a emprunté le plus de livres à la bibliothèque ?

-- 8.Afficher les prénoms des abonnés qui n'ont pas encore rendu de livres à la bibliothèque :

-- 9.Afficher les prénoms des abonnés qui ont emprunté le livre ayant l'ID 105 :

-- 10.Afficher les prénoms des abonnés qui ont emprunté au moins deux livres :
CORRECTION

1.

-- jointure explicite
SELECT abonne.prenom 
FROM abonne 
LEFT JOIN emprunt ON abonne.id_abonne= emprunt.abonne_id
WHERE emprunt.date_sortie='2014-12-17';

-- jointure implicte
SELECT prenom 
FROM abonne , emprunt 
WHERE abonne.id_abonne= emprunt.abonne_id
AND emprunt.date_sortie='2014-12-17';


2.

-- jointure explicite
SELECT COUNT(*) AS 'nombre de livre'
FROM emprunt
LEFT JOIN abonne ON emprunt.abonne_id= abonne.id_abonne
WHERE abonne.prenom='Guillaume';

-- jointure implicte
SELECT COUNT(*) AS 'nombre de livre'
FROM emprunt,abonne 
WHERE emprunt.abonne_id= abonne.id_abonne
AND prenom= 'Guillaume';

3.
-- jointure explicite
SELECT prenom
FROM abonne 
LEFT JOIN emprunt ON abonne.id_abonne= emprunt.abonne_id
LEFT JOIN livre ON emprunt.livre_id = livre.id_livre
WHERE livre.auteur='Alexandre Dumas';


-- jointure implicte
SELECT prenom
FROM abonne,emprunt,livre
WHERE abonne.id_abonne= emprunt.abonne_id
AND emprunt.livre_id = livre.id_livre
AND livre.auteur='Alexandre Dumas'; 

4.
-- jointure explicite
SELECT titre 
FROM livre
LEFT JOIN emprunt ON emprunt.livre_id= livre.id_livre
LEFT JOIN abonne ON emprunt.abonne_id=abonne.id_abonne
WHERE abonne.prenom = 'Benoit';


-- jointure implicte
SELECT titre 
FROM livre,emprunt,abonne
WHERE livre.id_livre= emprunt.livre_id
AND emprunt.abonne_id= abonne.id_abonne
AND abonne.prenom='benoit';
 
 5.
 -- jointure explicite
SELECT titre
FROM livre
WHERE id_livre not IN (
    SELECT livre_id
    FROM emprunt  
    LEFT JOIN abonne ON abonne.id_abonne = emprunt.abonne_id
    WHERE abonne.prenom = 'Chloé'
    );

-- jointure implicte
SELECT titre
FROM livre
 WHERE id_livre not IN (
     SELECT livre_id 
     FROM emprunt, abonne
     WHERE emprunt.abonne_id= abonne.id_abonne
     AND abonne.prenom = 'Chloé'
     );
     
6.
-- jointure explicite
SELECT titre 
FROM livre
LEFT JOIN emprunt ON  livre.id_livre= emprunt.livre_id
LEFT JOIN abonne ON abonne.id_abonne= emprunt.abonne_id
WHERE emprunt.date_rendu IS NULL
AND abonne.prenom="Chloé";

-- jointure implicte
SELECT titre From livre ,emprunt, abonne
WHERE livre.id_livre= emprunt.livre_id
AND abonne.id_abonne= emprunt.abonne_id
AND emprunt.date_rendu IS NULL
AND abonne.prenom= "chloé" ;

7.
-- joint explicite
SELECT prenom
FROM abonne
INNER JOIN emprunt ON abonne.id_abonne = emprunt.abonne_id
GROUP BY emprunt.abonne_id
ORDER BY COUNT(emprunt.abonne_id) DESC LIMIT 0, 1;

-- jointure implicite
SELECT prenom FROM abonne, emprunt 
WHERE abonne.id_abonne = emprunt.abonne_id
GROUP BY abonne.id_abonne 
ORDER BY COUNT(abonne.id_abonne) DESC LIMIT 0, 1;

8.

-- joint explicite
SELECT prenom 
FROM abonne 
INNER JOIN emprunt ON abonne.id_abonne= emprunt.abonne_id
WHERE emprunt.date_rendu IS NULL ;

-- jointure implicite
SELECT prenom
FROM abonne,emprunt
WHERE abonne.id_abonne= emprunt.abonne_id
AND emprunt.date_rendu IS NULL;

9.

-- joint explicite
SELECT prenom
FROM abonne 
LEFT JOIN emprunt ON abonne.id_abonne= emprunt.abonne_id
WHERE emprunt.livre_id = 105;

-- jointure implicite
SELECT prenom
FROM abonne,emprunt
WHERE abonne.id_abonne= emprunt.abonne_id
AND emprunt.livre_id= 105;

10.

-- joint explicite
SELECT prenom
FROM abonne  
INNER JOIN emprunt  ON abonne.id_abonne= emprunt.abonne_id
GROUP BY abonne.prenom HAVING COUNT(emprunt.id_emprunt) >= 2;

-- jointure implicite
SELECT prenom 
FROM abonne,emprunt
WHERE abonne.id_abonne= emprunt.abonne_id 
GROUP BY abonne.prenom 
HAVING COUNT(emprunt.id_emprunt) >= 2;
 
 
 
 
 EXERCICE:
 1.
-- on veux récupèrer le prénom de l'abonné et le titre du livre,et y inclure egalement les livres qui n'ont pas été empruntés (des valeurs NULL seront affichées pour les colonnes de la table "abonne").
2.
-- on veux récupèrer le prénom de l'abonné et le titre du livre pour les livres écrits par l'auteur "GUY DE MAUPASSANT". Elle utilise une jointure interne avec des conditions
3.
--  on veux  effectuer une jointure entre les tables "abonne" et "livre", retournant toutes les combinaisons possibles de prénoms d'abonnés et de titres de livres.


CORRECTION:

1.
SELECT abonne.prenom , livre.titre
FROM abonne
RIGHT  JOIN emprunt ON abonne.id_abonne= emprunt.abonne_id
RIGHT JOIN livre ON emprunt.livre_id = livre.id_livre;


SELECT abonne.prenom , livre.titre
FROM livre
LEFT JOIN emprunt ON emprunt.livre_id = livre.id_livre
LEFT JOIN abonne  ON emprunt.abonne_id = abonne.id_abonne

2.
SELECT abonne.prenom, livre.titre
FROM abonne
LEFT JOIN emprunt ON abonne.id_abonne = emprunt.abonne_id
LEFT JOIN livre ON emprunt.livre_id = livre.id_livre
UNION
SELECT abonne.prenom, livre.titre
FROM abonne
RIGHT JOIN emprunt ON abonne.id_abonne = emprunt.abonne_id
RIGHT JOIN livre ON emprunt.livre_id = livre.id_livre

3.
SELECT abonne.prenom, livre.titre
FROM abonne
CROSS JOIN livre;

--------------------------------------------------------------
-- on veux récupèrer le prénom de l'abonné et le titre du livre pour les livres écrits par l'auteur "GUY DE MAUPASSANT".
SELECT abonne.prenom , livre.titre
FROM abonne
INNER JOIN emprunt ON abonne.id_abonne= emprunt.abonne_id
INNER JOIN livre ON emprunt.livre_id= livre.id_livre
WHERE livre.auteur = 'GUY DE MAUPASSANT';

------------------------------
EXERCICE
--1. Afficher les prénoms des abonnés avec les dates de sortie et de rendu des livres qu'ils ont empruntés. (Jointure explicite)

SELECT a.prenom, e.date_sortie, e.date_rendu
FROM abonne a
INNER JOIN emprunt e ON a.id_abonne = e.abonne_id
INNER JOIN livre l ON e.livre_id = l.id_livre;


--2. Afficher les dates de sortie et de rendu des livres empruntés par Guillaume en utilisant une requête imbriquée.

SELECT a.prenom, e.date_sortie, e.date_rendu
FROM abonne a
INNER JOIN emprunt e ON a.id_abonne = e.abonne_id
INNER JOIN livre l ON e.livre_id = l.id_livre
WHERE a.prenom = 'Guillaume';

---requête imbriquée

--3. Afficher les dates de sortie et de rendu des livres écrits par Alphonse Daudet. (Jointure explicite)

SELECT e.date_sortie, e.date_rendu
FROM emprunt e
INNER JOIN (
    SELECT id_abonne
    FROM abonne
    WHERE prenom = 'Guillaume'
) a ON e.abonne_id = a.id_abonne
INNER JOIN livre l ON e.livre_id = l.id_livre;


--4. Afficher les prénoms des abonnés ayant emprunté le livre "Une Vie" en 2016. (Jointure explicite)

SELECT abonne.prenom , livre.titre
FROM abonne
INNER JOIN emprunt ON abonne.id_abonne= emprunt.abonne_id
INNER JOIN livre ON emprunt.livre_id= livre.id_livre
WHERE livre.titre = 'Une Vie' AND emprunt.date_sortie= '2016';


--5. Afficher le nombre de livres empruntés par chaque abonné. (Jointure explicite)

SELECT a.prenom, COUNT(e.livre_id) AS 'nombre de livre emprunte'
FROM abonne a
LEFT JOIN emprunt e ON a.id_abonne = e.abonne_id
GROUP BY a.id_abonne, a.prenom;

--6. Afficher le nombre de livres à rendre pour chaque abonné. (Jointure explicite)

SELECT a.prenom, COUNT(e.livre_id) AS 'nombre de livre a rendre'
FROM abonne a
LEFT JOIN emprunt e ON a.id_abonne = e.abonne_id
WHERE e.date_rendu IS NULL
GROUP BY a.id_abonne, a.prenom;


--7. Afficher les prénoms des abonnés avec les titres et dates de sortie des livres qu'ils ont empruntés. (Jointure explicite)

SELECT abonne.prenom, livre.titre, emprunt.date_sortie
FROM abonne
LEFT JOIN emprunt ON abonne.id_abonne = emprunt.abonne_id
LEFT JOIN livre ON emprunt.livre_id = livre.id_livre
WHERE livre.titre IS NOT NULL AND emprunt.date_sortie IS NOT NULL;



--8. Afficher les prénoms des abonnés avec les numéros des livres qu'ils ont empruntés, y compris ceux qui n'ont pas emprunté de livre. (Jointure externe gauche)


--9. Afficher les titres des livres empruntés et les prénoms des abonnés correspondants. (Jointure explicite)

--10.Afficher les prénoms des abonnés avec les titres des livres qu'ils ont empruntés, en excluant les doublons (ex: benoit qui a empreinte plusieurs). (Jointure explicite)
