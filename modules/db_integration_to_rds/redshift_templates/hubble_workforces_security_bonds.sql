
create table hubble_workforces_security_bonds
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"insurance_company" varchar(55),
"insurance_agent" varchar(54),
"security_bond_number" varchar(22),
"start_date" date,
"expiry_date" date,
"remarks" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
