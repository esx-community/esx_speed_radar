

CREATE TABLE `peage_flash` (
  `id` int(11) NOT NULL,
  `plate` varchar(10) NOT NULL,
  `speed` int(11) NOT NULL,
  `modele` varchar(25) NOT NULL,
  `station` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



INSERT INTO `peage_flash` (`id`, `plate`, `speed`, `modele`, `station`) VALUES
(1, '09JBK526', 168, 'T20', 1);



ALTER TABLE `peage_flash`
  ADD PRIMARY KEY (`id`);


--
ALTER TABLE `peage_flash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
