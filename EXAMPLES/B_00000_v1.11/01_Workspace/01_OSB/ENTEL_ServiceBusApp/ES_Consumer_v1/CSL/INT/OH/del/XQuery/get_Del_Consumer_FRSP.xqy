xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/EBM/Consumer/del/v1";
(:: import schema at "../../../../../ESC/Primary/del_Consumer_v1_EBM.xsd" ::)
declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";

declare variable $ResponseHeader as element() (:: schema-element(ns1:ResponseHeader) ::) external;

declare function local:get_Del_Consumer_FRSP($ResponseHeader as element() (:: schema-element(ns1:ResponseHeader) ::)) as element() (:: schema-element(ns2:Del_Consumer_FRSP) ::) {
    <ns2:Del_Consumer_FRSP>
        {$ResponseHeader}
        <ns2:Body></ns2:Body>
    </ns2:Del_Consumer_FRSP>
};

local:get_Del_Consumer_FRSP($ResponseHeader)
