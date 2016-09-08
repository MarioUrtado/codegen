xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.credits.com/entidades/xsd";
(:: import schema at "../WSDL/CreditsServices.wsdl" ::)

declare variable $delConsumerREQ as element() (:: schema-element(ns1:delConsumerREQ) ::) external;

declare function local:get_delConsumerRSP($delConsumerREQ as element() (:: schema-element(ns1:delConsumerREQ) ::)) as element() (:: schema-element(ns1:delConsumerRSP) ::) {
    <ns1:delConsumerRSP>
        <ns1:idTransaccion>{fn:data($delConsumerREQ/*[1])}</ns1:idTransaccion>
        <ns1:fechaYhoraTransaccion>{fn:data($delConsumerREQ/*[2])}</ns1:fechaYhoraTransaccion>
        <ns1:ResponseCode></ns1:ResponseCode>
        <ns1:ResponseDescription></ns1:ResponseDescription>
        <ns1:ResponseDateTime>{fn:current-dateTime()}</ns1:ResponseDateTime>
    </ns1:delConsumerRSP>
};

local:get_delConsumerRSP($delConsumerREQ)
