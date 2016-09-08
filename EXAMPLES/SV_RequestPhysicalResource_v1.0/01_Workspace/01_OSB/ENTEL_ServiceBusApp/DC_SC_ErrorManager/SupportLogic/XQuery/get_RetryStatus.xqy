xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $maxRetry as xs:string external;
declare variable $retryCount as xs:string external;
declare variable $status as xs:string external;

declare function local:func($maxRetry as xs:string, 
                            $retryCount as xs:string, 
                            $status as xs:string) 
                            as xs:string {
     if ( $status = 'PENDING' or $status =  'PROCESSING' )
     then if ( $maxRetry = $retryCount)
          then 'LRT'
          else 'ORT'
     else if ( $status = 'DONE_FAIL' or $status = 'DONE') 
          then 'FRT'
          else 'UNK' 
};

local:func($maxRetry, $retryCount, $status)
