-- -----------------------------------------------------
-- Tabela de especialidades
-- -----------------------------------------------------
CREATE TABLE especialidade (
  id_espec INT NOT NULL PRIMARY KEY,
  nome_espec VARCHAR(45) NOT NULL);

-- -----------------------------------------------------
-- Tabela de médicos
-- -----------------------------------------------------
CREATE TABLE medico (
  id_medico INT NOT NULL PRIMARY KEY,
  nome_medico VARCHAR(120) NOT NULL,
  cpf_medico NUMERIC(11) NOT NULL,
  crm VARCHAR(10) NOT NULL,
  email_medico VARCHAR(120) NOT NULL,
  cargo VARCHAR(60) NOT NULL,
  id_espec INT NOT NULL,
  CONSTRAINT fk_medico_especialidade
    FOREIGN KEY (id_espec) 
	REFERENCES especialidade (id_espec));

-- -----------------------------------------------------
-- Tabela de convênios
-- -----------------------------------------------------
CREATE TABLE convenio (
  id_convenio INT NOT NULL PRIMARY KEY,
  nome_convenio VARCHAR(45) NOT NULL,
  cnpj_convenio VARCHAR(20) NOT NULL,
  tempo_carencia INT NOT NULL);

-- -----------------------------------------------------
-- Tabela de pacientes
-- -----------------------------------------------------
CREATE TABLE paciente (
  id_paciente INT NOT NULL PRIMARY KEY,
  nome_paciente VARCHAR(120) NOT NULL,
  data_nasc DATE NOT NULL,
  cpf_paciente NUMERIC(11) NOT NULL,
  rg_paciente VARCHAR(15) NOT NULL,
  email_paciente VARCHAR(120) NOT NULL,
  id_convenio INT,
  CONSTRAINT fk_paciente_convenio
    FOREIGN KEY (id_convenio)
    REFERENCES convenio (id_convenio));

-- -----------------------------------------------------
-- Tabela de endereços
-- -----------------------------------------------------
CREATE TABLE endereco (
  id_endereco INT NOT NULL PRIMARY KEY,
  logradouro VARCHAR(120) NOT NULL,
  bairro VARCHAR(60) NOT NULL,
  cidade VARCHAR(80) NOT NULL,
  estado VARCHAR(45) NOT NULL,
  cep NUMERIC(8) NOT NULL,
  id_medico INT,
  id_paciente INT,
  CONSTRAINT fk_endereco_medico
    FOREIGN KEY (id_medico)
    REFERENCES medico (id_medico),
  CONSTRAINT fk_endereco_paciente
    FOREIGN KEY (id_paciente)
    REFERENCES paciente (id_paciente));

-- -----------------------------------------------------
-- Tabela de telefones
-- -----------------------------------------------------
CREATE TABLE telefone (
  id_telefone INT NOT NULL PRIMARY KEY,
  ddd NUMERIC(2) NOT NULL,
  numero NUMERIC(9) NOT NULL,
  id_medico INT,
  id_paciente INT,
  CONSTRAINT fk_telefone_medico
    FOREIGN KEY (id_medico)
    REFERENCES medico (id_medico),
  CONSTRAINT fk_telefone_paciente
    FOREIGN KEY (id_paciente)
    REFERENCES paciente (id_paciente));

-- -----------------------------------------------------
-- Tabela de enfermeiros
-- -----------------------------------------------------
CREATE TABLE enfermeiro (
  id_enfermeiro INT NOT NULL PRIMARY KEY,
  nome_enfermeiro VARCHAR(120) NOT NULL,
  cpf_enfermeiro NUMERIC(11) NOT NULL,
  cre VARCHAR(10) NOT NULL);

-- -----------------------------------------------------
-- Tabela de tipos de quarto
-- -----------------------------------------------------
CREATE TABLE tipo_quarto (
  id_tipo_quarto INT NOT NULL PRIMARY KEY,
  desc_quarto VARCHAR(45) NOT NULL,
  valor_diario DECIMAL(8,2) NOT NULL);

