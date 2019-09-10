
create table hubble_salaries_settings_deduction_types
(
"client_server_id" smallint,
"id" integer,
"name" varchar(58),
"code" varchar(58),
"taxable" boolean,
"cpf_group" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
