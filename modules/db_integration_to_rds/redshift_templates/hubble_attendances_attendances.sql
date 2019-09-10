
create table hubble_attendances_attendances
(
"client_server_id" smallint,
"id" integer,
"team_id" integer,
"profile_id" integer,
"shift" integer,
"check_in_time" timestamp without time zone,
"check_in_latitude" double precision,
"check_in_longitude" double precision,
"check_out_time" timestamp without time zone,
"check_out_latitude" double precision,
"check_out_longitude" double precision,
"incomplete" smallint,
"check_in_adjusted_time" smallint,
"check_in_mismatched_location" smallint,
"created_at" timestamp without time zone,
"updated_at" timestamp without time zone,
"check_in_from_mobile" smallint,
"check_out_from_mobile" smallint,
"check_out_mismatched_location" smallint,
"check_out_adjusted_time" smallint,
"authentic_check_in_time" timestamp without time zone,
"authentic_check_out_time" timestamp without time zone,
"check_in_photo" varchar(27),
"check_out_photo" varchar(28),
"check_in_fr_photo" varchar(27),
"check_out_fr_photo" varchar(28),
"check_in_mismatched_face" smallint,
"check_out_mismatched_face" smallint,
"check_in_face_similarity" numeric,
"check_out_face_similarity" numeric,
"check_in_date" date,
"check_in_user_id" integer,
"check_out_user_id" integer,
"check_out_date" date,
"check_in_remark" varchar(336),
"check_out_remark" varchar(744),
"verifier_id" integer,
"shift_assignment_id" integer,
"check_in_from_face_id_device" smallint,
"check_out_from_face_id_device" smallint,
primary key ("client_server_id", "id")
)
compound sortkey("client_server_id", "id")
