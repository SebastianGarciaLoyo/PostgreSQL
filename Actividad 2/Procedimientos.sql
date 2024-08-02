-- Creando los procedimientos que se necesitan


-- Insertar Cliente

CREATE FUNCTION insertar_cliente(id VARCHAR(20), nombre VARCHAR(40), apellidos VARCHAR(100), celular NUMERIC(10,0), direccion VARCHAR(80), correo_electronico VARCHAR(70))
RETURNS VOID AS $$
BEGIN
INSERT INTO clientes (id,nombre,apellidos,celular,direccion,correo_electronico) VALUES (id,nombre,apellidos,celular,direccion,correo_electronico);
END;
$$ LANGUAGE plpgsql;

SELECT insertar_cliente(
    '12345', 
    'Juan', 
    'Pérez González', 
    9876543210, 
    'Calle Falsa 123, Ciudad', 
    'juan.perez@example.com'
);


-- Actualizar Cliente

CREATE OR REPLACE FUNCTION actualizar_cliente(
    p_id VARCHAR(20),
    p_nombre VARCHAR(40),
    p_apellidos VARCHAR(100),
    p_celular DECIMAL(10,0),
    p_direccion VARCHAR(80),
    p_correo_electronico VARCHAR(70)
)
RETURNS VOID AS $$
BEGIN
    UPDATE clientes
    SET nombre = p_nombre, apellidos = p_apellidos, celular = p_celular, direccion = p_direccion, correo_electronico = p_correo_electronico
    WHERE id = p_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Cliente con ID % no encontrado', p_id;
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT actualizar_cliente(
    '67890', 
    'Ana', 
    'Gómez Martínez', 
    6123456789, 
    'Avenida Siempre Viva 742, Springfield', 
    'ana.gomez@example.com'
);


-- Eliminar Cliente

CREATE OR REPLACE FUNCTION eliminar_cliente(p_id VARCHAR(20))
RETURNS TEXT AS $$
DECLARE
    filas_afectadas INTEGER;
BEGIN
    -- Verificar si el cliente existe antes de intentar eliminarlo
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE id = p_id) THEN
        RETURN 'Cliente con ID ' || p_id || ' no existe';
    END IF;

    -- Eliminar el cliente con el ID proporcionado
    DELETE FROM clientes
    WHERE id = p_id;

    -- Contar el número de filas afectadas
    GET DIAGNOSTICS filas_afectadas = ROW_COUNT;

    -- Confirmar la eliminación
    RETURN CASE
        WHEN filas_afectadas > 0 THEN 'Cliente con ID ' || p_id || ' eliminado correctamente'
        ELSE 'No se pudo eliminar el cliente con ID ' || p_id
    END;
END;
$$ LANGUAGE plpgsql;


SELECT eliminar_cliente('12345');



--