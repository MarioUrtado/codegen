xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)
declare namespace ns1="http://www.entel.cl/SC/ErrorManager/RetryManager/getRetryStatus/v1";
(:: import schema at "../../../../DC_SC_ErrorManager/SupportAPI/XSD/CSM/getRetryStatus_RetryManager_v1_CSM.xsd" ::)

declare variable $Trace as element() (:: schema-element(ns2:Trace) ::) external;

declare function local:get_GetRetryStatus($Trace as element() (:: schema-element(ns2:Trace) ::)) as element() (:: schema-element(ns1:GetRetryStatus_REQ) ::) {
    <ns1:GetRetryStatus_REQ>
       {$Trace}
    </ns1:GetRetryStatus_REQ>
};

local:get_GetRetryStatus($Trace)