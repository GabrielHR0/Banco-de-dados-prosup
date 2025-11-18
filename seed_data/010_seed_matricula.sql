INSERT INTO matricula (status, data_inicio, data_fim, aluno_id, plano_preco_id) VALUES
-- Matrículas com Plano Mensal (id_plano=1)
('Ativa', '2024-03-01', '2024-04-01', 1, 1),   -- Plano Mensal na Tabela 2024-1
('Ativa', '2024-04-01', '2024-05-01', 2, 6),   -- Plano Mensal na Tabela 2024-2

-- Matrículas com Plano Bimestral (id_plano=2)  
('Ativa', '2024-03-01', '2024-05-01', 3, 2),   -- Plano Bimestral na Tabela 2024-1
('Ativa', '2024-04-01', '2024-06-01', 4, 7),   -- Plano Bimestral na Tabela 2024-2

-- Matrículas com Plano Trimestral (id_plano=3)
('Ativa', '2024-03-01', '2024-06-01', 5, 3),   -- Plano Trimestral na Tabela 2024-1
('Ativa', '2024-04-01', '2024-07-01', 6, 8),   -- Plano Trimestral na Tabela 2024-2

-- Matrículas com Plano Semestral (id_plano=4)
('Ativa', '2024-03-01', '2024-09-01', 7, 4),   -- Plano Semestral na Tabela 2024-1
('Ativa', '2024-04-01', '2024-10-01', 8, 9),   -- Plano Semestral na Tabela 2024-2

-- Matrículas com Plano Anual (id_plano=5)
('Ativa', '2024-03-01', '2025-03-01', 9, 5),   -- Plano Anual na Tabela 2024-1
('Ativa', '2024-04-01', '2025-04-01', 10, 10), -- Plano Anual na Tabela 2024-2

-- Matrículas promocionais (Tabela Verão)
('Ativa', '2024-02-01', '2024-03-01', 11, 11), -- Plano Mensal Promocional
('Cancelada', '2024-02-01', '2024-04-01', 12, 12), -- Plano Bimestral Promocional (cancelada)
('Suspensa', '2024-02-01', '2024-05-01', 13, 13); -- Plano Trimestral Promocional (suspensa)