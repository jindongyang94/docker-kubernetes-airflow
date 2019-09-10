
create table hubble_leave_entitlement_action_logs
(
"client_server_id" smallint,
"id" integer,
"entitlement_id" integer,
"remark" character varying,
"amount" numeric,
"action_type" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"user_id" integer,
"date" date
)
