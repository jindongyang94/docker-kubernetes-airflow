
create table hubble_workforces_employment_histories
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"start_date" date,
"end_date" date,
"company_name" varchar(57),
"business_type" varchar(43),
"designation" varchar(63),
"last_salary" varchar(6),
"reason_for_leaving" varchar(82),
"remarks" varchar(102),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
