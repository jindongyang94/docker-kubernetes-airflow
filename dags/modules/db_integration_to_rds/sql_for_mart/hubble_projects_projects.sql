CREATE TABLE public.hubble_projects_projects
(
    id integer,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    code character varying COLLATE pg_catalog."default" NOT NULL,
    address character varying COLLATE pg_catalog."default",
    latitude double precision,
    longitude double precision,
    start_date date,
    end_date date,
    permit_date date,
    status integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    country character varying COLLATE pg_catalog."default",
    address_alt character varying COLLATE pg_catalog."default",
    site_in_charge character varying COLLATE pg_catalog."default",
    site_email character varying COLLATE pg_catalog."default",
    site_office_number character varying COLLATE pg_catalog."default",
    contract_sum numeric,
    contract_sum_gst numeric,
    main_contractor character varying COLLATE pg_catalog."default",
    developer character varying COLLATE pg_catalog."default",
    permit_date_target date,
    dlp_end_date date,
    geo_fence_id integer,
--     CONSTRAINT hubble_projects_projects_pkey PRIMARY KEY (id)
--     CONSTRAINT fk_rails_364185980f FOREIGN KEY (geo_fence_id)
--         REFERENCES public.hubble_math_geo_fences (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE NO ACTION
)