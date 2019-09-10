
create table hubble_projects_teams
(
"client_server_id" smallint,
"id" integer,
"project_id" integer,
"name" varchar(78),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
