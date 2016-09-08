xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/RA/INT-AS400-CLI/ClientDelete/v1";
(:: import schema at "../CSC/INT-AS400-CLI_ClientDelete_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.as400.com/";
(:: import schema at "../../../CommonResources/LegacyResources/INT-AS400-CLI/HTTPSOAP11/XSD/CLI_API_v1.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/EBO/Consumer/v1";

declare variable $RaREQ as element() (:: schema-element(ns1:INT-AS400-CLI_ClientDelete_REQ) ::) external;

declare function local:get_INT-AS400-CLI_ClientDelete_LegacyREQ(
  $RaREQ as element() (:: schema-element(ns1:INT-AS400-CLI_ClientDelete_REQ) ::)
  ) as element() (:: schema-element(ns2:ClientDelete_REQUEST) ::) {
    <ns2:ClientDelete_REQUEST>
        <ns2:CLI_ID>{data($RaREQ/ns1:Body/ns3:ConsumerID)}</ns2:CLI_ID>
        <ns2:CLI_TYPE>{data($RaREQ/ns1:Body/ns3:ConsumerType)}</ns2:CLI_TYPE>
    </ns2:ClientDelete_REQUEST>
};

local:get_INT-AS400-CLI_ClientDelete_LegacyREQ($RaREQ)