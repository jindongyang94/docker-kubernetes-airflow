
create table hubble_project_setting_floor_plans
(
"client_server_id" smallint,
"id" integer,
"floor_plan_type" varchar(36),
"identifier" varchar(51),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"project_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
