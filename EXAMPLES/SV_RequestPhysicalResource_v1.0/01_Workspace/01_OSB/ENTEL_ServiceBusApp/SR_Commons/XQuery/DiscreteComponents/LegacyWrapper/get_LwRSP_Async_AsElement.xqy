xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../XSD/ESO/Result_v2_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/CSM/LegacyWrapper/v1";
(:: import schema at "../../../XSD/CSM/LegacyWrapper_v1_CSM.xsd" ::)

declare namespace ns4="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns6="http://www.entel.cl/CSM/LegacyWrapper/Aux/Common";
(:: import schema at "../../../XSD/LegacyWrapper_Common.xsd" ::)

declare variable $RaDetails as element() (:: schema-element(ns6:RaDetails) ::) external;
declare variable $LegacyRSP as element() external;
declare variable $RequestHeader as element()? (:: schema-element(ns4:RequestHeader) ::) external;

declare function local:get_LwRSP_Async_AsElement( 
                                        $RaDetails as element() (:: schema-element(ns6:RaDetails) ::) ,
                                        $RequestHeader as element() (:: schema-element(ns4:RequestHeader) ::),
                                        $LegacyRSP as element()
                                        )
                                       as element() (:: schema-element(ns2:LwRSP) ::) {
    <ns2:LwRSP>
        {$RequestHeader}  
        <ns2:LegacyRSP>
            {$LegacyRSP}
        </ns2:LegacyRSP>
        {$RaDetails}
    </ns2:LwRSP>
};

local:get_LwRSP_Async_AsElement($RaDetails, $RequestHeader, $LegacyRSP)
