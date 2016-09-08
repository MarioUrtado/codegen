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

declare variable $LegacyRSP as element()? (:: schema-element(ns1:ClientObtain_RESPONSE) ::) external;
declare variable $Result as element() (:: schema-element(ns2:Result) ::) external;

declare function local:get_CHL-SALESFORCE-CRM_ClientObtain_AdapterRSP_OK($LegacyRSP as element()? (:: schema-element(ns1:ClientObtain_RESPONSE) ::), 
                                                                  $Result as element() (:: schema-element(ns2:Result) ::)) 
                                                                  as element() (:: schema-element(ns3:CHL-SALESFORCE-CRM_ClientObtain_RSP) ::) {
    <ns3:CHL-SALESFORCE-CRM_ClientObtain_RSP>
       {$Result}
        {if ($LegacyRSP) then
            <ns3:Body>
                 <ns5:Consumer>
                     <ns5:ConsumerName>{fn:data($LegacyRSP/ns1:CLI_NAME)}</ns5:ConsumerName>
                     <ns5:ConsumerSurename>{fn:data($LegacyRSP/ns1:CLI_SNAME)}</ns5:ConsumerSurename>
                     {
                         if ($LegacyRSP/ns1:CLI_AGE)
                         then <ns5:ConsumerAge>{fn:data($LegacyRSP/ns1:CLI_AGE)}</ns5:ConsumerAge>
                         else ()
                     }
                     <ns5:ConsumerStatus>{fn:data($LegacyRSP/ns1:CLI_STAT)}</ns5:ConsumerStatus>
                     {
                         if ($LegacyRSP/ns1:CLI_TYPE)
                         then <ns5:ConsumerLegalType>{fn:data($LegacyRSP/ns1:CLI_TYPE)}</ns5:ConsumerLegalType>
                         else ()
                     }
                 </ns5:Consumer>
             </ns3:Body>
         else
          ()
         }
    </ns3:CHL-SALESFORCE-CRM_ClientObtain_RSP>
};

local:get_CHL-SALESFORCE-CRM_ClientObtain_AdapterRSP_OK($LegacyRSP, $Result)