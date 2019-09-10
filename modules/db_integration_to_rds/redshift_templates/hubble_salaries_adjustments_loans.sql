
create table hubble_salaries_adjustments_loans
(
"client_server_id" smallint,
"id" integer,
"employee_id" integer,
"name" varchar(28),
"description" varchar(57),
"initial_amount" numeric,
"repayment_amount" numeric,
"start_date" date,
"status" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
