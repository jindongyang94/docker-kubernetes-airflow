create table attendance_mart
as
(
select *
from hubble_attendances_attendances as mart

left join hubble_clients_clients as clients
on mart.attendance_client_id = clients.client_id

left join hubble_workforces_profiles as profiles
on mart.attendance_profile_id = profiles.profile_id 
and mart.attendance_client_id = profiles.profile_client_id

left join hubble_projects_teams as teams
on mart.attendance_team_id = teams.team_id
and mart.attendance_client_id = teams.team_client_id

left join hubble_projects_projects as projects
on teams.team_project_id = projects.project_id
and teams.team_client_id = projects.project_client_id

left join hubble_attendances_shifts_shift_assignments as shift_assignments
on mart.attendance_shift_assignment_id = shift_assignments.shift_assignment_id
and mart.attendance_client_id = shift_assignments.shift_assignment_client_id

left join hubble_attendances_shifts_shifts as shifts
on shift_assignments.shift_assignment_shift_id = shifts.shift_id
and shift_assignments.shift_assignment_client_id = shifts.shift_client_id
)

alter table attendance_mart
drop column attendance_client_id,
drop column attendance_profile_id,
drop column attendance_team_id,
drop column team_project_id,
drop column attendance_shift_assignment_id,
drop column shift_assignment_shift_id,

drop column profile_client_id,
drop column team_client_id,
drop column shift_assignment_client_id,
drop column shift_client_id,
drop column project_client_id


-- redshift
create table attendance_mart
as
(
select *
from hubble_attendances_attendances as mart

left join hubble_clients_clients as clients
on mart.attendance_client_id = clients.client_id

left join hubble_workforces_profiles as profiles
on mart.attendance_profile_id = profiles.profile_id
and mart.attendance_client_id = profiles.profile_client_id

left join hubble_projects_teams as teams
on mart.attendance_team_id = teams.team_id
and mart.attendance_client_id = teams.team_client_id

left join hubble_projects_projects as projects
on teams.team_project_id = projects.project_id
and teams.team_client_id = projects.project_client_id

left join hubble_attendances_shifts_shift_assignments as shift_assignments
on mart.attendance_shift_assignment_id = shift_assignments.shift_assignment_id
and mart.attendance_client_id = shift_assignments.shift_assignment_client_id

left join hubble_attendances_shifts_shifts as shifts
on shift_assignments.shift_assignment_shift_id = shifts.shift_id
and shift_assignments.shift_assignment_client_id = shifts.shift_client_id
);

alter table attendance_mart drop column attendance_client_id;
alter table attendance_mart drop column attendance_profile_id;
alter table attendance_mart drop column attendance_team_id;
alter table attendance_mart drop column team_project_id;
alter table attendance_mart drop column attendance_shift_assignment_id;
alter table attendance_mart drop column shift_assignment_shift_id;
alter table attendance_mart drop column profile_client_id;
alter table attendance_mart drop column team_client_id;
alter table attendance_mart drop column shift_assignment_client_id;
alter table attendance_mart drop column shift_client_id;
alter table attendance_mart drop column project_client_id;