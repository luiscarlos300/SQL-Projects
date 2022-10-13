# HiveQL
<br>

# 1. Column constraint

## 1.1 PRIMARY KEY command

```powershell

CREATE TABLE transacoes (
id_cliente INT,
id_transacao INT PRIMARY KEY,
data_compra DATE,
valor FLOAT,
id_loja varchar(25)
);

```

## 1.2 FOREIGN KEY command

```powershell

CREATE TABLE transacoes(
id_cliente INT,
id_transacao INT PRIMARY KEY,
data_compra DATE,
valor FLOAT,
id_loja varchar(25),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

```

## 1.3 NOT NULL command

```powershell

CREATE TABLE transacoes (
id_cliente INT,
id_transacao INT PRIMARY KEY,
data_compra DATE,
valor FLOAT NOT NULL,
id_loja varchar(25),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

```

## 1.4 UNIQUE command

```powershell

CREATE TABLE transacoes (
id_cliente INT,
id_transacao INT PRIMARY KEY,
data_compra DATE UNIQUE,
valor FLOAT NOT NULL,
id_loja varchar(25),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

```

## 1.5 CHECK command

```powershell

CREATE TABLE transacoes (
id_cliente INT,
id_transacao INT PRIMARY KEY,
data_compra DATE UNIQUE,
valor FLOAT NOT NULL,
id_loja varchar(25),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
CHECK (valor > 0)
);

```

# 2. Selecting the data

## 2.1 AS command

```powershell

SELECT id_cliente,id_transacao, data_compra, id_loja AS nome_loja FROM transacoes;

```

## 2.2 SELECT DISTINCT command

```powershell

SELECT DISTINCT id_loja AS nome_loja FROM transacoes;

```

# 3. Sorting and limiting results

## 3.1 ORDER command

```powershell

SELECT id_cliente, valor
FROM transacoes
WHERE id_cliente= 1
ORDER BY valor DESC;

```

## 3.2 LIMIT command

```powershell

SELECT id_transacao, valor
FROM transacoes
LIMIT 3;

```