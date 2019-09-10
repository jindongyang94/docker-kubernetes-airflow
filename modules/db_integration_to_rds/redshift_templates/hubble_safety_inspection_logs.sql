
create table hubble_safety_inspection_logs
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"inspection_id" integer,
"validation" varchar(256),
"remark" varchar(316),
"action" varchar(10),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
