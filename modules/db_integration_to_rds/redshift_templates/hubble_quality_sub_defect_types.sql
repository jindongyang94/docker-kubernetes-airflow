
create table hubble_quality_sub_defect_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(123),
"description" varchar(244),
"remedial_action" varchar(78),
"main_defect_type_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
