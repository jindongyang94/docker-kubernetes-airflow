
create table hubble_workforces_designations
(
"client_server_id" smallint,
"id" integer,
"code" varchar(34),
"name" varchar(34),
"designation_holdable_type" varchar(45),
"designation_holdable_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
