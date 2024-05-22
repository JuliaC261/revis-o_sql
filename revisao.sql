--SELECT DISTINCT m.nome_medico
--FROM medico m, especialidade e
--WHERE m.id_espec = 1;

--SELECT p.nome_paciente, c.nome_convenio, c.tempo_carencia
--FROM paciente p
--JOIN convenio c ON p.id_convenio = c.id_convenio
--WHERE c.tempo_carencia < 90
--ORDER BY p.id_paciente;

--SELECT co.data_hora_consulta
--FROM consulta co
--WHERE co.data_hora_consulta BETWEEN '2024-01-01' AND '2024-05-15';

--SELECT DISTINCT co.valor_consulta, e.nome_espec
--FROM consulta co, medico m
--JOIN especialidade e ON e.id_espec = m.id_espec
--ORDER BY e.nome_espec;

--SELECT p.nome_paciente, i.data_entrada
--FROM internacao i
--JOIN paciente p ON i.id_paciente = p.id_paciente
--WHERE i.data_efetiva_alta IS NULL;

--SELECT m.nome_medico, co.data_hora_consulta
--FROM consulta co
--JOIN medico m ON m.id_medico = co.id_medico
--WHERE co.data_hora_consulta::date = '2024-10-01';

--SELECT p.nome_paciente, co.data_hora_consulta, i.data_entrada
--FROM consulta co
--JOIN paciente p ON p.id_paciente = co.id_paciente
--JOIN internacao i ON i.id_paciente = p.id_paciente
--WHERE p.id_convenio IS NULL;

--SELECT e.nome_espec
--FROM especialidade e
--LEFT JOIN medico m ON e.id_espec = m.id_espec
--WHERE m.id_medico IS NULL;