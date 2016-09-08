xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns4="http://www.entel.cl/EDD/Dictionary/v1";
(:: import schema at "../../../XSD/EDD/Dictionary_v1_EDD.xsd" ::)
declare namespace ns3="http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../../../XSD/ESO/Error_v1_ESO.xsd" ::)
declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../XSD/ESO/Result_v2_ESO.xsd" ::)
declare namespace ns6="http://www.entel.cl/ESO/Tracer/v1";
(:: import schema at "../../../XSD/ESO/Tracer_v1_ESO.xsd" ::)

declare namespace ns5="http://www.entel.cl/SC/LoggerManager/error/v1";


declare variable $HeaderTracer as element() (:: element(ns6:HeaderTracer) ::) external;
declare variable $Result as element() (:: schema-element(ns2:Result) ::) external;
declare variable $ErrorIndex as element() (:: schema-element(ns3:ErrorIndex) ::) external;
declare variable $ErrorPlaceHolder as element() (:: element(*, ns4:SimpleEventPlaceHolderDetail_Type) ::) external;

declare function local:get_errorREQ_v2($HeaderTracer as element() (:: element(ns6:HeaderTracer) ::), 
                                     $Result as element() (:: schema-element(ns2:Result) ::), 
                                     $ErrorIndex as element() (:: schema-element(ns3:ErrorIndex) ::), 
                                     $ErrorPlaceHolder as element() (:: element(*, ns4:SimpleEventPlaceHolderDetail_Type) ::))
                                     as element() {
    
    <ns5:ErrorREQ>
        {$HeaderTracer}
        {$Result}
        {$ErrorIndex}
        {$ErrorPlaceHolder}
    </ns5:ErrorREQ>
    
};

local:get_errorREQ_v2($HeaderTracer, $Result, $ErrorIndex, $ErrorPlaceHolder)
