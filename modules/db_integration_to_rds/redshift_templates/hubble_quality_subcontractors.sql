
create table hubble_quality_subcontractors
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"company_name" varchar(81),
"company_email" varchar(51),
"primary_name" varchar(73),
"primary_number" varchar(22),
"secondary_name" varchar(25),
"secondary_number" varchar(12),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"type_id" integer,
"code" varchar(27),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
