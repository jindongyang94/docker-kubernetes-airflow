
create table hubble_workforces_accommodations
(
"client_server_id" smallint,
"id" integer,
"name" varchar(48),
"address" varchar(64),
"cost" numeric,
"currency" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
