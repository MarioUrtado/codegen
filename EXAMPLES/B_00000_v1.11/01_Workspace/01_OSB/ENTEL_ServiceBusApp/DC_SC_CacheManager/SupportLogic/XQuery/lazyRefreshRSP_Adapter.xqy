xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/CacheManager/lazyRefresh/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/lazyRefresh_CacheManager_v1_CSM.xsd" ::)

declare namespace ns2 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare variable $status as xs:string external;
declare variable $description as xs:string external;
declare variable $fault as element()? external;

declare function local:lazyRefreshRSP_Adapter($status as xs:string, 
                                              $description as xs:string, 
                                              $fault as element()?) as element() (:: schema-element(ns1:LazyRefreshRSP) ::) {
    <ns1:LazyRefreshRSP>
        <ns2:Result status="{$status}" description="{$description}">
        { if (xs:string($fault) != "") then
                <ns3:SourceError code="{data($fault/*:errorCode)}" description="{data($fault/*:reason)}">
                    <ns3:ErrorSourceDetails source="{'MDW'}" details="{$description}"/>
                    <ns3:SourceFault>{$fault}</ns3:SourceFault>
                </ns3:SourceError>
          else ()
        }
        </ns2:Result>
    </ns1:LazyRefreshRSP>
};

local:lazyRefreshRSP_Adapter($status, $description, $fault)
