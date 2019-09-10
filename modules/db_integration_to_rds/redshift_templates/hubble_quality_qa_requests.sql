
create table hubble_quality_qa_requests
(
"client_server_id" smallint,
"id" integer,
"ref_num" varchar(24),
"project_id" integer,
"is_joint_inspection" integer,
"joint_subcontractor_id" integer,
"joint_validation" varchar(256),
"location_x" double precision,
"location_y" double precision,
"subcontractor_id" integer,
"type_id" integer,
"description" varchar(906),
"dimensions" varchar(1),
"remedial_action" varchar(1147),
"deadline" date,
"approval_status" integer,
"supervisor_id" integer,
"status" integer,
"manager_remarks" varchar(1),
"supervisor_remarks" varchar(64),
"subcontractor_remarks" varchar(108),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"floorplan_id" integer,
"defect_reason" varchar(24),
"soi_ref_number" varchar(31),
"is_archived" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
