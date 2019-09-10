
create table hubble_attendances_shifts_overtimes
(
"client_server_id" smallint,
"id" integer,
"shift_id" integer,
"start_time" varchar(8),
"start_days_offset" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"custom_overtime" double precision,
"overtime_multiplier" double precision,
"multiplier_reference" integer,
"starts_after" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
