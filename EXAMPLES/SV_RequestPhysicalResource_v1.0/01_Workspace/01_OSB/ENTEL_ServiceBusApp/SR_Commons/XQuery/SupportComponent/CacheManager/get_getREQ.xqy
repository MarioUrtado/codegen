xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/CacheManager/get/v1";

declare variable $source as xs:string external;
declare variable $category as xs:string external;
declare variable $instance as xs:string external;

declare function local:getREQ_CacheManager($source as xs:string,
                                           $category as xs:string,
                                           $instance as xs:string) as element() {
    <ns2:GetREQ>
        <ns2:Key source="{$source}"
                 category="{$category}"
                 instance="{$instance}">
        </ns2:Key>
    </ns2:GetREQ>
};

local:getREQ_CacheManager($source, $category, $instance)
