
create table hubble_salaries_payrolls_employee_payment_templates
(
"client_server_id" smallint,
"id" integer,
"employee_id" integer,
"payment_template_id" integer,
"is_following_global_setting" boolean,
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
"is_including_fpa" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
