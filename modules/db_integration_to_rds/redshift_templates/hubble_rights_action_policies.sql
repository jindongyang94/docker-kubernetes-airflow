
create table hubble_rights_action_policies
(
"client_server_id" smallint,
"id" integer,
"name" varchar(52),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"description" varchar(114),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
