xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../XSD/ESO/Result_v2_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/CSM/LegacyWrapper/v1";
(:: import schema at "../../../XSD/CSM/LegacyWrapper_v1_CSM.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns6="http://www.entel.cl/CSM/LegacyWrapper/Aux/Common";
(:: import schema at "../../../XSD/LegacyWrapper_Common.xsd" ::)

declare variable $Result as element() (:: schema-element(ns1:Result) ::) external;
declare variable $LegacyRSP as element() external;

declare function local:get_LwRSP_Sync_AsElement( 
                                        $Result as element() (:: schema-element(ns1:Result) ::), 
                                        $LegacyRSP as element()
                                        )
                                       as element() (:: schema-element(ns2:LwRSP) ::) {
    <ns2:LwRSP>
        {$Result}        
        <ns2:LegacyRSP>
            {$LegacyRSP}
        </ns2:LegacyRSP>
    </ns2:LwRSP>
};

local:get_LwRSP_Sync_AsElement($Result, $LegacyRSP)
