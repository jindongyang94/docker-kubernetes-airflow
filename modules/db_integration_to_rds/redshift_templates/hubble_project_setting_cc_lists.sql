
create table hubble_project_setting_cc_lists
(
"client_server_id" smallint,
"id" integer,
"name" varchar(60),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