-- -----------------------------------------------------
-- Tabela de quartos
-- -----------------------------------------------------
CREATE TABLE quarto (
  id_quarto INT NOT NULL PRIMARY KEY,
  numero INT NOT NULL,
  id_tipo_quarto INT NOT NULL,
  CONSTRAINT fk_quarto_tipo_quarto1
    FOREIGN KEY (id_tipo_quarto)
    REFERENCES tipo_quarto (id_tipo_quarto));

-- -----------------------------------------------------
-- Tabela de internações
-- -----------------------------------------------------
CREATE TABLE internacao (
  id_internacao INT NOT NULL PRIMARY KEY,
  data_entrada DATE NOT NULL,
  data_prev_alta DATE NOT NULL,
  data_efetiva_alta DATE,
  desc_procedimentos VARCHAR(200) NOT NULL,
  id_paciente INT NOT NULL,
  id_medico INT NOT NULL,
  id_quarto INT NOT NULL,
  CONSTRAINT fk_internacao_paciente
    FOREIGN KEY (id_paciente)
    REFERENCES paciente (id_paciente),
  CONSTRAINT fk_internacao_medico
    FOREIGN KEY (id_medico)
    REFERENCES medico (id_medico),
  CONSTRAINT fk_internacao_quarto
    FOREIGN KEY (id_quarto)
    REFERENCES quarto (id_quarto));

-- -----------------------------------------------------
-- Tabela de plantões
-- -----------------------------------------------------
CREATE TABLE plantao (
  id_plantao INT NOT NULL PRIMARY KEY,
  data_plantao DATE NOT NULL,
  hora_plantao TIMESTAMP NOT NULL,
  id_internacao INT NOT NULL,
  id_enfermeiro INT NOT NULL,
  CONSTRAINT fk_plantao_internacao
    FOREIGN KEY (id_internacao)
    REFERENCES internacao (id_internacao),
  CONSTRAINT fk_plantao_enfermeiro
    FOREIGN KEY (id_enfermeiro)
    REFERENCES enfermeiro (id_enfermeiro));

-- -----------------------------------------------------
-- Tabela de consultas
-- -----------------------------------------------------
CREATE TABLE consulta (
  id_consulta INT NOT NULL PRIMARY KEY,
  data_hora_consulta TIMESTAMP NOT NULL,
  valor_consulta NUMERIC(8,2) NOT NULL,
  id_medico INT NOT NULL,
  id_paciente INT NOT NULL,
  CONSTRAINT fk_consulta_medico
    FOREIGN KEY (id_medico)
    REFERENCES medico (id_medico),
  CONSTRAINT fk_consulta_paciente
    FOREIGN KEY (id_paciente)
    REFERENCES paciente (id_paciente));

-- -----------------------------------------------------
-- Tabela de receitas
-- -----------------------------------------------------
CREATE TABLE receita (
  id_receita INT NOT NULL PRIMARY KEY,
  medicamento VARCHAR(60) NOT NULL,
  dosagem VARCHAR(45) NOT NULL,
  instrucao_uso VARCHAR(250) NOT NULL,
  id_consulta INT NOT NULL,
  CONSTRAINT fk_receita_consulta
    FOREIGN KEY (id_consulta)
    REFERENCES consulta (id_consulta));

-- -----------------------------------------------------
-- Inserts
-- -----------------------------------------------------

-- Inserindo registros na tabela especialidade
INSERT INTO especialidade (id_espec, nome_espec) VALUES
(1, 'Cardiologia'), (2, 'Dermatologia'), (3, 'Pediatria'), (4, 'Ortopedia'),
(5, 'Neurologia'), (6, 'Ginecologia'), (7, 'Oftalmologia'), (8, 'Psiquiatria'),
(9, 'Urologia'), (10, 'Gastroenterologia'), (11, 'Endocrinologia'), (12, 'Oncologia'),
(13, 'Reumatologia'), (14, 'Nefrologia'), (15, 'Hematologia'), (16, 'Infectologia'),
(17, 'Pneumologia'), (18, 'Otorrinolaringologia'), (19, 'Anestesiologia'), (20, 'Radiologia'),
(21, 'Cirurgiã Cardíaco'), (22, 'Cirurgião Cardiovascular');

