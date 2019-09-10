
create table hubble_quality_inspections
(
"client_server_id" smallint,
"id" integer,
"inspection_type_id" integer,
"trade_id" integer,
"project_id" integer,
"cc_list_id" integer,
"location_id" integer,
"inspection_template_id" integer,
"form_submission_id" integer,
"status" varchar(1),
"references_number" varchar(1),
"description" varchar(1),
"deadline" timestamp without time zone,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
