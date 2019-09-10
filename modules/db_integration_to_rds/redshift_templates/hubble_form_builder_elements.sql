
create table hubble_form_builder_elements
(
"client_server_id" smallint,
"id" integer,
"name" varchar(21),
"position_x" integer,
"position_y" integer,
"description" varchar(1),
"is_compulsory" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"hubble_form_builder_element_type_id" integer,
"placeholder" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
