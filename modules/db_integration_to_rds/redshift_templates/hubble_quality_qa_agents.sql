
create table hubble_quality_qa_agents
(
"client_server_id" smallint,
"id" integer,
"role" integer,
"profile_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
