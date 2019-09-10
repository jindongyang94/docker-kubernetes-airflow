
create table hubble_attendances_shifts_break_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(31),
"code" varchar(12),
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
