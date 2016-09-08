xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns2="http://www.entel.cl/SC/CorrelationMember/registerGroup/v1";
declare namespace ns3="http://www.entel.cl/SC/CorrelationManager/Aux/CorrelationMembers";

declare variable $RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::) external;
declare variable $GroupName as xs:string external;
declare variable $GroupDescription as xs:string? external;
declare variable $Members as element() external;

declare function local:get_RegisterGroupREQ($RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::), 
                                            $GroupName as xs:string, 
                                            $GroupDescription as xs:string?, 
                                            $Members as element()) 
                                              as element() {
  
    <ns2:RegisterGroupREQ>
        {$RequestHeader}
		<ns3:Group 
			ns3:groupName="{$GroupName}" 
			ns3:groupDescription="{$GroupDescription}">
			<ns3:Members>
				  {
				  for $Member in $Members/*:Member return
                                   <ns3:Member> 
                                            {
                                               if ($Member/@memberName!='') then attribute    ns3:memberName{$Member/@memberName} else (),
                                               if ($Member/@memberType!='') then attribute    ns3:memberType{$Member/@memberType} else (),
                                               if ($Member/@memberCorrID!='') then attribute  ns3:memberCorrID{$Member/@memberCorrID} else (),
                                               if ($Member/@memberAddress!='') then attribute ns3:memberAddress{$Member/@memberAddress} else ()
                                            }
                                    </ns3:Member>
                                  }
			</ns3:Members>
		</ns3:Group>
</ns2:RegisterGroupREQ>
  
};

local:get_RegisterGroupREQ($RequestHeader, $GroupName, $GroupDescription, $Members)
