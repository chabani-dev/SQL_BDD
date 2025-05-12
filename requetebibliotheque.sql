SELECT live_id FROM emprunt where date_embauche IS NULL; 

SELECT prenom FROM abonne where id_abonne IN
(SELECT id_abonne FROM abonne where date_rendu IS NULL);

-- afficher id des livres que chloé à emprunt 
SELECT livres_id FROM emprunt where id_employes IN
(SELECT id_abonne FROM abonne WHERE prenom = 'Chloé');


-- afficher la liste des abonnées

SELECT prenom FROM abonne where id_abonne IN
(SELECT id_abonne FROM emprunt where id_live IN
(SELECT id_live FROM livre where auteur= 'ALPHONSE DAUDET'));

-- connaitre les tittre des livres que chloé à emprunt

SELECT tittre FROM livre where id_livre IN
(SELECT livre_id FROM emprunt where abonne_id = 
(SELECT id_abonne FROM abonne where prenom='chloé'));


SELECT titre FROM livre WHERE id_livre NOT IN (SELECT livre_id FROM emprunt WHERE abonne_id = (SELECT id_abonne FROM abonne WHERE prenom='chloé'));

-- connaitre les titres que chloé n'as pas rendu 

SELECT titre FROM livre where id_live IN
(SELECT live_id FROM emprunt where date_rendu IS NULL AND abonne_id
(SELECT id_abonne FROM abonne where prenom='chloé' ));


--récupérer le prenom du personne qui à plus de nombre des livres emprutés 
SELECT prenom FROM abonne where id_abonne =
(SELECT abonne_id FROM emprunt GROUP BY abonne_id ORDER BY COUNT (abonne_id) DESC LIMIT 0,1);


-- Exo : affichez les prénoms des abonnés ayant emprunté un livre le 19/12/2014
    SELECT prenom FROM abonne WHERE id_abonne IN
    (SELECT abonne_id FROM emprunt WHERE date_sortie = '2016-12-17');

-- SELECT * FROM emprunt WHERE date_sortie BETWEEN DATE_SUB(CURDATE(), INTERVAL 14 YEAR) AND CURDATE();
-- SELECT * FROM `emprunt` ORDER BY `date_sortie` DESC

-- SELECT prenom FROM abonne WHERE id_abonne IN 
-- (SELECT abonne_id FROM emprunt 
--     WHERE date_sortie BETWEEN DATE_SUB(CURDATE(), INTERVAL 365 DAY) AND CURDATE());

--2.Combien de livres Guillaume a emprunté à la bibliothèque ?
SELECT COUNT(*) As 'nombre de livre ' FROM emprunt WHERE abonne_id =
(SELECT id_abonne FROM abonne WHERE prenom ='Guillaume');


--3.Afficher la liste des abonnés ayant déjà emprunté un livre d'ALEXANDRE DUMAS :
SELECT prenom FROM abonne where id_abonne IN
(SELECT id_abonne FROM emprunt where id_live IN
(SELECT id_live FROM livre where auteur= 'ALPHONSE DAUDET'));


--4.Afficher le titre du livre que Benoit a emprunté à la bibliothèque--
SELECT tittre FROM livre where id_livre IN
(SELECT livre_id FROM emprunt where abonne_id = 
(SELECT id_abonne FROM abonne where prenom='Benoit'));


--5.Afficher les titres des livres que Chloé n'a pas encore empruntés--
SELECT titre FROM livre WHERE id_livre NOT IN
(SELECT livre_id FROM emprunt WHERE abonne_id =
(SELECT id_abonne FROM abonne Where prenom= 'Chloé'));

-- 6.Afficher le titre des livres que Chloé n'a pas encore rendus à la bibliothèque--

SELECT titre FROM livre where id_livre IN
(SELECT livre_id FROM emprunt where date_rendu IS NULL AND abonne_id
(SELECT id_abonne FROM abonne where prenom='chloé' ));


SELECT titre FROM livre where id_livre IN
(SELECT livre_id FROM emprunt where ISNULL (date_rendu) AND abonne_id IN
(SELECT id_abonne FROM abonne where prenom='chloé' ));


