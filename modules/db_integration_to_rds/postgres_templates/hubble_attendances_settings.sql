
create table hubble_attendances_settings
(
"client_server_id" smallint,
"id" integer,
"day_shift_start_time" time without time zone,
"night_shift_start_time" time without time zone,
"flag_mismatched_face_if_lower_than" smallint,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"late_after" smallint,
"adjusted_time_flag_window" integer,
"effective_start_date" date,
"effective_end_date" date,
"block_duration" integer,
"minimum_duration_to_earn_block" integer,
"salary_date_start_time" time without time zone,
"decimals_round_before_hours_computation" integer
)
