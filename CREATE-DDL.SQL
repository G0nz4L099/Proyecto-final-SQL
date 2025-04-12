
CREATE DATABASE Control_de_trabajo ;
USE Control_de_trabajo ;   
-- Tabla de Campos
CREATE TABLE IF NOT EXISTS Campos (
    ID_campo INT NOT NULL PRIMARY KEY,
    Nombre VARCHAR(20),
    Longitud DECIMAL(9,6),
    Latitud DECIMAL(8,6),
    Sup_Area INT,
    Uso VARCHAR(20)
);

-- Tabla de Ganado
CREATE TABLE IF NOT EXISTS Ganado (
    ID INT NOT NULL PRIMARY KEY,
    Campo INT,
    Tipo_animal VARCHAR(20),
    Precio INT,
    Cntd INT,
    Ultima_Adquisicion DATE,
    FOREIGN KEY (Campo) REFERENCES Campos(ID_campo) ON DELETE SET NULL
);

-- Tabla de Vacunación de Ganado
CREATE TABLE IF NOT EXISTS Vacunacion_Ganado (
    ID_vacuna INT NOT NULL PRIMARY KEY,
    ID_ganado INT,
    Vacuna VARCHAR(20),
    Fecha_aplic DATE,
    Dosis INT,
    Precio DECIMAL(10,2),
    FOREIGN KEY (ID_ganado) REFERENCES Ganado(ID) ON DELETE CASCADE
);

-- Tabla de Cultivos
CREATE TABLE IF NOT EXISTS Cultivos (
    ID_cultivo INT NOT NULL PRIMARY KEY,
    Campo INT,
    Tipo_cultivo VARCHAR(20),
    Cntd_sem INT,
    Cntd_cshd INT,
    Cntd_disp INT,
    Fecha_smbra DATE,
    Fecha_cshd DATE,
    FOREIGN KEY (Campo) REFERENCES Campos(ID_campo) ON DELETE SET NULL
);

-- Tabla de Uso de Cultivos
CREATE TABLE IF NOT EXISTS Uso_Cultivos (
    ID_uso INT NOT NULL PRIMARY KEY,
    ID_cult INT,
    Razon VARCHAR(20),
    Cntd INT,
    Fecha DATE,
    FOREIGN KEY (ID_cult) REFERENCES Cultivos(ID_cultivo) ON DELETE CASCADE
);

-- Tabla de Empleados
CREATE TABLE IF NOT EXISTS Empleados (
    ID_emp INT NOT NULL PRIMARY KEY,
    Campo INT,
    Nombre VARCHAR(20),
    DNI VARCHAR(20) UNIQUE,
    Tel VARCHAR(15),
    Fecha_nac DATE,
    Inicio_lab DATE,
    Especializacion VARCHAR(20),
    FOREIGN KEY (Campo) REFERENCES Campos(ID_campo) ON DELETE SET NULL
);

-- Tabla de Maquinaria
CREATE TABLE IF NOT EXISTS Maquinaria (
    ID_M INT NOT NULL PRIMARY KEY,
    Mdl VARCHAR(20),
    Patente VARCHAR(20) UNIQUE,
    Servis DATE,
    En_Uso BOOLEAN
);


-- Tabla de Uso de Máquinas
CREATE TABLE IF NOT EXISTS Uso_Maquinas (
    IDMus INT NOT NULL PRIMARY KEY,
    ID_emp INT,
    ID_M INT,
    KM_Rec INT,
    Consumo DECIMAL(10,2),
    Fecha_uso DATE,
    Hs INT,
    FOREIGN KEY (ID_emp) REFERENCES Empleados(ID_emp) ON DELETE SET NULL,
    FOREIGN KEY (ID_M) REFERENCES Maquinaria(ID_M) ON DELETE CASCADE
);


-- Tabla de Recursos
CREATE TABLE IF NOT EXISTS Recursos (
    ID_rec INT NOT NULL PRIMARY KEY,
    Campo INT,
    RC_nom VARCHAR(20),
    Unidades INT,
    Tipo VARCHAR(20),
    Fecha_vto DATE,
    Valor_und DECIMAL(10,2),
    UNIQUE (campo , RC_nom) ,
    FOREIGN KEY (Campo) REFERENCES Campos(ID_campo) ON DELETE CASCADE

);

-- Tabla de Movimiento de Recursos
CREATE TABLE IF NOT EXISTS Movimiento_Recursos (
    ID_mov INT NOT NULL PRIMARY KEY,
    ID_rec INT,
    Destino VARCHAR(20),
    Ctd INT,
    Fecha DATE,
    FOREIGN KEY (ID_rec) REFERENCES Recursos(ID_rec) ON DELETE CASCADE
);

-- Tabla de Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    ID_clnt INT NOT NULL PRIMARY KEY,
    Nombre VARCHAR(20),
    Tel VARCHAR(20),
    Ubicacion VARCHAR(20),
    Email VARCHAR(20) UNIQUE
);

-- Tabla de Proveedores
CREATE TABLE IF NOT EXISTS Proveedores (
    ID_prov INT NOT NULL PRIMARY KEY,
    Nombre VARCHAR(20),
    Tel VARCHAR(20),
    Ubicacion VARCHAR(20),
    Email VARCHAR(20) UNIQUE
);

-- Tabla de Transacciones
CREATE TABLE IF NOT EXISTS Transacciones (
    ID_transaccion INT NOT NULL PRIMARY KEY,
    ID_mov INT,
    Typ VARCHAR(20),
    Cnt INT,
    Fecha_trc DATE,
    Total DECIMAL(10,2),
    ID_clnt INT NULL,
    ID_prov INT NULL,
    FOREIGN KEY (ID_mov) REFERENCES Movimiento_Recursos(ID_mov) ON DELETE SET NULL,
    FOREIGN KEY (ID_clnt) REFERENCES Clientes(ID_clnt) ON DELETE SET NULL,
    FOREIGN KEY (ID_prov) REFERENCES Proveedores(ID_prov) ON DELETE SET NULL
);

