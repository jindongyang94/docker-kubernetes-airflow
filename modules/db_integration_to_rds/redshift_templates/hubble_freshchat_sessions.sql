
create table hubble_freshchat_sessions
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"restore_id" varchar(54),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
