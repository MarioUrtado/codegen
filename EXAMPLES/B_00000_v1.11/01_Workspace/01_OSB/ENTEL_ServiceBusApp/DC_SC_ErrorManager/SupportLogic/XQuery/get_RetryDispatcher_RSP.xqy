xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/SC/ErrorManager/RetryManager/retryDispatcher/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/retryDispatcher_RetryManager_v1_CSM.xsd" ::)

declare variable $Payload as element(*) external;

declare function local:get_RetryDispatcher_RSP(
                                               $Payload as element(*)) 
                                               as element() (:: schema-element(ns2:RetryDispatcher_RSP) ::) {
    <ns2:RetryDispatcher_RSP>
        <ns2:Payload>{$Payload}</ns2:Payload>
    </ns2:RetryDispatcher_RSP>
};

local:get_RetryDispatcher_RSP($Payload)
