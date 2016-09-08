xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/CacheManager/get/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/get_CacheManager_v1_CSM.xsd" ::)

declare variable $GetREQ as element() (:: schema-element(ns1:GetREQ) ::) external;

declare function local:getREQ_Adapter($GetREQ as element() (:: schema-element(ns1:GetREQ) ::)) as xs:string {
      fn:concat(
      data($GetREQ/ns1:Key/@source),"|",
      data($GetREQ/ns1:Key/@category),"|",
      normalize-space(data($GetREQ/ns1:Key/@instance)))
};

local:getREQ_Adapter($GetREQ)
