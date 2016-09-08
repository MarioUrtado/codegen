xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/EBM/Consumer/get/v1";
(:: import schema at "../../../../../ESC/Primary/get_Consumer_v1_EBM.xsd" ::)

declare namespace ns2 = "http://www.entel.cl/EBO/Consumer/v1";

declare namespace ns5 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns3 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace ns6 = "http://www.entel.cl/EBM/Consumer/get/JSON/v1";
(:: import schema at "../../../../../ESC/Secondary/get_Consumer_JSON_v1_EBM.xsd" ::)

declare namespace ns7 = "http://www.entel.cl/ESO/MessageHeaderJSON/v1";


declare variable $getConsumerReq as element() (:: schema-element(ns6:Get_Consumer_REQ) ::) external;

declare function local:func($getConsumerReq as element() (:: schema-element(ns6:Get_Consumer_REQ) ::)
                            ) 
                            as element() (:: schema-element(ns1:Get_Consumer_REQ) ::) {
    <ns1:Get_Consumer_REQ>
       
        <ns3:RequestHeader>
            <ns3:Consumer sysCode="{fn:data($getConsumerReq/ns7:RequestHeader/ns7:Consumer/ns7:sysCode)}" enterpriseCode="{fn:data($getConsumerReq/ns7:RequestHeader/ns7:Consumer/ns7:enterpriseCode)}"
                countryCode="{fn:data($getConsumerReq/ns7:RequestHeader/ns7:Consumer/ns7:countryCode)}">
            </ns3:Consumer>
            <ns3:Trace clientReqTimestamp="{fn:data($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:clientReqTimestamp)}" eventID="{fn:data($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:eventID)}">
                {
                    if ($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:reqTimestamp)
                    then attribute reqTimestamp {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:reqTimestamp)}
                    else ()
                }
                {
                    if ($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:rspTimestamp)
                    then attribute rspTimestamp {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:rspTimestamp)}
                    else ()
                }
                {
                    if ($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:processID)
                    then attribute processID {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:processID)}
                    else ()
                }
                {
                    if ($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:sourceID)
                    then attribute sourceID {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:sourceID)}
                    else ()
                }
                {
                    if ($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:correlationEventID)
                    then attribute correlationEventID {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:correlationEventID)}
                    else ()
                }
                {
                    if ($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:conversationID)
                    then attribute conversationID {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:conversationID)}
                    else ()
                }
                {
                    if ($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:correlationID)
                    then attribute correlationID {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:correlationID)}
                    else ()
                }
                {
                    if ($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service)
                    then <ns3:Service>
                        {
                            if ($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:code)
                            then attribute code {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:code)}
                            else ()
                        }
                        {
                            if ($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:name)
                            then attribute name {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:name)}
                            else ()
                        }
                        {
                            if ($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:operation)
                            then attribute operation {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Trace/ns7:Service/ns7:operation)}
                            else ()
                        }</ns3:Service>
                    else ()
                }
            </ns3:Trace>
            {
                if ($getConsumerReq/ns7:RequestHeader/ns7:Channel)
                then <ns3:Channel>
                    {
                        if ($getConsumerReq/ns7:RequestHeader/ns7:Channel/ns7:name)
                        then attribute name {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Channel/ns7:name)}
                        else ()
                    }
                    {
                        if ($getConsumerReq/ns7:RequestHeader/ns7:Channel/ns7:mode)
                        then attribute mode {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Channel/ns7:mode)}
                        else ()
                    }</ns3:Channel>
                else ()
            }
            {
                if ($getConsumerReq/ns7:RequestHeader/ns7:Result)
                then <ns4:Result status="{fn:data($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:status)}">
                    {
                        if ($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:description)
                        then attribute description {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:description)}
                        else ()
                    }
                    {
                        if ($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError)
                        then <ns5:CanonicalError>
                            {
                                if ($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:code)
                                then attribute code {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:code)}
                                else ()
                            }
                            {
                                if ($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:description)
                                then attribute description {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:description)}
                                else ()
                            }
                            {
                                if ($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:type)
                                then attribute type {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CanonicalError/ns7:type)}
                                else ()
                            }</ns5:CanonicalError>
                        else ()
                    }
                    {
                        if ($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError)
                        then <ns5:SourceError>
                            {
                                if ($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:code)
                                then attribute code {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:code)}
                                else ()
                            }
                            {
                                if ($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:description)
                                then attribute description {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:description)}
                                else ()
                            }
                            <ns5:ErrorSourceDetails>
                                {
                                    if ($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:ErrorSourceDetails/ns7:source)
                                    then attribute source {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:ErrorSourceDetails/ns7:source)}
                                    else ()
                                }
                                {
                                    if ($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:ErrorSourceDetails/ns7:details)
                                    then attribute details {fn:data($getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:SourceError/ns7:ErrorSourceDetails/ns7:details)}
                                    else ()
                                }
                                </ns5:ErrorSourceDetails></ns5:SourceError>
                        else ()
                    }
                    <ns4:CorrelativeErrors>
                        {
                            for $SourceError in $getConsumerReq/ns7:RequestHeader/ns7:Result/ns7:CorrelativeErrors/ns7:SourceError
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
                                <ns5:SourceFault></ns5:SourceFault>
                            </ns5:SourceError>
                        }
                    </ns4:CorrelativeErrors></ns4:Result>
                else ()
            }
        </ns3:RequestHeader>
        <ns1:Body>
            <ns2:ConsumerID>{fn:data($getConsumerReq/ns6:Body/ns6:ConsumerID)}</ns2:ConsumerID>
        </ns1:Body>
    </ns1:Get_Consumer_REQ>
};

local:func($getConsumerReq)
