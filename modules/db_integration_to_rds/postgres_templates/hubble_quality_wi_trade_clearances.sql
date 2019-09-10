
create table hubble_quality_wi_trade_clearances
(
"client_server_id" smallint,
"id" integer,
"sig_name" character varying,
"sig_trade" character varying,
"validation" bytea,
"wi_request_id" integer,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone
)
