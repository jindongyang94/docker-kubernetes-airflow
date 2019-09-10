
create table hubble_tonnages_bins
(
"client_server_id" smallint,
"id" integer,
"project_id" integer,
"bin_type_id" integer,
"quantity" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
