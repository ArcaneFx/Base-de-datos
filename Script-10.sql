-- ========================
-- USUARIO
-- ========================
CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nickname VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    nacionalidad VARCHAR(50),
    correo VARCHAR(100) UNIQUE NOT NULL,
    saldo NUMERIC(10,2) DEFAULT 0,
    biografia TEXT
);

-- ========================
-- TIENDA
-- ========================
CREATE TABLE tienda (
    id_tienda SERIAL PRIMARY KEY,
    categorias TEXT
);

-- Relación usuario N:1 tienda
ALTER TABLE usuario
ADD COLUMN id_tienda INTEGER,
ADD CONSTRAINT fk_usuario_tienda
FOREIGN KEY (id_tienda) REFERENCES tienda(id_tienda);

-- ========================
-- JUEGO
-- ========================
CREATE TABLE juego (
    id_juego SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    descuento NUMERIC(5,2) DEFAULT 0,
    fecha_lanzamiento DATE,
    genero VARCHAR(50),
    resena_general TEXT
);

-- ========================
-- BIBLIOTECA (1:1 usuario)
-- ========================
CREATE TABLE biblioteca (
    id_biblioteca SERIAL PRIMARY KEY,
    id_usuario INTEGER UNIQUE,
    horas_de_juego INTEGER DEFAULT 0,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- ========================
-- CARRITO (1:1 usuario)
-- ========================
CREATE TABLE carrito (
    id_carrito SERIAL PRIMARY KEY,
    id_usuario INTEGER UNIQUE,
    id_tienda INTEGER,
    total_precio NUMERIC(10,2) DEFAULT 0,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_tienda) REFERENCES tienda(id_tienda)
);

-- ========================
-- METODO PAGO (1:1 carrito)
-- ========================
CREATE TABLE metodo_pago (
    id_metodo_pago SERIAL PRIMARY KEY,
    metodo VARCHAR(50),
    id_carrito INTEGER UNIQUE,
    FOREIGN KEY (id_carrito) REFERENCES carrito(id_carrito)
);

-- ========================
-- BOLETA
-- ========================
CREATE TABLE boleta (
    id_boleta SERIAL PRIMARY KEY,
    fecha_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total NUMERIC(10,2),
    id_usuario INTEGER,
    id_carrito INTEGER UNIQUE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_carrito) REFERENCES carrito(id_carrito)
);

-- ========================
-- RESEÑA
-- ========================
CREATE TABLE resena (
    id_resena SERIAL PRIMARY KEY,
    comentario TEXT,
    calificacion INTEGER CHECK (calificacion BETWEEN 1 AND 5),
    id_usuario INTEGER,
    id_juego INTEGER,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego)
);

-- ========================
-- LOGROS
-- ========================
CREATE TABLE logros (
    id_logro SERIAL PRIMARY KEY,
    fecha_desbloqueado DATE
);

-- N:N biblioteca - logros
CREATE TABLE biblioteca_logros (
    id_biblioteca INTEGER,
    id_logro INTEGER,
    PRIMARY KEY (id_biblioteca, id_logro),
    FOREIGN KEY (id_biblioteca) REFERENCES biblioteca(id_biblioteca),
    FOREIGN KEY (id_logro) REFERENCES logros(id_logro)
);

-- ========================
-- DESARROLLADOR
-- ========================
CREATE TABLE desarrollador (
    id_desarrollador SERIAL PRIMARY KEY,
    nombre_desarrollador VARCHAR(100)
);

-- N:N desarrollador - juego
CREATE TABLE desarrollador_juego (
    id_desarrollador INTEGER,
    id_juego INTEGER,
    PRIMARY KEY (id_desarrollador, id_juego),
    FOREIGN KEY (id_desarrollador) REFERENCES desarrollador(id_desarrollador),
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego)
);

-- ========================
-- EDITOR
-- ========================
CREATE TABLE editor (
    id_editor SERIAL PRIMARY KEY,
    nombre_editor VARCHAR(100)
);

-- N:N editor - juego
CREATE TABLE editor_juego (
    id_editor INTEGER,
    id_juego INTEGER,
    PRIMARY KEY (id_editor, id_juego),
    FOREIGN KEY (id_editor) REFERENCES editor(id_editor),
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego)
);