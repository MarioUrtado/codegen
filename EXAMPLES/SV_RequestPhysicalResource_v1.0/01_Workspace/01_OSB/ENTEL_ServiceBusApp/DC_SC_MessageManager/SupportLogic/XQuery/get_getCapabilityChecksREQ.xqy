xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getCapabilityChecks";
(:: import schema at "../JCA/getCapabilityChecks/getCapabilityChecks_sp.xsd" ::)

declare variable $service_code as xs:string external;
declare variable $service_name as xs:string external;
declare variable $service_operation as xs:string external;

declare function local:getCapabilityChecksREQ($service_code as xs:string, 
                                              $service_name as xs:string, 
                                              $service_operation as xs:string) 
                                              as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:P_SERVICE_CODE>{fn:data($service_code)}</ns1:P_SERVICE_CODE>
        <ns1:P_SERVICE_NAME>{fn:data($service_name)}</ns1:P_SERVICE_NAME>
        <ns1:P_SERVICE_OPERATION>{fn:data($service_operation)}</ns1:P_SERVICE_OPERATION>
    </ns1:InputParameters>
};

local:getCapabilityChecksREQ($service_code, $service_name, $service_operation)
