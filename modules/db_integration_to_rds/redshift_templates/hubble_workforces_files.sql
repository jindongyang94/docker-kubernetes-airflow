
create table hubble_workforces_files
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"filename_id" integer,
"attachment" varchar(99),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
