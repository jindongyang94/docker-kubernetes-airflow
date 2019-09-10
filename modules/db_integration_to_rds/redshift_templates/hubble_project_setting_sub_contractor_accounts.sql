
create table hubble_project_setting_sub_contractor_accounts
(
"client_server_id" smallint,
"id" integer,
"sub_contractor_id" integer,
"user_id" integer,
"name" varchar(25),
"code" varchar(15),
"designation" varchar(22),
"trade" varchar(37),
"phone_no" varchar(12),
"email" varchar(45),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
