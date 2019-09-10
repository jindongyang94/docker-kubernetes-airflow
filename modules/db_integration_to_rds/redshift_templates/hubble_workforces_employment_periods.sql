
create table hubble_workforces_employment_periods
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"employee_type" integer,
"join_date" date,
"probation_start_date" date,
"probation_end_date" date,
"confirmation_date" date,
"resignation_date" date,
"termination_date" date,
"termination_reason" varchar(97),
"evaluation_score" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
