xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/ConversationManager/getStatus/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getStatus_ConversationManager_v1_CSM.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getConversationStatusAdapter";
(:: import schema at "../JCA/getConversationStatusAdapter/getConversationStatusAdapter_sp.xsd" ::)

declare namespace con = "http://www.entel.cl/SC/ConversationManager/Aux/ConversationStatus";

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";

declare variable $OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:get_GetStatusRSP_Adapter($OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:GetStatusRSP) ::) {
    <ns2:GetStatusRSP>
        
        <ns2:ConversationStatus status="{fn:data($OutputParameters/ns1:P_STATUS)}">
            {
                if ($OutputParameters/ns1:P_RSP_MSG)
                then <con:ReponseMessage>{fn-bea:inlinedXML($OutputParameters/ns1:P_RSP_MSG)}</con:ReponseMessage>
                else ()
            }
        </ns2:ConversationStatus>
    </ns2:GetStatusRSP>
};

local:get_GetStatusRSP_Adapter($OutputParameters)
