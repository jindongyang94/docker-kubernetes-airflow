
create table hubble_salaries_adjustments_recurring_allowances
(
"client_server_id" smallint,
"id" integer,
"name" varchar(57),
"code" varchar(43),
"awardable_type" varchar(70),
"awardable_id" integer,
"cpf_group" integer,
"taxable" boolean,
"active" boolean,
"level" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
