-- INSERT TWO LINES IN TABLE posts
-- ----------------------------------------------------------------------
LOCK TABLES posts WRITE;
INSERT INTO posts
(
  id, title, body
) VALUES
(
  1,
  'Hello API World!',
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
   tempor incididunt ut labore et dolore magna aliqua.  Ut enim ad minim
   veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
   commodo consequat.  Duis aute irure dolor in reprehenderit in voluptate
   velit esse cillum dolore eu fugiat nulla pariatur.  Excepteur sint occaecat
   cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id
   est laborum.'
);
INSERT INTO posts
(
  title, body
) VALUES
( 'Soneto de Fidelidade',
  '<p>De tudo ao meu amor serei atento <br>Antes; e com tal zelo, e sempre, e
   tanto <br>Que mesmo em face do maior encanto <br>Dele se encante mais meu
   pensamento</p><p>Quero vivê-lo em cada vão momento <br>E em seu louvor hei
   de espalhar meu canto <br>E rir me riso, e derramar meu pranto <br>Ao seu
   pesar ou seu contentamento</p><p>E assim quando mais tarde me procure
   <br>quem sabe a morte, angústia de quem vive <br>quem sabe a solidão, fim
   de quem ama</p><p>Eu possa me dizer do amor (que tive) <br>que não seja
   imortal, posto que é chama <br>mas que seja infinito enquanto dure.</p>'
);
UNLOCK TABLES;
