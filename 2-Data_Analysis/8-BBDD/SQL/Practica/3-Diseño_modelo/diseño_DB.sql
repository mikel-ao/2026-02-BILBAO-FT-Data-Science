-- Creamos las tablas

CREATE TABLE piezas ( 
pieza_id INT PRIMARY KEY, 
nombre VARCHAR(100) NOT NULL, 
color VARCHAR(50), 
precio FLOAT(10,2), 
categoria INT 
);

CREATE TABLE categorias (
categoria_id INT PRIMARY KEY,
nombre VARCHAR(100)
);

CREATE TABLE proveedores (
proveedor_id INT PRIMARY KEY,
nombre VARCHAR(100),
direccion VARCHAR(200),
ciudad VARCHAR(50),
provincia VARCHAR(50)
);

CREATE TABLE suministros (
pedido_id INT PRIMARY KEY,
proveedor INT,
pieza INT,
cantidad INT,
fecha TIMESTAMP
);

-- Asignamos relaciones
-- La relación va de la hija a la madre, 
-- por ejemplo: En una categoría (Madre), puede haber muchas piezas (Hija)
-- se altera la hija para conectarla con la madre:

ALTER TABLE piezas
ADD CONSTRAINT fk_categoria_piezas -- No es obligatorio pero conviene ponerle nombre a la relación
FOREIGN KEY (categoria)
REFERENCES categorias(categoria_id);

ALTER TABLE suministros
FOREIGN KEY (proveedor)
ADD CONSTRAINT fk_proveedores_suministros
REFERENCES proveedores(proveedor_id);

ALTER TABLE suministros
FOREIGN KEY (pieza)
ADD CONSTRAINT fk_piezas_suministros
REFERENCES piezas(pieza_id);
