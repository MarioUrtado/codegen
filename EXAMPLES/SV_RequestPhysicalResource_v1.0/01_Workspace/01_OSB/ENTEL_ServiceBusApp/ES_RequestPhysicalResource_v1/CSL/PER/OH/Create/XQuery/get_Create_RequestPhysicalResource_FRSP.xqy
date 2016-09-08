xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/EBM/RequestPhysicalResource/Create/v1";
(:: import schema at "../../../../../ESC/Primary/Create_RequestPhysicalResource_v1_EBM.xsd" ::)
declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare variable $ResponseHeader as element() (:: schema-element(ns1:ResponseHeader) ::) external;

declare function local:get_Create_RequestPhysicalResource_FRSP($ResponseHeader as element() (:: schema-element(ns1:ResponseHeader) ::)) as element() (:: schema-element(ns2:Create_RequestPhysicalResource_FRSP) ::) {
    <ns2:Create_RequestPhysicalResource_FRSP>
        {$ResponseHeader}
        <ns2:Body></ns2:Body>
    </ns2:Create_RequestPhysicalResource_FRSP>
};

local:get_Create_RequestPhysicalResource_FRSP($ResponseHeader)
