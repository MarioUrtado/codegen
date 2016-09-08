xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns2="http://www.entel.cl/SC/ConversationManager/getStatus/v1";

declare variable $ConversationID as xs:string (:: ns1:conversationID_SType ::)  external;

declare function local:get_GetStatusREQ($ConversationID as xs:string (:: ns1:conversationID_SType ::) ) as element() {
    <ns2:GetStatusREQ>
        <ns2:ConversationID>{$ConversationID}</ns2:ConversationID>
    </ns2:GetStatusREQ>
};

local:get_GetStatusREQ($ConversationID)
