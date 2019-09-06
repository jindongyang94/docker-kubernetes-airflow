
create table hubble_projects_projects
(
project_id integer,
project_name varchar(128),
project_code varchar(64),
project_address varchar(256),
project_latitude double precision,
project_longitude double precision,
project_start_date date,
project_end_date date,
project_permit_date date,
project_status integer,
project_created_at timestamp without time zone,
project_updated_at timestamp without time zone,
project_country varchar(16),
project_address_alt varchar(1024),
project_site_in_charge varchar(64),
project_site_email varchar(64),
project_site_office_number varchar(16),
project_contract_sum numeric,
project_contract_sum_gst numeric,
project_main_contractor varchar(128),
project_developer varchar(128),
project_permit_date_target date,
project_dlp_end_date date,
project_geo_fence_id integer,
project_client_id smallint
)
