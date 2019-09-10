
create table hubble_workforces_skill_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(72),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
