
create table hubble_quality_wi_attachments
(
"client_server_id" smallint,
"id" integer,
"wi_request_id" integer,
"image" varchar(49),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