-- Inserindo registros na tabela medico
INSERT INTO medico (id_medico, nome_medico, cpf_medico, crm, email_medico, cargo, id_espec) VALUES
(1, 'Dr. João Silva', '12345678901', 'CRM001', 'joao.silva@example.com', 'Chefe de Setor', 1),
(2, 'Dr. Maria Souza', '23456789012', 'CRM002', 'maria.souza@example.com', 'Médica Residente', 2),
(3, 'Dr. Pedro Costa', '34567890123', 'CRM003', 'pedro.costa@example.com', 'Médico Plantonista', 3),
(4, 'Dr. Ana Lima', '45678901234', 'CRM004', 'ana.lima@example.com', 'Médica Assistente', 4),
(5, 'Dr. Carlos Mendes', '56789012345', 'CRM005', 'carlos.mendes@example.com', 'Chefe de Setor', 5),
(6, 'Dr. Julia Ferreira', '67890123456', 'CRM006', 'julia.ferreira@example.com', 'Médica Residente', 6),
(7, 'Dr. Roberto Almeida', '78901234567', 'CRM007', 'roberto.almeida@example.com', 'Médico Plantonista', 7),
(8, 'Dr. Laura Oliveira', '89012345678', 'CRM008', 'laura.oliveira@example.com', 'Médica Assistente', 8),
(9, 'Dr. Marcos Ramos', '90123456789', 'CRM009', 'marcos.ramos@example.com', 'Chefe de Setor', 9),
(10, 'Dr. Fernanda Santos', '01234567890', 'CRM010', 'fernanda.santos@example.com', 'Médica Residente', 10),
(11, 'Dr. Ricardo Gomes', '11111111111', 'CRM011', 'ricardo.gomes@example.com', 'Médico Plantonista', 11),
(12, 'Dr. Amanda Batista', '22222222222', 'CRM012', 'amanda.batista@example.com', 'Médica Assistente', 12),
(13, 'Dr. Felipe Rocha', '33333333333', 'CRM013', 'felipe.rocha@example.com', 'Chefe de Setor', 13),
(14, 'Dr. Camila Duarte', '44444444444', 'CRM014', 'camila.duarte@example.com', 'Médica Residente', 14),
(15, 'Dr. Henrique Barros', '55555555555', 'CRM015', 'henrique.barros@example.com', 'Médico Plantonista', 15),
(16, 'Dr. Patricia Lima', '66666666666', 'CRM016', 'patricia.lima@example.com', 'Médica Assistente', 16),
(17, 'Dr. Jorge Nunes', '77777777777', 'CRM017', 'jorge.nunes@example.com', 'Chefe de Setor', 17),
(18, 'Dr. Vanessa Martins', '88888888888', 'CRM018', 'vanessa.martins@example.com', 'Médica Residente', 18),
(19, 'Dr. Paulo Costa', '99999999999', 'CRM019', 'paulo.costa@example.com', 'Médico Plantonista', 19),
(20, 'Dr. Claudia Souza', '10101010101', 'CRM020', 'claudia.souza@example.com', 'Médica Assistente', 20);

-- Inserindo registros na tabela convenio
INSERT INTO convenio (id_convenio, nome_convenio, cnpj_convenio, tempo_carencia) VALUES
(1, 'Amil', '12345678000101', 30), (2, 'Bradesco Saúde', '23456789000102', 60),
(3, 'SulAmérica', '34567890000103', 90), (4, 'Unimed', '45678901000104', 120),
(5, 'Golden Cross', '56789012000105', 30), (6, 'Porto Seguro Saúde', '67890123000106', 60),
(7, 'Allianz', '78901234000107', 90), (8, 'Notredame Intermédica', '89012345000108', 120),
(9, 'Hapvida', '90123456000109', 30), (10, 'Prevent Senior', '01234567000110', 60),
(11, 'São Francisco Saúde', '12345678000111', 90), (12, 'Cassi', '23456789000112', 120),
(13, 'Samp', '34567890000113', 30), (14, 'Trasmontano Saúde', '45678901000114', 60),
(15, 'Qsaúde', '56789012000115', 90), (16, 'Vivest', '67890123000116', 120),
(17, 'Santa Helena Saúde', '78901234000117', 30), (18, 'GreenLine Saúde', '89012345000118', 60),
(19, 'Central Nacional Unimed', '90123456000119', 90), (20, 'Medservice', '01234567000120', 120);

