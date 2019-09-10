
create table hubble_leave_settings_policies
(
"client_server_id" smallint,
"id" integer,
"policy" varchar(93),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
