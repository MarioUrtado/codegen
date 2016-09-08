xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/EndpointConfiguration/v1";
(:: import schema at "../../../XSD/ESO/EndpointConfiguration_v1_ESO.xsd" ::)

declare namespace ns2="http://www.entel.cl/CSM/TransportWrapper/v1";
(:: import schema at "../../../XSD/CSM/TransportWrapper_v1_CSM.xsd" ::)

declare namespace ns3="http://www.entel.cl/CSM/LegacyWrapper/Aux/Common";
(:: import schema at "../../../XSD/LegacyWrapper_Common.xsd" ::)

declare namespace ns4="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare variable $LegacyREQ as element() external;
declare variable $Endpoint as element() (:: schema-element(ns1:Endpoint) ::) external;
declare variable $RaDetails as element() (:: schema-element(ns3:RaDetails) ::) external;
declare variable $RequestHeader as element() (:: schema-element(ns4:RequestHeader) ::) external;

declare function local:get_PwREQ($LegacyREQ as element(), 
                                 $Endpoint as element() (:: schema-element(ns1:Endpoint) ::),
                                 $RaDetails as element() (:: schema-element(ns3:RaDetails) ::),
                                 $RequestHeader as element()? (:: schema-element(ns4:RequestHeader) ::)
                                 )  
                                 as element() (:: schema-element(ns2:TwREQ) ::) {
                                 
    <ns2:TwREQ>
        {$RequestHeader}
        {$LegacyREQ}
        {$RaDetails}
        {$Endpoint}
    </ns2:TwREQ>
};

local:get_PwREQ($LegacyREQ, $Endpoint, $RaDetails, $RequestHeader)