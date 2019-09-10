
create table hubble_safety_settings_permit_class_checklist_items
(
"client_server_id" smallint,
"id" integer,
"sequence" integer,
"question" varchar(763),
"active" boolean,
"permit_class_checklist_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
