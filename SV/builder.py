from tempfile import mkstemp
import shutil
import os
import ConfigParser
import util
import xml.etree.ElementTree as ET

root_path=os.path.dirname(os.path.realpath(__file__)).replace('\\', '/')
os.chdir(root_path)

def generateConfig(_path):
	_config = ConfigParser.ConfigParser()
	_config.readfp(open(_path))
	return _config

def chdir_force(_dir):
	if not(os.path.isdir(_dir)):
		os.makedirs(_dir)
	os.chdir(_dir)

def build(_initConfig, workspace):
	print '-----------------------------------------'
	print 'Inicio de construccion de proyecto'
	config=generateConfig(_initConfig)

	config_template_location = ConfigParser.ConfigParser()
	config_template_location.readfp(open((root_path+'/TEMPLATE_CONFIG')))

	config_2 = ConfigParser.ConfigParser()
	config_2.readfp(open((root_path+'/TEMPLATES/ES/ES_ARQUITECTURE_TAG')))

	serviceName=config.get( 'SERVICE', 'name')
	serviceCode=config.get( 'SERVICE', 'code')
	serviceVersion=config.get( 'SERVICE', 'version')

	print 'Servicio: ' + serviceName

	project='ES_'+serviceName+'_v'+serviceVersion
	countries=['INT', 'CHL', 'PER']

	print 'Capacidades: ' + config.get( 'CAPABILITIES', 'name')
	capabilities=config.get( 'CAPABILITIES', 'name').split(',')

	chdir_force(project)

	_from=root_path+config_template_location.get('PROJECT','jpr')
	_to=project+'.jpr'
	util.jpr(_from,_to, serviceName)

	_from=root_path+config_template_location.get('PROJECT','servicebus')
	_to='servicebus.sboverview'
	util.serviesbus(_from,_to, serviceName)

	_from=root_path+config_template_location.get('PROJECT','pom')
	_to='pom.xml'
	util.pom(_from,_to, serviceName)

	chdir_force('MPL')

	#GENERATE PIF
	chdir_force('PIF')

	pif_pipeline_name=(serviceName+'_PIF.pipeline')
	_from=root_path+config_template_location.get('MPL','pipeline')
	_to=pif_pipeline_name
	util.servieNameReplace(_from, _to,serviceName)

	pif_proxy_name=(serviceName+'_PIF.proxy')
	_from=root_path+config_template_location.get('MPL','proxy')
	_to=pif_proxy_name
	util.servieNameReplace(_from, _to,serviceName)

	os.chdir('../')
	os.makedirs('SIF')

	os.chdir('../')

	chdir_force('ESC')
	os.makedirs('Primary')
	os.makedirs('Secondary')
	os.chdir('../')

	chdir_force('CSL')
	for ctry in countries:
		chdir_force(ctry)
		chdir_force('OH')
		for cap in capabilities:
			if ( ctry in config.get(cap, 'countries') ):
				chdir_force(cap)

				##Create XQuery template
				chdir_force('XQuery')

				capability = util.Capability(cap, '', serviceName, ctry, cap)

				xquery_template_file=root_path+config_template_location.get('CSL','xquery_frsp')
				xquery_name='get_'+cap+'_'+serviceName+'_FRSP.xqy'
				util.replaceOHComponentName(xquery_template_file, xquery_name, capability)

				os.chdir('../')
				
				##Create Pipeline
				pipeline_template_file=root_path+config_template_location.get('CSL','pipeline')
				pipeline_OH_file=ctry+'_'+cap+'_'+serviceName+'_OH.pipeline'
				util.replaceOHComponentName(pipeline_template_file, pipeline_OH_file, capability)

				#OH
				os.chdir('../')
		##Country/CSL		
		os.chdir('../../')

	##Root project folder
	os.chdir('../')

	##GENERATE_ESARQUITECTURE
	with open('get_ESArchitecture.xqy', 'w') as new_file:
		with open((root_path+'/TEMPLATES/ES/get_ESArchitecture_TEMPLATE.xqy'), 'r') as template_file:
			for line in template_file:
				if 'PLACE_CAPABILIES' in line:
					for ctry in countries:
						new_line=config_2.get('COUNTRY_TAG', 'open').replace('%COUNTRY_NAME%',ctry )
						new_file.write(('\t\t'+new_line + '\n'))
						for cap in capabilities:
							capability_code = config.get(cap, 'code')
							new_line=config_2.get('CAPABILITY_TAG', 'open')
							new_line=new_line.replace('%CAPABILITY_NAME%',cap ).replace('%CAPABILITY_CODE%', capability_code).replace('%COUNTRY_NAME%', ctry).replace('%SERVICE_NAME%', serviceName)
							new_file.write(('\t\t\t'+new_line))
							new_file.write( (config_2.get('CAPABILITY_TAG', 'close')+'\n'))
						new_line=config_2.get('COUNTRY_TAG', 'close')
						new_file.write(('\t\t' + new_line + '\n'))
				else:
					new_line=line.replace('%SERVICE_NAME%', serviceName).replace('%SERVICE_CODE%', serviceCode)
					new_file.write(new_line)
	os.chdir('../')

	wsdlConfig = os.path.join(os.path.join(root_path, 'tmp'),(serviceName.upper()+'_V'+serviceVersion+'_ESC.WSDL.cfg'))

	#get config of paths
	paramConfig=generateConfig(wsdlConfig)

	#import wsdl to project
	wsdlPath=paramConfig.get('WSDL', 'path').replace('\\', '/')
	ESCpath = './'+project+'/ESC/Primary'
	shutil.copy(wsdlPath, ESCpath)

	#import ebs to project
	try:
		ebmPath=paramConfig.get('EBMs', 'path').replace('\\', '/')
	except ConfigParser.NoSectionError, e:
		ebmPath=wsdlPath+'/EBM'
		raise e

	for cap in capabilities:
		ebmfile= cap + '_'+serviceName+'_v'+config.get(cap, 'version')+'_EBM.xsd'
		ebmfilepath = os.path.join(ebmPath, ebmfile)
		shutil.copy(ebmfilepath, ESCpath)

	## COMIENZO DEL  FLASHEOOOOOOO
	pathCommonsEBO = '../../../SR_Commons/XSD/EBO/'

	paths_to_replace = ['../../../SID/CommonBusinessEntitiesDomain/','../../../SID/CustomerDomain/','../../../SID/EngagedPartyDomain/','../../../SID/MarketSalesDomain/','../../../SID/NetworkDomain/','../../../SID/ProductDomain/','../../../SID/ResourceDomain/','../../../SID/ServiceDomain/']

	for file in os.listdir(ESCpath):
		full_file = os.path.join(ESCpath, file)
		if ('EBM.XSD' in full_file.upper() ):
			fh, abs_path = mkstemp()
			with open(abs_path,'w') as new_file:
				with open(full_file) as old_file:
					for line in old_file:
						for pattern in paths_to_replace:
							if pattern in line:
								print 'REPLACE'
								line = line.replace(pattern, pathCommonsEBO)
						new_file.write(line)
			os.close(fh)
			os.remove(full_file)
			shutil.move(abs_path, full_file)
		if ('ESC.WSDL' in full_file.upper() ):
			print 'WSDL encontrado'
			fh, abs_path = mkstemp()
			with open(abs_path,'w') as new_file:
				with open(full_file) as old_file:
					for line in old_file:
						new_file.write(line.replace('schemaLocation="EBM/', 'schemaLocation="'))
			os.close(fh)
			os.remove(full_file)
			shutil.move(abs_path, full_file)

	## FIN DEL  FLASH INFORMATIVO

	print 'Importando Proyecto a la aplicacion'
	newElement = ET.fromstring(('<hash><url n="URL" path="'+project+'/'+project+'.jpr"/></hash>'))
	applicationName=os.path.basename(os.path.normpath(workspace))+'.jws'
	applicationName = os.path.join(workspace, applicationName)
	tree = ET.parse(applicationName)
	root = tree.getroot()
	for ele in root.findall(".//*[@n='listOfChildren']"):
		ele.append(newElement)
		break
	tree.write(applicationName,  encoding="UTF-8")
	print 'Fin de construccion de proyecto'
	print '-----------------------------------------'
def main():

	config = generateConfig('pool.cfg')
	workspace = config.get('WORKSPACE', 'path')
	os.chdir(workspace)

	inits=[]
	full_path_temp = os.path.join(root_path, 'tmp')
	for file in os.listdir(full_path_temp):
		if '_init.cfg' in file:
			inits.append(file)

	for initConfig in inits:
		fullpathInit = os.path.join(full_path_temp, initConfig)
		build(fullpathInit,workspace)

main()