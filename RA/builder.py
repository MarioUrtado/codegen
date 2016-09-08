import os
import ConfigParser

config = ConfigParser.ConfigParser()
config.readfp(open('init.cfg'))	

def build(section):

	country=config.get('RA', 'country')
	system=config.get('RA', 'system')
	apis=config.get('RA', 'apis').split(',')
	country_system=country+'-'+system
	project_name='DC_RA_'+country_system+'_v1'

	os.makedirs(project_name)
	os.chdir(project_name)

	#servicesbus.servicesbus
	servicesbus_file='servicesbus.servicesbus'
	with open(servicesbus_file, 'w') as new_file:
		with open('../TEMPLATES/RA/TEMPLATE_servicebus.sboverview', 'r') as template_file:
			for line in template_file:
				new_line=line.replace('%PROJECT_NAME%', project_name)
				new_file.write(new_line)

	#project.jpr
	project_file=project_name+'.jpr'
	with open(project_file, 'w') as new_file:
		with open('../TEMPLATES/RA/TEMPLATE.jpr', 'r') as template_file:
			for line in template_file:
				new_line=line.replace('%PROJECT_NAME%', project_name).replace('%DEFUALT_PACKAGE_PROJECT_NAME%', project_name.lower().replace('-',''))
				new_file.write(new_line)


	#pom.xml
	pom_file='pom.xml'
	with open(pom_file, 'w') as new_file:
		with open('../TEMPLATES/RA/POM_TEMPLATE.xml', 'r') as template_file:
			for line in template_file:
				new_line=line.replace('%PROJECT_NAME%', project_name)
				new_file.write(new_line)



	os.makedirs('CommonResources')
	os.makedirs('ResourceAdapters')

	os.chdir('ResourceAdapters')

	for api in apis:
		system_api=system+'-'+api
		system_api_operations=config.get(system_api,'operations').split(',')
		for operation in system_api_operations:
			country_system_api=country+'-'+system_api
			country_system_api_operation=country+'-'+system_api+'_'+operation
			ra_name=country+'-'+system_api+'_'+operation+'_RA_v1'
			os.makedirs(ra_name)
			os.chdir(ra_name)

			#Creacion de CSC, sus xsd y wsdl
			os.makedirs('CSC')
			os.chdir('CSC')

			wsdl_name=country_system_api_operation+'_v1_CSC.wsdl'
			with open(wsdl_name, 'w') as new_file:
				with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/CSC/TEMPLATE_CSC.wsdl', 'r') as template_file:
					for line in template_file:
						new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',operation)
						new_file.write(new_line)
			csm_name=country_system_api_operation+'_v1_CSM.xsd'
			with open(csm_name, 'w') as new_file:
				with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/CSC/TEMPLATE_CSM.xsd', 'r') as template_file:
					for line in template_file:
						new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',operation)
						new_file.write(new_line)
			os.chdir('../')

			#Creacion de pipeline y proxy SDAdapter
			os.makedirs('SDAdapter')
			os.chdir('SDAdapter')

			sda_pipeline=country_system_api_operation+'_RA_SDA.pipeline'
			with open(sda_pipeline, 'w') as new_file:
				with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/SDAdapter/TEMPLATE_SDA.pipeline', 'r') as template_file:
					for line in template_file:
						new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',operation).replace('%SYSTEM%', country_system )
						new_file.write(new_line)
			sda_proxy=country_system_api_operation+'_RA_SDA.proxy'
			with open(sda_proxy, 'w') as new_file:
				with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/SDAdapter/TEMPLATE_SDA.proxy', 'r') as template_file:
					for line in template_file:
						new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',operation).replace('%SYSTEM%', country_system )
						new_file.write(new_line)
			#return to RA
			os.chdir('../')

			os.makedirs('XQuery')
			os.chdir('XQuery')

			xq_name_rsp_error=country_system_api_operation+'_AdapterRSP_ERROR.xqy'
			with open(xq_name_rsp_error, 'w') as new_file:
				with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/XQuery/TEMPLATE_AdapterRSP_ERROR.xqy', 'r') as template_file:
					for line in template_file:
						new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',operation)
						new_file.write(new_line)


			os.chdir('../')
			#Create proxy y pipeline de RA
			ra_pipeline=country_system_api_operation+'_RA.pipeline'
			with open(ra_pipeline, 'w') as new_file:
				with open('../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/TEMPLATE_RA.pipeline', 'r') as template_file:
					for line in template_file:
						new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',operation).replace('%SYSTEM%', country_system )
						new_file.write(new_line)
			ra_proxy=country_system_api_operation+'_RA_SDA.proxy'
			with open(ra_proxy, 'w') as new_file:
				with open('../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/TEMPLATE_RA.proxy', 'r') as template_file:
					for line in template_file:
						new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',operation).replace('%SYSTEM%', country_system )
						new_file.write(new_line)
			#Return to ResourceAdaptes
			os.chdir('../')

	#Return: Project RA
	os.chdir('../')

	os.makedirs('LG_DB')

	os.chdir('LG_DB')

	ra_proxy=country_system_api_operation+'_RA_SDA.proxy'
	with open(ra_proxy, 'w') as new_file:
		with open('../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/TEMPLATE_RA.proxy', 'r') as template_file:
			for line in template_file:
				new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',operation).replace('%SYSTEM%', country_system )
				new_file.write(new_line)


def main():
	config = ConfigParser.ConfigParser()
	config.readfp(open('init.cfg'))
	for target in config.sections():

