
create table hubble_workforces_levies
(
"client_server_id" smallint,
"id" integer,
"tier" integer,
"monthly" numeric,
"daily" numeric,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
