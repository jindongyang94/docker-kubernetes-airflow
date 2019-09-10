
create table hubble_salaries_settings_bank_accounts
(
"client_server_id" smallint,
"id" integer,
"bank_code" varchar(6),
"bank_name" varchar(6),
"branch_no" varchar(10),
"account_no" varchar(15),
"account_name" varchar(88),
"company_identification" varchar(15),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"batch_counter" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
