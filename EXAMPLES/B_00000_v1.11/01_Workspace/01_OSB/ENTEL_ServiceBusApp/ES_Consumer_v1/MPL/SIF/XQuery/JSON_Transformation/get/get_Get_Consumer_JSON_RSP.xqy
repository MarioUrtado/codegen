xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/EBM/Consumer/get/JSON/v1";
(:: import schema at "../../../../../ESC/Secondary/get_Consumer_JSON_v1_EBM.xsd" ::)
declare namespace ns1="http://www.entel.cl/EBM/Consumer/get/v1";
(:: import schema at "../../../../../ESC/Primary/get_Consumer_v1_EBM.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/EBO/Consumer/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace ns5 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns6 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns7 = "http://www.entel.cl/ESO/MessageHeaderJSON/v1";

declare variable $Get_Consumer_RSP as element() (:: schema-element(ns1:Get_Consumer_RSP) ::) external;

declare function local:func($Get_Consumer_RSP as element() (:: schema-element(ns1:Get_Consumer_RSP) ::)) as element() (:: schema-element(ns2:Get_Consumer_RSP) ::) {
    <ns2:Get_Consumer_RSP>
        <ns7:ResponseHeader>
            <ns7:Consumer>
                <ns7:sysCode>{fn:data($Get_Consumer_RSP/*[1]/*[1]/@sysCode)}</ns7:sysCode>
                <ns7:enterpriseCode>{fn:data($Get_Consumer_RSP/*[1]/*[1]/@enterpriseCode)}</ns7:enterpriseCode>
                <ns7:countryCode>{fn:data($Get_Consumer_RSP/*[1]/*[1]/@countryCode)}</ns7:countryCode>
            </ns7:Consumer>
            <ns7:Trace>
                <ns7:clientReqTimestamp>{fn:data($Get_Consumer_RSP/*[1]/*[2]/@clientReqTimestamp)}</ns7:clientReqTimestamp>
                {
                    if ($Get_Consumer_RSP/*[1]/*[2]/@reqTimestamp)
                    then <ns7:reqTimestamp>{fn:data($Get_Consumer_RSP/*[1]/*[2]/@reqTimestamp)}</ns7:reqTimestamp>
                    else ()
                }
                {
                    if ($Get_Consumer_RSP/*[1]/*[2]/@rspTimestamp)
                    then <ns7:rspTimestamp>{fn:data($Get_Consumer_RSP/*[1]/*[2]/@rspTimestamp)}</ns7:rspTimestamp>
                    else ()
                }
                {
                    if ($Get_Consumer_RSP/*[1]/*[2]/@processID)
                    then <ns7:processID>{fn:data($Get_Consumer_RSP/*[1]/*[2]/@processID)}</ns7:processID>
                    else ()
                }
                <ns7:eventID>{fn:data($Get_Consumer_RSP/*[1]/*[2]/@eventID)}</ns7:eventID>
                {
                    if ($Get_Consumer_RSP/*[1]/*[2]/@sourceID)
                    then <ns7:sourceID>{fn:data($Get_Consumer_RSP/*[1]/*[2]/@sourceID)}</ns7:sourceID>
                    else ()
                }
                {
                    if ($Get_Consumer_RSP/*[1]/*[2]/@correlationEventID)
                    then <ns7:correlationEventID>{fn:data($Get_Consumer_RSP/*[1]/*[2]/@correlationEventID)}</ns7:correlationEventID>
                    else ()
                }
                {
                    if ($Get_Consumer_RSP/*[1]/*[2]/@conversationID)
                    then <ns7:conversationID>{fn:data($Get_Consumer_RSP/*[1]/*[2]/@conversationID)}</ns7:conversationID>
                    else ()
                }
                {
                    if ($Get_Consumer_RSP/*[1]/*[2]/@correlationID)
                    then <ns7:correlationID>{fn:data($Get_Consumer_RSP/*[1]/*[2]/@correlationID)}</ns7:correlationID>
                    else ()
                }
                {
                    if ($Get_Consumer_RSP/*[1]/*[2]/ns4:Service)
                    then <ns7:Service>
                        {
                            if ($Get_Consumer_RSP/*[1]/*[2]/ns4:Service/@code)
                            then <ns7:code>{fn:data($Get_Consumer_RSP/*[1]/*[2]/ns4:Service/@code)}</ns7:code>
                            else ()
                        }
                        {
                            if ($Get_Consumer_RSP/*[1]/*[2]/ns4:Service/@name)
                            then <ns7:name>{fn:data($Get_Consumer_RSP/*[1]/*[2]/ns4:Service/@name)}</ns7:name>
                            else ()
                        }
                        {
                            if ($Get_Consumer_RSP/*[1]/*[2]/ns4:Service/@operation)
                            then <ns7:operation>{fn:data($Get_Consumer_RSP/*[1]/*[2]/ns4:Service/@operation)}</ns7:operation>
                            else ()
                        }</ns7:Service>
                    else ()
                }
            </ns7:Trace>
            {
                if ($Get_Consumer_RSP/*[1]/ns4:Channel)
                then <ns7:Channel>
                    {
                        if ($Get_Consumer_RSP/*[1]/ns4:Channel/@name)
                        then <ns7:name>{fn:data($Get_Consumer_RSP/*[1]/ns4:Channel/@name)}</ns7:name>
                        else ()
                    }
                    {
                        if ($Get_Consumer_RSP/*[1]/ns4:Channel/@mode)
                        then <ns7:mode>{fn:data($Get_Consumer_RSP/*[1]/ns4:Channel/@mode)}</ns7:mode>
                        else ()
                    }</ns7:Channel>
                else ()
            }
            <ns7:Result>
                <ns7:status>{fn:data($Get_Consumer_RSP/*[1]/ns5:Result/@status)}</ns7:status>
                {
                    if ($Get_Consumer_RSP/*[1]/ns5:Result/@description)
                    then <ns7:description>{fn:data($Get_Consumer_RSP/*[1]/ns5:Result/@description)}</ns7:description>
                    else ()
                }
                {
                    if ($Get_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError)
                    then <ns7:CanonicalError>
                        {
                            if ($Get_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError/@type)
                            then <ns7:type>{fn:data($Get_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError/@type)}</ns7:type>
                            else ()
                        }
                        {
                            if ($Get_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError/@code)
                            then <ns7:code>{fn:data($Get_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError/@code)}</ns7:code>
                            else ()
                        }
                        {
                            if ($Get_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError/@description)
                            then <ns7:description>{fn:data($Get_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError/@description)}</ns7:description>
                            else ()
                        }</ns7:CanonicalError>
                    else ()
                }
                {
                    if ($Get_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError)
                    then <ns7:SourceError>
                        {
                            if ($Get_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/@code)
                            then <ns7:code>{fn:data($Get_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/@code)}</ns7:code>
                            else ()
                        }
                        {
                            if ($Get_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/@description)
                            then <ns7:description>{fn:data($Get_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/@description)}</ns7:description>
                            else ()
                        }
                        <ns7:ErrorSourceDetails>
                            {
                                if ($Get_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@source)
                                then <ns7:source>{fn:data($Get_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@source)}</ns7:source>
                                else ()
                            }
                            <ns7:details></ns7:details>
                        </ns7:ErrorSourceDetails>
                        <ns7:SourceFault>{fn-bea:serialize($Get_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/ns6:SourceFault)}</ns7:SourceFault></ns7:SourceError>
                    else ()
                }
                <ns7:CorrelativeErrors>
                    {
                        for $SourceError in $Get_Consumer_RSP/*[1]/ns5:Result/ns5:CorrelativeErrors/ns6:SourceError
                        return 
                        <ns7:SourceError>
                            {
                                if ($SourceError/@code)
                                then <ns7:code>{fn:data($SourceError/@code)}</ns7:code>
                                else ()
                            }
                            {
                                if ($SourceError/@description)
                                then <ns7:description>{fn:data($SourceError/@description)}</ns7:description>
                                else ()
                            }
                            <ns7:ErrorSourceDetails>
                                {
                                    if ($SourceError/ns6:ErrorSourceDetails/@source)
                                    then <ns7:source>{fn:data($SourceError/ns6:ErrorSourceDetails/@source)}</ns7:source>
                                    else ()
                                }
                                {
                                    if ($SourceError/ns6:ErrorSourceDetails/@details)
                                    then <ns7:details>{fn:data($SourceError/ns6:ErrorSourceDetails/@details)}</ns7:details>
                                    else ()
                                }
                            </ns7:ErrorSourceDetails>
                            <ns7:SourceFault>{fn-bea:serialize($SourceError/ns6:SourceFault)}</ns7:SourceFault></ns7:SourceError>
                    }</ns7:CorrelativeErrors>
            </ns7:Result>
        </ns7:ResponseHeader>
        <ns2:Body>
            <ns2:Consumer>
                <ns2:ConsumerName>{fn:data($Get_Consumer_RSP/*[2]/ns3:Consumer/ns3:ConsumerName)}</ns2:ConsumerName>
                <ns2:ConsumerSurename>{fn:data($Get_Consumer_RSP/*[2]/ns3:Consumer/ns3:ConsumerSurename)}</ns2:ConsumerSurename>
                <ns2:ConsumerAge>{fn:data($Get_Consumer_RSP/*[2]/ns3:Consumer/ns3:ConsumerAge)}</ns2:ConsumerAge>
                <ns2:ConsumerStatus>{fn:data($Get_Consumer_RSP/*[2]/ns3:Consumer/ns3:ConsumerStatus)}</ns2:ConsumerStatus>
            </ns2:Consumer>
        </ns2:Body>
    </ns2:Get_Consumer_RSP>
};

local:func($Get_Consumer_RSP)
