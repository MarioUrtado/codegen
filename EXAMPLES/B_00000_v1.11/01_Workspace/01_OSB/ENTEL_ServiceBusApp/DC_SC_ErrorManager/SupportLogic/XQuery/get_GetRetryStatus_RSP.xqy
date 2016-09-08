xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ErrorManager/RetryManager/getRetryStatus/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getRetryStatus_RetryManager_v1_CSM.xsd" ::)

declare namespace ns2 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare variable $retryCount as xs:decimal external;
declare variable $retryStatus as xs:string external;
declare variable $maxRetry as xs:decimal external;
declare variable $intervalTime as xs:decimal external;
declare variable $resultStatus as xs:string external;
declare variable $resultDescription as xs:string external;

declare function local:get_GetRetryStatus_RSP(
                                              $retryCount as xs:decimal, 
                                              $retryStatus as xs:string, 
                                              $maxRetry as xs:decimal, 
                                              $intervalTime as xs:decimal,
                                              $resultStatus as xs:string,
                                              $resultDescription as xs:string
                                              ) 
                                              as element() (:: schema-element(ns1:GetRetryStatus_RSP) ::) {
    <ns1:GetRetryStatus_RSP>
        <ns1:RetryConfig>
            {
              if( $resultStatus = 'OK'  )
              then <ns1:Config maxRetry="{xs:int(fn:data($maxRetry))}" intervalTime="{xs:string(fn:data($intervalTime))}" />
              else ()
            }
        </ns1:RetryConfig>
        {
          if($retryStatus != 'UNK' and $resultStatus = 'OK' )
          then <ns1:RetryStatus status="{$retryStatus}" retryCount="{xs:int(fn:data($retryCount))}" />
          else <ns1:RetryStatus status="{$retryStatus}" />
        }
        <ns2:Result status="{fn:data($resultStatus)}"  description="{fn:data($resultDescription)}"></ns2:Result>
    </ns1:GetRetryStatus_RSP>
};

local:get_GetRetryStatus_RSP($retryCount, $retryStatus, $maxRetry, $intervalTime, $resultStatus, $resultDescription)
