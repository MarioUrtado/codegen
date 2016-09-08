xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ConversationManager/getNewConversation/v1";


declare function local:get_GetNewConversationREQ() as element() {
    <ns1:GetNewConversationREQ>
    </ns1:GetNewConversationREQ>
};

local:get_GetNewConversationREQ()
