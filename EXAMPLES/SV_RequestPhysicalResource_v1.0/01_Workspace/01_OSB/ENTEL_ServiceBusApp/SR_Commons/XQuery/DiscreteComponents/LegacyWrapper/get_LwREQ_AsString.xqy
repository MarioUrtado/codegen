xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/CSM/LegacyWrapper/v1";
(:: import schema at "../../../XSD/CSM/LegacyWrapper_v1_CSM.xsd" ::)

declare namespace ns5 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v1";

declare namespace ns1 = "http://www.entel.cl/ESO/EndpointConfiguration/v1";

declare namespace ns6="http://www.entel.cl/CSM/LegacyWrapper/Aux/Common";
(:: import schema at "../../../XSD/LegacyWrapper_Common.xsd" ::)

declare namespace ns3="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare variable $RaName as xs:string external;
declare variable $RaAddr as xs:string external;
declare variable $RaCorrID as xs:string external;
declare variable $LegacyRequest as xs:string external;
declare variable $TargetOperation as xs:string external;
declare variable $TargetVersion as xs:string external;
declare variable $TargetAPI  as xs:string external;
declare variable $TargetProvider as xs:string external;
declare variable $RequestHeader as element() (:: schema-element(ns3:RequestHeader) ::) external;

declare function local:get_LwREQ_AsString(
                          $RaName as xs:string,
                          $RaAddr as xs:string,
                          $RaCorrID as xs:string,
                          $LegacyRequest as xs:string, 
                          $TargetOperation as xs:string,
                          $TargetVersion as xs:string,
                          $TargetAPI  as xs:string,
                          $TargetProvider as xs:string,
                          $RequestHeader as element() (:: schema-element(ns3:RequestHeader) ::)) 
                          as element() (:: schema-element(ns2:LwREQ) ::) {
                          
    <ns2:LwREQ>
        <ns2:LegacyREQ>
          {$LegacyRequest}
        </ns2:LegacyREQ>
        <ns6:RaDetails>
          {
            attribute name {$RaName},
            attribute addr {$RaAddr},
            attribute corrID {$RaCorrID}
          }
        </ns6:RaDetails>
        <ns1:Target provider="{$TargetProvider}" api="{$TargetAPI}" operation="{$TargetOperation}" version="{$TargetVersion}"/>
        {$RequestHeader}
    </ns2:LwREQ>
};

local:get_LwREQ_AsString($RaName, $RaAddr, $RaCorrID,$LegacyRequest,$TargetOperation,$TargetVersion,$TargetAPI,$TargetProvider,$RequestHeader)
