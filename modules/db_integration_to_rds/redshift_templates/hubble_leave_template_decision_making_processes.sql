
create table hubble_leave_template_decision_making_processes
(
"client_server_id" smallint,
"id" integer,
"name" varchar(43),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"is_default" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
