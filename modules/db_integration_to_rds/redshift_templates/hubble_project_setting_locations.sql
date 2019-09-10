
create table hubble_project_setting_locations
(
"client_server_id" smallint,
"id" integer,
"zone" varchar(34),
"floor" varchar(22),
"unit" varchar(22),
"x" double precision,
"y" double precision,
"width" double precision,
"height" double precision,
"floor_plan_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
