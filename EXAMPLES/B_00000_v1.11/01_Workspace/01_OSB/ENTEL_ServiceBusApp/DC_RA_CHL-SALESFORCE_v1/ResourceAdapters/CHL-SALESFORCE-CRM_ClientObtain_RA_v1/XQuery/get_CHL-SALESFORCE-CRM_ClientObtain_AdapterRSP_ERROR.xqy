xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.entel.cl/CSM/RA/CHL-SALESFORCE-CRM/ClientObtain/v1";
(:: import schema at "../CSC/CHL-SALESFORCE-CRM_ClientObtain_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare namespace ns1="http://www.entel.salesforce.cl/";
(:: import schema at "../../../CommonResources/LegacyResources/CHL-SALESFORCE-CRM/HTTPSOAP12/XSD/SALESFORCE_CommonAPI_v13.1.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns5 = "http://www.entel.cl/EBO/Consumer/v1";

declare variable $Result as element() (:: schema-element(ns2:Result) ::) external;

declare function local:get_CHL-SALESFORCE-CRM_ClientObtain_AdapterRSP_ERROR($Result as element() (:: schema-element(ns2:Result) ::)) 
                                                                  as element() (:: schema-element(ns3:CHL-SALESFORCE-CRM_ClientObtain_RSP) ::) {
    <ns3:CHL-SALESFORCE-CRM_ClientObtain_RSP>
       {$Result}
    </ns3:CHL-SALESFORCE-CRM_ClientObtain_RSP>
};

local:get_CHL-SALESFORCE-CRM_ClientObtain_AdapterRSP_ERROR($Result)