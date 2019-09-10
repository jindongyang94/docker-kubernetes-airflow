
create table hubble_salaries_accounts_company_lock_transitions
(
"client_server_id" smallint,
"id" integer,
"company_lock_id" integer,
"to_state" character varying,
"metadata" text,
"sort_key" integer,
"most_recent" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
