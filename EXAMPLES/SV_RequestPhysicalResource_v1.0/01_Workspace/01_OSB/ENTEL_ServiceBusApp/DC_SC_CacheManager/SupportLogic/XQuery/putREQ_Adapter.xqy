xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/CacheManager/put/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/put_CacheManager_v1_CSM.xsd" ::)

declare variable $PutREQ as element() (:: schema-element(ns1:PutREQ) ::) external;

declare function local:putREQ_Adapter($PutREQ as element() (:: schema-element(ns1:PutREQ) ::)) as xs:string {
    fn:concat($PutREQ/ns1:Key/@source,"|", $PutREQ/ns1:Key/@category,"|", $PutREQ/ns1:Key/@instance)
};

local:putREQ_Adapter($PutREQ)
