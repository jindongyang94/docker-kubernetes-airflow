
create table hubble_workforces_departments
(
"client_server_id" smallint,
"id" integer,
"code" varchar(42),
"name" varchar(54),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
