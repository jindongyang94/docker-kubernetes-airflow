
create table hubble_salaries_adjustments_shift_awardables
(
"client_server_id" smallint,
"id" integer,
"applicable_days_rule" text,
"basic_hours_exceed_rule" double precision,
"basic_hours_comparator" character varying,
"ot_hours_exceed_rule" double precision,
"ot_hours_comparator" character varying,
"time_cross_rule" time without time zone,
"award_manual_rule" boolean
)
