-- CreateTable
CREATE TABLE `Usuario` (
    `usuario_id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre1` VARCHAR(191) NOT NULL,
    `nombre2` VARCHAR(191) NULL,
    `apellido1` VARCHAR(191) NOT NULL,
    `apellido2` VARCHAR(191) NOT NULL,
    `usuario_iniciales` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `email_adicional` VARCHAR(191) NOT NULL,
    `idioma_id` INTEGER NOT NULL,
    `uso_horario` VARCHAR(191) NOT NULL,
    `genero_id` INTEGER NOT NULL,

    UNIQUE INDEX `Usuario_usuario_iniciales_key`(`usuario_iniciales`),
    UNIQUE INDEX `Usuario_email_key`(`email`),
    UNIQUE INDEX `Usuario_email_adicional_key`(`email_adicional`),
    PRIMARY KEY (`usuario_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Genero` (
    `genero_id` INTEGER NOT NULL AUTO_INCREMENT,
    `genero_nombre` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Genero_genero_nombre_key`(`genero_nombre`),
    PRIMARY KEY (`genero_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Idioma` (
    `idioma_id` INTEGER NOT NULL AUTO_INCREMENT,
    `idioma_nombre` VARCHAR(191) NOT NULL,
    `idioma_clave` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Idioma_idioma_clave_key`(`idioma_clave`),
    PRIMARY KEY (`idioma_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Monedas` (
    `moneda_id` INTEGER NOT NULL AUTO_INCREMENT,
    `moneda_clave` VARCHAR(191) NULL,
    `moneda_nombre` VARCHAR(191) NULL,
    `moneda_nombre_singular` VARCHAR(191) NULL,
    `moneda_nombre_plural` VARCHAR(191) NULL,
    `moneda_denominacion` VARCHAR(191) NULL,
    `moneda_simbolo` VARCHAR(191) NULL,
    `moneda_decimales` VARCHAR(191) NOT NULL,
    `moneda_porcentaje_variacion` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Monedas_moneda_clave_key`(`moneda_clave`),
    UNIQUE INDEX `Monedas_moneda_nombre_key`(`moneda_nombre`),
    PRIMARY KEY (`moneda_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Clientes` (
    `operacion_id` INTEGER NOT NULL AUTO_INCREMENT,
    `usuario_id` INTEGER NOT NULL,
    `cliente` VARCHAR(191) NOT NULL,
    `emisor_id` INTEGER NOT NULL,
    `montorecibido` INTEGER NOT NULL,
    `moneda_id` INTEGER NOT NULL,
    `tipodecambio` INTEGER NOT NULL,
    `forma_pago_id` INTEGER NOT NULL,
    `fecha` VARCHAR(191) NOT NULL,
    `status_id` INTEGER NOT NULL,
    `numeroperacion` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`operacion_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Anexoclientes` (
    `anexo_id` INTEGER NOT NULL AUTO_INCREMENT,
    `observaciones` VARCHAR(191) NULL,
    `cuentabancaria` VARCHAR(191) NULL,
    `fechadeingreso` VARCHAR(191) NULL,
    `fechadeconfirmacion` VARCHAR(191) NULL,
    `observacionesalconfirmar` VARCHAR(191) NULL,
    `operacion_id` INTEGER NOT NULL,

    PRIMARY KEY (`anexo_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Formasdepago` (
    `forma_pago_id` INTEGER NOT NULL AUTO_INCREMENT,
    `forma_clave` VARCHAR(191) NOT NULL,
    `forma_tipo` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Formasdepago_forma_clave_key`(`forma_clave`),
    PRIMARY KEY (`forma_pago_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Status` (
    `status_id` INTEGER NOT NULL AUTO_INCREMENT,
    `status_tipo` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Status_status_tipo_key`(`status_tipo`),
    PRIMARY KEY (`status_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Cfdi` (
    `cfdi_id` INTEGER NOT NULL AUTO_INCREMENT,
    `cfdi_clave` VARCHAR(191) NOT NULL,
    `cfdi_descripcion` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Cfdi_cfdi_clave_key`(`cfdi_clave`),
    PRIMARY KEY (`cfdi_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Regimen` (
    `regimen_id` INTEGER NOT NULL AUTO_INCREMENT,
    `regimen_tipo` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Regimen_regimen_tipo_key`(`regimen_tipo`),
    PRIMARY KEY (`regimen_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Metododepago` (
    `metodopago_id` INTEGER NOT NULL AUTO_INCREMENT,
    `metodopago_clave` VARCHAR(191) NOT NULL,
    `metodopago_tipo` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Metododepago_metodopago_clave_key`(`metodopago_clave`),
    PRIMARY KEY (`metodopago_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Tipodecomprobante` (
    `tipocomprobante_id` INTEGER NOT NULL AUTO_INCREMENT,
    `tipocomprobante_clave` VARCHAR(191) NOT NULL,
    `tipocomprobante_descripcion` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Tipodecomprobante_tipocomprobante_clave_key`(`tipocomprobante_clave`),
    PRIMARY KEY (`tipocomprobante_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Emisores` (
    `emisor_id` INTEGER NOT NULL AUTO_INCREMENT,
    `emisor_nombre` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Emisores_emisor_nombre_key`(`emisor_nombre`),
    PRIMARY KEY (`emisor_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Receptores` (
    `receptor_id` INTEGER NOT NULL AUTO_INCREMENT,
    `receptor_nombre` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Receptores_receptor_nombre_key`(`receptor_nombre`),
    PRIMARY KEY (`receptor_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Comprobantes` (
    `comprobante_id` INTEGER NOT NULL AUTO_INCREMENT,
    `emisor_id` INTEGER NOT NULL,
    `receptor_id` INTEGER NOT NULL,
    `fecha_emision` VARCHAR(191) NULL,
    `folio_usuario` VARCHAR(191) NULL,
    `total` VARCHAR(191) NULL,
    `subtotal` VARCHAR(191) NULL,
    `tipo_cambio` VARCHAR(191) NULL,
    `saldo_insoluto` VARCHAR(191) NULL,
    `descuento` VARCHAR(191) NULL,
    `total_traslado` VARCHAR(191) NULL,
    `total_retenido` VARCHAR(191) NULL,
    `comentario` VARCHAR(191) NULL,
    `fecha_vencimiento` VARCHAR(191) NULL,
    `lugar_expedicion` VARCHAR(191) NULL,
    `status_comprobante_pago_id` INTEGER NOT NULL,
    `tipo_comprobante_id` INTEGER NOT NULL,
    `moneda_id` INTEGER NOT NULL,
    `idioma_id` INTEGER NOT NULL,
    `metodo_pago_id` INTEGER NOT NULL,
    `forma_pago_id` INTEGER NOT NULL,
    `condicion_pago_id` VARCHAR(191) NULL,
    `uso_cfdi_id` INTEGER NOT NULL,
    `regimen_fiscal_id` INTEGER NOT NULL,

    PRIMARY KEY (`comprobante_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Movimientos` (
    `movimiento_id` INTEGER NOT NULL AUTO_INCREMENT,
    `fecha` VARCHAR(191) NOT NULL,
    `concepto` VARCHAR(191) NOT NULL,
    `referencia` VARCHAR(191) NOT NULL,
    `monto` DOUBLE NOT NULL,
    `tipo_cambio` DOUBLE NOT NULL,
    `emisor_id` INTEGER NOT NULL,
    `moneda_id` INTEGER NOT NULL,
    `forma_pago_id` INTEGER NOT NULL,
    `status_id` INTEGER NOT NULL,

    PRIMARY KEY (`movimiento_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Condiciondepago` (
    `condicion_pago_id` INTEGER NOT NULL AUTO_INCREMENT,
    `condicion_pago_nombre` VARCHAR(191) NOT NULL,
    `condicion_pago_dias_para_vencer` INTEGER NOT NULL,
    `idioma_id` INTEGER NOT NULL,
    `condicion_pago_status` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`condicion_pago_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_idioma_id_fkey` FOREIGN KEY (`idioma_id`) REFERENCES `Idioma`(`idioma_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Usuario` ADD CONSTRAINT `Usuario_genero_id_fkey` FOREIGN KEY (`genero_id`) REFERENCES `Genero`(`genero_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Clientes` ADD CONSTRAINT `Clientes_usuario_id_fkey` FOREIGN KEY (`usuario_id`) REFERENCES `Usuario`(`usuario_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Clientes` ADD CONSTRAINT `Clientes_moneda_id_fkey` FOREIGN KEY (`moneda_id`) REFERENCES `Monedas`(`moneda_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Clientes` ADD CONSTRAINT `Clientes_forma_pago_id_fkey` FOREIGN KEY (`forma_pago_id`) REFERENCES `Formasdepago`(`forma_pago_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Clientes` ADD CONSTRAINT `Clientes_status_id_fkey` FOREIGN KEY (`status_id`) REFERENCES `Status`(`status_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Anexoclientes` ADD CONSTRAINT `Anexoclientes_operacion_id_fkey` FOREIGN KEY (`operacion_id`) REFERENCES `Clientes`(`operacion_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comprobantes` ADD CONSTRAINT `Comprobantes_emisor_id_fkey` FOREIGN KEY (`emisor_id`) REFERENCES `Emisores`(`emisor_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comprobantes` ADD CONSTRAINT `Comprobantes_receptor_id_fkey` FOREIGN KEY (`receptor_id`) REFERENCES `Receptores`(`receptor_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comprobantes` ADD CONSTRAINT `Comprobantes_status_comprobante_pago_id_fkey` FOREIGN KEY (`status_comprobante_pago_id`) REFERENCES `Status`(`status_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comprobantes` ADD CONSTRAINT `Comprobantes_tipo_comprobante_id_fkey` FOREIGN KEY (`tipo_comprobante_id`) REFERENCES `Tipodecomprobante`(`tipocomprobante_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comprobantes` ADD CONSTRAINT `Comprobantes_moneda_id_fkey` FOREIGN KEY (`moneda_id`) REFERENCES `Monedas`(`moneda_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comprobantes` ADD CONSTRAINT `Comprobantes_idioma_id_fkey` FOREIGN KEY (`idioma_id`) REFERENCES `Idioma`(`idioma_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comprobantes` ADD CONSTRAINT `Comprobantes_metodo_pago_id_fkey` FOREIGN KEY (`metodo_pago_id`) REFERENCES `Metododepago`(`metodopago_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comprobantes` ADD CONSTRAINT `Comprobantes_forma_pago_id_fkey` FOREIGN KEY (`forma_pago_id`) REFERENCES `Formasdepago`(`forma_pago_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comprobantes` ADD CONSTRAINT `Comprobantes_uso_cfdi_id_fkey` FOREIGN KEY (`uso_cfdi_id`) REFERENCES `Cfdi`(`cfdi_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comprobantes` ADD CONSTRAINT `Comprobantes_regimen_fiscal_id_fkey` FOREIGN KEY (`regimen_fiscal_id`) REFERENCES `Regimen`(`regimen_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Movimientos` ADD CONSTRAINT `Movimientos_emisor_id_fkey` FOREIGN KEY (`emisor_id`) REFERENCES `Emisores`(`emisor_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Movimientos` ADD CONSTRAINT `Movimientos_moneda_id_fkey` FOREIGN KEY (`moneda_id`) REFERENCES `Monedas`(`moneda_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Movimientos` ADD CONSTRAINT `Movimientos_forma_pago_id_fkey` FOREIGN KEY (`forma_pago_id`) REFERENCES `Formasdepago`(`forma_pago_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Movimientos` ADD CONSTRAINT `Movimientos_status_id_fkey` FOREIGN KEY (`status_id`) REFERENCES `Status`(`status_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Condiciondepago` ADD CONSTRAINT `Condiciondepago_idioma_id_fkey` FOREIGN KEY (`idioma_id`) REFERENCES `Idioma`(`idioma_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
