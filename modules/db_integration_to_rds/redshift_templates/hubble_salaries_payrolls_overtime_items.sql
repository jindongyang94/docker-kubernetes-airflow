
create table hubble_salaries_payrolls_overtime_items
(
"client_server_id" smallint,
"id" integer,
"name" varchar(18),
"amount" numeric,
"employee_payment_id" integer,
"unit" varchar(7),
"rate" numeric,
"unit_value" numeric,
"date" date,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
