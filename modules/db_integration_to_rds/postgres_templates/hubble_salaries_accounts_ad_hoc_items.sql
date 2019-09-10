
create table hubble_salaries_accounts_ad_hoc_items
(
"client_server_id" smallint,
"id" integer,
"employee_id" integer,
"source_employee_payment_id" integer,
"status" integer,
"item_type" integer,
"name" character varying,
"month" integer,
"year" integer,
"remarks" character varying,
"initial_amount" numeric,
"initial_taxable_amount" numeric,
"initial_cpf_amount" numeric,
"paid_amount" numeric,
"paid_taxable_amount" numeric,
"paid_cpf_amount" numeric,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
