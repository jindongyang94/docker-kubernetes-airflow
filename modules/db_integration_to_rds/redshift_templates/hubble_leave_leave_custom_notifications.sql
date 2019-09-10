
create table hubble_leave_leave_custom_notifications
(
"client_server_id" smallint,
"id" integer,
"name" varchar(34),
"notification_mode" integer,
"application_mode" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
