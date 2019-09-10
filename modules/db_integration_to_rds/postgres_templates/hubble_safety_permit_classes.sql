
create table hubble_safety_permit_classes
(
"client_server_id" smallint,
"id" integer,
"name" character varying,
"description" character varying,
"remarks" character varying,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"permit_id" integer,
"class_setting_id" integer,
"validation" bytea,
"trade_ic_validation" bytea
)
