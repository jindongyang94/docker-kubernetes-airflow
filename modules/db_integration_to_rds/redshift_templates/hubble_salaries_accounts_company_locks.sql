
create table hubble_salaries_accounts_company_locks
(
"client_server_id" smallint,
"id" integer,
"company_id" integer,
"month" integer,
"year" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
