
create table hubble_salaries_accounts_company_lock_transitions
(
"client_server_id" smallint,
"id" integer,
"company_lock_id" integer,
"to_state" varchar(1),
"metadata" varchar(1),
"sort_key" integer,
"most_recent" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
