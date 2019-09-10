
create table hubble_salaries_payrolls_adjustment_items
(
"client_server_id" smallint,
"id" integer,
"name" varchar(58),
"amount" numeric,
"adjustment_type" integer,
"cpf_group" integer,
"employee_payment_id" integer,
"taxable" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
