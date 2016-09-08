xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../../../../../../SR_Commons/XSD/ESO/Error_v1_ESO.xsd" ::)

declare namespace http="http://www.bea.com/wli/sb/transports/http";
declare namespace ctx="http://www.bea.com/wli/sb/context";
declare namespace tran="http://www.bea.com/wli/sb/transports";

declare variable $LegacyResponse as element() external;
declare variable $LegacyResult as element()? external;

declare function local:PER-SIE-EAI_HTTPSOAP11_SEB($LegacyResponse as element(), $LegacyResult as element()?) as element() (:: schema-element(ns1:SourceError) ::) {
  
    let $SourceErrorCode	          := local:getSourceErrorCode()
    let $SourceErrorDescription 	  := local:getSourceErrorDescription()
    let $ErrorSourceCode                  := "PER-SIE"
    let $ErrorSourceDetails               := "PER-SIE-EAI_HTTPSOAP11_TW"
    
    return 
        <ns1:SourceError code="{$SourceErrorCode}" description="{$SourceErrorDescription}">
            <ns1:ErrorSourceDetails source="{$ErrorSourceCode}" details="{$ErrorSourceDetails}"/>
            <ns1:SourceFault>{$LegacyResponse}</ns1:SourceFault>
        </ns1:SourceError>
};

declare function local:getSourceErrorCode() as xs:string
{
	
	let $FaultErrorCode := 
          if(exists($LegacyResponse/*:STATUS_CODE)) then
            data($LegacyResponse/*:STATUS_CODE)
          else
              if(exists($LegacyResult/http:http-response-code)) then
                data($LegacyResult/http:http-response-code)
          (: 
            If the main option for identifying the Legacy Result Code is not found within the $LegacyREQ, 
            depending on each case, the code can be taken from elsewhere. 
            
            This would be an example, where the Legacy Result code is then taken from the HTTP Response Code
            found in the $LegacyResult variable.
            
            As the Legacy's endpoints are mostly HTTP-based, this behaviour was chosen to be left 
            as template; there is no other reason for it. 
              
            If there is no other options on where to take the Legacy Result Code,  the  value 'FRW-Default' 
            should be returned instead.
          :)
          
          else
            ('FRW-Default')

	return $FaultErrorCode
};

declare function local:getSourceErrorDescription() as xs:string
{
          let $FaultErrorDescription := 
            if(exists($LegacyResponse/*:STATUS_DESC)) then
              data($LegacyResponse/*:STATUS_DESC)
                else
                  if(exists($LegacyResult/tran:response-message)) then
                    data($LegacyResult/tran:response-message)
              (: 
                If the main option for identifying the Legacy Result Description is not found within the $LegacyREQ, 
                depending on each case, the description can be taken from elsewhere. 
                
                This would be an example, where the Legacy Result Description is then taken from the HTTP Response Message
                found in the $LegacyResult variable.
  
                As the Legacy's endpoints are mostly HTTP-based, this behaviour was chosen to be left 
                as template; there is no other reason for it. 
                  
                If there is no other options on where to take the Legacy Result Description,  the  value 
                'No Legacy Result Information was found. This is a default Legacy Result.' 
                should be returned instead.
              :)
          
              else
                ('No Legacy Result Information was found. This is a default Legacy Result.')
	
	return $FaultErrorDescription
};

local:PER-SIE-EAI_HTTPSOAP11_SEB($LegacyResponse, $LegacyResult)

