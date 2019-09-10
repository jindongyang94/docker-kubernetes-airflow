
create table hubble_form_builder_form_sections
(
"client_server_id" smallint,
"id" integer,
"name" varchar(27),
"position_x" integer,
"position_y" integer,
"is_group" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"is_checklist" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
