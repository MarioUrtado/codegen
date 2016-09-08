xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/CacheManager/lazyRefresh/v1";
(:: import schema at "../../../DC_SC_CacheManager/SupportAPI/XSD/CSM/lazyRefresh_CacheManager_v1_CSM.xsd" ::)

declare variable $category as xs:string external;

declare function local:refreshCacheREQ($category as xs:string) 
                                       as element() (:: schema-element(ns1:LazyRefreshREQ) ::) {
    <ns1:LazyRefreshREQ>
        <ns1:Key source="ParameterManager" category="{fn:data($category)}">
        </ns1:Key>
    </ns1:LazyRefreshREQ>
};

local:refreshCacheREQ($category)
