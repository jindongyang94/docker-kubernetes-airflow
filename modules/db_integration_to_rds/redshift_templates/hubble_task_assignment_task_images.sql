
create table hubble_task_assignment_task_images
(
"client_server_id" smallint,
"id" integer,
"task_id" integer,
"attachment" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
