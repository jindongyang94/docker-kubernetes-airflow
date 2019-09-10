
create table hubble_salaries_accounts_dailies
(
"client_server_id" smallint,
"id" integer,
"workforces_profile_id" integer,
"date" date,
"basic_lock" boolean,
"overtime_lock" boolean,
"adjustment_lock" boolean,
"working_days_in_month" numeric,
"verified" boolean,
"basic_amount" numeric,
"overtime_amount" numeric,
"adjustments_amount" numeric,
"adjustments_taxable_amount" numeric,
"adjustments_cpf_amount" numeric,
"basic_paid_amount" numeric,
"overtime_paid_amount" numeric,
"adjustments_paid_amount" numeric,
"adjustments_paid_taxable_amount" numeric,
"adjustments_paid_cpf_amount" numeric,
"basic_paid_by_employee_payment_id" integer,
"overtime_paid_by_employee_payment_id" integer,
"adjustments_paid_by_employee_payment_id" integer
)
