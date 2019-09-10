
create table hubble_safety_permits
(
"client_server_id" smallint,
"id" integer,
"project_id" integer,
"floorplan_id" integer,
"valid_start" timestamp without time zone,
"valid_end" timestamp without time zone,
"is_night_work" integer,
"gridline" varchar(238),
"description" varchar(415),
"ref_num" varchar(34),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"location_x" double precision,
"location_y" double precision,
"status" integer,
"applicant_name" varchar(264),
"mobile_number" varchar(28),
"is_archived" boolean,
"permit_applicant_id" integer,
"trade_ic_id" integer,
"safety_assessor_id" integer,
"ptw_approver_id" integer,
"approval_status" integer,
"current_pending_approval_sequence" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