-- Inserindo registros na tabela paciente
INSERT INTO paciente (id_paciente, nome_paciente, data_nasc, cpf_paciente, rg_paciente, email_paciente, id_convenio) VALUES
(1, 'Carlos Souza', '1980-05-15', '98765432101', 'MG1234567', 'carlos.souza@example.com', 1),
(2, 'Ana Martins', '1992-08-24', '87654321012', 'SP2345678', 'ana.martins@example.com', 2),
(3, 'Pedro Lima', '1985-11-30', '76543210923', 'RJ3456789', 'pedro.lima@example.com', 3),
(4, 'Maria Oliveira', '1977-03-14', '65432109834', 'PR4567890', 'maria.oliveira@example.com', 4),
(5, 'João Batista', '1995-07-25', '54321098745', 'SC5678901', 'joao.batista@example.com', 5),
(6, 'Julia Costa', '1982-09-12', '43210987656', 'RS6789012', 'julia.costa@example.com', 6),
(7, 'Roberto Silva', '1990-01-18', '32109876567', 'BA7890123', 'roberto.silva@example.com', 7),
(8, 'Fernanda Ribeiro', '1987-06-04', '21098765478', 'PE8901234', 'fernanda.ribeiro@example.com', 8),
(9, 'Marcos Ferreira', '1979-10-22', '10987654389', 'CE9012345', 'marcos.ferreira@example.com', 9),
(10, 'Patricia Mendes', '1991-04-17', '19876543210', 'DF0123456', 'patricia.mendes@example.com', 10),
(11, 'Rafael Almeida', '1983-12-29', '29876543211', 'GO1234567', 'rafael.almeida@example.com', 11),
(12, 'Larissa Rodrigues', '1988-05-10', '39876543212', 'MT2345678', 'larissa.rodrigues@example.com', null),
(13, 'Gabriel Moreira', '1986-02-03', '49876543213', 'MS3456789', 'gabriel.moreira@example.com', 13),
(14, 'Renata Carvalho', '1978-08-09', '59876543214', 'MG4567890', 'renata.carvalho@example.com', 14),
(15, 'Bruno Silva', '1993-11-21', '69876543215', 'SP5678901', 'bruno.silva@example.com', 15),
(16, 'Mariana Santos', '1994-02-27', '79876543216', 'RJ6789012', 'mariana.santos@example.com', 16),
(17, 'Felipe Almeida', '1989-06-16', '89876543217', 'PR7890123', 'felipe.almeida@example.com', null),
(18, 'Beatriz Silva', '1984-07-18', '99876543218', 'SC8901234', 'beatriz.silva@example.com', 18),
(19, 'Luiz Costa', '1996-09-05', '10987654321', 'RS9012345', 'luiz.costa@example.com', 19),
(20, 'Amanda Rocha', '1981-12-08', '20987654322', 'BA0123456', 'amanda.rocha@example.com', 20);

