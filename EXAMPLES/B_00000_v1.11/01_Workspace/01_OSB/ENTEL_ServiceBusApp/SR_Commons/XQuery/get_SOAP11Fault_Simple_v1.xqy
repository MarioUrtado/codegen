xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1 = "http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../XSD/ESO/Error_v1_ESO.xsd" ::)

declare variable $faultCode as xs:string external;
declare variable $canonicalError as element() (:: schema-element(ns1:CanonicalError) ::) external;
declare variable $faultDetails as element() external;

declare function local:get_SOAP11Fault_Simple($faultCode as xs:string, 
                                       $canonicalError as element() (:: schema-element(ns1:CanonicalError) ::),
                                       $faultDetails as element()) as element(*) {
                                       
      <env:Fault xmlns:env="http://schemas.xmlsoap.org/wsdl/soap/">
		<env:faultcode>env:{$faultCode}</env:faultcode>
		<env:faultstring>{concat($canonicalError/@code," - ",$canonicalError/@description)}</env:faultstring>
		<env:detail>
			{$faultDetails}
		</env:detail>    
      </env:Fault>
};

local:get_SOAP11Fault_Simple($faultCode, $canonicalError, $faultDetails)
