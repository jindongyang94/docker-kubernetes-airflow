
create table hubble_form_builder_element_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(24),
"etype" varchar(22),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
