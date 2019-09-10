
create table hubble_rights_action_permissions_policies
(
"client_server_id" smallint,
"id" integer,
"action_policy_id" integer,
"action_permission_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
