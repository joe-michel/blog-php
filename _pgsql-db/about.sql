-- Adminer 4.7.1 PostgreSQL dump

DROP TABLE IF EXISTS "users";
CREATE TABLE "public"."users" (
    "id" SERIAL PRIMARY KEY NOT NULL,
    "username" character varying(250) NOT NULL,
    "password" character varying(250) NOT NULL,
    "permissionId" int NOT NULL
)
-- 2019-02-21 11:11:52.20687+00
