
create table hubble_leave_entitlement_entitlements
(
"client_server_id" smallint,
"id" integer,
"start_date" date,
"end_date" date,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"workforces_profile_id" integer,
"policy_id" integer,
"holding_days" numeric,
"balance_amount" numeric
)
