
create table hubble_salaries_profiles
(
"client_server_id" smallint,
"id" integer,
"name" character varying,
"type" character varying,
"prorate_rule" smallint,
"attendance_based" smallint,
"working_hours_in_year" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"active" boolean,
"working_days_in_week" numeric,
"working_hours_in_day" numeric,
"automatic_public_holiday" boolean
)
