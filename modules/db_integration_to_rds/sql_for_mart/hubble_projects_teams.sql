CREATE TABLE public.hubble_projects_teams
(
    id integer,
    project_id integer,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
--     CONSTRAINT hubble_projects_teams_pkey PRIMARY KEY (id)
)