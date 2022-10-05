# HiveSQL
<br>

# 1. Creating tables
## 1.1 CREATE command

```powershell

CREATE TABLE transacoes (
id_transacao INT,
id_cliente INT,
data_compra DATE,
valor FLOAT,
);

```

## 1.2 ALTER TABLE command

```powershell

ALTER TABLE transacoes
ADD id_loja STRING;

ALTER TABLE transacoes
ALTER COLUMN valor DOUBLE;

ALTER TABLE transacoes
DROP COLUMN id_cliente;

```

# 1.2 DROP TABLE command

```powershell

DROP TABLE transacoes;

```

# 1.3 INSERT INTO command

```powershell

INSERT INTO transacoes VALUES (1,768805383,2021-06-10,50.74,'magalu');
INSERT INTO transacoes VALUES (2,768805399,2021-06-13,30.90,'giraffas');
INSERT INTO transacoes VALUES (3,818770008,2021-06-05,110.00,'postoshell');

```

# 1.4 UPDATE command

```powershell

UPDATE transacoes
SET valor = 250.30
WHERE id = 818770008;

```

# 1.4 DELETE command

```powershell

DELETE FROM transacoes WHERE id_cliente = 768805383;

```