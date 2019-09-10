
create table hubble_workforces_skills
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"course_id" integer,
"course_date" date,
"training_centre" varchar(111),
"expiry_date" date,
"send_by_company" boolean,
"remarks" varchar(145),
"course_type_id" integer,
"skill_type_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
