
create table hubble_salaries_accounts_ad_hoc_items
(
"client_server_id" smallint,
"id" integer,
"employee_id" integer,
"source_employee_payment_id" integer,
"status" integer,
"item_type" integer,
"name" varchar(48),
"month" integer,
"year" integer,
"remarks" varchar(1),
"initial_amount" numeric,
"initial_taxable_amount" numeric,
"initial_cpf_amount" numeric,
"paid_amount" numeric,
"paid_taxable_amount" numeric,
"paid_cpf_amount" numeric,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
