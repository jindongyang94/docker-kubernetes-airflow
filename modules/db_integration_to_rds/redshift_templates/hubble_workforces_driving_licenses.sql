
create table hubble_workforces_driving_licenses
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"license_type" integer,
"expiry_date" date,
"license_number" varchar(13),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
