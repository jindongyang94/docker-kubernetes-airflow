
create table hubble_quality_cases
(
"client_server_id" smallint,
"id" integer,
"deadline" timestamp without time zone,
"location" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"status" integer,
"location_id" integer,
"user_id" integer,
"identifier" character varying,
"soi_ref_num" character varying,
"cc_list_id" integer,
"backcharge_remark" character varying,
"pending_begin" timestamp without time zone,
"pending_end" timestamp without time zone,
"active_begin" timestamp without time zone,
"active_end" timestamp without time zone,
"rejected_begin" timestamp without time zone,
"rejected_end" timestamp without time zone,
"closed_begin" timestamp without time zone,
"closed_end" timestamp without time zone,
"is_archived" boolean
)
