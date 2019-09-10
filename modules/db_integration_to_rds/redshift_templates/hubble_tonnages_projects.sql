
create table hubble_tonnages_projects
(
"client_server_id" smallint,
"id" integer,
"project_id" integer,
"required_collection" varchar(1),
"client" varchar(1),
"client_contact_number" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
