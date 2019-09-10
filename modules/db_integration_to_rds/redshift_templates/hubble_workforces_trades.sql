
create table hubble_workforces_trades
(
"client_server_id" smallint,
"id" integer,
"name" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