-- Inserindo registros na tabela endereco
INSERT INTO endereco (id_endereco, logradouro, bairro, cidade, estado, cep, id_medico, id_paciente) VALUES
(1, 'Rua das Flores, 123', 'Centro', 'São Paulo', 'SP', 12345678, 1, NULL),
(2, 'Avenida Brasil, 456', 'Jardins', 'São Paulo', 'SP', 23456789, 2, NULL),
(3, 'Rua da Paz, 789', 'Vila Mariana', 'São Paulo', 'SP', 34567890, 3, NULL),
(4, 'Rua dos Andradas, 101', 'Copacabana', 'Rio de Janeiro', 'RJ', 45678901, 4, NULL),
(5, 'Avenida Atlântica, 202', 'Ipanema', 'Rio de Janeiro', 'RJ', 56789012, 5, NULL),
(6, 'Rua das Laranjeiras, 303', 'Botafogo', 'Rio de Janeiro', 'RJ', 67890123, 6, NULL),
(7, 'Rua das Margaridas, 404', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ', 78901234, 7, NULL),
(8, 'Rua das Rosas, 505', 'Leblon', 'Rio de Janeiro', 'RJ', 89012345, 8, NULL),
(9, 'Rua dos Jasmins, 606', 'Gávea', 'Rio de Janeiro', 'RJ', 90123456, 9, NULL),
(10, 'Rua das Acácias, 707', 'Lagoa', 'Rio de Janeiro', 'RJ', 12345067, 10, NULL),
(11, 'Rua das Hortências, 808', 'Flamengo', 'Rio de Janeiro', 'RJ', 23456078, 11, NULL),
(12, 'Rua das Orquídeas, 909', 'Laranjeiras', 'Rio de Janeiro', 'RJ', 34567089, 12, NULL),
(13, 'Rua das Tulipas, 1010', 'Santa Teresa', 'Rio de Janeiro', 'RJ', 45678090, 13, NULL),
(14, 'Rua das Violetas, 1111', 'Glória', 'Rio de Janeiro', 'RJ', 56789012, 14, NULL),
(15, 'Rua das Camélias, 1212', 'Catete', 'Rio de Janeiro', 'RJ', 67890123, 15, NULL),
(16, 'Rua das Azaleias, 1313', 'Lapa', 'Rio de Janeiro', 'RJ', 78901234, 16, NULL),
(17, 'Rua das Dalias, 1414', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ', 89012345, 17, NULL),
(18, 'Rua das Hortênsias, 1515', 'Copacabana', 'Rio de Janeiro', 'RJ', 90123456, 18, NULL),
(19, 'Rua das Azaleias, 1616', 'Ipanema', 'Rio de Janeiro', 'RJ', 12345678, 19, NULL),
(20, 'Rua das Dalias, 1717', 'Flamengo', 'Rio de Janeiro', 'RJ', 23456789, 20, NULL),
(21, 'Avenida Paulista, 111', 'Bela Vista', 'São Paulo', 'SP', 12345678, NULL, 1),
(22, 'Rua Augusta, 222', 'Consolação', 'São Paulo', 'SP', 23456789, NULL, 2),
(23, 'Rua Oscar Freire, 333', 'Jardins', 'São Paulo', 'SP', 34567890, NULL, 3),
(24, 'Rua Haddock Lobo, 444', 'Cerqueira César', 'São Paulo', 'SP', 45678901, NULL, 4),
(25, 'Rua da Consolação, 555', 'Higienópolis', 'São Paulo', 'SP', 56789012, NULL, 5),
(26, 'Rua Frei Caneca, 666', 'Bela Vista', 'São Paulo', 'SP', 67890123, NULL, 6),
(27, 'Rua Itapeva, 777', 'Bela Vista', 'São Paulo', 'SP', 78901234, NULL, 7),
(28, 'Rua Maria Antônia, 888', 'Vila Buarque', 'São Paulo', 'SP', 89012345, NULL, 8),
(29, 'Rua Augusta, 999', 'Consolação', 'São Paulo', 'SP', 90123456, NULL, 9),
(30, 'Avenida Rebouças, 1010', 'Pinheiros', 'São Paulo', 'SP', 12345067, NULL, 10);

-- Inserindo registros na tabela telefone
INSERT INTO telefone (id_telefone, ddd, numero, id_medico, id_paciente) VALUES
(1, 11, 987654321, 1, NULL),
(2, 21, 876543210, 2, NULL),
(3, 31, 765432109, 3, NULL),
(4, 41, 654321098, 4, NULL),
(5, 51, 543210987, 5, NULL),
(6, 61, 432109876, 6, NULL),
(7, 71, 321098765, 7, NULL),
(8, 81, 210987654, 8, NULL),
(9, 91, 109876543, 9, NULL),
(10, 11, 198765432, 10, NULL),
(11, 21, 298765432, 11, NULL),
(12, 31, 398765432, 12, NULL),
(13, 41, 498765432, 13, NULL),
(14, 51, 598765432, 14, NULL),
(15, 61, 698765432, 15, NULL),
(16, 71, 798765432, 16, NULL),
(17, 81, 898765432, 17, NULL),
(18, 91, 998765432, 18, NULL),
(19, 11, 109876543, 19, NULL),
(20, 21, 119876543, 20, NULL),
(21, 11, 987654321, NULL, 1),
(22, 21, 876543210, NULL, 2),
(23, 31, 765432109, NULL, 3),
(24, 41, 654321098, NULL, 4),
(25, 51, 543210987, NULL, 5),
(26, 61, 432109876, NULL, 6),
(27, 71, 321098765, NULL, 7),
(28, 81, 210987654, NULL, 8),
(29, 91, 109876543, NULL, 9),
(30, 11, 198765432, NULL, 10);

-- Inserindo registros na tabela enfermeiro
INSERT INTO enfermeiro (id_enfermeiro, nome_enfermeiro, cpf_enfermeiro, cre) VALUES
(1, 'Enf. Clara Silva', '12312312312', 'CRE001'),
(2, 'Enf. Carlos Souza', '23423423423', 'CRE002'),
(3, 'Enf. Maria Lima', '34534534534', 'CRE003'),
(4, 'Enf. João Almeida', '45645645645', 'CRE004'),
(5, 'Enf. Ana Mendes', '56756756756', 'CRE005'),
(6, 'Enf. Pedro Rocha', '67867867867', 'CRE006'),
(7, 'Enf. Julia Santos', '78978978978', 'CRE007'),
(8, 'Enf. Ricardo Costa', '89089089089', 'CRE008'),
(9, 'Enf. Fernanda Oliveira', '90190190190', 'CRE009'),
(10, 'Enf. Marcos Ribeiro', '01201201201', 'CRE010'),
(11, 'Enf. Amanda Pereira', '11211211211', 'CRE011'),
(12, 'Enf. Felipe Moreira', '22322322322', 'CRE012'),
(13, 'Enf. Vanessa Martins', '33433433433', 'CRE013'),
(14, 'Enf. Jorge Nunes', '44544544544', 'CRE014'),
(15, 'Enf. Luana Carvalho', '55655655655', 'CRE015'),
(16, 'Enf. Thiago Duarte', '66766766766', 'CRE016'),
(17, 'Enf. Camila Araújo', '77877877877', 'CRE017'),
(18, 'Enf. Gustavo Mendes', '88988988988', 'CRE018'),
(19, 'Enf. Bruna Lima', '99099099099', 'CRE019'),
(20, 'Enf. Eduardo Ferreira', '10110110110', 'CRE020');

-- Inserindo registros na tabela tipo_quarto
INSERT INTO tipo_quarto (id_tipo_quarto, desc_quarto, valor_diario) VALUES
(1, 'Individual', 200.00),
(2, 'Duplo', 150.00),
(3, 'Coletivo', 100.00),
(4, 'Suíte', 300.00),
(5, 'Luxo', 400.00),
(6, 'Pediátrico', 180.00),
(7, 'Maternidade', 250.00),
(8, 'UTI', 500.00),
(9, 'Semi-UTI', 350.00),
(10, 'Isolamento', 220.00),
(11, 'Cardiologia', 260.00),
(12, 'Neurologia', 280.00),
(13, 'Ortopedia', 240.00),
(14, 'Oncologia', 300.00),
(15, 'Pneumologia', 230.00),
(16, 'Psiquiatria', 210.00),
(17, 'Urologia', 270.00),
(18, 'Dermatologia', 220.00),
(19, 'Geriatria', 260.00),
(20, 'Gastroenterologia', 250.00);

-- Inserindo registros na tabela quarto
INSERT INTO quarto (id_quarto, numero, id_tipo_quarto) VALUES
(1, 101, 1),
(2, 102, 2),
(3, 103, 3),
(4, 104, 4),
(5, 105, 5),
(6, 106, 6),
(7, 107, 7),
(8, 108, 8),
(9, 109, 9),
(10, 110, 10),
(11, 111, 11),
(12, 112, 12),
(13, 113, 13),
(14, 114, 14),
(15, 115, 15),
(16, 116, 16),
(17, 117, 17),
(18, 118, 18),
(19, 119, 19),
(20, 120, 20);

-- Inserindo registros na tabela internacao
INSERT INTO internacao (id_internacao, data_entrada, data_prev_alta, data_efetiva_alta, desc_procedimentos, id_paciente, id_medico, id_quarto) VALUES
(1, '2023-01-01', '2023-01-10', '2023-01-10', 'Cirurgia cardíaca', 1, 1, 1),
(2, '2023-02-01', '2023-02-10', '2023-02-09', 'Tratamento dermatológico', 2, 2, 2),
(3, '2023-03-01', '2023-03-10', '2023-03-11', 'Consulta pediátrica', 3, 3, 3),
(4, '2023-04-01', '2023-04-10', '2023-04-08', 'Fratura de braço', 4, 4, 4),
(5, '2023-05-01', '2023-05-10', '2023-05-09', 'Consulta neurológica', 5, 5, 5),
(6, '2023-06-01', '2023-06-10', '2023-06-10', 'Consulta ginecológica', 6, 6, 6),
(7, '2023-07-01', '2023-07-10', '2023-07-11', 'Consulta oftalmológica', 7, 7, 7),
(8, '2023-08-01', '2023-08-10', '2023-08-10', 'Tratamento psiquiátrico', 8, 8, 8),
(9, '2023-09-01', '2023-09-10', '2023-09-09', 'Tratamento urológico', 9, 9, 9),
(10, '2023-10-01', '2023-10-10', '2023-10-10', 'Consulta gastroenterológica', 10, 10, 10),
(11, '2023-11-01', '2023-11-10', '2023-11-09', 'Tratamento endocrinológico', 11, 11, 11),
(12, '2023-12-01', '2023-12-10', '2023-12-10', 'Consulta oncológica', 12, 12, 12),
(13, '2024-01-01', '2024-01-10', '2024-01-09', 'Consulta reumatológica', 13, 13, 13),
(14, '2024-02-01', '2024-02-10', '2024-02-10', 'Consulta nefrológica', 14, 14, 14),
(15, '2024-03-01', '2024-03-10', '2024-03-11', 'Consulta hematológica', 15, 15, 15),
(16, '2024-04-01', '2024-04-10', '2024-04-09', 'Consulta infectológica', 16, 16, 16),
(17, '2024-05-01', '2024-05-10', '2024-05-10', 'Consulta pneumológica', 17, 17, 17),
(18, '2024-06-01', '2024-06-10', null, 'Consulta otorrinolaringológica', 18, 18, 18),
(19, '2024-07-01', '2024-07-10', null, 'Consulta anestesiológica', 19, 19, 19),
(20, '2024-08-01', '2024-08-10', null, 'Consulta radiológica', 20, 20, 20);

-- Inserindo registros na tabela plantao
INSERT INTO plantao (id_plantao, data_plantao, hora_plantao, id_internacao, id_enfermeiro) VALUES
(1, '2024-01-01', '2024-01-01 08:00:00', 1, 1),
(2, '2024-02-01', '2024-02-01 08:00:00', 2, 2),
(3, '2024-03-01', '2024-03-01 08:00:00', 3, 3),
(4, '2024-04-01', '2024-04-01 08:00:00', 4, 4),
(5, '2024-05-01', '2024-05-01 08:00:00', 5, 5),
(6, '2024-06-01', '2024-06-01 08:00:00', 6, 6),
(7, '2024-07-01', '2024-07-01 08:00:00', 7, 7),
(8, '2024-08-01', '2024-08-01 08:00:00', 8, 8),
(9, '2024-09-01', '2024-09-01 08:00:00', 9, 9),
(10, '2024-10-01', '2024-10-01 08:00:00', 10, 10),
(11, '2024-11-01', '2024-11-01 08:00:00', 11, 11),
(12, '2024-12-01', '2024-12-01 08:00:00', 12, 12),
(13, '2025-01-01', '2025-01-01 08:00:00', 13, 13),
(14, '2025-02-01', '2025-02-01 08:00:00', 14, 14),
(15, '2025-03-01', '2025-03-01 08:00:00', 15, 15),
(16, '2025-04-01', '2025-04-01 08:00:00', 16, 16),
(17, '2025-05-01', '2025-05-01 08:00:00', 17, 17),
(18, '2025-06-01', '2025-06-01 08:00:00', 18, 18),
(19, '2025-07-01', '2025-07-01 08:00:00', 19, 19),
(20, '2025-08-01', '2025-08-01 08:00:00', 20, 20);

-- Inserindo registros na tabela consulta
INSERT INTO consulta (id_consulta, data_hora_consulta, valor_consulta, id_medico, id_paciente) VALUES
(1, '2024-01-01 10:00:00', 150.00, 1, 1),
(2, '2024-02-01 10:00:00', 150.00, 2, 2),
(3, '2024-03-01 10:00:00', 150.00, 3, 3),
(4, '2024-04-01 10:00:00', 150.00, 4, 4),
(5, '2024-05-01 10:00:00', 150.00, 5, 5),
(6, '2024-06-01 10:00:00', 150.00, 6, 6),
(7, '2024-07-01 10:00:00', 150.00, 7, 7),
(8, '2024-08-01 10:00:00', 150.00, 8, 8),
(9, '2024-09-01 10:00:00', 150.00, 9, 9),
(10, '2024-10-01 10:00:00', 150.00, 10, 10),
(11, '2024-11-01 10:00:00', 150.00, 11, 11),
(12, '2024-12-01 10:00:00', 150.00, 12, 12),
(13, '2025-01-01 10:00:00', 150.00, 13, 13),
(14, '2025-02-01 10:00:00', 150.00, 14, 14),
(15, '2025-03-01 10:00:00', 150.00, 15, 15),
(16, '2025-04-01 10:00:00', 150.00, 16, 16),
(17, '2025-05-01 10:00:00', 150.00, 17, 17),
(18, '2025-06-01 10:00:00', 150.00, 18, 18),
(19, '2025-07-01 10:00:00', 150.00, 19, 19),
(20, '2025-08-01 10:00:00', 150.00, 20, 20);

-- Inserindo registros na tabela receita
INSERT INTO receita (id_receita, medicamento, dosagem, instrucao_uso, id_consulta) VALUES
(1, 'Paracetamol', '500mg', 'Tomar 1 comprimido a cada 8 horas', 1),
(2, 'Amoxicilina', '875mg', 'Tomar 1 comprimido a cada 12 horas', 2),
(3, 'Ibuprofeno', '600mg', 'Tomar 1 comprimido a cada 8 horas', 3),
(4, 'Omeprazol', '20mg', 'Tomar 1 cápsula pela manhã', 4),
(5, 'Diclofenaco', '50mg', 'Tomar 1 comprimido a cada 8 horas', 5),
(6, 'Simvastatina', '40mg', 'Tomar 1 comprimido à noite', 6),
(7, 'Metformina', '850mg', 'Tomar 1 comprimido após o jantar', 7),
(8, 'Atenolol', '50mg', 'Tomar 1 comprimido pela manhã', 8),
(9, 'Losartana', '50mg', 'Tomar 1 comprimido à noite', 9),
(10, 'Furosemida', '40mg', 'Tomar 1 comprimido pela manhã', 10),
(11, 'Captopril', '25mg', 'Tomar 1 comprimido a cada 8 horas', 11),
(12, 'Levotiroxina', '100mcg', 'Tomar 1 comprimido pela manhã', 12),
(13, 'Bromazepam', '3mg', 'Tomar 1 comprimido à noite', 13),
(14, 'Diazepam', '5mg', 'Tomar 1 comprimido à noite', 14),
(15, 'Lorazepam', '2mg', 'Tomar 1 comprimido à noite', 15),
(16, 'Clonazepam', '2mg', 'Tomar 1 comprimido à noite', 16),
(17, 'Alprazolam', '1mg', 'Tomar 1 comprimido à noite', 17),
(18, 'Sertralina', '50mg', 'Tomar 1 comprimido pela manhã', 18),
(19, 'Fluoxetina', '20mg', 'Tomar 1 comprimido pela manhã', 19),
(20, 'Paroxetina', '20mg', 'Tomar 1 comprimido pela manhã', 20);



