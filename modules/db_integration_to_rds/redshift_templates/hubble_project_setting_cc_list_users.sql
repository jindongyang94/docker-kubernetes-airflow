
create table hubble_project_setting_cc_list_users
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"cc_list_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
