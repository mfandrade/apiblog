LOCK TABLES `comments` WRITE;
INSERT INTO `comments`(
  `post_id`,
  `text`) VALUES (
  2,
  'Muito lindo esse soneto! Vinícius de Moraes é maravilhoso!');
UNLOCK TABLES;

