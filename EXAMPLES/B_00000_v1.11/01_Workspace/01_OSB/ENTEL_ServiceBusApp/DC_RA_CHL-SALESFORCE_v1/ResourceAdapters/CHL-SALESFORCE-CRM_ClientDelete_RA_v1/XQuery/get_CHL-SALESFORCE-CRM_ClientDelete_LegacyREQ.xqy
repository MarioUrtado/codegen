xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/RA/CHL-SALESFORCE-CRM/ClientDelete/v1";
(:: import schema at "../CSC/CHL-SALESFORCE-CRM_ClientDelete_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.salesforce.cl/";
(:: import schema at "../../../CommonResources/LegacyResources/CHL-SALESFORCE-CRM/HTTPSOAP12/XSD/SALESFORCE_CommonAPI_v13.1.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/EBO/Consumer/v1";

declare variable $RaREQ as element() (:: schema-element(ns1:CHL-SALESFORCE-CRM_ClientDelete_REQ) ::) external;

declare function local:get_CHL-SALESFORCE-CRM_ClientDelete_LegacyREQ(
  $RaREQ as element() (:: schema-element(ns1:CHL-SALESFORCE-CRM_ClientDelete_REQ) ::)
  ) as element() (:: schema-element(ns2:ClientDelete_REQUEST) ::) {
  
    <ns2:ClientDelete_REQUEST>
        <ns2:CLI_ID>{data($RaREQ/ns1:Body/ns3:ConsumerID)}</ns2:CLI_ID>
        <ns2:CLI_TYPE>{data($RaREQ/ns1:Body/ns3:ConsumerType)}</ns2:CLI_TYPE>
    </ns2:ClientDelete_REQUEST>
};

local:get_CHL-SALESFORCE-CRM_ClientDelete_LegacyREQ($RaREQ)
