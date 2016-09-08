xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/CorrelationManager/getCorrelation/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getCorrelation_CorrelationManager_v1_CSM.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getCorrelationMemberAdapter";
(:: import schema at "../JCA/getCorrelationMemberAdapter/getCorrelationMemberAdapter_sp.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare namespace ns5 = "http://www.entel.cl/ESO/MessageHeader/v1";

declare namespace cor = "http://www.entel.cl/SC/CorrelationManager/Aux/CorrelationMembers";

declare variable $OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare variable $Result as element() (:: schema-element(ns3:Result) ::)  external;



declare function local:getGroupName($idGrup as xs:integer, $OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::)) as xs:string {
      
   if(data($OutputParameters/*[1]/*/*[4])=$idGrup) 
         then ($OutputParameters/*[1]/ns1:CORRELATION_MESSAGE_Row/*[1])[1]
         
        else()
      
};

declare function local:getRequestHeader($idGrup as xs:integer, $OutputParameters as element() (:: schema-element(ns1:OutputParameters) ::)) as xs:string {
      
   if(data($OutputParameters/*[1]/*/*[4])=$idGrup) 
         then ($OutputParameters/*[1]/ns1:CORRELATION_MESSAGE_Row/*[2])[1]
         
        else()
      
};

declare function local:deduplicate($list) {
  if (fn:empty($list)) then ()
  else 
    let $head := $list[1],
      $tail := $list[position() > 1]
    return
      if (fn:exists($tail[ . = $head ])) then local:deduplicate($tail)
      else ($head, local:deduplicate($tail))
};


                          


declare function local:func($OutputParameters as element()? (:: schema-element(ns1:OutputParameters) ::)  ,$Result as element() (:: schema-element(ns3:Result) ::)  ) as element() (:: schema-element(ns2:GetCorrelationRSP) ::) {
   
     let $listIdGroup := local:deduplicate(data($OutputParameters/*[1]/*/*[4]))
    return 
    <ns2:GetCorrelationRSP>
        {
            $Result
        }      
       {  if($Result/@*:status='OK') then
           <ns2:Group>
              {
                  for $idGrup in $listIdGroup
                  return 
                          <cor:GroupDetail>
                                     {fn-bea:inlinedXML(local:getRequestHeader($idGrup,$OutputParameters))}
                                    <cor:Group cor:groupName="{ local:getGroupName($idGrup,$OutputParameters)}">
                                        <cor:Members>{
                                             for $CORRELATION_MESSAGE_Row in $OutputParameters/ns1:CORRELATION_MESSAGE/ns1:CORRELATION_MESSAGE_Row
                                                          return
                                                            if($CORRELATION_MESSAGE_Row/*[4]=$idGrup)then
                                                                  <cor:Member cor:memberName="{$CORRELATION_MESSAGE_Row/*[5]}" cor:memberType="{$CORRELATION_MESSAGE_Row/*[7]}" cor:memberCorrID="{$CORRELATION_MESSAGE_Row/*[6]}"   cor:memberAddress="{$CORRELATION_MESSAGE_Row/*[8]}"  />
                                                                else()
                                              }
                                        
                                        </cor:Members>
                                    </cor:Group>
                      </cor:GroupDetail>
                         
                  
              }
          </ns2:Group>
          
           else()
         }
    </ns2:GetCorrelationRSP>
};

local:func($OutputParameters,$Result)
