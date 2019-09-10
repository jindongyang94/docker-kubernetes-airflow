
create table hubble_attendances_shifts_schedule_exceptions
(
"client_server_id" smallint,
"id" integer,
"schedule_assignment_id" integer,
"date" date,
"shift_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
