
create table hubble_form_builder_submissions
(
"client_server_id" smallint,
"id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"user_id" integer,
"form_version_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
