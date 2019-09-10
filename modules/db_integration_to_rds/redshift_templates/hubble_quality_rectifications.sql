
create table hubble_quality_rectifications
(
"client_server_id" smallint,
"id" integer,
"rectifiable_type" varchar(34),
"rectifiable_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"remark" varchar(256),
"user_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
