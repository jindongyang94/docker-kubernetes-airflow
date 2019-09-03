
module_name = 'attendance'

module_tables = [
    'hubble_workforces_profiles',
    'hubble_attendances_shifts_shifts',
    'hubble_attendances_shifts_shift_assignments',
    'hubble_projects_projects',
    'hubble_projects_teams',
    'hubble_attendances_attendances',
]
# module_tables = ['hubble_attendances_attendances']

dev_db = {'host': 'hubblebase.cmgdthsodgpa.ap-southeast-1.rds.amazonaws.com',
          'port': '5432',
          'user': 'hubbledev_db',
          'password': 'hubadmin!',
          'database': 'data-warehouse-test'}

prod_db = {'host': 'proddbreplica.ckkr7jwtdz4y.us-west-2.rds.amazonaws.com',
           'port': '5432',
           'user': 'hubbledb',
           'password': 'N0VERM!ND'}

client_csv = 'hubble_clients_clients.csv'

entity_mapping = {'hubble_workforces_profiles': 'profile',
                  'hubble_attendances_shifts_shifts': 'shift',
                  'hubble_attendances_shifts_shift_assignments': 'shift_assignment',
                  'hubble_attendances_attendances': 'attendance',
                  'hubble_projects_projects': 'project',
                  'hubble_projects_teams': 'team'}

sql_dir = 'sql_for_mart'

merge_strat = 'drop'  # drop or keep?

postgresql_to_redshift_types = {
    'time without time zone': 'varchar(8)'
}

redshift_db = {'host': 'rs-attendance.clug9mtqmy9j.ap-southeast-1.redshift.amazonaws.com',
               'port': '5439',
               'user': 'awsuser',
               'password': 'Hubble123',
               'database': 'dev'}

redshift_iam_role = 'arn:aws:iam::175416825336:role/RedshiftS3Access'

redshift_region = 'ap-southeast-1'

s3_bucket = 'warehouse-attendance'

pivot_time = '12:00:00'