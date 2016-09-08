xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ConversationManager/publishResult/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/publishResult_ConversationManager_v1_CSM.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getConsumerCallbackURLAdapter";
(:: import schema at "../JCA/getConsumerCallbackURL/getConsumerCallbackURLAdapter_sp.xsd" ::)

declare variable $PublishResultREQ as element() (:: schema-element(ns1:PublishResultREQ) ::) external;

declare function local:get_GetConsumerCallbackURLREQ($PublishResultREQ as element() (:: schema-element(ns1:PublishResultREQ) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_SYSTEM_CODE>{fn:data($PublishResultREQ/ns1:Consumer/@sysCode)}</ns2:P_SYSTEM_CODE>
        <ns2:P_COUNTRY_CODE>{fn:data($PublishResultREQ/ns1:Consumer/@countryCode)}</ns2:P_COUNTRY_CODE>
        <ns2:P_ENTERPRISE_CODE>{fn:data($PublishResultREQ/ns1:Consumer/@enterpriseCode)}</ns2:P_ENTERPRISE_CODE>
        {
          if (fn:exists($PublishResultREQ/ns1:Service))
          then <ns2:P_SERVICE_CODE>{fn:data($PublishResultREQ/ns1:Service/@code)}</ns2:P_SERVICE_CODE>
          else(<ns2:P_SERVICE_CODE>{fn:data($PublishResultREQ/ns1:CallbackMessage/*[1]/*[1]/*[2]/*[1]/@code)}</ns2:P_SERVICE_CODE>)
        }
        
        {
          if (fn:exists($PublishResultREQ/ns1:Service))
          then <ns2:P_CAPABILITY_NAME>{fn:data($PublishResultREQ/ns1:Service/@operation)}</ns2:P_CAPABILITY_NAME>
          else(<ns2:P_CAPABILITY_NAME>{fn:data($PublishResultREQ/ns1:CallbackMessage/*[1]/*[1]/*[2]/*[1]/@operation)}</ns2:P_CAPABILITY_NAME>)
        }
    </ns2:InputParameters>
};

local:get_GetConsumerCallbackURLREQ($PublishResultREQ)
