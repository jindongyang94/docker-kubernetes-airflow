
create table hubble_salaries_payrolls_tax_items
(
"client_server_id" smallint,
"id" integer,
"employee_payment_id" integer,
"name" text,
"employer_cpf_amount" numeric,
"employee_cpf_amount" numeric,
"cpf_ordinary_wage_before_ceiling" numeric,
"cpf_additional_wage_before_ceiling" numeric,
"taxable_wage" numeric,
"non_taxable_wage" numeric,
"cpf_ordinary_wage_after_ceiling" numeric,
"cpf_additional_wage_after_ceiling" numeric,
"sdl_amount" numeric
)
