
create table hubble_tonnages_schedules
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"project_id" integer,
"date" timestamp without time zone,
"load_id" integer,
"status" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"service_type_id" integer,
"requestor" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
