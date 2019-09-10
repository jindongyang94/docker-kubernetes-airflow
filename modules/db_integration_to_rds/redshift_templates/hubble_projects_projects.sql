
create table hubble_projects_projects
(
"client_server_id" smallint,
"id" integer,
"name" varchar(168),
"code" varchar(76),
"address" varchar(205),
"latitude" double precision,
"longitude" double precision,
"start_date" date,
"end_date" date,
"permit_date" date,
"status" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"country" varchar(16),
"address_alt" varchar(1087),
"site_in_charge" varchar(84),
"site_email" varchar(75),
"site_office_number" varchar(18),
"contract_sum" numeric,
"contract_sum_gst" numeric,
"main_contractor" varchar(181),
"developer" varchar(181),
"permit_date_target" date,
"dlp_end_date" date,
"geo_fence_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
