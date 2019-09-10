
create table hubble_salaries_adjustments_recurring_deductions
(
"client_server_id" smallint,
"id" integer,
"name" varchar(43),
"code" varchar(43),
"cpf_group" integer,
"level" integer,
"interval" integer,
"taxable" boolean,
"active" boolean,
"applicable_days_rule" varchar(117),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
