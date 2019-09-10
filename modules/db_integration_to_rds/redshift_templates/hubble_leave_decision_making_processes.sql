
create table hubble_leave_decision_making_processes
(
"client_server_id" smallint,
"id" integer,
"leave_application_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
