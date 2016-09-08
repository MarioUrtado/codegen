xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/CSM/SOAP11_ESCompatible_IE/v1";
(:: import schema at "../../../XSD/CSM/SOAP11_ESCompatible_IE_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";

declare variable $RequestHeader as element() (:: schema-element(ns2:RequestHeader) ::) external;
declare variable $IeName as xs:string external;
declare variable $sourceFault as element() external;
declare variable $sourceBody as element() external;

declare function local:get_IE_UnexpectedErrorExceptionHandlerREQ($RequestHeader as element() (:: schema-element(ns2:RequestHeader) ::), 
                                                                 $IeName as xs:string, 
                                                                 $sourceFault as element(), 
                                                                 $sourceBody as element()) 
                                                                 as element() (:: schema-element(ns1:IE_UnexpectedErrorExceptionHandlerREQ) ::) {
    <ns1:IE_UnexpectedErrorExceptionHandlerREQ>
        {$RequestHeader}       
        <ns1:IeName>{fn:data($IeName)}</ns1:IeName>
        <ns1:Fault>{$sourceFault}</ns1:Fault>
        <ns1:IeREQ>{$sourceBody}</ns1:IeREQ>
    </ns1:IE_UnexpectedErrorExceptionHandlerREQ>
};

local:get_IE_UnexpectedErrorExceptionHandlerREQ($RequestHeader, $IeName, $sourceFault, $sourceBody)
