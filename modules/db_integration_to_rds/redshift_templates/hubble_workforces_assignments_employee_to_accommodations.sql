
create table hubble_workforces_assignments_employee_to_accommodations
(
"client_server_id" smallint,
"id" integer,
"employee_id" integer,
"accommodation_id" integer,
"effective_start_date" date,
"effective_end_date" date,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
