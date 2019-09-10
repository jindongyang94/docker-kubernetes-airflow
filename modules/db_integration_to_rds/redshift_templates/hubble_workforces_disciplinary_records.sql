
create table hubble_workforces_disciplinary_records
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"project_id" integer,
"date" date,
"document_ref_no" varchar(64),
"description" varchar(675),
"severity" integer,
"blacklisted" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
