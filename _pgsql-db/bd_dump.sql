-- Drop all the tables in the right order
DROP TABLE IF EXISTS "articles";
DROP SEQUENCE IF EXISTS articles_id_seq;

DROP TABLE IF EXISTS "users";
DROP SEQUENCE IF EXISTS users_id_seq;

DROP TABLE IF EXISTS "labels";

DROP TABLE IF EXISTS "categories";
DROP SEQUENCE IF EXISTS categories_id_seq;
