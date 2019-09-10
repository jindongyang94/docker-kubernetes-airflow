
create table hubble_safety_permit_classes
(
"client_server_id" smallint,
"id" integer,
"name" varchar(100),
"description" varchar(276),
"remarks" varchar(343),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"permit_id" integer,
"class_setting_id" integer,
"validation" varchar(256),
"trade_ic_validation" varchar(256),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
