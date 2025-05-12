--TRIGGER-----------------

CREATE TABLE fournisseur (
  id INT NOT NULL auto_increment PRIMARY KEY ,
  nom varchar(10) NOT NULL,
  ville varchar(10) NOT NULL
);


CREATE TABLE article (
  id INT NOT NULL auto_increment   PRIMARY KEY,
  titre varchar(10) NOT NULL,
  couleur varchar(10) NOT NULL,
  prix int(3) NOT NULL,
  stock int(3) NOT NULL,
  fournisseur_id INT default NULL,
FOREIGN KEY (fournisseur_id) REFERENCES fournisseur (id)

);



----------------TRIGGER-----------------

CREATE TABLE IF NOT EXISTS employes_sauvegarde (
  id_employes int(4) NOT NULL AUTO_INCREMENT,
  prenom varchar(20) DEFAULT NULL,
  nom varchar(20) DEFAULT NULL,
  sexe enum('m','f') NOT NULL,
  service varchar(30) DEFAULT NULL,
  date_embauche date DEFAULT NULL,
  salaire float DEFAULT NULL,
  PRIMARY KEY (id_employes)
) 
DELIMITER $
CREATE TRIGGER t_employes_sauvegarde AFTER INSERT ON employes
FOR EACH ROW
BEGIN
INSERT INTO employes_sauvegarde (id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES (NEW.id_employes, NEW.prenom, NEW.nom, NEW.sexe, NEW.service, NEW.date_embauche, NEW.salaire);
END $
DELIMITER ;
----------------------

CREATE TABLE IF NOT EXISTS employes_supprime (
  id_employes int(4) NOT NULL AUTO_INCREMENT,
  prenom varchar(20) DEFAULT NULL,
  nom varchar(20) DEFAULT NULL,
  sexe enum('m','f') NOT NULL,
  service varchar(30) DEFAULT NULL,
  date_embauche date DEFAULT NULL,
  salaire float DEFAULT NULL,
  PRIMARY KEY (id_employes)
) 

DELIMITER $

CREATE TRIGGER t_employes_supprime AFTER DELETE ON employes
FOR EACH ROW
BEGIN
	INSERT INTO employes_supprime(id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES (OLD.id_employes, OLD.prenom, OLD.nom, OLD.sexe, OLD.service, OLD.date_embauche, OLD.salaire);
END $
DELIMITER ;

-----------
DELIMITER $
CREATE TRIGGER calcule_augmentation AFTER UPDATE ON employes
FOR EACH ROW
BEGIN
  DECLARE ancien_salaire INT;
  DECLARE nouveau_salaire INT;
  DECLARE pourcentage DECIMAL(5,2);
  
  IF NEW.salaire <> OLD.salaire THEN
    SET ancien_salaire = OLD.salaire;
    SET nouveau_salaire = NEW.salaire;
      SET pourcentage = ((nouveau_salaire - ancien_salaire) / ancien_salaire) * 100;
    INSERT INTO employes_augmentation (id_employes, pourcentage_augmentation) 
    VALUES (NEW.id_employes, pourcentage);
  END IF;
END$
DELIMITER ;


CREATE TABLE employes_depart (
  id_employes INT NOT NULL,
  nom_depart VARCHAR(30) NOT NULL,
  date_depart TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_employes)
);


DELIMITER $
CREATE TRIGGER t_employes_depart
AFTER DELETE ON employes
FOR EACH ROW
BEGIN
INSERT INTO employes_depart (id_employes,nom_depart)
VALUES (OLD.id_employes, CONCAT(OLD.prenom,' ',OLD.nom));
END $
DELIMITER ;

