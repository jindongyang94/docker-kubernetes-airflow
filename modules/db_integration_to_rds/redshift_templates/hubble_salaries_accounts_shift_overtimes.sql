
create table hubble_salaries_accounts_shift_overtimes
(
"client_server_id" smallint,
"id" integer,
"hours" numeric,
"rate" numeric,
"value" numeric,
"capped_hours" numeric,
"capped_value" numeric,
"shift_account_id" integer,
"sequence" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
