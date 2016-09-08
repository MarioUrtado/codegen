xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/EBM/Consumer/upd/JSON/v1";
(:: import schema at "../../../../../ESC/Secondary/upd_Consumer_JSON_v1_EBM.xsd" ::)
declare namespace ns1="http://www.entel.cl/EBM/Consumer/upd/v1";
(:: import schema at "../../../../../ESC/Primary/upd_Consumer_v1_EBM.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/MessageHeaderJSON/v1";

declare namespace ns6 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns5 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns4 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare variable $Upd_Consumer_RSP as element() (:: schema-element(ns1:Upd_Consumer_RSP) ::) external;

declare function local:func($Upd_Consumer_RSP as element() (:: schema-element(ns1:Upd_Consumer_RSP) ::)) as element() (:: schema-element(ns2:Upd_Consumer_RSP) ::) {
    <ns2:Upd_Consumer_RSP>
        <ns3:ResponseHeader>
            <ns3:Consumer>
                <ns3:sysCode>{fn:data($Upd_Consumer_RSP/*[1]/*[1]/@sysCode)}</ns3:sysCode>
                <ns3:enterpriseCode>{fn:data($Upd_Consumer_RSP/*[1]/*[1]/@enterpriseCode)}</ns3:enterpriseCode>
                <ns3:countryCode>{fn:data($Upd_Consumer_RSP/*[1]/*[1]/@countryCode)}</ns3:countryCode>
            </ns3:Consumer>
            <ns3:Trace>
                <ns3:clientReqTimestamp>{fn:data($Upd_Consumer_RSP/*[1]/*[2]/@clientReqTimestamp)}</ns3:clientReqTimestamp>
                {
                    if ($Upd_Consumer_RSP/*[1]/*[2]/@reqTimestamp)
                    then <ns3:reqTimestamp>{fn:data($Upd_Consumer_RSP/*[1]/*[2]/@reqTimestamp)}</ns3:reqTimestamp>
                    else ()
                }
                {
                    if ($Upd_Consumer_RSP/*[1]/*[2]/@rspTimestamp)
                    then <ns3:rspTimestamp>{fn:data($Upd_Consumer_RSP/*[1]/*[2]/@rspTimestamp)}</ns3:rspTimestamp>
                    else ()
                }
                {
                    if ($Upd_Consumer_RSP/*[1]/*[2]/@processID)
                    then <ns3:processID>{fn:data($Upd_Consumer_RSP/*[1]/*[2]/@processID)}</ns3:processID>
                    else ()
                }
                <ns3:eventID>{fn:data($Upd_Consumer_RSP/*[1]/*[2]/@eventID)}</ns3:eventID>
                {
                    if ($Upd_Consumer_RSP/*[1]/*[2]/@sourceID)
                    then <ns3:sourceID>{fn:data($Upd_Consumer_RSP/*[1]/*[2]/@sourceID)}</ns3:sourceID>
                    else ()
                }
                {
                    if ($Upd_Consumer_RSP/*[1]/*[2]/@correlationEventID)
                    then <ns3:correlationEventID>{fn:data($Upd_Consumer_RSP/*[1]/*[2]/@correlationEventID)}</ns3:correlationEventID>
                    else ()
                }
                {
                    if ($Upd_Consumer_RSP/*[1]/*[2]/@conversationID)
                    then <ns3:conversationID>{fn:data($Upd_Consumer_RSP/*[1]/*[2]/@conversationID)}</ns3:conversationID>
                    else ()
                }
                {
                    if ($Upd_Consumer_RSP/*[1]/*[2]/@correlationID)
                    then <ns3:correlationID>{fn:data($Upd_Consumer_RSP/*[1]/*[2]/@correlationID)}</ns3:correlationID>
                    else ()
                }
                <ns3:Service>
                    {
                        if ($Upd_Consumer_RSP/*[1]/*[2]/ns4:Service/@code)
                        then <ns3:code>{fn:data($Upd_Consumer_RSP/*[1]/*[2]/ns4:Service/@code)}</ns3:code>
                        else ()
                    }
                    {
                        if ($Upd_Consumer_RSP/*[1]/*[2]/ns4:Service/@name)
                        then <ns3:name>{fn:data($Upd_Consumer_RSP/*[1]/*[2]/ns4:Service/@name)}</ns3:name>
                        else ()
                    }
                    {
                        if ($Upd_Consumer_RSP/*[1]/*[2]/ns4:Service/@operation)
                        then <ns3:operation>{fn:data($Upd_Consumer_RSP/*[1]/*[2]/ns4:Service/@operation)}</ns3:operation>
                        else ()
                    }
                </ns3:Service>
            </ns3:Trace>
            <ns3:Channel>
                {
                    if ($Upd_Consumer_RSP/*[1]/ns4:Channel/@name)
                    then <ns3:name>{fn:data($Upd_Consumer_RSP/*[1]/ns4:Channel/@name)}</ns3:name>
                    else ()
                }
                {
                    if ($Upd_Consumer_RSP/*[1]/ns4:Channel/@mode)
                    then <ns3:mode>{fn:data($Upd_Consumer_RSP/*[1]/ns4:Channel/@mode)}</ns3:mode>
                    else ()
                }
            </ns3:Channel>
            <ns3:Result>
                <ns3:status>{fn:data($Upd_Consumer_RSP/*[1]/ns5:Result/@status)}</ns3:status>
                {
                    if ($Upd_Consumer_RSP/*[1]/ns5:Result/@description)
                    then <ns3:description>{fn:data($Upd_Consumer_RSP/*[1]/ns5:Result/@description)}</ns3:description>
                    else ()
                }
                <ns3:CanonicalError>
                    {
                        if ($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError/@type)
                        then <ns3:type>{fn:data($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError/@type)}</ns3:type>
                        else ()
                    }
                    {
                        if ($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError/@code)
                        then <ns3:code>{fn:data($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError/@code)}</ns3:code>
                        else ()
                    }
                    {
                        if ($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError/@description)
                        then <ns3:description>{fn:data($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:CanonicalError/@description)}</ns3:description>
                        else ()
                    }
                </ns3:CanonicalError>
                <ns3:SourceError>
                    {
                        if ($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/@code)
                        then <ns3:code>{fn:data($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/@code)}</ns3:code>
                        else ()
                    }
                    {
                        if ($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/@description)
                        then <ns3:description>{fn:data($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/@description)}</ns3:description>
                        else ()
                    }
                    <ns3:ErrorSourceDetails>
                        {
                            if ($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@source)
                            then <ns3:source>{fn:data($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@source)}</ns3:source>
                            else ()
                        }
                        {
                            if ($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@details)
                            then <ns3:details>{fn:data($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/ns6:ErrorSourceDetails/@details)}</ns3:details>
                            else ()
                        }
                    </ns3:ErrorSourceDetails>
                    <ns3:SourceFault>{fn:data($Upd_Consumer_RSP/*[1]/ns5:Result/ns6:SourceError/ns6:SourceFault)}</ns3:SourceFault>
                </ns3:SourceError>
                <ns3:CorrelativeErrors>
                    {
                        for $SourceError in $Upd_Consumer_RSP/*[1]/ns5:Result/ns5:CorrelativeErrors/ns6:SourceError
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
                            <ns3:SourceFault>{fn:data($SourceError/ns6:SourceFault)}</ns3:SourceFault>
                        </ns3:SourceError>
                    }
                </ns3:CorrelativeErrors>
            </ns3:Result>
        </ns3:ResponseHeader>
        <ns2:Body></ns2:Body>
    </ns2:Upd_Consumer_RSP>
};

local:func($Upd_Consumer_RSP)
