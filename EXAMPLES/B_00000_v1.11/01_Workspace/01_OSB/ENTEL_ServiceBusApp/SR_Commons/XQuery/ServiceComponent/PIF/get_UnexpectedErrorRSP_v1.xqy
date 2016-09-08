xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns2="http://www.entel.cl/ESO/Exception/v1";
(:: import schema at "../../../XSD/ESO/Exception_v1_ESO.xsd" ::)

declare variable $ResponseHeader as element() (:: schema-element(ns1:ResponseHeader) ::) external;

declare function local:get_IF_UnexpectedErrorExceptionRSP_v1($ResponseHeader as element() (:: schema-element(ns1:ResponseHeader) ::))
  as element() (:: schema-element(ns2:UnexpectedErrorException) ::)

{
    <ns2:UnexpectedErrorException>
      {$ResponseHeader}
    </ns2:UnexpectedErrorException>
};

local:get_IF_UnexpectedErrorExceptionRSP_v1($ResponseHeader)
