import shutil
import os
import ConfigParser
import util
import xml.etree.ElementTree as ET

root_path=os.path.dirname(os.path.realpath(__file__)).replace('\\', '/')

def generateConfig(_path):
	_config = ConfigParser.ConfigParser()
	_config.readfp(open(_path))
	return _config

def chdir_force(_dir):
	if not(os.path.isdir(_dir)):
		os.makedirs(_dir)
	os.chdir(_dir)

def main():
	config=generateConfig('init.cfg')

	config_template_location = ConfigParser.ConfigParser()
	config_template_location.readfp(open('TEMPLATE_CONFIG'))

	config_2 = ConfigParser.ConfigParser()
	config_2.readfp(open('TEMPLATES/ES/ES_ARQUITECTURE_TAG'))

	serviceName=config.get( 'SERVICE', 'name')
	serviceCode=config.get( 'SERVICE', 'code')
	serviceVersion=config.get( 'SERVICE', 'version')

	project='ES_'+serviceName+'_v'+serviceVersion
	countries=['INT', 'CHL', 'PER']

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
			chdir_force(cap)

			##Create XQuery template
			chdir_force('XQuery')

			#lg_value_list=config.get(cap, 'legacy').split(',')

			#legacy = util.Legacy(lg_value_list[0], lg_value_list[1], lg_value_list[2], lg_value_list[3])

			capability = util.Capability(cap, '', serviceName, ctry, cap)

			#xquery_template_file=root_path+config_template_location.get('CSL','xquery_rsp')
			#xquery_name='get_'+cap+'_'+serviceName+'_RSP.xqy'
			#util.replaceOHComponentNameWithLegacy(xquery_template_file, xquery_name, capability, legacy)

			xquery_template_file=root_path+config_template_location.get('CSL','xquery_frsp')
			xquery_name='get_'+cap+'_'+serviceName+'_FRSP.xqy'
			util.replaceOHComponentName(xquery_template_file, xquery_name, capability)

			#xquery_template_file=root_path+config_template_location.get('CSL','xquery_ra_req')
			#xquery_name='get_'+legacy.country+'-'+legacy.system+'-'+legacy.api+'_'+legacy.operation+'_REQ.xqy'
			#util.replaceOHComponentNameWithLegacy(xquery_template_file, xquery_name, capability, legacy)			

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
		with open('../TEMPLATES/ES/get_ESArchitecture_TEMPLATE.xqy', 'r') as template_file:
			for line in template_file:
				if 'PLACE_CAPABILIES' in line:
					for ctry in countries:
						new_line=config_2.get('COUNTRY_TAG', 'open').replace('%COUNTRY_NAME%',ctry )
						new_file.write(new_line)
						for cap in capabilities:
							new_line=config_2.get('CAPABILITY_TAG', 'open')
							new_line=new_line.replace('%CAPABILITY_NAME%',cap ).replace('%CAPABILITY_CODE%', '###CAPABILITY_CODE#').replace('%COUNTRY_NAME%', ctry).replace('%SERVICE_NAME%', serviceName)
							new_file.write(new_line)
							new_file.write(config_2.get('CAPABILITY_TAG', 'close'))
						new_line=config_2.get('COUNTRY_TAG', 'close')
						new_file.write(new_line)
				else:
					new_line=line.replace('%SERVICE_NAME%', serviceName).replace('%SERVICE_CODE%', serviceCode)
					new_file.write(new_line)
	os.chdir('../')

	#get config of paths
	paramConfig=generateConfig('WSDL.CFG')

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

	for file_name in os.listdir(ebmPath):
	    full_file_name = os.path.join(ebmPath, file_name)
	    if (os.path.isfile(full_file_name)):
	        shutil.copy(full_file_name, ESCpath)

	#refactor path wsdl
#	goToESC=project+'/ESC/Primary'
#	os.chdir(goToESC)
	#
#	wsdlName = wsdlPath.split('/')[-1]
#
#	tree = ET.parse(wsdlName)
#	root = tree.getroot()
#	print root.attrib
#	root = root.find('{http://schemas.xmlsoap.org/wsdl/}types').find('{http://www.w3.org/2001/XMLSchema}schema')
#	objectify.deannotate(root, cleanup_namespaces=True)
#	for elementImport in root.findall('{http://www.w3.org/2001/XMLSchema}import'):
#		print 'adsasdasdadsad'
#		pathEBMInWsdl = elementImport.get('schemaLocation')
#		print pathEBMInWsdl
#		pathEBMInWsdl = pathEBMInWsdl.split('/')[-1]
#		print pathEBMInWsdl
#		elementImport.set('schemaLocation', pathEBMInWsdl)
#	tree.write(wsdlName, xml_declaration=True)
#
#	os.chdir('../../../')

	#copy project to workspace
	workspaacePath=paramConfig.get('WORKSPACE', 'path').replace('\\', '/')
	fullPathProject = root_path+'/'+project
	workspaacePathProject=workspaacePath+'/'+project
	shutil.copytree(fullPathProject, workspaacePathProject)

