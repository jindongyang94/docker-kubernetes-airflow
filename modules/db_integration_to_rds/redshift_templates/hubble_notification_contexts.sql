
create table hubble_notification_contexts
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"token" varchar(261),
"sub_context" varchar(91),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
