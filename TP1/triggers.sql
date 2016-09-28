DELIMITER //

CREATE TRIGGER chk_in_descartados_fecha
BEFORE INSERT ON `descartados`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from casos_criminales cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //

CREATE TRIGGER chk_up_descartados_fecha
BEFORE UPDATE ON `descartados`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from casos_criminales cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //



CREATE TRIGGER chk_in_congelados_fecha
BEFORE INSERT ON `congelados`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from casos_criminales cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //

CREATE TRIGGER chk_up_congelados_fecha
BEFORE UPDATE ON `congelados`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from casos_criminales cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //



CREATE TRIGGER chk_in_resueltos_fecha
BEFORE INSERT ON `resueltos`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from casos_criminales cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //

CREATE TRIGGER chk_up_resueltos_fecha
BEFORE UPDATE ON `resueltos`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from casos_criminales cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //



CREATE TRIGGER chk_in_eventos_fecha
BEFORE INSERT ON `eventos`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from casos_criminales cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //

CREATE TRIGGER chk_up_eventos_fecha
BEFORE UPDATE ON `eventos`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from casos_criminales cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //



CREATE TRIGGER chk_in_testimonios_fecha
BEFORE INSERT ON `testimonios`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from casos_criminales cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //

CREATE TRIGGER chk_up_testimonios_fecha
BEFORE UPDATE ON `testimonios`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from casos_criminales cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //



CREATE TRIGGER chk_in_custodias_fecha
BEFORE INSERT ON `custodias`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha_ingreso from evidencias e where NEW.evidencia_id = e.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha de ingreso de la evidencia';
  END IF;
END //

CREATE TRIGGER chk_up_custodias_fecha
BEFORE UPDATE ON `custodias`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha_ingreso from evidencias e where NEW.evidencia_id = e.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha de ingreso de la evidencia';
  END IF;
END //


DELIMITER ;
