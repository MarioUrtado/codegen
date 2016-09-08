import os
import ConfigParser
import util
import xml.etree.ElementTree as ET

def generateConfig(_path):
	_config = ConfigParser.ConfigParser()
	_config.readfp(open(_path))
	return _config


def chdir_force(_dir):
	if not(os.path.isdir(_dir)):
		os.makedirs(_dir)
	os.chdir(_dir)

def main(filename):

	paramConfig=generateConfig(filename)
	wsdlPath=paramConfig.get('WSDL', 'path').replace('\\', '/')

	config = ConfigParser.RawConfigParser()

	tree = ET.parse(wsdlPath)
	root = tree.getroot()

	serviceName = root.get('targetNamespace').split('/')[-2]

	config.add_section('SERVICE')
	config.set('SERVICE', 'NAME', serviceName)
	config.set('SERVICE', 'CODE', '##SERVICE_CODE##')
	config.set('SERVICE', 'VERSION', '1')

	config.add_section('CAPABILITIES')

	operations= []

	for element in root.findall('{http://schemas.xmlsoap.org/wsdl/}binding'):
		for operation in element.findall('{http://schemas.xmlsoap.org/wsdl/}operation'):
			operName = operation.attrib['name']
			if '_Callback' not in operName:
				operations.append(operation.attrib['name'])
		break

	operationsNames = ','.join(operations)

	config.set('CAPABILITIES', 'name', operationsNames)

	for oper in operations:
		config.add_section(oper)
		config.set(oper, 'code', '##CAPABILITY_CODE##')
		config.set(oper, 'version', '1')
		config.set(oper, 'syncORasync', 'sync')


	file_name = serviceName + '_init.cfg'
	with open(file_name, 'wb') as configfile:
		config.write(configfile)




