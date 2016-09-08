xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../XSD/ESO/Result_v2_ESO.xsd" ::)

declare namespace ns2="http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../XSD/ESO/Error_v1_ESO.xsd" ::)

declare variable $resultStatus as xs:string (:: ns1:resultStatus_SType ::)  external;
declare variable $resultDescription as xs:string external;
declare variable $canonicalErrorCode as xs:string external;
declare variable $canonicalErrorDescription as xs:string external;
declare variable $canonicalErrorType as xs:string (:: ns2:CanonicalErrorType_SType ::) external;
declare variable $sourceErrorCode as xs:string external;
declare variable $sourceErrorDescription as xs:string external;
declare variable $sourceFault as element()? external;
declare variable $errorSourceCode as xs:string external;
declare variable $errorSourceDetails as xs:string external;

declare function local:get_Result_Simple($resultStatus as xs:string (:: ns1:resultStatus_SType ::) , 
                                         $resultDescription as xs:string,
                                         $canonicalErrorCode as xs:string, 
                                         $canonicalErrorDescription as xs:string,
                                         $canonicalErrorType as xs:string (:: ns2:CanonicalErrorType_SType ::),
                                         $sourceErrorCode as xs:string, 
                                         $sourceErrorDescription as xs:string,
                                         $sourceFault as element()?,
                                         $errorSourceCode as xs:string, 
                                         $errorSourceDetails as xs:string
                                         ) as element()  (:: schema-element(ns1:Result) ::) {
   
   <ns1:Result status="{fn:data($resultStatus)}" description="{fn:data($resultDescription)}">
       <ns2:CanonicalError code="{fn:data($canonicalErrorCode)}" description="{fn:data($canonicalErrorDescription)}" type="{fn:data($canonicalErrorType)}">
       </ns2:CanonicalError>
       <ns2:SourceError>
        {
          if ($sourceErrorCode) 
            then attribute code {fn:data($sourceErrorCode)}
            else ()
        }
        {
          if ($sourceErrorDescription) 
            then attribute description {fn:data($sourceErrorDescription)}
            else ()
        } 
           <ns2:ErrorSourceDetails>
                   {
          if ($errorSourceCode) 
            then attribute source {fn:data($errorSourceCode)}
            else ()
          }
          {
            if ($errorSourceDetails) 
              then attribute details {fn:data($errorSourceDetails)}
              else ()
          } 
        
           </ns2:ErrorSourceDetails>
           {
               if ($sourceFault)
               then <ns2:SourceFault>{$sourceFault}</ns2:SourceFault>
               else ()
           }
       </ns2:SourceError>
   </ns1:Result>
   
};

local:get_Result_Simple($resultStatus, $resultDescription, $canonicalErrorCode, $canonicalErrorDescription, $canonicalErrorType, $sourceErrorCode, $sourceErrorDescription, $sourceFault, $errorSourceCode, $errorSourceDetails)

