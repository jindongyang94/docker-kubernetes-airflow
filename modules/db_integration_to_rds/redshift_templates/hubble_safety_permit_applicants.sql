
create table hubble_safety_permit_applicants
(
"client_server_id" smallint,
"id" integer,
"subcontractor_id" integer,
"name" varchar(1),
"mobile_number" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
