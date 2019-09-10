
create table hubble_leave_step_transition_remarks
(
"client_server_id" smallint,
"id" integer,
"step_transition_id" integer,
"content" varchar(88),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
