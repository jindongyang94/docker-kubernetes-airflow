
create table hubble_salaries_adjustments_project_accommodation_transport_cos
(
"client_server_id" smallint,
"id" integer,
"transport_reimbursement_id" integer,
"project_id" integer,
"accommodation_id" integer,
"amount" numeric,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
