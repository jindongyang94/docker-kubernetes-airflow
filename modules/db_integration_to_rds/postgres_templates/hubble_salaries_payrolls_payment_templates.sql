
create table hubble_salaries_payrolls_payment_templates
(
"client_server_id" smallint,
"id" integer,
"name" character varying,
"description" character varying,
"last_used" timestamp without time zone,
"payment_type" integer,
"basic_payment_start_date" integer,
"basic_payment_end_date" integer,
"overtime_payment_start_date" integer,
"overtime_payment_end_date" integer,
"adjustments_payment_start_date" integer,
"adjustments_payment_end_date" integer,
"basic_advance_payment_type" integer,
"basic_advance_payment_amount" numeric,
"overtime_advance_payment_type" integer,
"overtime_advance_payment_amount" numeric,
"adjustments_advance_payment_type" integer,
"adjustments_advance_payment_amount" numeric,
"company_id" integer,
"is_including_fpa" boolean
)
