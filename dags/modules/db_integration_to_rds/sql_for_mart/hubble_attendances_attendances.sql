CREATE TABLE public.hubble_attendances_attendances
(
    id integer,
    team_id integer,
    profile_id integer,
    shift integer NOT NULL,
    check_in_time timestamp without time zone NOT NULL,
    check_in_latitude double precision,
    check_in_longitude double precision,
    check_out_time timestamp without time zone,
    check_out_latitude double precision,
    check_out_longitude double precision,
    incomplete smallint NOT NULL,
    check_in_adjusted_time smallint NOT NULL,
    check_in_mismatched_location smallint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    check_in_from_mobile smallint,
    check_out_from_mobile smallint,
    check_out_mismatched_location smallint,
    check_out_adjusted_time smallint,
    authentic_check_in_time timestamp without time zone,
    authentic_check_out_time timestamp without time zone,
    check_in_photo character varying COLLATE pg_catalog."default",
    check_out_photo character varying COLLATE pg_catalog."default",
    check_in_fr_photo character varying COLLATE pg_catalog."default",
    check_out_fr_photo character varying COLLATE pg_catalog."default",
    check_in_mismatched_face smallint NOT NULL,
    check_out_mismatched_face smallint,
    check_in_face_similarity numeric,
    check_out_face_similarity numeric,
    check_in_date date NOT NULL,
    check_in_user_id integer,
    check_out_user_id integer,
    check_out_date date,
    check_in_remark character varying COLLATE pg_catalog."default",
    check_out_remark character varying COLLATE pg_catalog."default",
    verifier_id integer,
    shift_assignment_id integer
--     CONSTRAINT hubble_attendances_attendances_pkey PRIMARY KEY (id),
--     CONSTRAINT fk_rails_9e57aaae73 FOREIGN KEY (shift_assignment_id)
--         REFERENCES public.hubble_attendances_shifts_shift_assignments (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE SET NULL,
--     CONSTRAINT fk_rails_b1f9a16270 FOREIGN KEY (check_in_user_id)
--         REFERENCES public.hubble_users (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE NO ACTION,
--     CONSTRAINT fk_rails_f28e58a16b FOREIGN KEY (check_out_user_id)
--         REFERENCES public.hubble_users (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE NO ACTION
)