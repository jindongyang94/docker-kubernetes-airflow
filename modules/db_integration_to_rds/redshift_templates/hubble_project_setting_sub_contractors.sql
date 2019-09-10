
create table hubble_project_setting_sub_contractors
(
"client_server_id" smallint,
"id" integer,
"company_name" varchar(58),
"company_email" varchar(49),
"company_contact_number" varchar(13),
"code" varchar(12),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
