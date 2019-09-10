
create table hubble_safety_risk_levels
(
"client_server_id" smallint,
"id" integer,
"name" varchar(16),
"description" varchar(1),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
