xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/ConversationManager/getInfo/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getInfo_ConversationManager_v1_CSM.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getInfoAdapter";
(:: import schema at "../JCA/getInfoAdapter/getInfoAdapter_sp.xsd" ::)
declare namespace ns3="http://www.entel.cl/SC/ConversationManager/Aux/Conversation";
(:: import schema at "../../SupportAPI/XSD/Conversation.xsd" ::)

declare variable $OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:get_getInfoRSP_Adapter($OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:GetInfoRSP) ::) {
    <ns2:GetInfoRSP>
        <ns3:Conversation>
            {
                if ($OutputParameters/ns1:P_CONV_TYPE)
                then attribute type {fn:data($OutputParameters/ns1:P_CONV_TYPE)}
                else ()
            }
            {
                if ($OutputParameters/ns1:P_CONV_SEQUENCE)
                then attribute sequence {fn:data($OutputParameters/ns1:P_CONV_SEQUENCE)}
                else ()
            }
            {
                if ($OutputParameters/ns1:P_CONV_SERVICE)
                then attribute serviceName {fn:data($OutputParameters/ns1:P_CONV_SERVICE)}
                else ()
            }
            {
                if ($OutputParameters/ns1:P_CONV_CAPABILITY)
                then attribute serviceOperation {fn:data($OutputParameters/ns1:P_CONV_CAPABILITY)}
                else ()
            }
            {
                if ($OutputParameters/ns1:P_CONV_STATUS)
                then attribute status {fn:data($OutputParameters/ns1:P_CONV_STATUS)}
                else ()
            }
        </ns3:Conversation>
        <ns3:Transaction>
            {
                if ($OutputParameters/ns1:P_CONV_TX_TYPE)
                then attribute type {fn:data($OutputParameters/ns1:P_CONV_TX_TYPE)}
                else ()
            }
            {
                if ($OutputParameters/ns1:P_CONV_TX_SEQUENCE)
                then attribute sequence {fn:data($OutputParameters/ns1:P_CONV_TX_SEQUENCE)}
                else ()
            }
            {
                if ($OutputParameters/ns1:P_CONV_TX_EVENT_ID)
                then attribute eventID {fn:data($OutputParameters/ns1:P_CONV_TX_EVENT_ID)}
                else ()
            }
            {
                if ($OutputParameters/ns1:P_CONV_TX_PROCESS_ID)
                then attribute processID {fn:data($OutputParameters/ns1:P_CONV_TX_PROCESS_ID)}
                else ()
            }
            {
                if ($OutputParameters/ns1:P_CONV_TX_CORR_ID)
                then attribute correlationID {fn:data($OutputParameters/ns1:P_CONV_TX_CORR_ID)}
                else ()
            }
            {
                if ($OutputParameters/ns1:P_CONV_TX_STATUS)
                then attribute status {fn:data($OutputParameters/ns1:P_CONV_TX_STATUS)}
                else ()
            }
        </ns3:Transaction>
    </ns2:GetInfoRSP>
};

local:get_getInfoRSP_Adapter($OutputParameters)
