
create table hubble_salaries_settings_allowance_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(66),
"code" varchar(54),
"taxable" boolean,
"cpf_group" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
