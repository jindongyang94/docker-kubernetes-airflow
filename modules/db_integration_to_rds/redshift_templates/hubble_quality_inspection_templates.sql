
create table hubble_quality_inspection_templates
(
"client_server_id" smallint,
"id" integer,
"name" varchar(1),
"description" varchar(1),
"status" varchar(1),
"workflow_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"project_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
