xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace con="http://www.bea.com/wli/sb/context";
declare namespace ns1="http://www.entel.cl/SC/CacheManager/put/v1";

declare variable $source as xs:string external;
declare variable $category as xs:string external;
declare variable $instance as xs:string external;

declare variable $putRequest as element() external;

declare function local:putREQ_CacheManager($source as xs:string,
                                           $category as xs:string,
                                           $instance as xs:string,
                                           $putRequest as element()) as element() {
    <ns1:PutREQ>
        <ns1:Key source="{$source}"
                 category="{$category}"
                 instance="{$instance}">
        </ns1:Key>
        <ns1:Value>{$putRequest}</ns1:Value>
    </ns1:PutREQ>
};

local:putREQ_CacheManager($source, $category, $instance, $putRequest)
