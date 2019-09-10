
create table hubble_salaries_accounts_employee_locks
(
"client_server_id" smallint,
"id" integer,
"employee_id" integer,
"month" integer,
"year" integer,
"remarks" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"status" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
