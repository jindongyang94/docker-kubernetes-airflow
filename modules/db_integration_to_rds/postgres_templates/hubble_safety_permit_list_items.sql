
create table hubble_safety_permit_list_items
(
"client_server_id" smallint,
"id" integer,
"permit_list_id" integer,
"sequence" integer,
"question" character varying,
"active" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"itemable_type" character varying,
"itemable_id" integer
)
