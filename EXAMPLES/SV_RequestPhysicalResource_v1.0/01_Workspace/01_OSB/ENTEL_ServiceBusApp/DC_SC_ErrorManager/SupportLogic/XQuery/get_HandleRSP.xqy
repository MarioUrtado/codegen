xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/SC/ErrorManager/handle/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/handle_ErrorManager_v1_CSM.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare variable $Result as element() (:: schema-element(ns1:Result) ::) external;

declare function local:get_handleRSP($Result as element() (:: schema-element(ns1:Result) ::)) as element() (:: schema-element(ns2:HandleRSP) ::) {
    <ns2:HandleRSP>
        {$Result}
    </ns2:HandleRSP>
};

local:get_handleRSP($Result)
