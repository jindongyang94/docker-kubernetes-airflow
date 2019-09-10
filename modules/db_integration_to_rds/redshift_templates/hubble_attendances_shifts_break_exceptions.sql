
create table hubble_attendances_shifts_break_exceptions
(
"client_server_id" smallint,
"id" integer,
"break_id" integer,
"attendance_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
