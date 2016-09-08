xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../../../XSD/ESO/Error_v1_ESO.xsd" ::)

declare namespace ns2="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns1="http://www.entel.cl/ESO/EnterpriseService/v1";
(:: import schema at "../../../XSD/ESO/EnterpriseService_v1_ESO.xsd" ::)

declare namespace ctx="http://www.bea.com/wli/sb/context";

declare variable $RequestHeader as element() (:: schema-element(ns2:RequestHeader) ::) external;
declare variable $ESArchitecture as element() (:: schema-element(ns1:EnterpriseService) ::) external;

declare function local:get_OHRoute_v3($RequestHeader as element() (:: schema-element(ns2:RequestHeader) ::), $ESArchitecture as element() (:: schema-element(ns1:EnterpriseService) ::)) as element () {
     
     let $ServiceName := data($RequestHeader/*:Trace/*:Service/@name)
     let $ServiceOperation := data($RequestHeader/*:Trace/*:Service/@operation)
     let $SupportedCountry := local:getSupportedCountry($ServiceOperation)
     
    return
    
    if($SupportedCountry="99") then 
      (: 
        There is no OH Component able to handle the requested service operation. This is probably due to an incompatilbe combination of
        Service + Capability + Country.
        
        The routing returned here forces a redirect from the PIF to an auxiliary pipeline with a predefined behaviour 
        made to handle such scenarios.
      :)
      <ctx:route>
        <ctx:service isProxy="true">SR_Commons/CommonTools/PIF_UnsupportedOperation/PIF_UnsupportedOperation</ctx:service>
      </ctx:route>
    else
      <ctx:route>
        <ctx:pipeline>{local:getOHPath($SupportedCountry, $ServiceOperation, $ServiceName)}</ctx:pipeline>
      </ctx:route>
};

declare function local:getOHPath($SupportedCountry as xs:string, $ServiceOperation as xs:string, $ServiceName as xs:string){
  fn:concat(local:getESProjectName($ServiceName),"/CSL/",$SupportedCountry,"/OH/",$ServiceOperation,"/",local:getOHName($SupportedCountry, $ServiceOperation, $ServiceName))
};

declare function local:getOHName($SupportedCountry as xs:string, $ServiceOperation as xs:string, $ServiceName as xs:string) as xs:string{
  concat($SupportedCountry,"_",$ServiceOperation,"_",$ServiceName,"_OH")
};

declare function local:getESProjectName($ServiceName as xs:string) as xs:string{

  fn:concat("ES_",$ServiceName,"_v",data($ESArchitecture/@majorVersion))

};

declare function local:getSupportedCountry($ServiceOperation as xs:string) as xs:string{

  let $ConsumerCountry := data($RequestHeader/*:Consumer/@countryCode)
     
  return

    if (exists($ESArchitecture/*[3]/*[@code=$ConsumerCountry]/*[@opName=$ServiceOperation])) then
      $ConsumerCountry
    else
      if (exists($ESArchitecture/*[3]/*[@code='INT']/*[@opName=$ServiceOperation])) then
        if (exists($ESArchitecture/*[3]/*[@code='INT']/*[@opName=$ServiceOperation]/@supports)) then
          if (fn:contains(data($ESArchitecture/*[3]/*[@code='INT']/*[@opName=$ServiceOperation]/@supports), $ConsumerCountry)) then
            'INT'
          else
            '99'
        else
          'INT'
      else
        '99'
};

local:get_OHRoute_v3($RequestHeader, $ESArchitecture)
