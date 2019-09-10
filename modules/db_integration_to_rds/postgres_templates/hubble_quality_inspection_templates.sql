
create table hubble_quality_inspection_templates
(
"client_server_id" smallint,
"id" integer,
"name" character varying,
"description" character varying,
"status" character varying,
"workflow_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"project_id" integer
)
