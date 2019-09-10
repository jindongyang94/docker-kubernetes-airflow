
create table hubble_safety_agents_projects
(
"client_server_id" smallint,
"agent_id" integer,
"project_id" integer,
primary key ("client_server_id")
)
compound sortkey("client_server_id")
