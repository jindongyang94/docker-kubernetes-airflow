
create table hubble_salaries_profiles
(
"client_server_id" smallint,
"id" integer,
"name" varchar(72),
"type" varchar(52),
"prorate_rule" smallint,
"attendance_based" smallint,
"working_hours_in_year" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"active" boolean,
"working_days_in_week" numeric,
"working_hours_in_day" numeric,
"automatic_public_holiday" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
