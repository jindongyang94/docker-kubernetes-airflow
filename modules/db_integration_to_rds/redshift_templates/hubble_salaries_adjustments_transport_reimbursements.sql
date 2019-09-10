
create table hubble_salaries_adjustments_transport_reimbursements
(
"client_server_id" smallint,
"id" integer,
"name" varchar(34),
"code" varchar(34),
"cpf_group" integer,
"taxable" boolean,
"allowance_type_id" integer,
"effective_start_date" date,
"effective_end_date" date,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
