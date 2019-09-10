
create table hubble_attendances_shifts_shifts
(
"client_server_id" smallint,
"id" integer,
"name" varchar(84),
"code" varchar(55),
"active" boolean,
"shift_start_time" varchar(8),
"shift_start_days_offset" integer,
"shift_end_time" varchar(8),
"shift_end_days_offset" integer,
"pay_start_time" varchar(8),
"pay_start_days_offset" integer,
"ot_mode" integer,
"break_mode" integer,
"paid_after_end_time" boolean,
"pay_stop_after_hours" numeric,
"pay_stop_after_time" varchar(8),
"pay_stop_after_days_offset" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"working_days" numeric,
"custom_basic" double precision,
"basic_multiplier" double precision,
"basic_multiplier_reference" integer,
"working_hours" numeric,
"custom_holiday" double precision,
"holiday_multiplier" double precision,
"holiday_multiplier_reference" integer,
"holiday_work_required" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
