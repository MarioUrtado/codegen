import ConfigParser
import os

config = ConfigParser.ConfigParser()
config.readfp(open('RA_INIT_CONFIG'))	

country=config.get('RA', 'country')
system=config.get('RA', 'system')
system_desc=config.get('RA', 'description')
system_name=config.get('RA', 'name')
apis=config.get('RA', 'apis').split(',')
country_system=country+'-'+system
folder_name='DB_RA_'+country_system+'_v1'

config_query = ConfigParser.ConfigParser()
config_query.readfp(open('TEMPLATES/RA/SQL/QUERY_TEMPLATE'))	

os.makedirs(folder_name)
os.chdir(folder_name)

lg_insert_file='SQL_CHANGE.sql'
with open(lg_insert_file, 'w') as new_file:
	with open('../TEMPLATES/RA/SQL/INSERT_TEMPLATE', 'r') as template_file:
		for line in template_file:
			if( '%REPLACE_SYSTEM%' in line):
				new_line=config_query.get('INSERT', 'system').replace('%SYSTEM_CODE%',country_system).replace('%SYSTEM_NAME%',system_name).replace('%SYSTEM_DESC%',system_desc).replace('\\n', os.linesep).replace('\\t', '  ')
				new_file.write(new_line+'\n')
			elif( '%REPLACE_SYSTEM_API%' in line):
				for api in apis:
					system_api_code=country_system+'-'+api
					print(system_api_code)
					system_api_name=config.get((system+'-'+api),'name')
					new_line=config_query.get('INSERT' ,'system_api').replace('%SYSTEM_CODE%',country_system).replace('%SYSTEM_API_CODE%',system_api_code).replace('%SYSTEM_API_NAME%', system_api_name).replace('\\n', os.linesep).replace('\\t', '  ')
					new_file.write(new_line+'\n')
			elif( '%REPLACE_SYSTEM_API_OPERATION%' in line):
				for api in apis:
					system_api=system+'-'+api
					country_system_api=country+'-'+system_api
					operations=config.get(system_api, 'operations').split(',')
					for operation in operations:
						system_api_operation=system_api+'_'+operation
						operation_version=config.get(system_api_operation,'version')
						operation_desc=config.get(system_api_operation,'description')
						new_line=config_query.get('INSERT' ,'system_api_operation').replace('%SYSTEM_API_CODE%',country_system_api).replace('%SYSTEM_API_OPERATION_VERSION%',operation_version).replace('%SYSTEM_API_OPERATION_NAME%', operation).replace('%SYSTEM_API_OPERATION_DESC%', operation_desc).replace('\\n', os.linesep).replace('\\t', '  ')
						new_file.write(new_line+'\n')
			#elif( '%REPLACE_SYSTEM_API_OPERATION_CONFIG%' in line):

			#elif( '%REPLACE_CONFIG_ENDPOINT%' in line):

			#elif( '%CONFIG_LIST%' in line):
				
			else:
				new_file.write(line)