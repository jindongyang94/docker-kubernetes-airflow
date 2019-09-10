
create table hubble_salaries_adjustments_loans
(
"client_server_id" smallint,
"id" integer,
"employee_id" integer,
"name" character varying,
"description" character varying,
"initial_amount" numeric,
"repayment_amount" numeric,
"start_date" date,
"status" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
