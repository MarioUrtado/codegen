xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../../../../../../SR_Commons/XSD/ESO/Error_v1_ESO.xsd" ::)

declare variable $LegacyResponse as element() external;
declare variable $NativeLegacyResponse as xs:string external;

declare function local:CHL-SALESFORCE-CRM_JMS_SEB($LegacyResponse as element(), $NativeLegacyResponse as xs:string) as element() (:: schema-element(ns1:SourceError) ::) {
    
    let $SourceErrorCode	          := local:getSourceErrorCode($LegacyResponse)
    let $SourceErrorDescription 	  := local:getSourceErrorDescription($LegacyResponse)
    let $ErrorSourceCode                  := "CHL-SALESFORCE"
    let $ErrorSourceDetails               := "CHL-SALESFORCE-CRM_JMS_TW_AC"
    
    return 
    <ns1:SourceError code="{$SourceErrorCode}" description="{$SourceErrorDescription}">
        <ns1:ErrorSourceDetails source="{$ErrorSourceCode}" details="{$ErrorSourceDetails}"/>
        <ns1:SourceFault>{$NativeLegacyResponse}</ns1:SourceFault>
    </ns1:SourceError>
};

declare function local:getSourceErrorCode($LegacyResponse as element()) as xs:string
{
	
	let $FaultErrorCode := data($LegacyResponse/*:ResponseDetails/*:StatusCode)
	
	return $FaultErrorCode
};

declare function local:getSourceErrorDescription($LegacyResponse as element()) as xs:string
{
	let $FaultErrorDescription := data($LegacyResponse/*:ResponseDetails/*:StatusDesc)
	
	return $FaultErrorDescription
};

local:CHL-SALESFORCE-CRM_JMS_SEB($LegacyResponse, $NativeLegacyResponse)

