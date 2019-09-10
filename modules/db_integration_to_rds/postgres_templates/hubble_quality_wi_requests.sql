
create table hubble_quality_wi_requests
(
"client_server_id" smallint,
"id" integer,
"ref_num" character varying,
"drawing_ref" character varying,
"inspection_num" integer,
"inspect_datetime" timestamp without time zone,
"supervisor_id" integer,
"rto_id" integer,
"project_id" integer,
"type_id" integer,
"clearance_status" integer,
"clearance_remarks" character varying,
"gridline" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"floorplan_id" integer
)
