
---------------------FONCTION-------------------------

-- Le delimiter permet de modifier le signe de reconnaissance de MYSQL du point-virgule (;) par le signe dollar ($).
-- Nous modifions ce signe car nous devons mettre des points-virgules à certains moments de nos instructions (dans le corps de la fonction) et nous ne
-- souhaitons pas que Mysql pense qu'il s'agit de la fin de notre fonction et qu'ils exécute un code qui ne serait pas terminé.

DELIMITER $


-- permet de créer une fonction

CREATE FUNCTION

-- représente le nom de notre fonction 
salaire_brut_en_net


-- représente un argument (paramètre) entrant de type INTeger (nombre)
-- Ceci signifie que notre traitement a besoin d'une information pour réaliser son traitement correctement.

(sal INT)

-- nous indiquons que notre fonction est destinée à retourner une valeur de type INTeger (nombre)

RETURNS INT

-- commentaire d'accompagnement pour mieux l'appréhender lors du listing des fonctions disponible
COMMENT 'Fonction permettant le calcul de salaire'

-- Cette ligne permet d'indiquer au système que notre traitement ne fera que lire (et non pas modifier, supprimer) des données.

READS SQL DATA

-- Début de nos instructions
BEGIN

-- Nous retournerons le salaire multiplié par 0,8 , c'est à dire que l'on retire 20 % et qu'on garde seulement 80 % du chiffre qu'on nous aura communiqué
-- (avec l'argument entrant).
-- Return est aussi le mot clé permettant de renvoyer une valeur et généralement terminer une fonction
RETURN (sal*0.8);

-- fin de notre fonction
END

-- permet de retrouver notre delimiter d'origine
DELIMITER ;


SELECT prenom , salaire AS 'salaire brut' , salaire_brut_net(salaire) as "salaire net" FROM employes;



---- 2 fonction 

DELIMITER $
CREATE FUNCTION salaire_brut_en_net(sal INT) 
RETURNS INT
COMMENT 'Fonction permettant le calcul de salaire'
READS SQL DATA
BEGIN
RETURN (sal*0.8);
END $
DELIMITER ;


---- 3 fonction 
DELIMITER //
CREATE FUNCTION recruitement_per_year(recruit_year INT)
RETURNS INT
READ SQL DATA
BEGIN
RETURN (SELECT COUNT(*) AS recruit_year 
        FROM employes WHERE YEAR(employes.date_embauche) = recruit_year);
END //
DELIMITER ; 

---- 4 fonction 
DELIMITER $
CREATE FUNCTION salaire_brut_en_net(sal INT) 
RETURNS INT
COMMENT 'Fonction permettant le calcul de salaire'
READS SQL DATA
BEGIN
RETURN (sal*0.8);
END $
DELIMITER ;


---- 5 fonction
DELIMITER //
CREATE FUNCTION fn_CountEmployes()
RETURNS INT
READS SQL DATA
BEGIN
DECLARE totalEmployes INT;
SELECT COUNT(*) INTO totalEmployes FROM employes;
RETURN totalEmployes;
END //
DELIMITER ; 


---- 6 fonction
DELIMITER //
CREATE FUNCTION fn_MaxSalaryEmployee()
RETURNS VARCHAR(40)
READS SQL DATA
BEGIN
DECLARE maxSalary INT;
DECLARE employeeName VARCHAR(40);
SELECT MAX(salaire) INTO maxSalary FROM employes;
SELECT CONCAT(prenom,' ',nom) INTO employeeName FROM employes WHERE salaire = maxSalary;
RETURN employeeName;
END //
DELIMITER ; 