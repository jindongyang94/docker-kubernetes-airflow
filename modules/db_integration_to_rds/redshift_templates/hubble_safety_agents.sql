
create table hubble_safety_agents
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"role" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
