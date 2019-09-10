
create table hubble_projects_team_start_times
(
"client_server_id" smallint,
"id" integer,
"team_id" integer,
"start_at" varchar(8),
"shift" integer,
"effective_date" date,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
