-- phpMyAdmin SQL Dump

-- version 4.5.1

-- http://www.phpmyadmin.net

--

-- Host: 127.0.0.1

-- Generation Time: 16-Nov-2016 às 21:15

-- Versão do servidor: 10.1.16-MariaDB

-- PHP Version: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

SET time_zone = "+00:00";





/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!40101 SET NAMES utf8mb4 */;


--

-- Database: `livraria`

--

-- --------------------------------------------------------

--

-- Estrutura da tabela `assunto`

--

CREATE TABLE `assunto` (

`sigla` char(2) NOT NULL,

`nome` varchar(40) DEFAULT NULL

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--

-- Extraindo dados da tabela `assunto`

--

INSERT INTO `assunto` (`sigla`, `nome`) VALUES

('BD', 'Banco de Dados'),

('ES', 'Engenharia de Software'),

('GP', 'Gerência de Projetos'),

('PR', 'Programação'),

('RC', 'Redes de Computadores');

-- --------------------------------------------------------

--

-- Estrutura da tabela `editora`

--

CREATE TABLE `editora` (

`codigo` int(11) NOT NULL,

`nome` varchar(20) DEFAULT NULL

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--

-- Extraindo dados da tabela `editora`

--

INSERT INTO `editora` (`codigo`, `nome`) VALUES

(1, 'Pearson'),

(2, 'Saraiva'),

(3, 'Bookman'),

(4, 'Unipê');

-- --------------------------------------------------------

--

-- Estrutura da tabela `livro`

--

CREATE TABLE `livro` (

`codigo` int(11) NOT NULL,

`titulo` varchar(50) DEFAULT NULL,

`valor` decimal(6,2) DEFAULT NULL,

`ano` int(11) DEFAULT NULL,

`assunto` char(2) DEFAULT NULL,

`editora` int(11) DEFAULT NULL

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--

-- Extraindo dados da tabela `livro`

--

INSERT INTO `livro` (`codigo`, `titulo`, `valor`, `ano`, `assunto`, `editora`) VALUES

(1, 'MySQL', '100.00', 2014, 'BD', 1),

(2, 'Introdução ao PMBOK', '88.00', 2014, 'GP', 2),

(3, 'JAVA', '75.00', 2014, 'PR', 2),

(4, 'Engenharia de Software', '120.00', 2013, 'ES', 3),

(5, 'Pyhton', '65.00', 2015, 'PR', 4),

(6, 'Oracle', '150.00', 2016, 'BD', 4),

(7, 'Redes de Computadores', '99.00', 2016, 'RC', 1);

--

-- Indexes for dumped tables

--

--

-- Indexes for table `assunto`

--

ALTER TABLE `assunto`

ADD PRIMARY KEY (`sigla`);

--

-- Indexes for table `editora`

--

ALTER TABLE `editora`

ADD PRIMARY KEY (`codigo`);

--

-- Indexes for table `livro`

--

ALTER TABLE `livro`

ADD PRIMARY KEY (`codigo`),

ADD KEY `assunto` (`assunto`),

ADD KEY `editora` (`editora`);

--

-- Constraints for dumped tables

--

--

-- Limitadores para a tabela `livro`

--

ALTER TABLE `livro`

ADD CONSTRAINT `livro_ibfk_1` FOREIGN KEY (`assunto`) REFERENCES `assunto` (`sigla`),

ADD CONSTRAINT `livro_ibfk_2` FOREIGN KEY (`editora`) REFERENCES `editora` (`codigo`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


DELIMITER $$
CREATE PROCEDURE consultar_livros()
select*from livro;
$$

CALL consulta_livros;

DELIMITER $$
CREATE PROCEDURE recuperar_msg()
BEGIN
SELECT 'Esta é uma aula de Banco de Dados' AS Mensagem;
END
$$

CALL recuperar_msg;
 

DELIMITER $$

CREATE PROCEDURE insereAssunto (IN p_sigla varchar(2), IN p_nome varchar(40))
BEGIN
INSERT INTO assunto (sigla, nome) VALUES (P_sigla, P_nome);
END $$

CALL insereAssunto ('ED','Estrutura de Dados');

DELIMITER $$
CREATE PROCEDURE sp_consulta()
BEGIN
SELECT l.codigo,l.titulo,l.valor,l.ano FROM livro l, editora e
WHERE e.codigo = l.editora AND e.nome='Pearson';
END $$

CALL sp_consulta;

DELIMITER $$
CREATE PROCEDURE sp_consultalivro (IN nomeproduto VARCHAR(30))
BEGIN 
SELECT l.titulo, l.valor, l.ano FROM livro l
WHERE l.titulo= nomeproduto;
END $$

CALL sp_consultalivro('Java');

CREATE PROCEDURE sp_consulta2(nomeEditora varchar(20))
BEGIN
SELECT e.nome, a.nome, l.titulo, l.valor, l.ano
FROM editora e, assunto a, livro l
WHERE e.codigo=l.editora AND asigla = l.assunt AND
e.nome=nomeEditora;
END $$

CALL sp_consulta2('Saraiva')

