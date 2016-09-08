xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getInfoAdapter";
(:: import schema at "../JCA/getInfoAdapter/getInfoAdapter_sp.xsd" ::)

declare variable $Trace as element() (:: schema-element(ns1:Trace) ::) external;

declare function local:get_getInfoREQ_Adapter($Trace as element()  (:: schema-element(ns1:Trace) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            if ($Trace/@conversationID)
            then <ns2:P_CONVERSATION_ID>{fn:data($Trace/@conversationID)}</ns2:P_CONVERSATION_ID>
            else ()
        }
    </ns2:InputParameters>
};

local:get_getInfoREQ_Adapter($Trace)
