
create table hubble_form_builder_submission_values
(
"client_server_id" smallint,
"id" integer,
"submission_id" integer,
"element_id" integer,
"value" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
