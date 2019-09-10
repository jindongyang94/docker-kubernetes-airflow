
create table hubble_quality_defects
(
"client_server_id" smallint,
"id" integer,
"case_id" integer,
"remark" varchar(1),
"main_defect_type" varchar(28),
"sub_defect_type" varchar(31),
"quantity" integer,
"reason_for_defect" varchar(42),
"description" varchar(235),
"remedial_action" varchar(118),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"defect_assignee_id" integer,
"status" integer,
"pin_color" varchar(10),
"sequence_id" integer,
"not_rectified_begin" timestamp without time zone,
"not_rectified_end" timestamp without time zone,
"rectified_begin" timestamp without time zone,
"rectified_end" timestamp without time zone,
"accepted_begin" timestamp without time zone,
"accepted_end" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
