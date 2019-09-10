
create table hubble_leave_leave_warnings
(
"client_server_id" smallint,
"id" integer,
"application_mode" integer,
"group_mode" integer,
"threshold" integer,
"active" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
