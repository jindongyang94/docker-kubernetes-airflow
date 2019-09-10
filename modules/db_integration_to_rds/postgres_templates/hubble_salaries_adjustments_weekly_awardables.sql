
create table hubble_salaries_adjustments_weekly_awardables
(
"client_server_id" smallint,
"id" integer,
"work_full_rule" boolean,
"basic_hours_exceed_rule" double precision,
"ot_hours_exceed_rule" double precision,
"basic_hours_comparator" character varying,
"ot_hours_comparator" character varying
)
