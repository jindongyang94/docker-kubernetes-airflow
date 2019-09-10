
create table hubble_safety_hk_requests
(
"client_server_id" smallint,
"id" integer,
"project_id" integer,
"subcontractor_id" integer,
"joint_subcontractor_id" integer,
"floorplan_id" integer,
"description" varchar(1),
"remedial_action" varchar(1),
"deadline" date,
"ref_num" varchar(1),
"is_joint_inspection" integer,
"location_x" double precision,
"location_y" double precision,
"joint_validation" varchar(256),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"type_id" integer,
"status" integer,
"approval_status" integer,
"approval_remarks" varchar(1),
"request_remarks" varchar(1),
"supervisor_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
