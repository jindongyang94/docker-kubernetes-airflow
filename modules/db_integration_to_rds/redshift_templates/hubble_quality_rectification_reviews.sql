
create table hubble_quality_rectification_reviews
(
"client_server_id" smallint,
"id" integer,
"rectification_id" integer,
"remark" varchar(1),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"user_id" integer,
"extended_deadline" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
