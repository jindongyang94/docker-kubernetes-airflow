
create table hubble_salaries_caps
(
"client_server_id" smallint,
"id" integer,
"cap_period" integer,
"cap_type" integer,
"amount_type" integer,
"amount" numeric,
"treatment_type" integer,
"salaries_profile_id" integer,
"applicable_days" text,
"allowance_setting_id" integer,
"custom_cap_rate" double precision,
"cap_rate_multiplier" double precision,
"cap_rate_multiplier_reference" integer
)
