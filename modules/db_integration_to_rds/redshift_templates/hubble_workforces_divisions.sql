
create table hubble_workforces_divisions
(
"client_server_id" smallint,
"id" integer,
"code" varchar(12),
"name" varchar(52),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
