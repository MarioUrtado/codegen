xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/CacheManager/lazyRefresh/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/lazyRefresh_CacheManager_v1_CSM.xsd" ::)

declare variable $key as element() (:: schema-element(ns1:LazyRefreshREQ) ::) external;

declare function local:lazyRefreshREQ_CacheManager($key as element() (:: schema-element(ns1:LazyRefreshREQ) ::)) as xs:string {
    if($key/ns1:Key/@source != "" and $key/ns1:Key/@category != "" and $key/ns1:Key/@instance != "") then 
      concat("key() = &#34;",$key/ns1:Key/@source,"|",$key/ns1:Key/@category,"|",$key/ns1:Key/@instance,"&#34;")
    else if ($key/ns1:Key/@source = "" and $key/ns1:Key/@category = "" and $key/ns1:Key/@instance = "") then
      "key() != &#34;&#34;"
    else if ($key/ns1:Key/@source != "" and $key/ns1:Key/@category != "") then
      concat("key() like &#34;",$key/ns1:Key/@source,"|",$key/ns1:Key/@category,"%&#34;")
    else if ($key/ns1:Key/@source != "") then
      concat("key() like &#34;",$key/ns1:Key/@source,"%&#34;")
    else
      concat("key() like &#34;",$key/ns1:Key/@source,"|",$key/ns1:Key/@category,"|",$key/ns1:Key/@instance,"%&#34;")
};

local:lazyRefreshREQ_CacheManager($key)
