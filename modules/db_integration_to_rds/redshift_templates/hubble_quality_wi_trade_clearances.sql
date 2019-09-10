
create table hubble_quality_wi_trade_clearances
(
"client_server_id" smallint,
"id" integer,
"sig_name" varchar(15),
"sig_trade" varchar(4),
"validation" varchar(256),
"wi_request_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
