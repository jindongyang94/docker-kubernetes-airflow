
create table hubble_workforces_educations
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"educational_level_id" integer,
"institute" varchar(48),
"year_of_completion" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
