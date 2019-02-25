-- Adminer 4.7.1 PostgreSQL dump

DROP TABLE IF EXISTS "about";
CREATE TABLE "public"."about" (
    "id" integer NOT NULL,
    "name" character varying(50) NOT NULL,
    "profile" character varying(50) NOT NULL
) WITH (oids = false);

INSERT INTO "about" ("id", "name", "profile") VALUES
(1,	'Jean',	'Developer'),
(2,	'Pierre',	'Designer'),
(3,	'Paul',	'Community manager');

-- 2019-02-21 11:11:52.20687+00
