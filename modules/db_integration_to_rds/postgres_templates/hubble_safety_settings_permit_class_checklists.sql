
create table hubble_safety_settings_permit_class_checklists
(
"client_server_id" smallint,
"id" integer,
"sequence" integer,
"name" character varying,
"active" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"permit_class_id" integer,
"checklist_type" integer
)
