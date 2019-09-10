
create table hubble_leave_leave_notification_observers
(
"client_server_id" smallint,
"id" integer,
"employee_id" integer,
"custom_notification_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
