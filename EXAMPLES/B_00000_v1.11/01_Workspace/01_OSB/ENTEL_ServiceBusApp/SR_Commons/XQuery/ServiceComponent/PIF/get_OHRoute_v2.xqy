xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns1="http://www.entel.cl/XQuery/getOperationHandlerRoute";
declare namespace ctx="http://www.bea.com/wli/sb/context";

declare variable $requestHeader as element() (:: element(*, ns2:MessageHeader_Type) ::) external;
declare variable $serviceVersion as xs:string external;

(:~
 : This function creates the routing XML tags required to dynamically route a message from
 : the PIF to the desired Operation Handler. It uses the indormation in the Request Header
 : as a parameter to do so.
 :)

declare function ns1:get_OHRoute_v2($requestHeader as element() (:: element(*, ns2:MessageHeader_Type) ::), $serviceVersion) as element() {
    
     let $COUNTRY := data($requestHeader/*:Consumer/@countryCode)
     let $ES_NAME := data($requestHeader/*:Trace/*:Service/@name)
     let $CAP_NAME := data($requestHeader/*:Trace/*:Service/@operation)
     let $PRJ_NAME := fn:concat("ES_",$ES_NAME,"_v",$serviceVersion)
     let $OH_NAME := concat($COUNTRY,"_",$CAP_NAME,"_",$ES_NAME,"_OH")
                      
    return
                      
    <ctx:route>
      <ctx:pipeline>{ fn:concat($PRJ_NAME,"/CSL/",$COUNTRY,"/OH/",$CAP_NAME,"/",$OH_NAME) }</ctx:pipeline>
    </ctx:route>
};

ns1:get_OHRoute_v2($requestHeader, $serviceVersion)
