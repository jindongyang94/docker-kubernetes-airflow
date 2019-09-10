
create table hubble_leave_entitlement_action_logs
(
"client_server_id" smallint,
"id" integer,
"entitlement_id" integer,
"remark" varchar(342),
"amount" numeric,
"action_type" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"user_id" integer,
"date" date,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
