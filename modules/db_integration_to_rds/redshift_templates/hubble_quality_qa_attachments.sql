
create table hubble_quality_qa_attachments
(
"client_server_id" smallint,
"id" integer,
"qa_request_id" integer,
"att_type" integer,
"image" varchar(51),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
