
create table hubble_leave_leave_applications
(
"client_server_id" smallint,
"id" integer,
"workforces_profile_id" integer,
"application_date" date,
"start_date" timestamp without time zone,
"end_date" timestamp without time zone,
"remarks" varchar(214),
"attachments" varchar(106),
"serial_no" integer,
"applicant_id" integer,
"leave_date_mode" integer,
"start_date_mode" integer,
"end_date_mode" integer,
"leave_policy_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
