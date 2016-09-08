xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/EBM/Consumer/upd/JSON/v1";
(:: import schema at "../../../../../ESC/Secondary/upd_Consumer_JSON_v1_EBM.xsd" ::)
declare namespace ns2="http://www.entel.cl/EBM/Consumer/upd/v1";
(:: import schema at "../../../../../ESC/Primary/upd_Consumer_v1_EBM.xsd" ::)

declare namespace ns5 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns3 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace ns6 = "http://www.entel.cl/EBO/Consumer/v1";

declare namespace ns7 = "http://www.entel.cl/ESO/MessageHeaderJSON/v1";

declare variable $UpdConsumerREQ as element() (:: schema-element(ns1:Upd_Consumer_REQ) ::) external;

declare function local:func($UpdConsumerREQ as element() (:: schema-element(ns1:Upd_Consumer_REQ) ::)) as element() (:: schema-element(ns2:Upd_Consumer_REQ) ::) {
    <ns2:Upd_Consumer_REQ>
        <ns3:RequestHeader>
            <ns3:Consumer sysCode="{fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Consumer/ns7:sysCode)}" enterpriseCode="{fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Consumer/ns7:enterpriseCode)}"
                countryCode="{fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Consumer/ns7:countryCode)}">
            </ns3:Consumer>
            <ns3:Trace clientReqTimestamp="{fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:clientReqTimestamp)}" eventID="{fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:eventID)}">
                {
                    if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:reqTimestamp)
                    then attribute reqTimestamp {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:reqTimestamp)}
                    else ()
                }
                {
                    if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:rspTimestamp)
                    then attribute rspTimestamp {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:rspTimestamp)}
                    else ()
                }
                {
                    if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:processID)
                    then attribute processID {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:processID)}
                    else ()
                }
                {
                    if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:sourceID)
                    then attribute sourceID {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:sourceID)}
                    else ()
                }
                {
                    if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:correlationEventID)
                    then attribute correlationEventID {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:correlationEventID)}
                    else ()
                }
                {
                    if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:conversationID)
                    then attribute conversationID {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:conversationID)}
                    else ()
                }
                {
                    if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:correlationID)
                    then attribute correlationID {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:correlationID)}
                    else ()
                }
                {
                    if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:Service)
                    then <ns3:Service>
                        {
                            if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:code)
                            then attribute code {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:code)}
                            else ()
                        }
                        {
                            if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:name)
                            then attribute name {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:name)}
                            else ()
                        }
                        {
                            if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:operation)
                            then attribute operation {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:operation)}
                            else ()
                        }</ns3:Service>
                    else ()
                }
            </ns3:Trace>
            {
                if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Channel)
                then <ns3:Channel>
                    {
                        if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Channel/ns7:name)
                        then attribute name {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Channel/ns7:name)}
                        else ()
                    }
                    {
                        if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Channel/ns7:mode)
                        then attribute mode {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Channel/ns7:mode)}
                        else ()
                    }</ns3:Channel>
                else ()
            }
            {
                if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Result)
                then <ns4:Result status="{fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:status)}">
                    {
                        if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:description)
                        then attribute description {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:description)}
                        else ()
                    }
                    <ns5:CanonicalError>
                        {
                            if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:code)
                            then attribute code {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:code)}
                            else ()
                        }
                        {
                            if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:description)
                            then attribute description {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:description)}
                            else ()
                        }
                        {
                            if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:type)
                            then attribute type {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:type)}
                            else ()
                        }
                    </ns5:CanonicalError>
                    <ns5:SourceError>
                        {
                            if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:code)
                            then attribute code {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:code)}
                            else ()
                        }
                        {
                            if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:description)
                            then attribute description {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:description)}
                            else ()
                        }
                        <ns5:ErrorSourceDetails>
                            {
                                if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:ErrorSourceDetails/ns7:source)
                                then attribute source {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:ErrorSourceDetails/ns7:source)}
                                else ()
                            }
                            {
                                if ($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:ErrorSourceDetails/ns7:details)
                                then attribute details {fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:ErrorSourceDetails/ns7:details)}
                                else ()
                            }
                        </ns5:ErrorSourceDetails>
                        <ns5:SourceFault>{fn:data($UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:SourceFault)}</ns5:SourceFault>
                    </ns5:SourceError>
                    <ns4:CorrelativeErrors>
                        {
                            for $SourceError in $UpdConsumerREQ/ns7:RequestHeader/ns7:Result/ns7:CorrelativeErrors/ns7:SourceError
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
                                <ns5:SourceFault>{fn:data($SourceError/ns7:SourceFault)}</ns5:SourceFault></ns5:SourceError>
                        }
                    </ns4:CorrelativeErrors></ns4:Result>
                else ()
            }
        </ns3:RequestHeader>
        <ns2:Body>
            <ns6:ConsumerID>{fn:data($UpdConsumerREQ/ns1:Body/ns1:ConsumerID)}</ns6:ConsumerID>
            <ns6:Consumer>
                <ns6:ConsumerName>{fn:data($UpdConsumerREQ/ns1:Body/ns1:Consumer/ns1:ConsumerName)}</ns6:ConsumerName>
                <ns6:ConsumerSurename>{fn:data($UpdConsumerREQ/ns1:Body/ns1:Consumer/ns1:ConsumerSurename)}</ns6:ConsumerSurename>
                <ns6:ConsumerAge>{fn:data($UpdConsumerREQ/ns1:Body/ns1:Consumer/ns1:ConsumerAge)}</ns6:ConsumerAge>
                <ns6:ConsumerStatus>{fn:data($UpdConsumerREQ/ns1:Body/ns1:Consumer/ns1:ConsumerStatus)}</ns6:ConsumerStatus>
            </ns6:Consumer>
        </ns2:Body>
    </ns2:Upd_Consumer_REQ>
};

local:func($UpdConsumerREQ)
