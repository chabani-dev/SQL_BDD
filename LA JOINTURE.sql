-----------JOINTURE EXPLICITE----------------

--left join On souhaite recuperer tout les abonne et leurs emprunt ,si ils n'en n'ont pas,
--alors la valeur d'emprunt sera null

SELECT abonne.prenom , emprunt.livre_id
FROM abonne 
LEFT JOIN emprunt ON abonne.id_abonne=emprunt.abonne_id; 

--1.Afficher les prénoms des abonnés qui ont emprunté un livre le 12/12/2016 
--JOINTURE EXPLICITE
SELECT abonne.prenom, emprunt.livre_id 
FROM abonne 
LEFT JOIN emprunt ON abonne.id_abonne = emprunt.abonne_id 
WHERE emprunt.date_sortie = '2014-12-17';

--JOINTURE implicite
SELECT abonne.prenom, emprunt.livre_id 
FROM abonne 
LEFT JOIN emprunt ON abonne.id_abonne = emprunt.abonne_id 
WHERE emprunt.date_sortie = '2014-12-17';

--2.Combien de livres Guillaume a emprunté à la bibliothèque 

-- SELECT COUNT(*) As 'nombre de livre ' FROM emprunt
-- LEFT JOIN abonne ON  emprunt.abonne_id=abonne.id_abonne 
-- WHERE abonne.prenom ='Guillaume';

SELECT COUNT(*) AS 'nombre de livre'
FROM emprunt
INNER JOIN abonne ON emprunt.abonne_id = abonne.id_abonne
WHERE abonne.prenom = 'Guillaume';

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


--8.Afficher les prénoms des abonnés qui n'ont pas encore rendu de livres à la bibliothèque

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
 
--on veux récupèrer le prénom de l'abonné et le titre du livre, y compris les livres qui n'ont pas été empruntés (des valeurs NULL seront affichées pour les colonnes de la table "emprunt"--

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

--2.on veux récupèrer le prénom de l'abonné et le titre du livre pour les livres écrits par l'auteur "GUY DE MAUPASSANT". Elle utilise une jointure interne avec des conditions

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

