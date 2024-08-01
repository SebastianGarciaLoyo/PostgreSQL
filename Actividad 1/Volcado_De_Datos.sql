-- Volcando los datos de municipio y departamento

INSERT INTO departamento (id,name)
SELECT DISTINCT departamento_id, departamento_name
FROM localidades
ORDER BY departamento_name;



INSERT INTO municipio (id, name)
SELECT DISTINCT municipio_id, municipio_name
FROM localidades
ON CONFLICT (id) DO NOTHING;

-- Por si hay algun erro en municipio

DELETE FROM municipio
WHERE id IN (
    SELECT municipio_id FROM localidades
    GROUP BY municipio_id
    HAVING COUNT(*) > 1
);



