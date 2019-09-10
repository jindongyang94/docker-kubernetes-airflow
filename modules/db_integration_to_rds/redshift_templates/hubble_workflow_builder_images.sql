
create table hubble_workflow_builder_images
(
"client_server_id" smallint,
"id" integer,
"file" varchar(1),
"expired_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
