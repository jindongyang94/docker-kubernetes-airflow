
create table hubble_safety_hk_request_log_attachments
(
"client_server_id" smallint,
"id" integer,
"image" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"hk_request_log_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
