
create table hubble_salaries_parameters
(
"client_server_id" smallint,
"id" integer,
"salaries_profile_id" integer,
"workforces_profile_id" integer,
"basic_rate" numeric,
"ot_from_basic" boolean,
"ot_basic_multiplier" numeric,
"ot_custom_rate" numeric,
"holiday_from_basic" boolean,
"holiday_basic_multiplier" numeric,
"holiday_custom_rate" numeric,
"effective_start_date" date,
"effective_end_date" date,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