-- SELECT titre FROM livre 
-- WHERE id_livre IN 
-- (SELECT id_livre FROM emprunt WHERE abonne_id = 
-- (SELECT id_abonne FROM abonne WHERE prenom='chloé' AND date_rendu is null));


-- dans la table abonne = id_abonne et prenom 
-- dans la table emprunt = id_emprunt et live_id et abonne_id et date_rendu et date_sortie,
-- dans la table livre = id_live , auteur , titre

--7.Qui a emprunté le plus de livres à la bibliothèque ?--
SELECT prenom FROM abonne where id_abonne =
(SELECT abonne_id FROM emprunt GROUP BY abonne_id ORDER BY COUNT(abonne_id) DESC LIMIT 0,1);

--8.Afficher les prénoms des abonnés qui n'ont pas encore rendu de livres à la bibliothèque--

SELECT prenom FROM abonne WHERE id_abonne IN
(SELECT abonne_id FROM emprunt WHERE date_rendu IS NULL);

--9.Afficher les prénoms des abonnés qui ont emprunté le livre ayant l'ID 105---

SELECT prenom FROM abonne WHERE id_abonne IN
(SELECT abonne_id FROM emprunt WHERE livre_id = 105);

--10.Afficher les prénoms des abonnés qui ont emprunté au moins deux livres 
SELECT prenom 
FROM abonne 
WHERE id_abonne IN
(SELECT abonne_id FROM emprunt GROUP BY abonne_id HAVING COUNT(*) >= 2);


-- SELECT prenom FROM abonne WHERE id_abonne IN
-- (SELECT COUNT(abonne_id) FROM emprunt GROUP BY abonne_id abonne_id >= 2);


-- date de sortie pour abanne Guillaume et la date de rendu  abonne , empunt

SELECT a.prenom, e.date_sortie, e.date_rendu
FROM abonne a, emprunt e
WHERE a.id_abonne= e.abonne_id
AND a.prenom='guillaume';



SELECT date_sortie, date_rendu FROM emprunt WHERE id_abonne = (SELECT id_abonne FROM abonne WHERE prenom='guillaume');

-- les dates auxquelles les livres écrits par Alphonse Daudet ont été empruntés ou rendus à la bibliothèque.
 --- 

SELECT l.auteur, l.titre, e.date_sortie, e.date_rendu FROM livre l , emprunt e WHERE l.id_livre= e.livre_id AND
l.auteur= 'ALPHONSE DAUDET';

--Qui a emprunté le livre 'Une Vie' sur l'année 2014 ?
SELECT a.prenom
FROM abonne a, emprunt e, livre l
WHERE l.id_livre = e.livre_id
AND e.abonne_id = a.id_abonne
AND l.titre = 'Une vie'
AND e.date_sortie LIKE '2014%';

--La même chose en requête imbriquée :
SELECT prenom FROM abonne WHERE id_abonne IN ( SELECT abonne_id FROM emprunt WHERE date_sortie LIKE '2014%' AND livre_id = ( SELECT id_livre FROM livre WHERE titre='Une vie'));


--Afficher le nombre de livres empruntés par chaque abonné.
-- jointure in
SELECT a.prenom , COUNT(e.id_livre) AS 'nombre de livre emprunte'
FROM abonne a, emprunt e WHERE a.abonne_id=e.id_abonne
GROUP BY e.id_abonne; 

--Nous aimerions connaitre le nombre de livre(s) a rendre pour chaque abonné.

SELECT a.,prenom COUNT(e.livre_id) As 'nombre de livre 'FROM emprunt a,abanne a WHERE abonne_id= id_abonne =
SELECT e.id_abonne FROM abonne WHERE ;


---Qui a emprunté Quoi ? et Quand ? (Titre des livres emprunté, à quel date, et savoir par qui).
--Les jointures internes (INNER joins) implicites
SELECT a.prenom, l.titre, e.date_sortie
FROM abonne a, emprunt e, livre l
WHERE a.id_abonne=e.abonne_id
AND e.livre_id = l.id_livre;


 