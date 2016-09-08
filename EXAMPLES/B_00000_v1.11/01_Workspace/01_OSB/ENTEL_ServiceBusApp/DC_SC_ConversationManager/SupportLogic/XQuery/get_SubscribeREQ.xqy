xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ConversationManager/subscribe/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/subscribe_ConversationManager_v1_CSM.xsd" ::)

declare namespace ns2="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";

declare namespace con = "http://www.entel.cl/SC/ConversationManager/Aux/Conversation";

declare variable $RequestHeader as element() (:: schema-element(ns2:RequestHeader) ::) external;
declare variable $Subscriber_ConversationID as xs:string external;
declare variable $CallbackAddress as xs:string external;
declare variable $Provider_ConversationID as xs:string external;

declare function local:get_SubscribeREQ($RequestHeader as element() (:: schema-element(ns2:RequestHeader) ::),
                                        $Subscriber_ConversationID as xs:string, 
                                        $CallbackAddress as xs:string, 
                                        $Provider_ConversationID as xs:string) 
                                        as element() (:: schema-element(ns1:SubscribeREQ) ::) {
    
    let $protocol:= tokenize($CallbackAddress,'://')[1]
    return 
    
    <ns1:SubscribeREQ>
        {$RequestHeader}
        <ns1:Subscriber>
            <con:ConversationID>{fn:data($Subscriber_ConversationID)}</con:ConversationID>
            {
                if ($protocol = 'jms') then 
                    <ns1:JMSCallbackAddress addr="{$CallbackAddress}">
                    </ns1:JMSCallbackAddress>
                else
                    <ns1:HTTPCallbackAddress addr="{$CallbackAddress}">
                    </ns1:HTTPCallbackAddress>
            }
        </ns1:Subscriber>
        <ns1:Provider>
            <con:ConversationID>{fn:data($Provider_ConversationID)}</con:ConversationID>
        </ns1:Provider>
    </ns1:SubscribeREQ>
};

local:get_SubscribeREQ($RequestHeader, $Subscriber_ConversationID, $CallbackAddress, $Provider_ConversationID)
