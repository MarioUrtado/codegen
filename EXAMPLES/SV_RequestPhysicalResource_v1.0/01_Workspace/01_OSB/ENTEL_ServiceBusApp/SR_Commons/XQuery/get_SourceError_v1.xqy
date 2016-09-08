xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../XSD/ESO/Error_v1_ESO.xsd" ::)

declare variable $SourceErrorCode as xs:string external;
declare variable $SourceErrorDescription as xs:string external;
declare variable $SourceFault as element() external;
declare variable $ErrorSourceCode as xs:string external;
declare variable $ErrorSourceDetails as xs:string external;

declare function local:get_SourceError_v1($SourceErrorCode, $SourceErrorDescription, $SourceFault as element(), $ErrorSourceCode, $ErrorSourceDetails) as element() (:: schema-element(ns1:SourceError) ::) {
    
    <ns1:SourceError code="{$SourceErrorCode}" description="{$SourceErrorDescription}">
        <ns1:ErrorSourceDetails source="{$ErrorSourceCode}" details="{$ErrorSourceDetails}"/>
        <ns1:SourceFault>{$SourceFault}</ns1:SourceFault>
    </ns1:SourceError>
};

declare function local:getSourceErrorCode($ErrorFault as element()) as xs:string
{
	
	let $FaultErrorCode := data($ErrorFault/*[1]/*[1])
	
	return $FaultErrorCode
};

declare function local:getSourceErrorDescription($ErrorFault as element()) as xs:string
{
	let $FaultErrorDescription := data($ErrorFault/*[1]/*[2])
	
	return $FaultErrorDescription
};

local:get_SourceError_v1(
  $SourceErrorCode,
  $SourceErrorDescription,
  $SourceFault,
  $ErrorSourceCode,
  $ErrorSourceDetails
)