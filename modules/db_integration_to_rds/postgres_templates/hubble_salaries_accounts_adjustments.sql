
create table hubble_salaries_accounts_adjustments
(
"client_server_id" smallint,
"id" integer,
"value" numeric,
"shift_account_id" integer,
"daily_account_id" integer,
"adjustable_type" character varying,
"adjustable_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"salary_cap_id" integer
)
