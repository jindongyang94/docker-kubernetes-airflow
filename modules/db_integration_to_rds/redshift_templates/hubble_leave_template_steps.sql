
create table hubble_leave_template_steps
(
"client_server_id" smallint,
"id" integer,
"decision_making_process_id" integer,
"approver_id" integer,
"sequence_number" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
