xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ConversationManager/subscribe/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/subscribe_ConversationManager_v1_CSM.xsd" ::)

declare namespace ns2="http://www.entel.cl/SC/CorrelationMember/registerGroup/v1";
declare namespace ns3="http://www.entel.cl/SC/CorrelationManager/Aux/CorrelationMembers";
declare namespace ns4="http://www.entel.cl/ESO/MessageHeader/v1";
declare namespace ns5="http://www.entel.cl/SC/ConversationManager/Aux/Conversation";



declare variable $SubscribeREQ as element() (:: schema-element(ns1:SubscribeREQ) ::) external;

declare function local:get_RegisterGroupREQ_ConversationManager($SubscribeREQ as element() (:: schema-element(ns1:SubscribeREQ) ::)) 
                                              as element() {
  
<ns2:RegisterGroupREQ>
  {$SubscribeREQ/ns4:RequestHeader}
      <ns3:Group 
            ns3:groupName="{'CallbackSubscription'}" 
            ns3:groupDescription="Conversation Group For Conversation Subscribers">
            <ns3:Members>
                <ns3:Member>
                {
                    attribute ns3:memberName{'Subscriber'},
                    attribute ns3:memberType{'GroupOwner'},
                    attribute ns3:memberCorrID{data($SubscribeREQ/*[2]/*[1])},
                    attribute ns3:memberAddress{data($SubscribeREQ/*[2]/*[2]/@addr)}
                }
                </ns3:Member>
                 <ns3:Member>
                {
                    attribute ns3:memberName{'Provider'},
                    attribute ns3:memberType{'GroupProvider'},
                    attribute ns3:memberCorrID{data($SubscribeREQ/*[3]/*[1])}
                }
                </ns3:Member>
            </ns3:Members>
      </ns3:Group>
</ns2:RegisterGroupREQ>
  
};

local:get_RegisterGroupREQ_ConversationManager($SubscribeREQ)
