
create table hubble_attendances_shifts_schedules
(
"client_server_id" smallint,
"id" integer,
"name" varchar(70),
"schedule_type" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
