CREATE TABLE public.hubble_attendances_shifts_shift_assignments
(
    id integer,
    shift_id integer,
    workforces_profile_id integer,
    shift_start_time timestamp without time zone NOT NULL,
    shift_end_time timestamp without time zone NOT NULL,
    date date NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    schedule_id integer,
    late_attendance_id integer,
--     CONSTRAINT hubble_attendances_shifts_shift_assignments_pkey PRIMARY KEY (id)
--     CONSTRAINT fk_rails_1b4f6c165f FOREIGN KEY (schedule_id)
--         REFERENCES public.hubble_attendances_shifts_schedules (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE CASCADE,
--     CONSTRAINT fk_rails_3569d3588e FOREIGN KEY (late_attendance_id)
--         REFERENCES public.hubble_attendances_attendances (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE SET NULL,
--     CONSTRAINT fk_rails_40c5574128 FOREIGN KEY (shift_id)
--         REFERENCES public.hubble_attendances_shifts_shifts (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE NO ACTION,
--     CONSTRAINT fk_rails_5cb5b262fc FOREIGN KEY (workforces_profile_id)
--         REFERENCES public.hubble_workforces_profiles (id) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE NO ACTION
)