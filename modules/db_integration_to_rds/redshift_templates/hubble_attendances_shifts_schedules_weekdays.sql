
create table hubble_attendances_shifts_schedules_weekdays
(
"client_server_id" smallint,
"id" integer,
"weekly_schedule_id" integer,
"shift_id" integer,
"day" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
