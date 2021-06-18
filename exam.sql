-- FIRST TRANSACTION
BEGIN TRANSACTION;
INSERT INTO compra (cliente_id, fecha)
VALUES (1, NOW());

INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (9, (SELECT MAX (id) FROM compra), 5);

UPDATE producto
SET stock = stock - 5 WHERE id = 9;
COMMIT;

-- SECOND TRANSACTION
BEGIN TRANSACTION;
INSERT INTO compra (cliente_id, fecha)
VALUES (2, NOW());

INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (1, (SELECT MAX (id) FROM compra), 3);

INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (2, (SELECT MAX (id) FROM compra), 3);

INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (8, (SELECT MAX (id) FROM compra), 3);

UPDATE producto
SET stock = stock - 3 WHERE id = 1;
UPDATE producto
SET stock = stock - 3 WHERE id = 2;
UPDATE producto
SET stock = stock - 3 WHERE id = 8;
COMMIT;

-- THIRD OPERATION
BEGIN TRANSACTION;
SAVEPOINT createuser;

INSERT INTO cliente (nombre, email)
VALUES ('usuario11', 'usuario11@gmail.com');

ROLLBACK TO createuser;

\set AUTOCOMMIT on