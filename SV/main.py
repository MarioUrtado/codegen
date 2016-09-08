import builder
import parseWSDL
import ConfigParser

def generateConfig(_path):
	_config = ConfigParser.ConfigParser()
	_config.readfp(open(_path))
	return _config

config=generateConfig('pool.cfg')
workspace = config.get('WORKSPACE', 'path')
config.remove_section('WORKSPACE')

for section in config.sections():
	
	configDump = ConfigParser.RawConfigParser()
	configDump.add_section('WORKSPACE')
	configDump.set('WORKSPACE', 'path', workspace)
	configDump.add_section('WSDL')
	configDump.set('WSDL', 'path', config.get(section, 'wsdl'))
	configDump.add_section('EBMs')
	configDump.set('EBMs', 'path', config.get(section, 'ebmFolder'))
	with open('wsdl.cfg', 'wb') as configfile:
		configDump.write(configfile)

	parseWSDL.main()
	builder.main()