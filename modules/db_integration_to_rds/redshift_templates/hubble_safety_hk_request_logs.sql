
create table hubble_safety_hk_request_logs
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"hk_request_id" integer,
"validation" varchar(256),
"remark" varchar(1),
"action" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
