xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns0 = "http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)
declare namespace ns1 = "http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare variable $header as element() external;
declare variable $conversationID as xs:string? external;
declare variable $serviceCode as xs:string? external;
declare variable $serviceName as xs:string? external;
declare variable $serviceOperation as xs:string? external;

declare function local:getRequestHeaderStamp($header as element(), 
                                      $conversationID as xs:string?,
                                      $serviceCode as xs:string?,
                                      $serviceName as xs:string?,
                                      $serviceOperation as xs:string?) 
                                      as element() {
    
        <ns0:RequestHeader>
            {$header/*[1]}
            <ns0:Trace clientReqTimestamp = "{ fn:data($header/*[2]/@clientReqTimestamp) }"
                       reqTimestamp = "{ fn:current-dateTime() }"
                       processID = "{ fn:data($header/*[2]/@processID)}"
                       eventID = "{ fn:data($header/*[2]/@eventID) }" 
                       sourceID = "{ fn:data($header/*[2]/@sourceID) }" 
                       correlationEventID = "{ fn:data($header/*[2]/@correlationEventID) }"
                       conversationID = "{ $conversationID  }"
                       correlationID = "{ fn:data($header/*[2]/@correlationID) }">
                  <ns0:Service 
                    code = "{ $serviceCode }" 
                    name = "{ $serviceName }"
                    operation = "{ $serviceOperation }"/>
                </ns0:Trace>
            {
            if (fn:exists($header/*[3])) then
                  $header/*[3]
            else(
                  <ns0:Channel name = "UNK">
                  </ns0:Channel>
                )
            }
        </ns0:RequestHeader>

};

local:getRequestHeaderStamp($header, $conversationID, $serviceCode, $serviceName, $serviceOperation)
