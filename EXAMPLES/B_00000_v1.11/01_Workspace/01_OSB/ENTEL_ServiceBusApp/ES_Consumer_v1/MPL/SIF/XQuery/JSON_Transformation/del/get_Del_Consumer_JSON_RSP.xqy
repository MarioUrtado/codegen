xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/EBM/Consumer/del/JSON/v1";
(:: import schema at "../../../../../ESC/Secondary/del_Consumer_JSON_v1_EBM.xsd" ::)
declare namespace ns1="http://www.entel.cl/EBM/Consumer/del/v1";
(:: import schema at "../../../../../ESC/Primary/del_Consumer_v1_EBM.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/MessageHeaderJSON/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace ns5 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns6 = "http://www.entel.cl/ESO/Error/v1";

declare variable $delConsumerRsp as element() (:: schema-element(ns1:Del_Consumer_RSP) ::) external;

declare function local:func($delConsumerRsp as element() (:: schema-element(ns1:Del_Consumer_RSP) ::)) as element() (:: schema-element(ns2:Del_Consumer_RSP) ::) {
    <ns2:Del_Consumer_RSP>
        <ns3:ResponseHeader>
            <ns3:Consumer>
                <ns3:sysCode>{fn:data($delConsumerRsp/*[1]/*[1]/@sysCode)}</ns3:sysCode>
                <ns3:enterpriseCode>{fn:data($delConsumerRsp/*[1]/*[1]/@enterpriseCode)}</ns3:enterpriseCode>
                <ns3:countryCode>{fn:data($delConsumerRsp/*[1]/*[1]/@countryCode)}</ns3:countryCode>
            </ns3:Consumer>
            <ns3:Trace>
                <ns3:clientReqTimestamp>{fn:data($delConsumerRsp/*[1]/*[2]/@clientReqTimestamp)}</ns3:clientReqTimestamp>
                {
                    if ($delConsumerRsp/*[1]/*[2]/@reqTimestamp)
                    then <ns3:reqTimestamp>{fn:data($delConsumerRsp/*[1]/*[2]/@reqTimestamp)}</ns3:reqTimestamp>
                    else ()
                }
                {
                    if ($delConsumerRsp/*[1]/*[2]/@rspTimestamp)
                    then <ns3:rspTimestamp>{fn:data($delConsumerRsp/*[1]/*[2]/@rspTimestamp)}</ns3:rspTimestamp>
                    else ()
                }
                {
                    if ($delConsumerRsp/*[1]/*[2]/@processID)
                    then <ns3:processID>{fn:data($delConsumerRsp/*[1]/*[2]/@processID)}</ns3:processID>
                    else ()
                }
                <ns3:eventID>{fn:data($delConsumerRsp/*[1]/*[2]/@eventID)}</ns3:eventID>
                {
                    if ($delConsumerRsp/*[1]/*[2]/@sourceID)
                    then <ns3:sourceID>{fn:data($delConsumerRsp/*[1]/*[2]/@sourceID)}</ns3:sourceID>
                    else ()
                }
                {
                    if ($delConsumerRsp/*[1]/*[2]/@correlationEventID)
                    then <ns3:correlationEventID>{fn:data($delConsumerRsp/*[1]/*[2]/@correlationEventID)}</ns3:correlationEventID>
                    else ()
                }
                {
                    if ($delConsumerRsp/*[1]/*[2]/@conversationID)
                    then <ns3:conversationID>{fn:data($delConsumerRsp/*[1]/*[2]/@conversationID)}</ns3:conversationID>
                    else ()
                }
                {
                    if ($delConsumerRsp/*[1]/*[2]/@correlationID)
                    then <ns3:correlationID>{fn:data($delConsumerRsp/*[1]/*[2]/@correlationID)}</ns3:correlationID>
                    else ()
                }
                {
                    if ($delConsumerRsp/*[1]/*[2]/ns4:Service)
                    then <ns3:Service>
                        {
                            if ($delConsumerRsp/*[1]/*[2]/ns4:Service/@code)
                            then <ns3:code>{fn:data($delConsumerRsp/*[1]/*[2]/ns4:Service/@code)}</ns3:code>
                            else ()
                        }
                        {
                            if ($delConsumerRsp/*[1]/*[2]/ns4:Service/@name)
                            then <ns3:name>{fn:data($delConsumerRsp/*[1]/*[2]/ns4:Service/@name)}</ns3:name>
                            else ()
                        }
                        {
                            if ($delConsumerRsp/*[1]/*[2]/ns4:Service/@operation)
                            then <ns3:operation>{fn:data($delConsumerRsp/*[1]/*[2]/ns4:Service/@operation)}</ns3:operation>
                            else ()
                        }</ns3:Service>
                    else ()
                }
            </ns3:Trace>
            {
                if ($delConsumerRsp/*[1]/ns4:Channel)
                then <ns3:Channel>
                    {
                        if ($delConsumerRsp/*[1]/ns4:Channel/@name)
                        then <ns3:name>{fn:data($delConsumerRsp/*[1]/ns4:Channel/@name)}</ns3:name>
                        else ()
                    }
                    {
                        if ($delConsumerRsp/*[1]/ns4:Channel/@mode)
                        then <ns3:mode>{fn:data($delConsumerRsp/*[1]/ns4:Channel/@mode)}</ns3:mode>
                        else ()
                    }</ns3:Channel>
                else ()
            }
            <ns3:Result>
                <ns3:status>{fn:data($delConsumerRsp/*[1]/ns5:Result/@status)}</ns3:status>
                {
                    if ($delConsumerRsp/*[1]/ns5:Result/@description)
                    then <ns3:description>{fn:data($delConsumerRsp/*[1]/ns5:Result/@description)}</ns3:description>
                    else ()
                }
                {
                    if ($delConsumerRsp/*[1]/ns5:Result/ns6:CanonicalError)
                    then <ns3:CanonicalError>
                        {
                            if ($delConsumerRsp/*[1]/ns5:Result/ns6:CanonicalError/@type)
                            then <ns3:type>{fn:data($delConsumerRsp/*[1]/ns5:Result/ns6:CanonicalError/@type)}</ns3:type>
                            else ()
                        }
                        {
                            if ($delConsumerRsp/*[1]/ns5:Result/ns6:CanonicalError/@code)
                            then <ns3:code>{fn:data($delConsumerRsp/*[1]/ns5:Result/ns6:CanonicalError/@code)}</ns3:code>
                            else ()
                        }
                        {
                            if ($delConsumerRsp/*[1]/ns5:Result/ns6:CanonicalError/@description)
                            then <ns3:description>{fn:data($delConsumerRsp/*[1]/ns5:Result/ns6:CanonicalError/@description)}</ns3:description>
                            else ()
                        }</ns3:CanonicalError>
                    else ()
                }
                {
                    if ($delConsumerRsp/*[1]/ns5:Result/ns6:SourceError)
                    then <ns3:SourceError>
                        {
                            if ($delConsumerRsp/*[1]/ns5:Result/ns6:SourceError/@code)
                            then <ns3:code>{fn:data($delConsumerRsp/*[1]/ns5:Result/ns6:SourceError/@code)}</ns3:code>
                            else ()
                        }
                        {
                            if ($delConsumerRsp/*[1]/ns5:Result/ns6:SourceError/@description)
                            then <ns3:description>{fn:data($delConsumerRsp/*[1]/ns5:Result/ns6:SourceError/@description)}</ns3:description>
                            else ()
                        }
                        <ns3:ErrorSourceDetails>
                            {
                                if ($delConsumerRsp/*[1]/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@source)
                                then <ns3:source>{fn:data($delConsumerRsp/*[1]/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@source)}</ns3:source>
                                else ()
                            }
                            {
                                if ($delConsumerRsp/*[1]/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@details)
                                then <ns3:details>{fn:data($delConsumerRsp/*[1]/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@details)}</ns3:details>
                                else ()
                            }</ns3:ErrorSourceDetails>
                        <ns3:SourceFault>{fn-bea:serialize($delConsumerRsp/*[1]/ns5:Result/ns6:SourceError/ns6:SourceFault)}</ns3:SourceFault></ns3:SourceError>
                    else ()
                }
                <ns3:CorrelativeErrors>
                    {
                        for $SourceError in $delConsumerRsp/*[1]/ns5:Result/ns5:CorrelativeErrors/ns6:SourceError
                        return 
                        <ns3:SourceError>
                            {
                                if ($SourceError/@code)
                                then <ns3:code>{fn:data($SourceError/@code)}</ns3:code>
                                else ()
                            }
                            {
                                if ($SourceError/@description)
                                then <ns3:description>{fn:data($SourceError/@description)}</ns3:description>
                                else ()
                            }
                            <ns3:ErrorSourceDetails>
                                {
                                    if ($SourceError/ns6:ErrorSourceDetails/@source)
                                    then <ns3:source>{fn:data($SourceError/ns6:ErrorSourceDetails/@source)}</ns3:source>
                                    else ()
                                }
                                {
                                    if ($SourceError/ns6:ErrorSourceDetails/@details)
                                    then <ns3:details>{fn:data($SourceError/ns6:ErrorSourceDetails/@details)}</ns3:details>
                                    else ()
                                }
                            </ns3:ErrorSourceDetails>
                            <ns3:SourceFault>{fn-bea:serialize($SourceError/ns6:SourceFault)}</ns3:SourceFault></ns3:SourceError>
                    }
                </ns3:CorrelativeErrors>
            </ns3:Result>
        </ns3:ResponseHeader>
        <ns2:Body></ns2:Body>
    </ns2:Del_Consumer_RSP>
};

local:func($delConsumerRsp)
