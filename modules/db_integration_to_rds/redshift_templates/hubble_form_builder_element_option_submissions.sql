
create table hubble_form_builder_element_option_submissions
(
"client_server_id" smallint,
"id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"hubble_form_builder_submission_id" integer,
"hubble_form_builder_element_option_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
