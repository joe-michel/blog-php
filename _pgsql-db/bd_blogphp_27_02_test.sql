-- Adminer 4.7.1 PostgreSQL dump

DROP TABLE IF EXISTS "about";
CREATE TABLE "public"."about" (
    "id" integer NOT NULL,
    "name" character varying(50) NOT NULL,
    "profile" character varying(50) NOT NULL
) WITH (oids = false);


DROP TABLE IF EXISTS "articles";
CREATE TABLE "public"."articles" (
    "id" integer NOT NULL,
    "art_title" character varying,
    "author_id" integer,
    "art_content" character varying,
    "art_date" date,
    "main_categorie_id" integer,
    "side_categorie_id" integer,
    "comment_id" integer,
    CONSTRAINT "articles_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "articles_author_id_fkey" FOREIGN KEY (author_id) REFERENCES users(id) NOT DEFERRABLE,
    CONSTRAINT "articles_main_categorie_id_fkey" FOREIGN KEY (main_categorie_id) REFERENCES categories(id) NOT DEFERRABLE
) WITH (oids = false);


DROP TABLE IF EXISTS "categories";
CREATE TABLE "public"."categories" (
    "id" integer NOT NULL,
    "article_id" integer,
    "cat_title" character varying,
    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "comments";
CREATE TABLE "public"."comments" (
    "id" integer NOT NULL,
    "author_id" integer,
    "com_content" character varying,
    "com_date" date,
    CONSTRAINT "comments_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "comments_author_id_fkey" FOREIGN KEY (author_id) REFERENCES users(id) NOT DEFERRABLE
) WITH (oids = false);


DROP TABLE IF EXISTS "labels";
CREATE TABLE "public"."labels" (
    "id" integer NOT NULL,
    "user_label" character varying,
    CONSTRAINT "labels_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "users";
CREATE TABLE "public"."users" (
    "id" integer NOT NULL,
    "user_name" character varying,
    "user_label_id" integer,
    "user_password" character varying,
    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


-- 2019-02-27 11:10:00.217505+00
