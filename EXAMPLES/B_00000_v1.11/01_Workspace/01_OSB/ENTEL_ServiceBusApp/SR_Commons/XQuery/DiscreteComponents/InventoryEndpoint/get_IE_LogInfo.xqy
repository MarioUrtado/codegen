xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $IeName as xs:string external;
declare variable $body as element() external;

declare function local:get_IE_LogInfo($IeName as xs:string, 
                            $body as element()) 
                            as xs:string {
    fn:concat('InventoryEndpoint Name : ',
              $IeName ,
              '| TimeStamp: ',
              fn:current-dateTime(),
              ' | body: ',
              fn-bea:serialize($body)
            )  
};

local:get_IE_LogInfo($IeName, $body)
