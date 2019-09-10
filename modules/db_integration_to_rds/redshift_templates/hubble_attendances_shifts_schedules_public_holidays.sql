
create table hubble_attendances_shifts_schedules_public_holidays
(
"client_server_id" smallint,
"id" integer,
"schedule_id" integer,
"shift_id" integer,
"is_working_day" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
