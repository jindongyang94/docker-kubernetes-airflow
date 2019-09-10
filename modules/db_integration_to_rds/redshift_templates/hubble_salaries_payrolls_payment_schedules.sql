
create table hubble_salaries_payrolls_payment_schedules
(
"client_server_id" smallint,
"id" integer,
"payment_structure_id" integer,
"basic_payment_date" integer,
"basic_payment_mode" integer,
"basic_payment_value" numeric,
"overtime_payment_date" integer,
"overtime_payment_mode" integer,
"overtime_payment_value" numeric,
"adjustments_payment_date" integer,
"adjustments_payment_mode" integer,
"adjustments_payment_value" numeric,
"name" varchar(36),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
