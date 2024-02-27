-- RECUPERAÇÃO SIMPLES COM SELECT

SELECT * FROM produto;

-- Filtros com WHERE Statement

SELECT * FROM pedidos
WHERE StatusPedido = 'Confirmado';

-- Crie expressões para gerar atributos derivados
SELECT CONCAT('R$ ', FORMAT(SUM(Valor), 2)) AS TotalProdutos
FROM produto;

-- Defina ordenações dos dados com ORDER BY
SELECT * FROM pedidos
ORDER BY statuspedido;

-- Condições de filtros aos grupos – HAVING Statement
SELECT StatusPedido, CONCAT('R$ ', FORMAT(SUM(Frete), 2)) AS TotalFrete
FROM pedidos
GROUP BY StatusPedido
HAVING SUM(Frete) > 3;



