
create table hubble_task_assignments_units
(
"client_server_id" smallint,
"id" integer,
"block" varchar(22),
"floor" varchar(15),
"unit_no" varchar(46),
"unit_type_id" integer,
"bca_score" varchar(1),
"status" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"completed_samples" integer,
"completed_date" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
