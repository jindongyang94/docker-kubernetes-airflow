
create table hubble_safety_permit_lists
(
"client_server_id" smallint,
"id" integer,
"name" varchar(1),
"description" varchar(1),
"active" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
