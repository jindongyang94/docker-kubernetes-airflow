
create table hubble_salaries_payrolls_payment_structures
(
"client_server_id" smallint,
"id" integer,
"basic_cycle_on" integer,
"overtime_cycle_on" integer,
"adjustments_cycle_on" integer,
"name" varchar(18),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
