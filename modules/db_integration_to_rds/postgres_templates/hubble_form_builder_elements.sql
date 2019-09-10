
create table hubble_form_builder_elements
(
"client_server_id" smallint,
"id" integer,
"name" character varying,
"position_x" integer,
"position_y" integer,
"description" text,
"is_compulsory" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"hubble_form_builder_element_type_id" integer,
"placeholder" text
)
