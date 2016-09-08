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

declare variable $AdapterRSP as element()? (:: schema-element(ns3:CHL-SALESFORCE-CRM_ClientObtain_RSP) ::) external;
declare variable $GetMappingRSP as element() external;

declare function local:get_CHL-SALESFORCE-CRM_ClientObtain_RSPMappings($AdapterRSP as element()? (:: schema-element(ns3:CHL-SALESFORCE-CRM_ClientObtain_RSP) ::)
                                                                      ,$GetMappingRSP as element()) 
                                                                  as element() (:: schema-element(ns3:CHL-SALESFORCE-CRM_ClientObtain_RSP) ::) {
    <ns3:CHL-SALESFORCE-CRM_ClientObtain_RSP>
        {$AdapterRSP/*[1]}
        <ns3:Body>
              <ns5:Consumer>
                  {$AdapterRSP/*[2]/*[1]/*:ConsumerName}
                  {$AdapterRSP/*[2]/*[1]/*:ConsumerSurename}
                  {$AdapterRSP/*[2]/*[1]/*:ConsumerAge}
                  <ns5:ConsumerStatus>{data($GetMappingRSP/*[1]/*[1][@entity="Client" and @field="Status"]/@dCode)}</ns5:ConsumerStatus>
                  {$AdapterRSP/*[2]/*[1]/*:ConsumerLegalType}
              </ns5:Consumer>
          </ns3:Body>
    </ns3:CHL-SALESFORCE-CRM_ClientObtain_RSP>
};

local:get_CHL-SALESFORCE-CRM_ClientObtain_RSPMappings($AdapterRSP, $GetMappingRSP)