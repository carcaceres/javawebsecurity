-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-04-2017 a las 04:36:35
-- Versión del servidor: 5.6.17
-- Versión de PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `prueba`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

CREATE TABLE IF NOT EXISTS `login` (
  `user` varchar(20) NOT NULL,
  `pass` varchar(20) NOT NULL,
  `rol` int(2) NOT NULL,
  PRIMARY KEY (`user`),
  KEY `rol` (`rol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`user`, `pass`, `rol`) VALUES
('13805476', '123456', 1),
('23805476', '123456', 2),
('33805476', '123456', 3),
('admin', 'admin', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `codigo` varchar(10) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `sueldo` decimal(20,0) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`codigo`, `nombres`, `apellidos`, `sueldo`) VALUES
('c001', 'carlos', 'caceres', '3500000'),
('c002', 'maria', 'hoyos', '2000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prueba`
--

CREATE TABLE IF NOT EXISTS `prueba` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Volcado de datos para la tabla `prueba`
--

INSERT INTO `prueba` (`id`, `nombre`, `fecha`) VALUES
(1, 'jose', '2017-03-20'),
(2, 'carlos', '2017-03-20'),
(3, 'carlos', '2017-03-20'),
(4, 'maria', '2017-03-20'),
(5, 'hola', '2017-03-20'),
(6, 'carlos', '2017-03-20'),
(7, 'carlos', '2017-03-20'),
(8, '98098', '2017-03-20'),
(9, '98098', '2017-03-20'),
(10, 'carlos', '2017-03-20'),
(11, 'gleybins', '2017-03-20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE IF NOT EXISTS `rol` (
  `idrol` int(2) NOT NULL,
  `nomrol` varchar(20) NOT NULL,
  PRIMARY KEY (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idrol`, `nomrol`) VALUES
(1, 'Administrador'),
(2, 'Tutor'),
(3, 'Estudiante');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vistausuarios`
--
CREATE TABLE IF NOT EXISTS `vistausuarios` (
`user` varchar(20)
,`pass` varchar(20)
,`idrol` int(2)
,`nomrol` varchar(20)
);
-- --------------------------------------------------------

--
-- Estructura para la vista `vistausuarios`
--
DROP TABLE IF EXISTS `vistausuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vistausuarios` AS select `login`.`user` AS `user`,`login`.`pass` AS `pass`,`rol`.`idrol` AS `idrol`,`rol`.`nomrol` AS `nomrol` from (`rol` join `login` on((`rol`.`idrol` = `login`.`rol`)));

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `pk_rol` FOREIGN KEY (`rol`) REFERENCES `rol` (`idrol`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
