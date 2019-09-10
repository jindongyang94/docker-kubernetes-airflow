
create table hubble_safety_approval_structures
(
"client_server_id" smallint,
"id" integer,
"user_id" integer,
"permit_id" integer,
"status" integer,
"sequence" integer,
"role_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
