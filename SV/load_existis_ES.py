import os
import ConfigParser

def loadConfig(projectPath):
	self_path=root_path=os.path.dirname(os.path.realpath(__file__)).replace('\\', '/')

	root_path=(projectPath).replace('\\', '/')

	csl_path=root_path+'/CSL'
	mpl_path=root_path+'/MPL'
	esc_path=root_path+'/ESC'

	os.path.isdir(mpl_path)

	os.chdir(mpl_path)
	os.chdir('PIF')
	list_pif=os.listdir(os.getcwd())
	serviceName=''
	if(len(list_pif) == 2 ):
		serviceName=list_pif[0].split('_')[0]

	if(os.path.dirname(root_path).split('_')[1] == serviceName ):
		print('ok')

	os.chdir(csl_path)
	countries=os.listdir(os.getcwd())

	country_capabilities={}
	capabilities=[]

	for country in countries:
		os.chdir(country)
		os.chdir('OH')
		capabilities= os.listdir(os.getcwd())
		country_capabilities[country]=capabilities
		for cap in capabilities:
			if cap not in capabilities:
				capabilities.append(cap)
		os.chdir('../../')

	config = ConfigParser.ConfigParser()

	config.add_section('SERVICE')
	config.set('SERVICE', 'name', serviceName)
	config.set('SERVICE', 'version', '1')
	config.set('SERVICE', 'code', '')

	config.add_section('COUNTRIES')
	config.set('COUNTRIES', 'name', ",".join(countries))

	config.add_section('CAPABILITIES')
	config.set('CAPABILITIES', 'name', ",".join(capabilities))

	for cap in capabilities:
		config.add_section(cap)
		config.set(cap, 'name', cap)
		config.set(cap, 'reqName', cap)
		config.set(cap, 'code', '')
		countries_capabilities=[]
		for ctry in countries:
			if cap in country_capabilities[ctry]:
				countries_capabilities.append(ctry)
		config.set(cap, 'country', ",".join(country_capabilities))

	#config.write(self_path+'/load_config')
	print(config)

	with open((self_path+'/load_config'), 'wb') as configfile:
	    config.write(configfile)