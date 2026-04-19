```sql
-- Activar claves foráneas
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS suministros;
DROP TABLE IF EXISTS piezas;
DROP TABLE IF EXISTS proveedores;
DROP TABLE IF EXISTS categorias;

-- Tablas padre primero
CREATE TABLE IF NOT EXISTS categorias (
    categoria_id INTEGER PRIMARY KEY,
    nombre TEXT
);

CREATE TABLE IF NOT EXISTS proveedores (
    proveedor_id INTEGER PRIMARY KEY,
    nombre TEXT,
    direccion TEXT,
    ciudad TEXT,
    provincia TEXT
);

-- Tabla piezas (hija de categorias)
CREATE TABLE IF NOT EXISTS piezas ( 
    pieza_id INTEGER PRIMARY KEY, 
    nombre TEXT NOT NULL, 
    color TEXT, 
    precio REAL, 
    categoria INTEGER,
    FOREIGN KEY (categoria) REFERENCES categorias(categoria_id)
);

-- Tabla suministros (hija de proveedores y piezas)
CREATE TABLE IF NOT EXISTS suministros (
    pedido_id INTEGER PRIMARY KEY,
    proveedor INTEGER,
    pieza INTEGER,
    cantidad INTEGER,
    fecha TEXT,
    FOREIGN KEY (proveedor) REFERENCES proveedores(proveedor_id),
    FOREIGN KEY (pieza) REFERENCES piezas(pieza_id)
);

PRAGMA foreign_key_list(piezas);
PRAGMA foreign_key_list(proveedores);
PRAGMA foreign_key_list(suministros);
PRAGMA foreign_key_list(categorias);
```
