import os

class Legacy:

	def __init__(self, country, system, api, operation):
		self.country = country
		self.system = system
		self.api = api
		self.operation = operation
		self.country_system_api = self.country+'-'+self.system+'-'+self.api

	def country(self):
		return self.country
	def system(self):
		return self.system
	def api(self):
		return self.api
	def operation(self):
		return self.operation

class Capability:

	def __init__(self, name, code, service, country, reqName):
		self.name = name
		self.code = code
		self.service = service
		self.country = country
		self.reqName = reqName

	def name(self):
		return self.name

	def code(self):
		return self.code

	def service(self):
		return self.service

	def country(self):
		return self.country

	def reqName(self):
		return self.reqName

def servieNameReplace(_from, _to, _serviceName):
	with open(_to, 'w') as new_file:
		with open(_from, 'r') as template_file:
			for line in template_file:
				new_line = line.replace('%SERVICE_NAME%', _serviceName)
				new_file.write(new_line)

def pom(_from,_to, _serviceName ):
	servieNameReplace(_from,_to,_serviceName)

def jpr(_from,_to, _serviceName ):
	with open(_to, 'w') as new_file:
		with open(_from, 'r') as template_file:
			for line in template_file:
				new_line = line.replace('%SERVICE_NAME%', _serviceName).replace('%SERVICE_NAME_LOWER%', _serviceName.lower())
				new_file.write(new_line)

def serviesbus(_from,_to ,_serviceName):
	servieNameReplace(_from,_to,_serviceName)

def replaceOHComponentNameWithLegacy(_from, _to, capability, legacy):
	print(capability)
	with open(_to, 'w') as new_file:
		with open(_from, 'r') as template_file:
			for line in template_file:
				new_line = line.replace('%CAPABILITY_REQ_NAME%', capability.reqName)
				new_line = new_line.replace('%CAPABILITY_NAME%', capability.name)
				new_line = new_line.replace('%SERVICE_NAME%', capability.service)
				new_line = new_line.replace('%COUNTRY_NAME%',capability.country)
				new_line = new_line.replace('%LEGACY_COUNTRY%',legacy.country)
				new_line = new_line.replace('%LEGACY_SYSTEM%',legacy.system)
				new_line = new_line.replace('%LEGACY_API%',legacy.api)
				new_line = new_line.replace('%LEGACY_OPERATION%',legacy.operation)
				new_line = new_line.replace('%SYSTEM_API%',legacy.country_system_api)
				new_line = new_line.replace('%OPERATION%',legacy.operation)
				new_file.write(new_line)

def replaceOHComponentName(_from, _to, _capability):
	with open(_to, 'w') as new_file:
		with open(_from, 'r') as template_file:
			for line in template_file:
				new_line = line.replace('%CAPABILITY_REQ_NAME%', _capability.reqName()).replace('%CAPABILITY_NAME%', _capability.name()).replace('%SERVICE_NAME%', _capability.service()).replace('%COUNTRY_NAME%',_capability.country())
				new_file.write(new_line)

def replaceComponentWithSystemApiAndOperation(_from, _to, _systemApi, _operation):
	if not os.path.isfile(_to):
		with open(_to, 'w') as new_file:
			with open(_from, 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM_API%', _systemApi).replace('%OPERATION%',_operation)
					new_file.write(new_line)
		return True
	else:
		return False

def replaceComponent(_from, _to, _system, _systemApi, _operation):
	if not os.path.isfile(_to):
		with open(_to, 'w') as new_file:
			with open(_from, 'r') as template_file:
				for line in template_file:
					new_line=line.replace('%SYSTEM_API%', _systemApi).replace('%OPERATION%',_operation).replace('%SYSTEM%',_system)
					new_file.write(new_line)
		return True
	else:
		return False