
create table hubble_salaries_adjustments_recurring_deductions
(
"client_server_id" smallint,
"id" integer,
"name" character varying,
"code" character varying,
"cpf_group" integer,
"level" integer,
"interval" integer,
"taxable" boolean,
"active" boolean,
"applicable_days_rule" text
)
