
create table hubble_safety_permit_class_checklists
(
"client_server_id" smallint,
"id" integer,
"permit_class_id" integer,
"name" varchar(166),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"question" varchar(1),
"answer" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
