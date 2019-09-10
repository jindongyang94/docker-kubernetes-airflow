
create table hubble_salaries_adjustments_transport_reimbursement_schedules
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"effective_start_date" date,
"effective_end_date" date,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
