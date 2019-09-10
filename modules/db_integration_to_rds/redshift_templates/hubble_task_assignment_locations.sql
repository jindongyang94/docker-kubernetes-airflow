
create table hubble_task_assignment_locations
(
"client_server_id" smallint,
"id" integer,
"zone" varchar(22),
"floor" varchar(15),
"unit" varchar(46),
"unit_type_id" integer,
"bca_score" numeric,
"completion_status" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"completion_date" date,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
