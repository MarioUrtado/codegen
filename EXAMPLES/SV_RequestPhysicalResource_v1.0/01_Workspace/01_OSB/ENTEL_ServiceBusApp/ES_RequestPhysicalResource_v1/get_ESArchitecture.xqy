xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/EnterpriseService/v1";

declare function local:get_ESArchitecture() as element(){
    
    (: 
    This function holds the information require to describe this Service's Architecture (ESAS), at the Solution level.
    
    It should be kept updated over each modification made to the service, on which its Solution Architecture is modified.
    :)
    
    <ns1:EnterpriseService name="RequestPhysicalResource" code="PIM_0009" majorVersion="1" minorVersion="0">
	<ns1:ESC>
		<ns1:EBSC>
			<ns1:PrimaryContract name="RequestPhysicalResource_v1_ESC"/>
		</ns1:EBSC>
	</ns1:ESC>
	<ns1:MPL>
		<ns1:PIF name="RequestPhysicalResource_PIF"/>
	</ns1:MPL>
	<ns1:CSL>
		<ns1:Country code="PER">
			<ns1:OH opName="Create" opCode="OPER_00197" name="PER_Create_RequestPhysicalResource"/>
		</ns1:Country>
	</ns1:CSL>
  </ns1:EnterpriseService>
};

local:get_ESArchitecture()
