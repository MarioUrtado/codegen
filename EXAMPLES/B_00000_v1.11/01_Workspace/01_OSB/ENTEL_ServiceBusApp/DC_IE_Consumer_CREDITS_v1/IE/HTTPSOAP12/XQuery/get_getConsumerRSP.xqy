xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.credits.com/entidades/xsd";
(:: import schema at "../WSDL/CreditsServices.wsdl" ::)
declare namespace ns2="http://www.entel.cl/EBM/Consumer/get/v1";
(:: import schema at "../../../../ES_Consumer_v1/ESC/Primary/get_Consumer_v1_EBM.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/EBO/Consumer/v1";

declare variable $getConsumerREQ as element() (:: schema-element(ns1:getConsumerREQ) ::) external;
declare variable $Get_Consumer_RSP as element()(:: schema-element(ns2:Get_Consumer_RSP) ::) external;

declare function local:get_getConsumerRSP($getConsumerREQ as element() (:: schema-element(ns1:getConsumerREQ) ::), 
                                          $Get_Consumer_RSP as element()(:: schema-element(ns2:Get_Consumer_RSP) ::)) 
                            as element() (:: schema-element(ns1:getConsumerRSP) ::) {
    <ns1:getConsumerRSP>
        <ns1:idTransaccion>{fn:data($getConsumerREQ/*[1])}</ns1:idTransaccion>
        <ns1:fechaYhoraTransaccion>{fn:data($getConsumerREQ/*[2])}</ns1:fechaYhoraTransaccion>
        <ns1:ConsumerName>{fn:data($Get_Consumer_RSP/*[2]/*[1]/ns3:ConsumerName)}</ns1:ConsumerName>
        <ns1:ConsumerSurename>{fn:data($Get_Consumer_RSP/*[2]/*[1]/ns3:ConsumerSurename)}</ns1:ConsumerSurename>
        <ns1:ConsumerAge>{fn:data($Get_Consumer_RSP/*[2]/*[1]/ns3:ConsumerAge)}</ns1:ConsumerAge>
        <ns1:ConsumerStatus>{fn:data($Get_Consumer_RSP/*[2]/*[1]/ns3:ConsumerStatus)}</ns1:ConsumerStatus>
        <ns1:ConsumerLegalType>{fn:data($Get_Consumer_RSP/*[2]/*[1]/ns3:ConsumerLegalType)}</ns1:ConsumerLegalType>
        <ns1:ResponseDateTime>{fn:current-dateTime()}</ns1:ResponseDateTime>
    </ns1:getConsumerRSP>
};

local:get_getConsumerRSP($getConsumerREQ, $Get_Consumer_RSP)
