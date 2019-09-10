
create table hubble_salaries_ir8as_profiles
(
"client_server_id" smallint,
"id" integer,
"workforces_profile_id" integer,
"ir8as_submission_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
