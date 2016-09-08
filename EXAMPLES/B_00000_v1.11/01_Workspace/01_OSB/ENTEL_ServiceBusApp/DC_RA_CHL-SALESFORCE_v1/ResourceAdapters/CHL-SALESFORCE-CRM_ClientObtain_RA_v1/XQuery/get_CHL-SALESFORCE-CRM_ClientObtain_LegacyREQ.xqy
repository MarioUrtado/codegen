xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/RA/CHL-SALESFORCE-CRM/ClientObtain/v1";
(:: import schema at "../CSC/CHL-SALESFORCE-CRM_ClientObtain_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.salesforce.cl/";
(:: import schema at "../../../CommonResources/LegacyResources/CHL-SALESFORCE-CRM/HTTPSOAP12/XSD/SALESFORCE_CommonAPI_v13.1.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/EBO/Consumer/v1";

declare variable $RaREQ as element() (:: schema-element(ns1:CHL-SALESFORCE-CRM_ClientObtain_REQ) ::) external;

declare function local:get_CHL-SALESFORCE-CRM_ClientObtain_LegacyREQ($RaREQ as element() (:: schema-element(ns1:CHL-SALESFORCE-CRM_ClientObtain_REQ) ::))                                                    as element() (:: schema-element(ns2:ClientObtain_REQUEST) ::) {
    <ns2:ClientObtain_REQUEST>
        <ns2:CLI_ID>{fn:data($RaREQ/*[2]/*[1])}</ns2:CLI_ID>
        <ns2:CLI_TYPE>{fn:data($RaREQ/*[2]/*[2])}</ns2:CLI_TYPE>
    </ns2:ClientObtain_REQUEST>
};

local:get_CHL-SALESFORCE-CRM_ClientObtain_LegacyREQ($RaREQ)