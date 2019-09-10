
create table hubble_salaries_payrolls_donation_items
(
"client_server_id" smallint,
"id" integer,
"employee_payment_id" integer,
"name" varchar(13),
"amount" numeric,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
