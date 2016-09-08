xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1 = "http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../XSD/ESO/Error_v1_ESO.xsd" ::)

declare variable $faultCode as xs:string external;
declare variable $canonicalError as element() (:: schema-element(ns1:CanonicalError) ::) external;
declare variable $faultDetails as element() external;

declare function local:get_SOAP12Fault($faultCode as xs:string, 
                                       $canonicalError as element() (:: schema-element(ns1:CanonicalError) ::),
                                       $faultDetails as element()) as element(*) {
                                       
      <env:Fault xmlns:env="http://www.w3.org/2003/05/soap-envelope">
       <env:Code>
         <env:Value>env:{$faultCode}</env:Value>
       </env:Code>
       <env:Reason>
         <env:Text xml:lang="es">{concat($canonicalError/@code," - ",$canonicalError/@description)}</env:Text>
       </env:Reason>
       <env:Detail>
         {$faultDetails}
       </env:Detail>    
      </env:Fault>
};

local:get_SOAP12Fault($faultCode, $canonicalError, $faultDetails)
