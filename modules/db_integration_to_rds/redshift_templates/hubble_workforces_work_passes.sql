
create table hubble_workforces_work_passes
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"employment_pass_type" integer,
"number" varchar(18),
"application_date" date,
"issue_date" date,
"expiry_date" date,
"return_date" date,
"termination_date" date,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
