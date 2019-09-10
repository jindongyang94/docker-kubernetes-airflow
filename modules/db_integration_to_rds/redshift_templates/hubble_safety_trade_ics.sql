
create table hubble_safety_trade_ics
(
"client_server_id" smallint,
"id" integer,
"agent_id" integer,
"type_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
