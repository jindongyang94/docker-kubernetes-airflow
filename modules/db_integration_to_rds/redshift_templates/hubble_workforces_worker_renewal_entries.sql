
create table hubble_workforces_worker_renewal_entries
(
"client_server_id" smallint,
"id" integer,
"profile_id" integer,
"survey_id" integer,
"reason" varchar(1),
"rating" varchar(1),
"remarks" varchar(1),
"renewal_recommendation" boolean,
"renewal_outcome" boolean,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
