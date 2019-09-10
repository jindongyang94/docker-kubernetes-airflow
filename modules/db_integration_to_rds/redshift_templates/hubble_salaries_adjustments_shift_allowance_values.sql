
create table hubble_salaries_adjustments_shift_allowance_values
(
"client_server_id" smallint,
"id" integer,
"shift_assignment_id" integer,
"recurring_allowance_id" integer,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
