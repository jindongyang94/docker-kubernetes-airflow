
create table hubble_workforces_injuries
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"injury_date" varchar(15),
"injury_description" varchar(619),
"medical_insurance_claim" boolean,
"i_reportable" boolean,
"main_contractor_name" varchar(1),
"policy_number" varchar(49),
"broker_name" varchar(34),
"medical_insurance_claim_date" date,
"claim_description" varchar(4),
"project_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
