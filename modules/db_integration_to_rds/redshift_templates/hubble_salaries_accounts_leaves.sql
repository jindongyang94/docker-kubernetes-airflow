
create table hubble_salaries_accounts_leaves
(
"client_server_id" smallint,
"id" integer,
"shift_account_id" integer,
"leave_application_id" integer,
"leave_value" numeric,
"leave_unit_quantity" numeric,
"leave_unit_symbol" numeric,
"leave_unit_rate" numeric,
"leave_hours" numeric,
"paid" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
