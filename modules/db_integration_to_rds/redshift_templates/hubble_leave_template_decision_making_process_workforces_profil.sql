
create table hubble_leave_template_decision_making_process_workforces_profil
(
"client_server_id" smallint,
"id" integer,
"decision_making_process_id" integer,
"employee_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
