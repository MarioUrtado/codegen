import shutil
import util
import os
import ConfigParser

config = ConfigParser.ConfigParser()
config.readfp(open('init.cfg'))	

def chdir_force(_dir):
	force = False
	if not(os.path.isdir(_dir)):
		force = True
		os.makedirs(_dir)
	os.chdir(_dir)
	return force

def get_System(_target):
	sysApi=_target['country']+	'-'+	_target['system']
	return sysApi

def get_SystemApi(_target):
	sysApi = get_System(_target)+'-'+_target['api']
	return sysApi

def get_RAName(_target):
	RAName = get_SystemApi(_target)+'_'+_target['operation']+'_RA_v'+_target['version']
	return RAName	

def getProjectName(_target):
	projectName = 'DC_RA_' + get_System(_target)+'_v'+_target['version']
	return projectName	

def build_project(_target):

	projectName = getProjectName(_target)

	forceMkdir = chdir_force(projectName)

	#servicesbus.servicesbus
	servicesbus_file='servicesbus.servicesbus'
	if not os.path.isfile(servicesbus_file):
		with open(servicesbus_file, 'w') as new_file:
			with open('../TEMPLATES/RA/TEMPLATE_servicebus.sboverview', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%PROJECT_NAME%', projectName)
					new_file.write(new_line)
	else:
		print 'El archivo ' + servicesbus_file + ' ya existe'

	#project.jpr
	project_file=projectName+'.jpr'
	if not os.path.isfile(project_file):
		with open(project_file, 'w') as new_file:
			with open('../TEMPLATES/RA/TEMPLATE.jpr', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%PROJECT_NAME%', projectName).replace('%DEFUALT_PACKAGE_PROJECT_NAME%', projectName.lower().replace('-',''))
					new_file.write(new_line)
	else:
		print 'El archivo ' + project_file + ' ya existe'

	#pom.xml
	pom_file='pom.xml'
	if not os.path.isfile(pom_file):
		with open(pom_file, 'w') as new_file:
			with open('../TEMPLATES/RA/POM_TEMPLATE.xml', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%PROJECT_NAME%', projectName)
					new_file.write(new_line)
	else:
		print 'El archivo ' + pom_file + ' ya existe'

def replaceComponentSystemApiOperation(_to, _from):
	with open(_to, 'w') as new_file:
		with open(_from, 'r') as template_file:
			for line in template_file:
				new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',_target['operation'])
				new_file.write(new_line)

def replaceComponent(_to, _from):
	with open(sda_pipeline, 'w') as new_file:
		with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/SDAdapter/TEMPLATE_SDA.pipeline', 'r') as template_file:
			for line in template_file:
				new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',_target['operation']).replace('%SYSTEM%', country_system )
				new_file.write(new_line)

def build(_target):
	print '\n---------------------------------------------\n'
	print 'Armado projecto RA: ' + get_RAName(_target)

	country_system=get_System(_target)
	project_name=getProjectName(_target)

	build_project(_target)

	chdir_force('CommonResources')
	os.chdir('../')
	chdir_force('ResourceAdapters')

	country_system_api=get_SystemApi(_target)
	country_system_api_operation=get_SystemApi(_target)+'_'+_target['operation']
	ra_name=get_RAName(_target)
	forceCHDir = chdir_force(ra_name)

	if forceCHDir:
		print 'El RA '+ ra_name+  'No existe'
		#Creacion de CSC, sus xsd y wsdl
		chdir_force('CSC')

		wsdl_name=country_system_api_operation+'_v1_CSC.wsdl'
		with open(wsdl_name, 'w') as new_file:
			with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/CSC/TEMPLATE_CSC.wsdl', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',_target['operation'])
					new_file.write(new_line)
		csm_name=country_system_api_operation+'_v1_CSM.xsd'
		with open(csm_name, 'w') as new_file:
			with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/CSC/TEMPLATE_CSM.xsd', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',_target['operation'])
					new_file.write(new_line)
		os.chdir('../')

		#Creacion de pipeline y proxy SDAdapter
		chdir_force('SDAdapter')

		sda_pipeline=country_system_api_operation+'_RA_SDA.pipeline'
		with open(sda_pipeline, 'w') as new_file:
			with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/SDAdapter/TEMPLATE_SDA.pipeline', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',_target['operation']).replace('%SYSTEM%', country_system )
					new_file.write(new_line)
		sda_proxy=country_system_api_operation+'_RA_SDA.proxy'
		with open(sda_proxy, 'w') as new_file:
			with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/SDAdapter/TEMPLATE_SDA.proxy', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',_target['operation']).replace('%SYSTEM%', country_system )
					new_file.write(new_line)
		#return to RA
		os.chdir('../')

		chdir_force('XQuery')

		xq_name_rsp_error='get_'+country_system_api_operation+'_AdapterRSP_ERROR.xqy'
		with open(xq_name_rsp_error, 'w') as new_file:
			with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/XQuery/TEMPLATE_AdapterRSP_ERROR.xqy', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',_target['operation'])
					new_file.write(new_line)

		xq_name_rsp_error='get_'+country_system_api_operation+'_REQMappings.xqy'
		with open(xq_name_rsp_error, 'w') as new_file:
			with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/XQuery/TEMPLATE_REQMappings.xqy', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',_target['operation'])
					new_file.write(new_line)

		xq_name_rsp_error='get_'+country_system_api_operation+'_RSPMappings.xqy'
		with open(xq_name_rsp_error, 'w') as new_file:
			with open('../../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/XQuery/TEMPLATE_RSPMappings.xqy', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',_target['operation'])
					new_file.write(new_line)


		os.chdir('../')
		#Create proxy y pipeline de RA
		ra_pipeline=country_system_api_operation+'_RA.pipeline'
		with open(ra_pipeline, 'w') as new_file:
			with open('../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/TEMPLATE_RA.pipeline', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',_target['operation']).replace('%SYSTEM%', country_system )
					new_file.write(new_line)
		ra_proxy=country_system_api_operation+'_RA.proxy'
		with open(ra_proxy, 'w') as new_file:
			with open('../../../TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/TEMPLATE_RA.proxy', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM_API%', country_system_api).replace('%OPERATION%',_target['operation']).replace('%SYSTEM%', country_system )
					new_file.write(new_line)
		#Return to ResourceAdaptes
		os.chdir('../')

	else:
		print 'El RA '+ ra_name+  'Ya existe, se omite la creacion'
	print '\n---------------------------------------------\n'
	os.chdir('../../')

def getDictionary(config, section, workspace):
	dictionary = dict()
	dictionary['country'] = config.get(section, 'country')
	dictionary['system'] = config.get(section, 'system')
	dictionary['api'] = config.get(section, 'api')
	dictionary['operation'] = config.get(section, 'operation')
	dictionary['version'] = config.get(section, 'version')
	return dictionary

def main():
	config = ConfigParser.ConfigParser()
	config.readfp(open('init.cfg'))

	print 'Creacion de contexto'
	workspace = config.get('WORKSPACE', 'path')
	config.remove_section('WORKSPACE')
	for target in config.sections():
		dictionary = getDictionary(config,target, workspace)
		build(dictionary)

main()