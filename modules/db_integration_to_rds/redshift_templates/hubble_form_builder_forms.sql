
create table hubble_form_builder_forms
(
"client_server_id" smallint,
"id" integer,
"name" varchar(37),
"description" varchar(28),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"status" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
