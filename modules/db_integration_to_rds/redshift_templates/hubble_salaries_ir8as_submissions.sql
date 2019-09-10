
create table hubble_salaries_ir8as_submissions
(
"client_server_id" smallint,
"id" integer,
"workforces_company_id" integer,
"year" integer,
"authorizer_name" varchar(30),
"authorizer_designation" varchar(36),
"authorizer_email" varchar(36),
"telephone_number" varchar(12),
"branch_name" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"verified" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
