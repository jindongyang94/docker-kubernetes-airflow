
create table hubble_workforces_companies
(
"client_server_id" smallint,
"id" integer,
"code" varchar(10),
"name" varchar(78),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"id_type" integer,
"id_number" varchar(25),
"csn" varchar(22),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
