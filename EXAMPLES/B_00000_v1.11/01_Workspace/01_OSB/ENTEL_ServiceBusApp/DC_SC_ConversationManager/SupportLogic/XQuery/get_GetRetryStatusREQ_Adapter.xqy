xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns2="http://www.entel.cl/SC/ErrorManager/RetryManager/getRetryStatus/v1";
(:: import schema at "../../../DC_SC_ErrorManager/SupportAPI/XSD/CSM/getRetryStatus_RetryManager_v1_CSM.xsd" ::)

declare variable $Trace as element() (:: schema-element(ns1:Trace) ::) external;

declare function local:get_GetRetryStatusREQ_Adapter($Trace as element() (:: schema-element(ns1:Trace) ::)) as element() (:: schema-element(ns2:GetRetryStatus_REQ) ::) {
        <ns2:GetRetryStatus_REQ>
            <ns1:Trace clientReqTimestamp="{fn:data($Trace/@clientReqTimestamp)}" eventID="{fn:data($Trace/@eventID)}">
                {
                    if ($Trace/@reqTimestamp)
                    then attribute reqTimestamp {fn:data($Trace/@reqTimestamp)}
                    else ()
                }
                {
                    if ($Trace/@rspTimestamp)
                    then attribute rspTimestamp {fn:data($Trace/@rspTimestamp)}
                    else ()
                }
                {
                    if ($Trace/@processID)
                    then attribute processID {fn:data($Trace/@processID)}
                    else ()
                }
                {
                    if ($Trace/@sourceID)
                    then attribute sourceID {fn:data($Trace/@sourceID)}
                    else ()
                }
                {
                    if ($Trace/@correlationEventID)
                    then attribute correlationEventID {fn:data($Trace/@correlationEventID)}
                    else ()
                }
                {
                    if ($Trace/@conversationID)
                    then attribute conversationID {fn:data($Trace/@conversationID)}
                    else ()
                }
                {
                    if ($Trace/@correlationID)
                    then attribute correlationID {fn:data($Trace/@correlationID)}
                    else ()
                }
                {
                    if ($Trace/ns1:Service)
                    then 
                        <ns1:Service>
                            {
                                if ($Trace/ns1:Service/@code)
                                then attribute code {fn:data($Trace/ns1:Service/@code)}
                                else ()
                            }
                            {
                                if ($Trace/ns1:Service/@name)
                                then attribute name {fn:data($Trace/ns1:Service/@name)}
                                else ()
                            }
                            {
                                if ($Trace/ns1:Service/@operation)
                                then attribute operation {fn:data($Trace/ns1:Service/@operation)}
                                else ()
                            }
                        </ns1:Service>
                    else ()
                }
            </ns1:Trace>
        </ns2:GetRetryStatus_REQ>
};

local:get_GetRetryStatusREQ_Adapter($Trace)
