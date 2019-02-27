DROP TABLE IF EXISTS "labels";
CREATE TABLE "public"."labels" (
    "id" integer NOT NULL,
    "user_label" character varying,
    CONSTRAINT "labels_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "labels" ("id", "user_label") VALUES
(0,	'user'),
(1,	'author'),
(2,	'admin');


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

INSERT INTO "users" ("id", "username", "password", "label_id") VALUES
(1,	'joesentbon',	'$2y$10$AdsFAkBwIHgVdNfT5IdUtOxKFsyWvhqluW3zI/1oPZev.XyhGak6u',	0),
(2,	'vincent G',	'$2y$10$J43vAL83hfVmuE33bhM6NOo2RXQOFMmokH3P2xBIeVJFFp.5Z/YZW',	0),
(3,	'Papy',	'$2y$10$LxlwjD1FXjETb77KcL7WxeS3Xdm5wwwPgydGFIYdkEYQPlmPtm6iu',	0),
(4,	'Kratos',	'$2y$10$roIxStO3oFUYxkM4VOCKRORD8jPsFiH0DALvFC0fo8ipNQY/g1HBq',	0);
