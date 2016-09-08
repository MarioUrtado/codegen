xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.entel.cl/CSM/RA/INT-SIE-EAI/getMarketingCampaign/v1";
(:: import schema at "../CSC/INT-SIE-EAI_getMarketingCampaign_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns5 = "http://www.entel.cl/EBO/Consumer/v1";

declare variable $AdapterRSP as element()? (:: schema-element(ns3:INT-SIE-EAI_getMarketingCampaign_RSP) ::) external;
declare variable $GetMappingRSP as element() external;

declare function local:get_INT-SIE-EAI_getMarketingCampaign_RSPMappings($AdapterRSP as element()? (:: schema-element(ns3:INT-SIE-EAI_getMarketingCampaign_RSP) ::)
                                                                      ,$GetMappingRSP as element()) 
                                                                  as element() (:: schema-element(ns3:INT-SIE-EAI_getMarketingCampaign_RSP) ::) {
    <ns3:INT-SIE-EAI_getMarketingCampaign_RSP>
        {$AdapterRSP/*[1]}
        <ns3:Body>
        </ns3:Body>
    </ns3:INT-SIE-EAI_getMarketingCampaign_RSP>
};

local:get_INT-SIE-EAI_getMarketingCampaign_RSPMappings($AdapterRSP, $GetMappingRSP)