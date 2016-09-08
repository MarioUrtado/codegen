xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/RA/CHL/SALESFORCE/CRM/UPD-CLI-DATA/v1";
(:: import schema at "../XSD/CHL-SALESFORCE-CRM_UPD-CLI-DATA_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.salesforce.cl/";
(:: import schema at "../../../CommonResources/LegacyResources/CHL-SALESFORCE-CRM/HTTPSOAP12/XSD/SALESFORCE_CommonAPI_v13.1.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/EBO/Consumer/v1";

declare variable $RaREQ as element() (:: schema-element(ns1:CHL-SALESFORCE-CRM_UPD-CLI-DATA_REQ) ::) external;
declare variable $GetRSP as element() external;

declare function local:get_CHL-SALESFORCE-CRM_ClientObtain_LegacyREQ($RaREQ as element() (:: schema-element(ns1:CHL-SALESFORCE-CRM_UPD-CLI-DATA_REQ) ::), 
                                                                 $GetRSP as element()) 
                                                                 as element() {
    <CHL-SALESFORCE-CRM_UPD-CLI-DATA_RA_REQAux>
    <RequestData>
        <ConsumerID>{fn:data($RaREQ/ns1:Body/ns3:ConsumerID)}</ConsumerID>
        <ConsumerName>{fn:data($RaREQ/ns1:Body/ns3:Consumer/ns3:ConsumerName)}</ConsumerName>
        <ConsumerSurename>{fn:data($RaREQ/ns1:Body/ns3:Consumer/ns3:ConsumerSurename)}</ConsumerSurename>
        <ConsumerAge>{fn:data($RaREQ/ns1:Body/ns3:Consumer/ns3:ConsumerAge)}</ConsumerAge>
        <ConsumerStatus>{fn:data($RaREQ/ns1:Body/ns3:Consumer/ns3:ConsumerStatus)}</ConsumerStatus>
    </RequestData>
    <RequestDetails>
        <VerDigit>
          {
            data($GetRSP/*[1]/*[1]/@value) (: Se asume 1 solo valor :)
          }
        </VerDigit>
    </RequestDetails>
</CHL-SALESFORCE-CRM_UPD-CLI-DATA_RA_REQAux>

};

local:get_CHL-SALESFORCE-CRM_ClientObtain_LegacyREQ($RaREQ, $GetRSP)