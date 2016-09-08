xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/MessageManager/checkIN/v1";

declare namespace ns2 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare variable $serviceCode as xs:string external;
declare variable $serviceName as xs:string external;
declare variable $serviceOperation as xs:string external;
declare variable $serviceMessage as element() external;

declare function local:get_checkINREQ($serviceCode as xs:string, 
                                      $servicveName as xs:string, 
                                      $serviceOperation as xs:string, 
                                      $serviceMessage as element()) 
                                      as element() {
    <ns1:checkINREQ>
      <ns2:Service code="{$serviceCode}" name="{$servicveName}" operation="{$serviceOperation}"/>
      <ns1:Message>{$serviceMessage}</ns1:Message>
    </ns1:checkINREQ>
};

local:get_checkINREQ($serviceCode, $serviceName, $serviceOperation, $serviceMessage)
