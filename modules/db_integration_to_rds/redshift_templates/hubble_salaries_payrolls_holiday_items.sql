
create table hubble_salaries_payrolls_holiday_items
(
"client_server_id" smallint,
"id" integer,
"employee_payment_id" integer,
"name" varchar(37),
"amount" numeric,
"unit" varchar(9),
"rate" numeric,
"unit_value" numeric,
"date" date,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
