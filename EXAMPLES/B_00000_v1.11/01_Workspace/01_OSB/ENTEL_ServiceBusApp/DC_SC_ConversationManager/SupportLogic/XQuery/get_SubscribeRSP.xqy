xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/SC/ConversationManager/subscribe/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/subscribe_ConversationManager_v1_CSM.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare variable $Result as element() (:: schema-element(ns1:Result) ::) external;

declare function local:get_SubscribeRSP($Result as element() (:: schema-element(ns1:Result) ::)) as element() (:: schema-element(ns2:SubscribeRSP) ::) {
    <ns2:SubscribeRSP>
        <ns1:Result status="{fn:data($Result/@status)}">
            {
                if ($Result/@description)
                then attribute description {fn:data($Result/@description)}
                else ()
            }
            {
                if ($Result/ns3:CanonicalError)
                then 
                    <ns3:CanonicalError>
                        {
                            if ($Result/ns3:CanonicalError/@code)
                            then attribute code {fn:data($Result/ns3:CanonicalError/@code)}
                            else ()
                        }
                        {
                            if ($Result/ns3:CanonicalError/@description)
                            then attribute description {fn:data($Result/ns3:CanonicalError/@description)}
                            else ()
                        }
                        {
                            if ($Result/ns3:CanonicalError/@type)
                            then attribute type {fn:data($Result/ns3:CanonicalError/@type)}
                            else ()
                        }
                    </ns3:CanonicalError>
                else ()
            }
            {
                if ($Result/ns3:SourceError)
                then 
                    <ns3:SourceError>
                        {
                            if ($Result/ns3:SourceError/@code)
                            then attribute code {fn:data($Result/ns3:SourceError/@code)}
                            else ()
                        }
                        {
                            if ($Result/ns3:SourceError/@description)
                            then attribute description {fn:data($Result/ns3:SourceError/@description)}
                            else ()
                        }
                        <ns3:ErrorSourceDetails>
                            {
                                if ($Result/ns3:SourceError/ns3:ErrorSourceDetails/@source)
                                then attribute source {fn:data($Result/ns3:SourceError/ns3:ErrorSourceDetails/@source)}
                                else ()
                            }
                            {
                                if ($Result/ns3:SourceError/ns3:ErrorSourceDetails/@details)
                                then attribute details {fn:data($Result/ns3:SourceError/ns3:ErrorSourceDetails/@details)}
                                else ()
                            }
                        </ns3:ErrorSourceDetails>
                        {
                            if ($Result/ns3:SourceError/ns3:SourceFault)
                            then <ns3:SourceFault>{fn:data($Result/ns3:SourceError/ns3:SourceFault)}</ns3:SourceFault>
                            else ()
                        }
                    </ns3:SourceError>
                else ()
            }
            {
                if ($Result/ns1:CorrelativeErrors)
                then 
                    <ns1:CorrelativeErrors>
                        {
                            for $SourceError in $Result/ns1:CorrelativeErrors/ns3:SourceError
                            return 
                            <ns3:SourceError>
                                {
                                    if ($SourceError/@code)
                                    then attribute code {fn:data($SourceError/@code)}
                                    else ()
                                }
                                {
                                    if ($SourceError/@description)
                                    then attribute description {fn:data($SourceError/@description)}
                                    else ()
                                }
                                <ns3:ErrorSourceDetails>
                                    {
                                        if ($SourceError/ns3:ErrorSourceDetails/@source)
                                        then attribute source {fn:data($SourceError/ns3:ErrorSourceDetails/@source)}
                                        else ()
                                    }
                                    {
                                        if ($SourceError/ns3:ErrorSourceDetails/@details)
                                        then attribute details {fn:data($SourceError/ns3:ErrorSourceDetails/@details)}
                                        else ()
                                    }
                                </ns3:ErrorSourceDetails>
                                {
                                    if ($SourceError/ns3:SourceFault)
                                    then <ns3:SourceFault>{fn:data($SourceError/ns3:SourceFault)}</ns3:SourceFault>
                                    else ()
                                }
                            </ns3:SourceError>
                        }
                    </ns1:CorrelativeErrors>
                else ()
            }
        </ns1:Result>
    </ns2:SubscribeRSP>
};

local:get_SubscribeRSP($Result)
