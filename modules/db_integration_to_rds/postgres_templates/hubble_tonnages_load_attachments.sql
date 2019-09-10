
create table hubble_tonnages_load_attachments
(
"client_server_id" smallint,
"id" integer,
"load_id" integer,
"attachment" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"type" text,
"bin_location" text
)
