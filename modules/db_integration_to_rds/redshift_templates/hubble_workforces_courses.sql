
create table hubble_workforces_courses
(
"client_server_id" smallint,
"id" integer,
"title" varchar(82),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
