DELIMITER //

CREATE TRIGGER chk_in_descartado_fecha
BEFORE INSERT ON `descartado`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from caso_criminal cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //

CREATE TRIGGER chk_up_descartado_fecha
BEFORE UPDATE ON `descartado`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from caso_criminal cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //



CREATE TRIGGER chk_in_congelado_fecha
BEFORE INSERT ON `congelado`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from caso_criminal cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //

CREATE TRIGGER chk_up_congelado_fecha
BEFORE UPDATE ON `congelado`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from caso_criminal cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //



CREATE TRIGGER chk_in_resuelto_fecha
BEFORE INSERT ON `resuelto`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from caso_criminal cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //

CREATE TRIGGER chk_up_resuelto_fecha
BEFORE UPDATE ON `resuelto`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from caso_criminal cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //



CREATE TRIGGER chk_in_evento_fecha
BEFORE INSERT ON `evento`
FOR EACH ROW
BEGIN
  IF (NEW.fecha > (select fecha from caso_criminal cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser mayor a la fecha del caso';
  END IF;
END //

CREATE TRIGGER chk_up_evento_fecha
BEFORE UPDATE ON `evento`
FOR EACH ROW
BEGIN
  IF (NEW.fecha > (select fecha from caso_criminal cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser mayor a la fecha del caso';
  END IF;
END //



CREATE TRIGGER chk_in_testimonio_fecha
BEFORE INSERT ON `testimonio`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from caso_criminal cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //

CREATE TRIGGER chk_up_testimonio_fecha
BEFORE UPDATE ON `testimonio`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha from caso_criminal cc where NEW.caso_id = cc.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha del caso';
  END IF;
END //



CREATE TRIGGER chk_in_custodia_fecha
BEFORE INSERT ON `custodia`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha_ingreso from evidencia e where NEW.evidencia_id = e.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha de ingreso de la evidencia';
  END IF;
END //

CREATE TRIGGER chk_up_custodia_fecha
BEFORE UPDATE ON `custodia`
FOR EACH ROW
BEGIN
  IF (NEW.fecha < (select fecha_ingreso from evidencia e where NEW.evidencia_id = e.id)) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha no puede ser menor a la fecha de ingreso de la evidencia';
  END IF;
END //


DELIMITER ;
