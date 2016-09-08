xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/EnterpriseService/v1";

declare function local:get_ESArchitecture() as element(){
    
    (: 
    This function holds the information require to describe this Service's Architecture (ESAS), at the Solution level.
    
    It should be kept updated over each modification made to the service, on which its Solution Architecture is modified.
    :)
    
    <ns1:EnterpriseService name="%SERVICE_NAME%" code="%SERVICE_CODE%" majorVersion="1" minorVersion="0">
	<ns1:ESC>
		<ns1:EBSC>
			<ns1:PrimaryContract name="%SERVICE_NAME%_v1_ESC"/>
            <ns1:SecondaryContract name="%SERVICE_NAME%_v1_ESC"/>
		</ns1:EBSC>
	</ns1:ESC>
	<ns1:MPL>
		<ns1:PIF name="%SERVICE_NAME%_PIF"/>
        <ns1:SIF name="%SERVICE_NAME%_SIF"/>
	</ns1:MPL>
	<ns1:CSL>
PLACE_CAPABILIES
	</ns1:CSL>
  </ns1:EnterpriseService>
};

local:get_ESArchitecture()