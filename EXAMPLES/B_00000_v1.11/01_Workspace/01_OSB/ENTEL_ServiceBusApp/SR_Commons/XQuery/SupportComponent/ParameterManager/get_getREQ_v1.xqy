xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/SC/ParameterManager/get/v1";

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v1";

declare variable $RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::) external;
declare variable $Keys as element() external;

declare function local:get_getREQ($RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::), 
                                  $Keys as element()) 
                                  as element() {
    <ns2:GetREQ>
        <ns1:RequestHeader>{$RequestHeader/*}</ns1:RequestHeader>
        <ns2:Keys>
            {
              for $Key in $Keys/*:Key return
                <ns2:Key>{fn:data($Key)}</ns2:Key>
            }
        </ns2:Keys>
    </ns2:GetREQ>
};

local:get_getREQ($RequestHeader, $Keys)
