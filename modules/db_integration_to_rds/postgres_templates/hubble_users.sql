
create table hubble_users
(
"client_server_id" smallint,
"id" integer,
"name" character varying,
"password_digest" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"has_access" boolean,
"type" character varying,
"admin_group" integer
)
