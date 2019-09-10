
create table hubble_attendances_shifts_schedules_weeklies
(
"client_server_id" smallint,
"id" integer,
"schedule_id" integer,
"sequence" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
