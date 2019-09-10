
create table hubble_workforces_good_behaviours
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"project_id" integer,
"date" date,
"document_ref_no" varchar(1),
"description" varchar(241),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
