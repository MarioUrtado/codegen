xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/CSM/RA/CHL-SALESFORCE-CRM/ClientDelete/v1";
(:: import schema at "../CSC/CHL-SALESFORCE-CRM_ClientDelete_v1_CSM.xsd" ::)
declare namespace ns1="http://www.entel.salesforce.cl/";
(:: import schema at "../../../CommonResources/LegacyResources/CHL-SALESFORCE-CRM/HTTPSOAP12/XSD/SALESFORCE_CommonAPI_v13.1.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare variable $LegacyRSP as element() (:: schema-element(ns1:ClientDelete_RESPONSE) ::) external;
declare variable $Result as element() (:: schema-element(ns3:Result) ::) external;


declare function local:get_CHL-SALESFORCE-CRM_ClientDelete_AdapterRSP_OK($LegacyRSP as element() (:: schema-element(ns1:ClientDelete_RESPONSE) ::), $Result as element() (:: schema-element(ns3:Result) ::)) as element() (:: schema-element(ns2:CHL-SALESFORCE-CRM_ClientDelete_RSP) ::) {
    <ns2:CHL-SALESFORCE-CRM_ClientDelete_RSP>
        {$Result}
        <ns2:Body>
        </ns2:Body>
    </ns2:CHL-SALESFORCE-CRM_ClientDelete_RSP>
};

local:get_CHL-SALESFORCE-CRM_ClientDelete_AdapterRSP_OK($LegacyRSP, $Result)
