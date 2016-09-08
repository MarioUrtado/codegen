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

def get_TransportInstance(_target):
	transportInstanceName = _target['transport']
	if len(_target['instance']) > 0:
		transportInstanceName = transportInstanceName + '_' + _target['instance']
	return transportInstanceName

def get_TransportWrapperName(_target):
	transportWrapperName = get_SystemApi(_target) + '_' + get_TransportInstance(_target)
	return transportWrapperName

def getProjectName(_target):
	projectName = 'DC_LW_' + get_System(_target)+'_v'+_target['version']
	return projectName	

def build_project(_target):

	projectName = getProjectName(_target)

	forceMkdir = chdir_force(projectName)

	#servicesbus.servicesbus
	servicesbus_file='servicesbus.sboverview'
	if not os.path.isfile(servicesbus_file):
		with open(servicesbus_file, 'w') as new_file:
			with open('../TEMPLATES/LW/TEMPLATE_servicebus.sboverview', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%PROJECT_NAME%', projectName)
					new_file.write(new_line)
	else:
		print 'El archivo ' + servicesbus_file + ' ya existe'

	#project.jpr
	project_file=projectName+'.jpr'
	if not os.path.isfile(project_file):
		with open(project_file, 'w') as new_file:
			with open('../TEMPLATES/LW/TEMPLATE.jpr', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%PROJECT_NAME%', projectName).replace('%DEFUALT_PACKAGE_PROJECT_NAME%', projectName.lower().replace('-',''))
					new_file.write(new_line)
	else:
		print 'El archivo ' + project_file + ' ya existe'

	#pom.xml
	pom_file='pom.xml'
	if not os.path.isfile(pom_file):
		with open(pom_file, 'w') as new_file:
			with open('../TEMPLATES/LW/POM_TEMPLATE.xml', 'r') as template_file:
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

def build(_target):
	print '\n---------------------------------------------\n'
	print 'Armado projecto LW: ' + getProjectName(_target)
	print '\n---------------------------------------------\n'

	country_system=get_System(_target)
	project_name=getProjectName(_target)

	print 'Creaction de carpeta del proyecto: ' + project_name
	build_project(_target)

	country_system_api=get_SystemApi(_target)

	print 'Creacion de Wrappers'
	#Creacion de CSC, sus xsd y wsdl
	chdir_force('Wrapper')

	#Create proxy y pipeline de RA
	print '\n---------------------------------------------\n'
	print 'CREACION DE PROXY Y PIPELINE DE LW - INICIO'
	print '\n---------------------------------------------\n'
	
	lw_pipeline=country_system+'_LW.pipeline'
	with open(lw_pipeline, 'w') as new_file:
		with open('../../TEMPLATES/LW/Wrapper/LW.pipeline', 'r') as template_file:
			for line in template_file:
				new_line=line.replace('%SYSTEM%', country_system )
				new_file.write(new_line)
	lw_proxy=country_system+'_LW.proxy'
	with open(lw_proxy, 'w') as new_file:
		with open('../../TEMPLATES/LW/Wrapper/LW.proxy', 'r') as template_file:
			for line in template_file:
				new_line=line.replace('%SYSTEM%', country_system )
				new_file.write(new_line)
	print 'CREACION DE PROXY Y PIPELINE DE LW - FIN'

	os.chdir('../')

	chdir_force('APIWs')

	chdir_force(country_system_api)
	apiw_pipeline = country_system_api + '_APIW.pipeline'
	print '\n---------------------------------------------\n'
	print 'Creacion de APIW: ' + apiw_pipeline
	print '\n---------------------------------------------\n'

	if not os.path.isfile(apiw_pipeline):
		with open(apiw_pipeline, 'w') as new_file:
			with open('../../../TEMPLATES/LW/APIWs/API/APIW.pipeline', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM%', country_system ).replace('%SYSTEM_API%', country_system_api )
					new_file.write(new_line)

	chdir_force('TW')

	transportInstanceName = get_TransportInstance(_target)

	chdir_force(transportInstanceName)

	transportWrapperName = get_TransportWrapperName(_target)

	tw_pipeline = transportWrapperName + '.pipeline'

	print '\n---------------------------------------------\n'
	print 'Creacion de TransportWrapper Pipeline: ' + tw_pipeline
	print '\n---------------------------------------------\n'

	if not os.path.isfile(tw_pipeline):
		with open(tw_pipeline, 'w') as new_file:
			with open('../../../../../TEMPLATES/LW/APIWs/API/TW/TRANSPORT/TW.pipeline', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM%', country_system ).replace('%SYSTEM_API%', country_system_api )
					new_file.write(new_line)



	tw_bix = transportWrapperName + '.bix'

	print '\n---------------------------------------------\n'
	print 'Creacion de TransportWrapper Pipeline: ' + tw_bix
	print '\n---------------------------------------------\n'

	if not os.path.isfile(tw_bix):
		with open(tw_bix, 'w') as new_file:
			with open('../../../../../TEMPLATES/LW/APIWs/API/TW/TRANSPORT/TW.bix', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM%', country_system ).replace('%SYSTEM_API%', country_system_api ).replace('%TW_NAME%',transportWrapperName ).replace('%TRANSPORT_INSTANCE%', transportInstanceName)
					new_file.write(new_line)

	print 'CREACION DE PROXY Y PIPELINE DE LW - FIN'

	chdir_force('XQuery')
	
	tw_seb_xqy = transportWrapperName + '_SEB.xqy'
	if not os.path.isfile(tw_seb_xqy):
		with open(tw_seb_xqy, 'w') as new_file:
			with open('../../../../../../TEMPLATES/LW/APIWs/API/TW/TRANSPORT/XQuery/SEB.xqy', 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM%', country_system ).replace('%SYSTEM_API%', country_system_api ).replace('%TW_NAME%',transportWrapperName ).replace('%TRANSPORT_INSTANCE%', transportInstanceName)
					new_file.write(new_line)	
	#Return to ResourceAdaptes
	os.chdir('../../../../../../')
	print '\n---------------------------------------------\n'
	print os.getcwd()
	print '\n---------------------------------------------\n'
	print '\n---------------------------------------------\n'
	print '\n---------------------------------------------\n'

def getDictionary(config, section, workspace):
	dictionary = dict()
	dictionary['country'] = config.get(section, 'country')
	dictionary['system'] = config.get(section, 'system')
	dictionary['api'] = config.get(section, 'api')
	dictionary['version'] = config.get(section, 'version')
	dictionary['transport'] = config.get(section, 'transport')
	dictionary['instance'] = config.get(section, 'instance')
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