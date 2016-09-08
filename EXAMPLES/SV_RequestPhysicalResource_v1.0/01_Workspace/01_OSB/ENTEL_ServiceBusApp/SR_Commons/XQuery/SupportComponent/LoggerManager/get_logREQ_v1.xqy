xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns2="http://www.entel.cl/SC/LoggerManager/log/v1";

declare namespace ns3="http://www.entel.cl/ESO/Tracer/v1";
(:: import schema at "../../../XSD/ESO/Tracer_v1_ESO.xsd" ::)

declare variable $Component as xs:string external;
declare variable $Operation as xs:string external;
declare variable $Header as element() (:: schema-element(ns1:RequestHeader) ::) external;
declare variable $Message as element() external;
declare variable $Description as xs:string external;
declare variable $LogPlaceHolder_Time as xs:dateTime external;
declare variable $LogPlaceHolder_Place as xs:string external;
declare variable $LogMode_Type as xs:string external;
declare variable $LogSeverity as xs:string external;

declare function local:get_logREQ($Component as xs:string, $Operation as xs:string,
                                  $Header as element() (:: schema-element(ns1:RequestHeader) ::), 
                                  $Message as element(), 
                                  $Description as xs:string, 
                                  $LogPlaceHolder_Time as xs:dateTime, 
                                  $LogPlaceHolder_Place as xs:string, 
                                  $LogMode_Type as xs:string, 
                                  $LogSeverity as xs:string) 
                                  as element(ns2:LogREQ) {
 <ns2:LogREQ>
    <ns3:HeaderTracer component="{$Component}" operation="{$Operation}">
        <ns3:Header>
            <ns1:Consumer sysCode="{fn:data($Header/*:Consumer[1]/@sysCode)}" enterpriseCode="{fn:data($Header/*:Consumer[1]/@enterpriseCode)}" countryCode="{fn:data($Header/*:Consumer/@countryCode)}"/>
            <ns1:Trace>
                {
                    if ($Header/ns1:Trace/@clientReqTimestamp)
                    then attribute clientReqTimestamp {fn:data($Header/ns1:Trace/@clientReqTimestamp)}
                    else ()
                }
                {
                    if ($Header/ns1:Trace/@reqTimestamp)
                    then attribute reqTimestamp {fn:data($Header/ns1:Trace/@reqTimestamp)}
                    else ()
                }
                {
                    if ($Header/ns1:Trace/@rspTimestamp)
                    then attribute rspTimestamp {fn:data($Header/ns1:Trace/@rspTimestamp)}
                    else ()
                }
                {
                    if ($Header/ns1:Trace/@processID)
                    then attribute processID {fn:data($Header/ns1:Trace/@processID)}
                    else ()
                }
                {
                    if ($Header/ns1:Trace/@eventID)
                    then attribute eventID {fn:data($Header/ns1:Trace/@eventID)}
                    else ()
                }
                {
                    if ($Header/ns1:Trace/@sourceID)
                    then attribute sourceID {fn:data($Header/ns1:Trace/@sourceID)}
                    else ()
                }
                {
                    if ($Header/ns1:Trace/@correlationEventID)
                    then attribute correlationEventID {fn:data($Header/ns1:Trace/@correlationEventID)}
                    else ()
                }
                {
                    if ($Header/ns1:Trace/@conversationID)
                    then attribute conversationID {fn:data($Header/ns1:Trace/@conversationID)}
                    else ()
                }
                {
                    if ($Header/ns1:Trace/@correlationID)
                    then attribute correlationID {fn:data($Header/ns1:Trace/@correlationID)}
                    else ()
                }
                {
                    if ($Header/ns1:Trace/ns1:Service)
                    then 
                        <ns1:Service>
                            {
                                if ($Header/ns1:Trace/ns1:Service/@code)
                                then attribute code {fn:data($Header/ns1:Trace/ns1:Service/@code)}
                                else ()
                            }
                            {
                                if ($Header/ns1:Trace/ns1:Service/@name)
                                then attribute name {fn:data($Header/ns1:Trace/ns1:Service/@name)}
                                else ()
                            }
                            {
                                if ($Header/ns1:Trace/ns1:Service/@operation)
                                then attribute operation {fn:data($Header/ns1:Trace/ns1:Service/@operation)}
                                else ()
                            }
                        </ns1:Service>
                    else ()
                }
            </ns1:Trace>
            {
                if ($Header/ns1:Channel)
                then 
                    <ns1:Channel>
                        {
                            if ($Header/ns1:Channel/@name)
                            then attribute name {fn:data($Header/ns1:Channel/@name)}
                            else ()
                        }
                        {
                            if ($Header/ns1:Channel/@mode)
                            then attribute mode {fn:data($Header/ns1:Channel/@mode)}
                            else ()
                        }
                    </ns1:Channel>
                else ()
            }
        </ns3:Header>
    </ns3:HeaderTracer>
    <ns2:Message>{$Message}</ns2:Message>
    <ns2:Description>{$Description}</ns2:Description>
    <ns2:LogPlaceholder time="{$LogPlaceHolder_Time}" place="{$LogPlaceHolder_Place}"/>
    <ns2:LogMode logType="{$LogMode_Type}" logSeverity="{$LogSeverity}"/>
  </ns2:LogREQ>
};

local:get_logREQ($Component, $Operation, $Header, $Message, $Description, $LogPlaceHolder_Time, $LogPlaceHolder_Place, $LogMode_Type, $LogSeverity)
