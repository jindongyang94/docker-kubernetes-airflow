
create table hubble_quality_wi_requests
(
"client_server_id" smallint,
"id" integer,
"ref_num" varchar(27),
"drawing_ref" varchar(160),
"inspection_num" integer,
"inspect_datetime" timestamp without time zone,
"supervisor_id" integer,
"rto_id" integer,
"project_id" integer,
"type_id" integer,
"clearance_status" integer,
"clearance_remarks" varchar(1),
"gridline" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"floorplan_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
