import os
import ConfigParser
import util
import xml.etree.ElementTree as ET

def generateConfig(_path):
	_config = ConfigParser.ConfigParser()
	_config.readfp(open(_path))
	return _config

def main():

	paramConfig=generateConfig('wsdl.cfg')
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

	with open('init.cfg', 'wb') as configfile:
	    config.write(configfile)