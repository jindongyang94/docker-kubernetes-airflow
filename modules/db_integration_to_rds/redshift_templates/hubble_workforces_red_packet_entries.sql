
create table hubble_workforces_red_packet_entries
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"survey_id" integer,
"reason" varchar(1),
"suggested_amount" integer,
"actual_amount" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
