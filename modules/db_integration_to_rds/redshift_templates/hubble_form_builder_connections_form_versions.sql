
create table hubble_form_builder_connections_form_versions
(
"client_server_id" smallint,
"hubble_form_builder_connection_digest" varchar(60),
"hubble_form_builder_form_version_id" integer,
"level" integer,
primary key ("client_server_id")
)
compound sortkey("client_server_id")
