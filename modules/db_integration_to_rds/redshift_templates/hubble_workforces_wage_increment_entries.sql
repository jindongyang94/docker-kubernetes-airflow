
create table hubble_workforces_wage_increment_entries
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"survey_id" integer,
"reason" varchar(1),
"rating" varchar(1),
"suggested_increment" integer,
"actual_increment" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
