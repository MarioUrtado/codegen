xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/EBM/Consumer/del/JSON/v1";
(:: import schema at "../../../../../ESC/Secondary/del_Consumer_JSON_v1_EBM.xsd" ::)
declare namespace ns2="http://www.entel.cl/EBM/Consumer/del/v1";
(:: import schema at "../../../../../ESC/Primary/del_Consumer_v1_EBM.xsd" ::)

declare namespace ns5 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns3 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace ns6 = "http://www.entel.cl/EBO/Consumer/v1";

declare namespace ns7 = "http://www.entel.cl/ESO/MessageHeaderJSON/v1";

declare variable $delConsumerReq as element() (:: schema-element(ns1:Del_Consumer_REQ) ::) external;

declare function local:func($delConsumerReq as element() (:: schema-element(ns1:Del_Consumer_REQ) ::)) as element() (:: schema-element(ns2:Del_Consumer_REQ) ::) {
    <ns2:Del_Consumer_REQ>
        <ns3:RequestHeader>
            <ns3:Consumer sysCode="{fn:data($delConsumerReq/ns7:RequestHeader/ns7:Consumer/ns7:sysCode)}" enterpriseCode="{fn:data($delConsumerReq/ns7:RequestHeader/ns7:Consumer/ns7:enterpriseCode)}"
                countryCode="{fn:data($delConsumerReq/ns7:RequestHeader/ns7:Consumer/ns7:countryCode)}">
            </ns3:Consumer>
            <ns3:Trace clientReqTimestamp="{fn:data($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:clientReqTimestamp)}" eventID="{fn:data($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:eventID)}">
                {
                    if ($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:reqTimestamp)
                    then attribute reqTimestamp {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:reqTimestamp)}
                    else ()
                }
                {
                    if ($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:rspTimestamp)
                    then attribute rspTimestamp {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:rspTimestamp)}
                    else ()
                }
                {
                    if ($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:processID)
                    then attribute processID {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:processID)}
                    else ()
                }
                {
                    if ($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:sourceID)
                    then attribute sourceID {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:sourceID)}
                    else ()
                }
                {
                    if ($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:correlationEventID)
                    then attribute correlationEventID {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:correlationEventID)}
                    else ()
                }
                {
                    if ($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:conversationID)
                    then attribute conversationID {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:conversationID)}
                    else ()
                }
                {
                    if ($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:correlationID)
                    then attribute correlationID {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:correlationID)}
                    else ()
                }
                {
                    if ($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service)
                    then <ns3:Service>
                        {
                            if ($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:code)
                            then attribute code {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:code)}
                            else ()
                        }
                        {
                            if ($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:name)
                            then attribute name {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:name)}
                            else ()
                        }
                        {
                            if ($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:operation)
                            then attribute operation {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:operation)}
                            else ()
                        }</ns3:Service>
                    else ()
                }
            </ns3:Trace>
            {
                if ($delConsumerReq/ns7:RequestHeader/ns7:Channel)
                then <ns3:Channel>
                    {
                        if ($delConsumerReq/ns7:RequestHeader/ns7:Channel/ns7:name)
                        then attribute name {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Channel/ns7:name)}
                        else ()
                    }
                    {
                        if ($delConsumerReq/ns7:RequestHeader/ns7:Channel/ns7:mode)
                        then attribute mode {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Channel/ns7:mode)}
                        else ()
                    }</ns3:Channel>
                else ()
            }
            {
                if ($delConsumerReq/ns7:RequestHeader/ns7:Result)
                then <ns4:Result status="{fn:data($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:status)}">
                    {
                        if ($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:description)
                        then attribute description {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:description)}
                        else ()
                    }
                    {
                        if ($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError)
                        then <ns5:CanonicalError>
                            {
                                if ($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:code)
                                then attribute code {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:code)}
                                else ()
                            }
                            {
                                if ($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:description)
                                then attribute description {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:description)}
                                else ()
                            }
                            {
                                if ($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:type)
                                then attribute type {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:type)}
                                else ()
                            }</ns5:CanonicalError>
                        else ()
                    }
                    {
                        if ($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError)
                        then <ns5:SourceError>
                            {
                                if ($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:code)
                                then attribute code {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:code)}
                                else ()
                            }
                            {
                                if ($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:description)
                                then attribute description {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:description)}
                                else ()
                            }
                            <ns5:ErrorSourceDetails>
                                {
                                    if ($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:ErrorSourceDetails/ns7:source)
                                    then attribute source {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:ErrorSourceDetails/ns7:source)}
                                    else ()
                                }
                                {
                                    if ($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:ErrorSourceDetails/ns7:details)
                                    then attribute details {fn:data($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:ErrorSourceDetails/ns7:details)}
                                    else ()
                                }
                            </ns5:ErrorSourceDetails>
                            <ns5:SourceFault>{fn-bea:serialize($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:SourceFault)}</ns5:SourceFault></ns5:SourceError>
                        else ()
                    }
                    {
                        if ($delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CorrelativeErrors)
                        then <ns4:CorrelativeErrors>
                            {
                                for $SourceError in $delConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CorrelativeErrors/ns7:SourceError
                                return 
                                <ns5:SourceError>
                                    {
                                        if ($SourceError/ns7:code)
                                        then attribute code {fn:data($SourceError/ns7:code)}
                                        else ()
                                    }
                                    {
                                        if ($SourceError/ns7:description)
                                        then attribute description {fn:data($SourceError/ns7:description)}
                                        else ()
                                    }
                                    <ns5:ErrorSourceDetails>
                                        {
                                            if ($SourceError/ns7:ErrorSourceDetails/ns7:source)
                                            then attribute source {fn:data($SourceError/ns7:ErrorSourceDetails/ns7:source)}
                                            else ()
                                        }
                                        {
                                            if ($SourceError/ns7:ErrorSourceDetails/ns7:details)
                                            then attribute details {fn:data($SourceError/ns7:ErrorSourceDetails/ns7:details)}
                                            else ()
                                        }
                                    </ns5:ErrorSourceDetails>
                                    <ns5:SourceFault>{fn-bea:serialize($SourceError/ns7:SourceFault)}</ns5:SourceFault></ns5:SourceError>
                            }</ns4:CorrelativeErrors>
                        else ()
                    }</ns4:Result>
                else ()
            }
        </ns3:RequestHeader>
        <ns2:Body>
            <ns6:ConsumerID>{fn:data($delConsumerReq/ns1:Body/ns1:ConsumerID)}</ns6:ConsumerID>
        </ns2:Body>
    </ns2:Del_Consumer_REQ>
};

local:func($delConsumerReq)
