
create table hubble_rights_action_permissions
(
"client_server_id" smallint,
"id" integer,
"type" varchar(99),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
