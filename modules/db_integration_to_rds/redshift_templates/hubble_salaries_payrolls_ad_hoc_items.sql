
create table hubble_salaries_payrolls_ad_hoc_items
(
"client_server_id" smallint,
"id" integer,
"employee_payment_id" integer,
"name" varchar(63),
"amount" numeric,
"taxable" boolean,
"cpf_group" integer,
"ad_hoc_account_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
