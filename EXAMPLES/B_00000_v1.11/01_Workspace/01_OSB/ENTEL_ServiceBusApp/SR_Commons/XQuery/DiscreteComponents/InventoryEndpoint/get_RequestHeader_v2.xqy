xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare variable $RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::) external;
declare variable $ServiceCode as xs:string external;
declare variable $ServiceName as xs:string external;
declare variable $ServiceOperation as xs:string external;

declare function local:get_RequestHeader_v2($RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::), 
                            $ServiceCode as xs:string, 
                            $ServiceName as xs:string, 
                            $ServiceOperation as xs:string) 
                            as element() (:: schema-element(ns1:RequestHeader) ::) {
    <ns1:RequestHeader>
       {$RequestHeader/*[1]}       
        <ns1:Trace clientReqTimestamp="{fn:data($RequestHeader/*[2]/@clientReqTimestamp)}"
                         reqTimestamp="{fn:current-dateTime()}"
                            processID="{fn:data($RequestHeader/*[2]/@processID)}" 
                              eventID="{fn:data($RequestHeader/*[2]/@eventID)}" 
                             sourceID="{fn:data($RequestHeader/*[2]/@sourceID)}">
            <ns1:Service code="{fn:data($ServiceCode)}" 
                         name="{fn:data($ServiceName)}"
                    operation="{fn:data($ServiceOperation)}">
            </ns1:Service>
        </ns1:Trace>
         {$RequestHeader/*[3]}       
    </ns1:RequestHeader>
};

local:get_RequestHeader_v2($RequestHeader, $ServiceCode, $ServiceName, $ServiceOperation)
