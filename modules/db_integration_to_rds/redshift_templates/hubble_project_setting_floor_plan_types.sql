
create table hubble_project_setting_floor_plan_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(36),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
