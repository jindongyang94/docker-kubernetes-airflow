
create table hubble_users
(
"client_server_id" smallint,
"id" integer,
"name" varchar(42),
"password_digest" varchar(90),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"has_access" boolean,
"type" varchar(55),
"admin_group" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
