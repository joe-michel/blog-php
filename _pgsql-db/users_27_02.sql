-- Adminer 4.7.1 PostgreSQL dump

DROP TABLE IF EXISTS "users";
DROP SEQUENCE IF EXISTS users_id_seq;
CREATE SEQUENCE users_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."users" (
    "id" integer DEFAULT nextval('users_id_seq') NOT NULL,
    "username" character varying(250) NOT NULL,
    "password" character varying(250) NOT NULL,
    "permissionId" integer NOT NULL,
    CONSTRAINT "users_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "users_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES permissions(id) NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "users" ("id", "username", "password", "permissionId") VALUES
(2,	'JoséLeBg',	'$2y$10$8G0/JJcfBYjKEBlySSjrM.YNbrooaB3AOXf.de./0JdZWbXUT7BBK',	'0'),
(3,	'Francis',	'$2y$10$h3C6INo5cBJvmK2z9QG0H.90nWiRP3wFr8ddg9N3b92nFJDtBiChG',	1);
