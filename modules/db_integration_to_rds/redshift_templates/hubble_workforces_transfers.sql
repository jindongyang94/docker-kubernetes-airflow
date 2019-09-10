
create table hubble_workforces_transfers
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"company_id" integer,
"department_id" integer,
"division_id" integer,
"project_id" integer,
"designation_id" integer,
"supervisor_id" integer,
"accommodation_id" integer,
"job_grade" varchar(1),
"effective_start_date" date,
"effective_end_date" date,
"address_populated" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
