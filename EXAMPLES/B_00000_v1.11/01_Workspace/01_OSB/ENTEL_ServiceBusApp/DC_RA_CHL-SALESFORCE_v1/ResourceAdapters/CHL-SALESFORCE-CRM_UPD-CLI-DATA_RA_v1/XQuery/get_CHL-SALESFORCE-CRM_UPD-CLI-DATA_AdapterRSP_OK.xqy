xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.entel.cl/CSM/RA/CHL/SALESFORCE/CRM/UPD-CLI-DATA/v1";
(:: import schema at "../XSD/CHL-SALESFORCE-CRM_UPD-CLI-DATA_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare namespace ns1="http://www.entel.salesforce.cl/";
(:: import schema at "../../../CommonResources/LegacyResources/CHL-SALESFORCE-CRM/HTTPSOAP12/XSD/SALESFORCE_CommonAPI_v13.1.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns5 = "http://www.entel.cl/EBO/Consumer/v1";

declare namespace ns6="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare variable $LegacyRSP as element()? external;
declare variable $RequestHeader as element() (:: schema-element(ns6:RequestHeader) ::) external;

declare function local:get_CHL-SALESFORCE-CRM_UPD-CLI-DATA_AdapterRSP_OK($LegacyRSP as element()?, 
                                                                  $RequestHeader as element() (:: schema-element(ns6:RequestHeader) ::)) 
                                                                  as element() (:: schema-element(ns3:CHL-SALESFORCE-CRM_UPD-CLI-DATA_RSP) ::) {
    <ns3:CHL-SALESFORCE-CRM_UPD-CLI-DATA_RSP>
       {$RequestHeader}
        <ns3:Body>
            <ns5:Consumer>
                <ns5:ConsumerName>{data($LegacyRSP/*[1]/*:ConsumerID)}</ns5:ConsumerName>
                <ns5:ConsumerSurename>{data($LegacyRSP/*[1]/*:ConsumerSurename)}</ns5:ConsumerSurename>
                <ns5:ConsumerAge>{data($LegacyRSP/*[1]/*:ConsumerAge)}</ns5:ConsumerAge>
                <ns5:ConsumerStatus>{data($LegacyRSP/*[1]/*:ConsumerStatus)}</ns5:ConsumerStatus>
            </ns5:Consumer>
        </ns3:Body>
    </ns3:CHL-SALESFORCE-CRM_UPD-CLI-DATA_RSP>
};

local:get_CHL-SALESFORCE-CRM_UPD-CLI-DATA_AdapterRSP_OK($LegacyRSP, $RequestHeader)