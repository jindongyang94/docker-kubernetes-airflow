
create table hubble_salaries_adjustments_daily_awardables
(
"client_server_id" smallint,
"id" integer,
"applicable_days_rule" text,
"basic_hours_exceed_rule" double precision,
"ot_hours_exceed_rule" double precision,
"time_cross_rule" time without time zone,
"basic_hours_comparator" character varying,
"ot_hours_comparator" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"time_cross_rule_days_offset" integer,
"ph_setting_basic_hours_exceed_rule" double precision,
"ph_setting_basic_hours_comparator" character varying,
"ph_setting_ot_hours_exceed_rule" double precision,
"ph_setting_ot_hours_comparator" character varying,
"ph_setting_holiday_hours_exceed_rule" double precision,
"ph_setting_holiday_hours_comparator" character varying
)
