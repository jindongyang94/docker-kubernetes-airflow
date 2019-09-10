
create table hubble_form_builder_connections
(
"client_server_id" smallint,
"digest" varchar(60),
"from_type" varchar(48),
"from_id" varchar(1),
"to_type" varchar(42),
"to_id" varchar(1),
primary key ("client_server_id")
)
compound sortkey("client_server_id")
