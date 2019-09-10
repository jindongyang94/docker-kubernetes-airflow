
create table hubble_form_builder_form_state_transitions
(
"client_server_id" smallint,
"id" integer,
"to_state" character varying,
"metadata" json,
"sort_key" integer,
"hubble_form_builder_form_id" integer,
"most_recent" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
