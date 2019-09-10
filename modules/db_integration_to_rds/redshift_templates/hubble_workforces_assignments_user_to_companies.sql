
create table hubble_workforces_assignments_user_to_companies
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"company_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
