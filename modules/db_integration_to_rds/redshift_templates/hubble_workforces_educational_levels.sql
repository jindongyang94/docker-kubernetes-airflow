
create table hubble_workforces_educational_levels
(
"client_server_id" smallint,
"id" integer,
"name" varchar(75),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
