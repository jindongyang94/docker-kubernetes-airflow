
create table hubble_attendances_public_holiday_settings
(
"client_server_id" smallint,
"id" integer,
"name" varchar(90),
"start_date" date,
"end_date" date,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
