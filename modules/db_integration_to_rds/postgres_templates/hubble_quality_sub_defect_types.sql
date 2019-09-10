
create table hubble_quality_sub_defect_types
(
"client_server_id" smallint,
"id" integer,
"name" character varying,
"description" text,
"remedial_action" text,
"main_defect_type_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
