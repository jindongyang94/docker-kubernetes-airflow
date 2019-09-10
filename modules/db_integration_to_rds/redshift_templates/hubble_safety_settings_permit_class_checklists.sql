
create table hubble_safety_settings_permit_class_checklists
(
"client_server_id" smallint,
"id" integer,
"sequence" integer,
"name" varchar(249),
"active" boolean,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"permit_class_id" integer,
"checklist_type" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
