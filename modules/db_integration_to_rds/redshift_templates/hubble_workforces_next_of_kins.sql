
create table hubble_workforces_next_of_kins
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"name" varchar(28),
"date" date,
"nationality" varchar(16),
"contact_no" varchar(43),
"relationship" integer,
"nin_number" varchar(13),
"other_relationship" varchar(10),
"gender" integer,
"other_gender" varchar(1),
"place_of_residence" varchar(87),
"emergency_contact" boolean,
"childcare_leave_next_year" boolean,
"maternity_start_date" date,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
