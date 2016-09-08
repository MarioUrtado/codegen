xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/EnterpriseService/v1";

declare function local:get_ESArchitecture() as element(){
    
    (: 
    This function holds the information require to describe this Service's Architecture (ESAS), at the Solution level.
    
    It should be kept updated over each modification made to the service, on which its Solution Architecture is modified.
    :)
    
    <ns1:EnterpriseService name="Consumer" code="100" majorVersion="1" minorVersion="0">
	<ns1:ESC>
		<ns1:EBSC>
			<ns1:PrimaryContract name="Consumer_v1_ESC"/>
                        <ns1:SecondaryContract name="Consumer_v1_ESC"/>
		</ns1:EBSC>
	</ns1:ESC>
	<ns1:MPL>
		<ns1:PIF name="Consumer_PIF"/>
                <ns1:SIF name="Consumer_SIF"/>
	</ns1:MPL>
	<ns1:CSL>
		<ns1:Country code="CHL">
			<ns1:OH opName="get" opCode="101" name="CHL_get_Consumer"/>
			<ns1:OH opName="del" opCode="103" name="CHL_del_Consumer"/>
			<ns1:OH opName="upd" opCode="104" name="CHL_upd_Consumer"/>
		</ns1:Country>
		<ns1:Country code="INT">
			<ns1:OH opName="del" opCode="103" name="INT_del_Consumer" supports="CHL,PER"/>
		</ns1:Country>
	</ns1:CSL>
  </ns1:EnterpriseService>
};

local:get_ESArchitecture()
