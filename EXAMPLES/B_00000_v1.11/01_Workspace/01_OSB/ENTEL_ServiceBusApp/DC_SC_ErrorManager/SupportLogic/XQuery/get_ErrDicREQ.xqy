xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/EDD/Dictionary/v1";
(:: import schema at "../../../SR_Commons/XSD/EDD/Dictionary_v1_EDD.xsd" ::)
declare namespace ns2="http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../../../SR_Commons/XSD/ESO/Error_v1_ESO.xsd" ::)
declare namespace ns3="http://www.entel.cl/SC/ErrorManager/ErrorDictionary/v1";
(:: import schema at "../XSD/ErrorDictionary.xsd" ::)



declare variable $ErrorIndex as element() (:: element(*, ns1:SimpleIndexDetail_Type) ::) external;
declare variable $ErrorSourceDetails as element() (:: schema-element(ns2:ErrorSourceDetails) ::) external;
declare variable $ErrorMetadata as element() (:: schema-element(ns2:ErrorMetadata) ::) external;

declare function local:get_ErrDicREQ($ErrorIndex as element() (:: element(*, ns1:SimpleIndexDetail_Type) ::), 
                                     $ErrorSourceDetails as element() (:: schema-element(ns2:ErrorSourceDetails) ::), 
                                     $ErrorMetadata as element() (:: schema-element(ns2:ErrorMetadata) ::))  as element() (:: schema-element(ns3:ErrDicREQ) ::)  {
    
    <ns3:ErrDicREQ>
        {$ErrorMetadata}
        {$ErrorIndex}
        {$ErrorSourceDetails}
    </ns3:ErrDicREQ>
};

local:get_ErrDicREQ($ErrorIndex, $ErrorSourceDetails, $ErrorMetadata)
