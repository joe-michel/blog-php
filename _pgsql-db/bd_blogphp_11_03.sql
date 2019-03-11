-- Drop all the tables in the right order
DROP TABLE IF EXISTS "articles";
DROP SEQUENCE IF EXISTS articles_id_seq;

DROP TABLE IF EXISTS "users";
DROP SEQUENCE IF EXISTS users_id_seq;

DROP TABLE IF EXISTS "labels";

DROP TABLE IF EXISTS "categories";
DROP SEQUENCE IF EXISTS categories_id_seq;

-- Create all the tables in the opposite order
CREATE SEQUENCE categories_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."categories" (
    "id" integer DEFAULT nextval('categories_id_seq') NOT NULL,
    "categorie" character varying,
    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "categories" ("id", "categorie") VALUES
(1,	'Recettes'),
(2,	'Lorem'),
(3,	'Random');

CREATE TABLE "public"."labels" (
    "id" integer NOT NULL,
    "user_label" character varying,
    CONSTRAINT "labels_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "labels" ("id", "user_label") VALUES
(1,	'user'),
(2,	'author'),
(3,	'admin');

CREATE SEQUENCE users_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."users" (
    "id" integer DEFAULT nextval('users_id_seq') NOT NULL,
    "username" character varying,
    "password" character varying,
    "label_id" integer,
    CONSTRAINT "users_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "users_label_id_fkey" FOREIGN KEY (label_id) REFERENCES labels(id) NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "users" ("id", "username", "password", "label_id") VALUES
(1,	'joesentbon',	'$2y$10$AdsFAkBwIHgVdNfT5IdUtOxKFsyWvhqluW3zI/1oPZev.XyhGak6u',	1),
(2,	'vincent G',	'$2y$10$J43vAL83hfVmuE33bhM6NOo2RXQOFMmokH3P2xBIeVJFFp.5Z/YZW',	1),
(3,	'Papy',	'$2y$10$LxlwjD1FXjETb77KcL7WxeS3Xdm5wwwPgydGFIYdkEYQPlmPtm6iu',	2),
(4,	'Kratos',	'$2y$10$roIxStO3oFUYxkM4VOCKRORD8jPsFiH0DALvFC0fo8ipNQY/g1HBq',	3);



CREATE SEQUENCE articles_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."articles" (
    "id" integer DEFAULT nextval('articles_id_seq') NOT NULL,
    "title" character varying,
    "author_id" integer,
    "content" character varying,
    "date" character varying,
    "categorie_id" integer,
    CONSTRAINT "articles_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "articles_author_id_fkey" FOREIGN KEY (author_id) REFERENCES users(id) NOT DEFERRABLE,
    CONSTRAINT "articles_categorie_id_fkey" FOREIGN KEY (categorie_id) REFERENCES categories(id) NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "articles" ("id", "title", "author_id", "content", "date", "categorie_id") VALUES
(1,	'Recette de pâtes bolo',	2,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/2019',	1),
(2,	'Lorem',	4,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/2019',	2),
(3,	'Ipsum',	1,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/2019',	2),
(4,	'Dolor',	3,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/2019',	2),
(5,	'Sit',	4,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/2019',	2),
(6,	'Utilisation du lorem ipsum pour remplir une table articles',	3,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/2019',	3),
(7,	'Amet',	1,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/2019',	2),
(8,	'Consectetur',	2,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/2019',	2);
