
create table hubble_salaries_adjustments_recurring_deduction_schedules
(
"client_server_id" smallint,
"id" integer,
"recurring_deduction_id" integer,
"attributable_level_type" character varying,
"attributable_level_id" integer,
"amount_type" integer,
"amount" numeric,
"effective_start_date" date,
"effective_end_date" date
)
