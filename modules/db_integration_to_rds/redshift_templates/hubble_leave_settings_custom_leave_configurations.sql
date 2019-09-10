
create table hubble_leave_settings_custom_leave_configurations
(
"client_server_id" smallint,
"id" integer,
"entitlement_formula" integer,
"entitlement_period" integer,
"carry_forward_next_period" boolean,
"carry_forward_option" integer,
"name" varchar(75),
"proration_unit" integer,
"custom_leave_id" integer,
"entitlement_start_from_option" integer,
"entitlement_start_after_days" integer,
"carry_forward_max_amount" double precision,
"carry_forward_expired" boolean,
"carry_forward_expiry_after_months" integer,
"paid" boolean,
"short_description" varchar(195),
"long_description" varchar(1035),
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
