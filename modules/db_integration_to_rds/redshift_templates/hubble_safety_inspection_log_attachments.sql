
create table hubble_safety_inspection_log_attachments
(
"client_server_id" smallint,
"id" integer,
"image" varchar(51),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"inspection_log_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
