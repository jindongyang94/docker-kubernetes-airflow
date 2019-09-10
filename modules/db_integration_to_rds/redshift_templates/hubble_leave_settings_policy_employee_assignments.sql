
create table hubble_leave_settings_policy_employee_assignments
(
"client_server_id" smallint,
"id" integer,
"employee_id" integer,
"policy_id" integer,
"effective_start_date" date,
"effective_end_date" date,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
