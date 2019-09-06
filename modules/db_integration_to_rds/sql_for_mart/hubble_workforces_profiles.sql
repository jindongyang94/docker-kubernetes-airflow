CREATE TABLE public.hubble_workforces_profiles
(
    id integer,
    user_id integer,
    name character varying COLLATE pg_catalog."default",
    gender character varying COLLATE pg_catalog."default",
    birth_date date,
    other_race character varying COLLATE pg_catalog."default",
    other_religion character varying COLLATE pg_catalog."default",
    marital_status character varying COLLATE pg_catalog."default",
    passport_number character varying COLLATE pg_catalog."default",
    passport_expiry_date date,
    nationality character varying COLLATE pg_catalog."default",
    nin_number character varying COLLATE pg_catalog."default",
    email character varying COLLATE pg_catalog."default",
    phone_number character varying COLLATE pg_catalog."default",
    address character varying COLLATE pg_catalog."default",
    code character varying COLLATE pg_catalog."default",
    commence_date date,
    termination_date date,
    termination_reason text COLLATE pg_catalog."default",
    remarks text COLLATE pg_catalog."default",
    archival_group integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    has_profile boolean,
    department_id integer,
    photo character varying COLLATE pg_catalog."default",
    fr_photo character varying COLLATE pg_catalog."default",
    company_id integer,
    race integer,
    religion integer,
    dialect integer,
    other_dialect character varying COLLATE pg_catalog."default",
    country_of_birth character varying COLLATE pg_catalog."default",
    resident_status integer,
    national_service integer,
    spr_issue_date date,
    first_hired_date date,
    construction_hired_date date,
    postal_code character varying COLLATE pg_catalog."default",
    room_number character varying COLLATE pg_catalog."default",
    check_in_date date,
    check_out_date date,
    foreign_residential_address character varying COLLATE pg_catalog."default",
    foreign_contact_no character varying COLLATE pg_catalog."default",
    trade_id integer,
    payment_mode integer,
    medical_history character varying COLLATE pg_catalog."default",
    levy_id integer,
    bank_code character varying COLLATE pg_catalog."default",
    branch_no character varying COLLATE pg_catalog."default",
    account_no character varying COLLATE pg_catalog."default",
    account_name character varying COLLATE pg_catalog."default",
    accommodation_id integer,
    confirmation_date date,
    division_id integer
--     CONSTRAINT hubble_workforces_profiles_pkey PRIMARY KEY (id)
--     CONSTRAINT fk_rails_066b0253e7 FOREIGN KEY (division_id)
--         REFERENCES public.hubble_workforces_divisions (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE SET NULL,
--     CONSTRAINT fk_rails_0ca9bfd553 FOREIGN KEY (levy_id)
--         REFERENCES public.hubble_workforces_levies (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE NO ACTION,
--     CONSTRAINT fk_rails_13739dbeca FOREIGN KEY (accommodation_id)
--         REFERENCES public.hubble_workforces_accommodations (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE SET NULL,
--     CONSTRAINT fk_rails_1fb967a75e FOREIGN KEY (company_id)
--         REFERENCES public.hubble_workforces_companies (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE NO ACTION,
--     CONSTRAINT fk_rails_3e2d9eab2e FOREIGN KEY (department_id)
--         REFERENCES public.hubble_workforces_departments (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE NO ACTION,
--     CONSTRAINT fk_rails_5c23478114 FOREIGN KEY (trade_id)
--         REFERENCES public.hubble_workforces_trades (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE NO ACTION,
--     CONSTRAINT fk_rails_6a7ea1f7ab FOREIGN KEY (user_id)
--         REFERENCES public.hubble_users (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE NO ACTION
)