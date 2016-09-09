import shutil
import util
import os
import ConfigParser
import xml.etree.ElementTree as ET

root_path=os.path.dirname(os.path.realpath(__file__)).replace('\\', '/')

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

	#project.jpr
	project_file=projectName+'.jpr'
	if not os.path.isfile(project_file):
		with open(project_file, 'w') as new_file:
			with open((root_path+'/TEMPLATES/RA/TEMPLATE.jpr'), 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%PROJECT_NAME%', projectName).replace('%DEFUALT_PACKAGE_PROJECT_NAME%', projectName.lower().replace('-',''))
					new_file.write(new_line)
	else:
		print 'El archivo ' + project_file + ' ya existe'

	#pom.xml
	pom_file='pom.xml'
	if not os.path.isfile(pom_file):
		with open(pom_file, 'w') as new_file:
			with open((root_path+'/TEMPLATES/RA/POM_TEMPLATE.xml'), 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%PROJECT_NAME%', projectName)
					new_file.write(new_line)
	else:
		print 'El archivo ' + pom_file + ' ya existe'
	return forceMkdir

def build(_target, workspace):
	print '\n---------------------------------------------\n'
	print 'Armado projecto RA: ' + get_RAName(_target)

	country_system=get_System(_target)
	project_name=getProjectName(_target)

	isBuilder= build_project(_target)

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

		_to=country_system_api_operation+'_v1_CSC.wsdl'
		_from = root_path+'/TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/CSC/TEMPLATE_CSC.wsdl'
		util.replaceComponentWithSystemApiAndOperation(_from, _to, country_system_api, _target['operation'])

		_to=country_system_api_operation+'_v1_CSM.xsd'
		_from = root_path+'/TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/CSC/TEMPLATE_CSM.xsd'
		util.replaceComponentWithSystemApiAndOperation(_from, _to, country_system_api, _target['operation'])

		os.chdir('../')

		#Creacion de pipeline y proxy SDAdapter
		chdir_force('SDAdapter')

		_to=country_system_api_operation+'_RA_SDA.pipeline'
		_from = root_path+'/TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/SDAdapter/TEMPLATE_SDA.pipeline'
		util.replaceComponent(_from, _to, country_system, country_system_api , _target['operation'])

		_to=country_system_api_operation+'_RA_SDA.proxy'
		_from = root_path+'/TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/SDAdapter/TEMPLATE_SDA.proxy'
		util.replaceComponent(_from, _to, country_system, country_system_api , _target['operation'])

		#return to RA
		os.chdir('../')

		chdir_force('XQuery')

		_to='get_'+country_system_api_operation+'_AdapterRSP_ERROR.xqy'
		_from = root_path+'/TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/XQuery/TEMPLATE_AdapterRSP_ERROR.xqy'
		util.replaceComponentWithSystemApiAndOperation(_from, _to, country_system_api, _target['operation'])

		_to='get_'+country_system_api_operation+'_REQMappings.xqy'
		_from = root_path+'/TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/XQuery/TEMPLATE_REQMappings.xqy'
		util.replaceComponentWithSystemApiAndOperation(_from, _to, country_system_api, _target['operation'])

		_to='get_'+country_system_api_operation+'_RSPMappings.xqy'
		_from = root_path+'/TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/XQuery/TEMPLATE_RSPMappings.xqy'
		util.replaceComponentWithSystemApiAndOperation(_from, _to, country_system_api, _target['operation'])

		_to='get_'+country_system_api_operation+'_LegacyREQ.xqy'
		_from = root_path+'/TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/XQuery/TEMPLATE_LegacyREQ.xqy'
		util.replaceComponentWithSystemApiAndOperation(_from, _to, country_system_api, _target['operation'])

		_to='get_'+country_system_api_operation+'_AdapterRSP_OK.xqy'
		_from = root_path+'/TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/XQuery/TEMPLATE_AdapterRSP_OK.xqy'
		util.replaceComponentWithSystemApiAndOperation(_from, _to, country_system_api, _target['operation'])

		os.chdir('../')
		#Create proxy y pipeline de RA
		_to=country_system_api_operation+'_RA.pipeline'
		_from = root_path+'/TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/TEMPLATE_RA.pipeline'
		util.replaceComponent(_from, _to, country_system, country_system_api , _target['operation'])		
		

		_to=country_system_api_operation+'_RA.proxy'
		_from = root_path+'/TEMPLATES/RA/ResourceAdapters/TEMPLATE_RA/TEMPLATE_RA.proxy'
		util.replaceComponent(_from, _to, country_system, country_system_api , _target['operation'])		
		
		#Return to ResourceAdaptes
		os.chdir('../')
	else:
		print 'El RA '+ ra_name+  'Ya existe, se omite la creacion'
	print '\n---------------------------------------------\n'
	os.chdir('../../')

	if isBuilder:

		newElement = ET.fromstring(('<hash><url n="URL" path="'+project_name+'/'+project_name+'.jpr"/></hash>'))
		applicationName=os.path.basename(os.path.normpath(workspace))+'.jws'
		applicationName = os.path.join(workspace, applicationName)
		tree = ET.parse(applicationName)
		root = tree.getroot()
		for ele in root.findall(".//*[@n='listOfChildren']"):
			ele.append(newElement)
			break
		tree.write(applicationName,  encoding="UTF-8")

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

	os.chdir(workspace)

	for target in config.sections():
		dictionary = getDictionary(config,target, workspace)
		build(dictionary, workspace)

main()