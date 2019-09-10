
create table hubble_quality_defects
(
"client_server_id" smallint,
"id" integer,
"case_id" integer,
"remark" character varying,
"main_defect_type" character varying,
"sub_defect_type" character varying,
"quantity" integer,
"reason_for_defect" character varying,
"description" character varying,
"remedial_action" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"defect_assignee_id" integer,
"status" integer,
"pin_color" character varying,
"sequence_id" integer,
"not_rectified_begin" timestamp without time zone,
"not_rectified_end" timestamp without time zone,
"rectified_begin" timestamp without time zone,
"rectified_end" timestamp without time zone,
"accepted_begin" timestamp without time zone,
"accepted_end" timestamp without time zone
)
