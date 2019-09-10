
create table hubble_company_logos
(
"client_server_id" smallint,
"id" integer,
"logo" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
