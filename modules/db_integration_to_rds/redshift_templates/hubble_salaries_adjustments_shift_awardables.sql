
create table hubble_salaries_adjustments_shift_awardables
(
"client_server_id" smallint,
"id" integer,
"applicable_days_rule" varchar(10),
"basic_hours_exceed_rule" double precision,
"basic_hours_comparator" varchar(1),
"ot_hours_exceed_rule" double precision,
"ot_hours_comparator" varchar(1),
"time_cross_rule" varchar(8),
"award_manual_rule" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
