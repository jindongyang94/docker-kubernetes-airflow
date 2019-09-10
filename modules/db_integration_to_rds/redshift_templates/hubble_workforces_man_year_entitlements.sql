
create table hubble_workforces_man_year_entitlements
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"project_id" integer,
"agent_name" varchar(81),
"mye_number" varchar(21),
"pa_number" varchar(21),
"main_contractor" varchar(4),
"customer" varchar(1),
"mye_waiver" boolean,
"issued_warning" varchar(1),
"remarks" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
