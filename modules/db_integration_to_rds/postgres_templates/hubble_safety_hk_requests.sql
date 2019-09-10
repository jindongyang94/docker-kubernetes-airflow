
create table hubble_safety_hk_requests
(
"client_server_id" smallint,
"id" integer,
"project_id" integer,
"subcontractor_id" integer,
"joint_subcontractor_id" integer,
"floorplan_id" integer,
"description" character varying,
"remedial_action" character varying,
"deadline" date,
"ref_num" character varying,
"is_joint_inspection" integer,
"location_x" double precision,
"location_y" double precision,
"joint_validation" bytea,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"type_id" integer,
"status" integer,
"approval_status" integer,
"approval_remarks" character varying,
"request_remarks" character varying,
"supervisor_id" integer
)
