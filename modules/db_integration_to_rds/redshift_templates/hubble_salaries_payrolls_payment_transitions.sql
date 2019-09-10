
create table hubble_salaries_payrolls_payment_transitions
(
"client_server_id" smallint,
"id" integer,
"to_state" varchar(15),
"metadata" varchar(3),
"sort_key" integer,
"payment_id" integer,
"most_recent" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
