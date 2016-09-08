xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/CSM/RA/INT-SIE-MAR/createUpdateMarketingCampaign/v1";
(:: import schema at "../CSC/INT-SIE-MAR_createUpdateMarketingCampaign_v1_CSM.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare variable $Result as element() (:: schema-element(ns3:Result) ::) external;


declare function local:get_INT-SIE-MAR_createUpdateMarketingCampaign_AdapterRSP_ERROR($Result as element() (:: schema-element(ns3:Result) ::)) as element() (:: schema-element(ns2:INT-SIE-MAR_createUpdateMarketingCampaign_RSP) ::) {
    <ns2:INT-SIE-MAR_createUpdateMarketingCampaign_RSP>
        {$Result}
        <ns2:Body>
        </ns2:Body>
    </ns2:INT-SIE-MAR_createUpdateMarketingCampaign_RSP>
};

local:get_INT-SIE-MAR_createUpdateMarketingCampaign_AdapterRSP_ERROR($Result)