-- Adminer 4.7.1 PostgreSQL dump

DROP TABLE IF EXISTS "permissions";
CREATE TABLE "public"."permissions" (
    "id" integer NOT NULL,
    "rank" character varying(255) NOT NULL,
    CONSTRAINT "permissions_id" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "permissions" ("id", "rank") VALUES
('0',	'user'),
(1,	'author'),
(2,	'admin');