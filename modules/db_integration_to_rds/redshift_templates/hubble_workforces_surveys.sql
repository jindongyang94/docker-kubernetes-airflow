
create table hubble_workforces_surveys
(
"client_server_id" smallint,
"id" integer,
"name" varchar(22),
"date" date,
"open" boolean,
"type" varchar(58),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
