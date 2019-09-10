
create table hubble_projects_projects
(
"client_server_id" smallint,
"id" integer,
"name" character varying,
"code" character varying,
"address" character varying,
"latitude" double precision,
"longitude" double precision,
"start_date" date,
"end_date" date,
"permit_date" date,
"status" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"country" character varying,
"address_alt" character varying,
"site_in_charge" character varying,
"site_email" character varying,
"site_office_number" character varying,
"contract_sum" numeric,
"contract_sum_gst" numeric,
"main_contractor" character varying,
"developer" character varying,
"permit_date_target" date,
"dlp_end_date" date,
"geo_fence_id" integer
)
