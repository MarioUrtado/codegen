xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/EBM/%SERVICE_NAME%/%CAPABILITY_NAME%/v1";
(:: import schema at "../../../../../ESC/Primary/%CAPABILITY_NAME%_%SERVICE_NAME%_v1_EBM.xsd" ::)
declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare variable $ResponseHeader as element() (:: schema-element(ns1:ResponseHeader) ::) external;

declare function local:get_%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_FRSP($ResponseHeader as element() (:: schema-element(ns1:ResponseHeader) ::)) as element() (:: schema-element(ns2:%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_FRSP) ::) {
    <ns2:%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_FRSP>
        {$ResponseHeader}
        <ns2:Body></ns2:Body>
    </ns2:%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_FRSP>
};

local:get_%CAPABILITY_REQ_NAME%_%SERVICE_NAME%_FRSP($ResponseHeader)
