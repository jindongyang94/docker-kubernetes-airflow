
create table hubble_attendances_shifts_breaks
(
"client_server_id" smallint,
"id" integer,
"shift_id" integer,
"break_type_id" integer,
"start_time" time without time zone,
"start_days_offset" integer,
"end_time" time without time zone,
"end_days_offset" integer,
"toggleable" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"starts_after" integer,
"duration" integer
)
