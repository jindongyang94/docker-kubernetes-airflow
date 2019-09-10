
create table hubble_attendances_shifts_breaks
(
"client_server_id" smallint,
"id" integer,
"shift_id" integer,
"break_type_id" integer,
"start_time" varchar(8),
"start_days_offset" integer,
"end_time" varchar(8),
"end_days_offset" integer,
"toggleable" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"starts_after" integer,
"duration" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
