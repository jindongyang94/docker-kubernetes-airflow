
create table hubble_salaries_adjustments_daily_awardables
(
"client_server_id" smallint,
"id" integer,
"applicable_days_rule" varchar(99),
"basic_hours_exceed_rule" double precision,
"ot_hours_exceed_rule" double precision,
"time_cross_rule" varchar(8),
"basic_hours_comparator" varchar(3),
"ot_hours_comparator" varchar(3),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"time_cross_rule_days_offset" integer,
"ph_setting_basic_hours_exceed_rule" double precision,
"ph_setting_basic_hours_comparator" varchar(3),
"ph_setting_ot_hours_exceed_rule" double precision,
"ph_setting_ot_hours_comparator" varchar(3),
"ph_setting_holiday_hours_exceed_rule" double precision,
"ph_setting_holiday_hours_comparator" varchar(3),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
