-- Drop all the tables in the right order
DROP TABLE IF EXISTS "comments";
DROP SEQUENCE IF EXISTS comments_id_seq;

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

INSERT INTO "categories" ("categorie") VALUES
('Recettes de cuisine'),
('Lorem'),
('Random stuff');

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
    "username" character varying UNIQUE,
    "password" character varying,
    "label_id" integer,
    CONSTRAINT "users_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "users_label_id_fkey" FOREIGN KEY (label_id) REFERENCES labels(id) NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "users" ("username", "password", "label_id") VALUES
('joesentbon',	'$2y$10$AdsFAkBwIHgVdNfT5IdUtOxKFsyWvhqluW3zI/1oPZev.XyhGak6u',	2),
('vincent G',	'$2y$10$J43vAL83hfVmuE33bhM6NOo2RXQOFMmokH3P2xBIeVJFFp.5Z/YZW',	2),
('Papy',	'$2y$10$LxlwjD1FXjETb77KcL7WxeS3Xdm5wwwPgydGFIYdkEYQPlmPtm6iu',	2),
('Kratos',	'$2y$10$roIxStO3oFUYxkM4VOCKRORD8jPsFiH0DALvFC0fo8ipNQY/g1HBq',	3);



CREATE SEQUENCE articles_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."articles" (
    "id" integer DEFAULT nextval('articles_id_seq') NOT NULL,
    "title" character varying,
    "author_id" integer,
    "content" character varying,
    "date" character varying,
    "categorie_id" integer,
    CONSTRAINT "articles_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "articles_author_id_fkey" FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL NOT DEFERRABLE,
    CONSTRAINT "articles_categorie_id_fkey" FOREIGN KEY (categorie_id) REFERENCES categories(id) ON DELETE SET NULL NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "articles" ("title", "author_id", "content", "date", "categorie_id") VALUES
('Recette de pâtes bolo',	2,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/19',	1),
('Lorem',	4,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/19',	2),
('Ipsum',	1,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/19',	2),
('Dolor',	3,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/19',	2),
('Sit',	4,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/19',	2),
('Utilisation du lorem ipsum pour remplir une table articles',	3,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/19',	3),
('Amet',	1,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/19',	2),
('Consectetur',	2,	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',	'28/02/19',	2)
;

CREATE SEQUENCE comments_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."comments" (
  "id" integer DEFAULT nextval('comments_id_seq') NOT NULL,
  "author_id" integer,
  "article_id" integer,
  "content" character varying,
  "date" character varying,
  CONSTRAINT "comments_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "comments_author_id_fkey" FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL NOT DEFERRABLE,
  CONSTRAINT "comments_article_id_fkey" FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "comments" ("author_id", "article_id", "content", "date") VALUES
(1, 1, 'Bla bla bla, vive la cara', '11/03/19'),
(1, 1, 'Bla bla bla, je joue Trynda', '11/03/19'),
(1, 2, 'Bla bla bla et la date d édition dans tout ça', '11/03/19'),
(4, 1, 'Tu es un boulet Joey', '11/03/19')
;
