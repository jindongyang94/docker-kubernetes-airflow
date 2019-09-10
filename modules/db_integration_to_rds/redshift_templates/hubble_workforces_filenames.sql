
create table hubble_workforces_filenames
(
"client_server_id" smallint,
"id" integer,
"name" varchar(54),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
