DROP TABLE IF EXISTS "labels";
CREATE TABLE "public"."labels" (
    "id" integer NOT NULL,
    "user_label" character varying,
    CONSTRAINT "labels_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "labels" ("id", "user_label") VALUES
(1,	'user'),
(2,	'author'),
(3,	'admin');

DROP TABLE IF EXISTS "users";
DROP SEQUENCE IF EXISTS users_id_seq;
CREATE SEQUENCE users_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."users" (
    "id" integer DEFAULT nextval('users_id_seq') NOT NULL,
    "username" character varying,
    "password" character varying,
    "label_id" integer,
    CONSTRAINT "users_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "users_label_id_fkey" FOREIGN KEY ("label_id") REFERENCES labels(id) NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "users" ( "username", "password", "label_id") VALUES
(	'joesentbon',	'$2y$10$AdsFAkBwIHgVdNfT5IdUtOxKFsyWvhqluW3zI/1oPZev.XyhGak6u',	1),
(	'vincent G',	'$2y$10$J43vAL83hfVmuE33bhM6NOo2RXQOFMmokH3P2xBIeVJFFp.5Z/YZW',	1),
(	'Papy',	'$2y$10$LxlwjD1FXjETb77KcL7WxeS3Xdm5wwwPgydGFIYdkEYQPlmPtm6iu',	2),
(	'Kratos',	'$2y$10$roIxStO3oFUYxkM4VOCKRORD8jPsFiH0DALvFC0fo8ipNQY/g1HBq',	3);

DROP TABLE IF EXISTS "articles";
DROP SEQUENCE IF EXISTS artciles_id_seq;
CREATE SEQUENCE artciles_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "articles" (
  "id" int DEFAULT nextval('artciles_id_seq') NOT NULL,
  "title" varchar,
  "author_id" int,
  "content" varchar,
  "date" varchar, --changer le format quand on a le temps
  -- "categorie_id" int, --ajouter FK when cat table is added
  -- "comment_id" int, --ajouter FK when com table is added
  CONSTRAINT "articles_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "articles_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES users(id) NOT DEFERRABLE
);

INSERT INTO "articles" ("title", "author_id", "content", "date") VALUES
('Recette de pâtes bolo', '2', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '28/02/2019'),
('Lorem', '4', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '28/02/2019'),
('Ipsum', '1', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '28/02/2019'),
('Dolor', '3', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '28/02/2019'),
('Sit', '4', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '28/02/2019'),
('Utilisation du lorem ipsum pour remplir une table articles', '3', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '28/02/2019'),
('Amet', '1', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '28/02/2019'),
('Consectetur', '2', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '28/02/2019');
