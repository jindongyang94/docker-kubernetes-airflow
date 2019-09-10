
create table hubble_quality_logs
(
"client_server_id" smallint,
"id" integer,
"action" varchar(43),
"remark" varchar(256),
"loggable_id" integer,
"loggable_type" varchar(31),
"user_id" integer,
"validation" varchar(256),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
