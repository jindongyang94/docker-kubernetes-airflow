
create table hubble_safety_permit_logs
(
"client_server_id" smallint,
"id" integer,
"action" varchar(55),
"remark" varchar(484),
"user_id" integer,
"permit_id" integer,
"validation" varchar(256),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
