
create table hubble_safety_inspections
(
"client_server_id" smallint,
"id" integer,
"project_id" integer,
"subcontractor_id" integer,
"joint_subcontractor_id" integer,
"floorplan_id" integer,
"permit_id" integer,
"is_joint_inspection" integer,
"pin_x" double precision,
"pin_y" double precision,
"ref_num" varchar(30),
"description" varchar(1060),
"remedial_action" varchar(540),
"deadline" date,
"fine_reason" varchar(202),
"fine_charge" double precision,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"status" integer,
"risk_level_id" integer,
"type_id" integer,
"is_archived" boolean,
"safety_officer_id" integer,
"risk_level" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
