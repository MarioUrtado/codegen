xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns2="http://www.entel.cl/SC/ConversationManager/updStatus/v1";

declare namespace ns5="http://www.entel.cl/SC/ConversationManager/Aux/ConversationStatus";

declare namespace con = "http://www.entel.cl/SC/ConversationManager/Aux/ConversationStatus";
declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../XSD/ESO/Result_v2_ESO.xsd" ::)

declare variable $ConversationID as xs:string (:: ns1:conversationID_SType ::)  external;
declare variable $ConversationStatus as xs:string  external;
declare variable $Result as element() (:: schema-element(ns3:Result) ::)  external;
declare variable $ResponseMessage as element()? external;
declare variable $SourceComponentName as xs:string external;
declare variable $SourceComponentOperation as xs:string? external;

declare function local:get_GetStatusREQ(
$ConversationID as xs:string (:: ns1:conversationID_SType ::),
$ConversationStatus as xs:string,
$Result as element() (:: schema-element(ns3:Result) ::),
$ResponseMessage as element()?,
$SourceComponentName as xs:string,
$SourceComponentOperation as xs:string?
) as element() {
    <ns2:UpdStatusREQ>
        <ns2:ConversationID>{$ConversationID}</ns2:ConversationID>
        <ns2:ConversationStatus status="{$ConversationStatus}">
            <con:ReponseMessage>{$ResponseMessage}</con:ReponseMessage>
            {$Result}
        </ns2:ConversationStatus>
        <ns2:SourceComponent component="{$SourceComponentName}" operation="{$SourceComponentOperation}">
        </ns2:SourceComponent>
    </ns2:UpdStatusREQ>
};

local:get_GetStatusREQ($ConversationID, $ConversationStatus, $Result, $ResponseMessage, $SourceComponentName, $SourceComponentOperation)
