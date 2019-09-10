
create table hubble_workforces_disciplinary_records
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"project_id" integer,
"date" date,
"document_ref_no" character varying,
"description" character varying,
"severity" integer,
"blacklisted" boolean
)
