DROP SCHEMA IF EXISTS `tpv` ;

-- -----------------------------------------------------
-- Schema tpv
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tpv` DEFAULT CHARACTER SET utf8 ;
USE `tpv` ;

-- -----------------------------------------------------
-- Table `tpv`.`contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`contacto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cif_nif` VARCHAR(15) NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido1` VARCHAR(45) NULL,
  `apellido2` VARCHAR(45) NULL,
  `mail` VARCHAR(45) NULL,
  `telefono2` INT NULL,
  `telefono1` INT NULL,
  `direccion` VARCHAR(100) NULL,
  `cp` INT NULL,
  `provincia` VARCHAR(45) NULL,
  `poblacion` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `cif_nif_UNIQUE` (`cif_nif` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`empresa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cif` VARCHAR(15) NOT NULL,
  `razon_social` VARCHAR(50) NULL,
  `nombre _comercial` VARCHAR(50) NULL,
  `www` VARCHAR(100) NULL,
  `contacto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `cif_UNIQUE` (`cif` ASC),
  UNIQUE INDEX `razon_social_UNIQUE` (`razon_social` ASC),
  UNIQUE INDEX `nombre _comercial_UNIQUE` (`nombre _comercial` ASC),
  INDEX `fk_empresa_contacto1_idx` (`contacto_id` ASC),
  CONSTRAINT `fk_empresa_contacto1`
    FOREIGN KEY (`contacto_id`)
    REFERENCES `tpv`.`contacto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` TINYINT(1) NOT NULL DEFAULT 0,
  `fecha_alta` DATE NOT NULL,
  `contacto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_cliente_contacto1_idx` (`contacto_id` ASC),
  CONSTRAINT `fk_cliente_contacto1`
    FOREIGN KEY (`contacto_id`)
    REFERENCES `tpv`.`contacto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`empresa_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`empresa_cliente` (
  `empresa_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  INDEX `fk_empresa_cliente_empresa_idx` (`empresa_id` ASC),
  INDEX `fk_empresa_cliente_cliente1_idx` (`cliente_id` ASC),
  CONSTRAINT `fk_empresa_cliente_empresa`
    FOREIGN KEY (`empresa_id`)
    REFERENCES `tpv`.`empresa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empresa_cliente_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `tpv`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`proveedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_alta` VARCHAR(45) NOT NULL,
  `contacto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_proveedor_contacto1_idx` (`contacto_id` ASC),
  CONSTRAINT `fk_proveedor_contacto1`
    FOREIGN KEY (`contacto_id`)
    REFERENCES `tpv`.`contacto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`empresa_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`empresa_proveedor` (
  `empresa_id` INT NOT NULL,
  `proveedor_id` INT NOT NULL,
  INDEX `fk_empresa_cliente_empresa_idx` (`empresa_id` ASC),
  INDEX `fk_empresa_proveedor_proveedor1_idx` (`proveedor_id` ASC),
  CONSTRAINT `fk_empresa_cliente_empresa0`
    FOREIGN KEY (`empresa_id`)
    REFERENCES `tpv`.`empresa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empresa_proveedor_proveedor1`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `tpv`.`proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`familia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`familia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(5) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`subfamilia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`subfamilia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_familia` INT NOT NULL,
  `codigo` VARCHAR(5) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_subfamilia_familia1_idx` (`id_familia` ASC),
  CONSTRAINT `fk_subfamilia_familia1`
    FOREIGN KEY (`id_familia`)
    REFERENCES `tpv`.`familia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_familia` INT NOT NULL,
  `id_subfamilia` INT NOT NULL,
  `codigo` VARCHAR(50) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` BLOB NULL,
  PRIMARY KEY (`id`, `codigo`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_subfamilia_copy1_subfamilia1_idx` (`id_subfamilia` ASC, `id_familia` ASC),
  CONSTRAINT `fk_subfamilia_copy1_subfamilia1`
    FOREIGN KEY (`id_subfamilia`)
    REFERENCES `tpv`.`subfamilia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`tipo_iva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`tipo_iva` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `iva` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`articulo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NOT NULL,
  `id_proveedor` INT NOT NULL,
  `precio_compra` VARCHAR(5) NULL,
  `precio_venta` VARCHAR(5) NULL,
  `pvp` VARCHAR(45) NULL,
  `iva` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_Articulo_producto1_idx` (`id_producto` ASC),
  INDEX `fk_Articulo_proveedor1_idx` (`id_proveedor` ASC),
  INDEX `fk_Articulo_tipos_iva1_idx` (`iva` ASC),
  CONSTRAINT `fk_Articulo_producto1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `tpv`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Articulo_proveedor1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `tpv`.`proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Articulo_tipos_iva1`
    FOREIGN KEY (`iva`)
    REFERENCES `tpv`.`tipo_iva` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`stock` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_empresa` INT NOT NULL,
  `producto_codigo` VARCHAR(50) NOT NULL,
  `cantidad` INT NOT NULL,
  `minimo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_stock_empresa1_idx` (`id_empresa` ASC),
  INDEX `fk_stock_producto1_idx` (`producto_codigo` ASC),
  CONSTRAINT `fk_stock_empresa1`
    FOREIGN KEY (`id_empresa`)
    REFERENCES `tpv`.`empresa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stock_producto1`
    FOREIGN KEY (`producto_codigo`)
    REFERENCES `tpv`.`producto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`ticket` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(45) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `id_articulo` INT NOT NULL,
  `id_cliente` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC),
  INDEX `fk_ticket_Articulo1_idx` (`id_articulo` ASC),
  INDEX `fk_ticket_cliente1_idx` (`id_cliente` ASC),
  CONSTRAINT `fk_ticket_Articulo1`
    FOREIGN KEY (`id_articulo`)
    REFERENCES `tpv`.`articulo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `tpv`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`moviemiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`moviemiento` (
  `id` INT NOT NULL,
  `feha_hora` DATETIME NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`arqueo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`arqueo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora` DATETIME NULL,
  `ticket_id` INT NULL,
  `moviemiento_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_arqueo_ticket1_idx` (`ticket_id` ASC),
  INDEX `fk_arqueo_moviemiento1_idx` (`moviemiento_id` ASC),
  CONSTRAINT `fk_arqueo_ticket1`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `tpv`.`ticket` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_arqueo_moviemiento1`
    FOREIGN KEY (`moviemiento_id`)
    REFERENCES `tpv`.`moviemiento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`historial` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ticket_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_historial_ticket1_idx` (`ticket_id` ASC),
  CONSTRAINT `fk_historial_ticket1`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `tpv`.`ticket` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`pedido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(45) NOT NULL,
  `proveedor_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `producto_codigo` VARCHAR(50) NOT NULL,
  `cantidad` VARCHAR(45) NOT NULL,
  `coste_unidad` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_pedido_proveedor1_idx` (`proveedor_id` ASC),
  INDEX `fk_pedido_producto1_idx` (`producto_id` ASC, `producto_codigo` ASC),
  CONSTRAINT `fk_pedido_proveedor1`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `tpv`.`proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_producto1`
    FOREIGN KEY (`producto_id` , `producto_codigo`)
    REFERENCES `tpv`.`producto` (`id` , `codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`informe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`informe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(45) NOT NULL,
  `mes` VARCHAR(3) NOT NULL,
  `anyo` INT NOT NULL,
  `arqueo_id` INT NULL,
  `pedido_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_informe_arqueo1_idx` (`arqueo_id` ASC),
  INDEX `fk_informe_pedido1_idx` (`pedido_id` ASC),
  CONSTRAINT `fk_informe_arqueo1`
    FOREIGN KEY (`arqueo_id`)
    REFERENCES `tpv`.`arqueo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_informe_pedido1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `tpv`.`pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tpv`.`balance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`balance` (
  `id` INT NOT NULL,
  `mes` VARCHAR(45) NULL,
  `ingreso` VARCHAR(45) NULL,
  `gasto` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
