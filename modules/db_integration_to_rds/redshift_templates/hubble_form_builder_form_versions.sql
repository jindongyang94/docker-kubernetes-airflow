
create table hubble_form_builder_form_versions
(
"client_server_id" smallint,
"id" integer,
"form_id" integer,
"name" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
