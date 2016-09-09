import os
import builder
import parseWSDL
import ConfigParser

root_path=os.path.dirname(os.path.realpath(__file__)).replace('\\', '/')
os.chdir(root_path)
def chdir_force(_dir):
	if not(os.path.isdir(_dir)):
		os.makedirs(_dir)
	os.chdir(_dir)

def generateConfig(_path):
	_config = ConfigParser.ConfigParser()
	_config.readfp(open(_path))
	return _config

config=generateConfig((root_path+'/pool.cfg'))
workspace = config.get('WORKSPACE', 'path')
config.remove_section('WORKSPACE')

wsdls=[]
pool=config.get('CONTRACT_CONTAINER', 'path')
for file in os.listdir(pool):
	full_path = os.path.join( pool , file)
	if os.path.isfile(full_path):
		if ( '_ESC.WSDL' in file.upper() ):
			wsdls.append(file)

for section in wsdls:
	configDump = ConfigParser.RawConfigParser()
	configDump.add_section('WORKSPACE')
	configDump.set('WORKSPACE', 'path', workspace)
	configDump.add_section('WSDL')
	pathWSDL = os.path.join(pool,section)
	configDump.set('WSDL', 'path', pathWSDL)
	configDump.add_section('EBMs')
	pathEBM = os.path.join(pool, 'EBM')
	configDump.set('EBMs', 'path', pathEBM)

	chdir_force('tmp')

	filename = section.upper()+'.cfg'

	with open(filename, 'wb') as configfile:
		configDump.write(configfile)

	parseWSDL.main(filename)
	os.chdir('../')
	##builder.main()