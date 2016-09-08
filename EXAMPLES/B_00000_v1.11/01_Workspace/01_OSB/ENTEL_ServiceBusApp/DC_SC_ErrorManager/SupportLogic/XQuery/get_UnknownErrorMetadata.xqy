xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../../../SR_Commons/XSD/ESO/Error_v1_ESO.xsd" ::)

declare namespace http = "http://www.bea.com/wli/sb/transports/http";
declare namespace ctx = "http://www.bea.com/wli/sb/context";
declare namespace tp = "http://www.bea.com/wli/sb/transports";
declare namespace bpelx = "http://schemas.oracle.com/bpel/extension";

declare function local:get_UnknownErrorMetadata($ErrorFault as element(*)) as element() (:: schema-element(ns1:ErrorMetadata) ::) {
    
           let $FaultErrorCode    := local:getFaultErrorCode($ErrorFault)
     let $FaultErrorDescription   := local:getFaultErrorDescription($ErrorFault)
     let $FaultErrorState         := 'ERROR'  
     
     return
           
           <ns1:ErrorMetadata 
              code="{$FaultErrorCode}" 
              description="{substring($FaultErrorDescription,1,255)}" 
           />
     
};

(: ********************************************************************************************* :)
(: Retorna el Codigo del Error, segun la estructura recibida como Service Response:)
(: ********************************************************************************************* :)
declare function local:getFaultErrorCode($SourceFault as element(*)) as xs:string
{
        
        let $ErrorCode := 
        
        if (exists($SourceFault/*:bpelFault))
        (: Error Generico, proveniente de BPEL Extension :)
        then local:getSOAFaultErrorCode($SourceFault)
        
        (: Error Generico, proveniente de Service Bus o SOAP-ENV :)
        else local:getSBFaultErrorCode($SourceFault)
    
       return $ErrorCode
};

declare function local:getSBFaultErrorCode($SourceFault as element(*)) as xs:string
{
        let $ErrorCode :=  
        
        (: Errores Genericos, recibidos como SOAP-ENV:Fault :)
        if (exists($SourceFault//*:faultcode))  then data($SourceFault//*:faultcode) else
         
        (: Errores Genericos, recibidos como ctx:fault :)
        if (exists($SourceFault//*:errorCode))  then data($SourceFault//*:errorCode) else ''
        
        return $ErrorCode
};

declare function local:getSOAFaultErrorCode($SourceFault as element(*)) as xs:string
{
        (: Errores Genericos, recibidos como bpelx:remoteFault :)
        let $ErrorCode :=  if (exists($SourceFault/*:bpelFault/*:code))   then data($SourceFault/*:bpelFault/*:code) else ""
        
        return $ErrorCode
};

(: ********************************************************************************************* :)
(: Retorna la Descripcion del Error, segun la estructura recibida como Service Response:)
(: ********************************************************************************************* :)
declare function local:getFaultErrorDescription($SourceFault as element(*)) as xs:string
{
          let $ErrorDescription :=           
          
          (: Discriminar providencia del error :)
          if (exists($SourceFault/*:bpelFault))  
          
          (: Error Generico, proveniente de BPEL Extension :)
          then local:getSOAFaultErrorDescription($SourceFault )
          
          (: Error Generico, proveniente de ServiceBus Context o SOAP Envelope :)
          else local:getSBFaultErrorDescription($SourceFault)
          
          return $ErrorDescription
};

declare function local:getSBFaultErrorDescription($SourceFault as element(*)) as xs:string
{
          (: Errores Genericos, recibidos como ctx:fault :)
          let $CtxFaultDescription := if (exists($SourceFault//*:reason))       then data($SourceFault//*:reason) else ""
             
          (: Errores Genericos, recibidos como SOAP-ENV:Fault :)
          let $SoapFaultDescription := if (exists($SourceFault//*:faultstring)) then data($SourceFault//*:faultstring) else ""
          
          return concat( 
                        local:printErrorDetail("Fault Description",$SoapFaultDescription),
                        local:printErrorDetail("Reason",$CtxFaultDescription)
          )
};

declare function local:getSOAFaultErrorDescription($SourceFault as element(*)) as xs:string
{
          (: Errores Genericos, recibidos como bpelx:remoteFault :)
          let $SummaryFaultDescription :=  if (exists($SourceFault/*:bpelFault/*:detail))   then data($SourceFault/*:bpelFault/*:detail) else ""
          
          return $SummaryFaultDescription
};

(: ********************************************************************************************* :)
(: :)
(: ********************************************************************************************* :)
declare function local:printErrorDetail($ErrorHeader as xs:string, $ErrorDescription as xs:string) as xs:string
{
  let $NewLine := "&#10;"
  let $ErrorDetail :=  if ($ErrorDescription = '') then ('') else concat($NewLine,"[", $ErrorHeader, "] : ", $ErrorDescription)
  return $ErrorDetail
};

declare variable $ErrorFault as element(*) external;


local:get_UnknownErrorMetadata($ErrorFault)