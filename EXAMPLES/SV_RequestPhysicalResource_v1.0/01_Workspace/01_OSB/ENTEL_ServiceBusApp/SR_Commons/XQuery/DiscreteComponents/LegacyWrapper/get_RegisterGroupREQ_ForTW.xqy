xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns2="http://www.entel.cl/SC/CorrelationMember/registerGroup/v1";
declare namespace ns3="http://www.entel.cl/SC/CorrelationManager/Aux/CorrelationMembers";

declare variable $RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::) external;
declare variable $TwName as xs:string external;
declare variable $LegacyProvider as xs:string external;
declare variable $LegacyCorrID as xs:string external;
declare variable $Members as element() external;
declare variable $RaDetails as element() external;

declare function local:get_RegisterGroupREQ_ForTW($RequestHeader as element() (:: schema-element(ns1:RequestHeader) ::), 
                                            $TwName as xs:string, 
                                            $LegacyProvider as xs:string, 
                                            $LegacyCorrID as xs:string, 
                                            $RaDetails) 
                                              as element() {
  
    <ns2:RegisterGroupREQ>
        {$RequestHeader}
		<ns3:Group 
			ns3:groupName="{$TwName}" 
			ns3:groupDescription="Correlation Group for an Async TW">
			<ns3:Members>
				
                              <ns3:Member>
                                        {
                                          if ($RaDetails/@name!='') then attribute ns3:memberName{$RaDetails/@name} else (),
                                          attribute ns3:memberType{'GroupController'},
                                          if ($RaDetails/@corrID!='') then attribute ns3:memberCorrID{$RaDetails/@corrID} else (),
                                          if ($RaDetails/@addr!='') then attribute ns3:memberAddress{$RaDetails/@addr} else ()
                                        }
                               </ns3:Member>
                              
                              <ns3:Member>
                                        {
                                          if ($TwName!='') then attribute ns3:memberName{$TwName} else (),
                                          attribute ns3:memberType{'GroupOwner'},
                                          if ($LegacyCorrID!='') then attribute ns3:memberCorrID{$LegacyCorrID} else ()
                                        }
                               </ns3:Member>
                              
                              <ns3:Member>
                                        {
                                          if ($LegacyProvider!='') then attribute ns3:memberName{$LegacyProvider} else (),
                                          attribute ns3:memberType{'GroupProvider'},
                                          if ($LegacyCorrID!='') then attribute ns3:memberCorrID{$LegacyCorrID} else ()
                                        }
                               </ns3:Member>

			</ns3:Members>
		</ns3:Group>
</ns2:RegisterGroupREQ>
  
};

local:get_RegisterGroupREQ_ForTW($RequestHeader, $TwName, $LegacyProvider, $LegacyCorrID, $RaDetails)
