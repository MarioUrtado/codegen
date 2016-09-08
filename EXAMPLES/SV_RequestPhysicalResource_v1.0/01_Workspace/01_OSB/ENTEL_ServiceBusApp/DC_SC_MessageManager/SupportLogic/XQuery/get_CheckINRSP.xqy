xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/MessageManager/checkIN/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/checkIN_MessageManager_v1_CSM.xsd" ::)

declare namespace ns4="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare variable $message as element() external;
(: Types: 1 = ValidMessage, 2 = InvalidMessage, 3 = InvalidHeader, 4 = IncompleteValidation :) 
declare variable $type as xs:int external;

declare variable $result as element() (:: schema-element(ns4:Result) ::) external;


declare function local:getCheckINRSP($type as xs:int,
                                     $message as element(), 
                                     $result as element() (:: schema-element(ns4:Result) ::)) 
                                     as element() (:: schema-element(ns2:checkINRSP) ::) {
    <ns2:checkINRSP>
        {if($type = 1) then 
          <ns2:ValidMessage>
            <ns2:Message>{$message}</ns2:Message>
          </ns2:ValidMessage>
         else if ($type = 2) then
          <ns2:InvalidMessage>
            {$result}
            <ns2:Message>{$message/*}</ns2:Message>
          </ns2:InvalidMessage>
         else if ($type = 3) then
          <ns2:InvalidHeader>
            {$result}
          </ns2:InvalidHeader>
         else
          <ns2:IncompleteValidation>
            {$result}
            <ns2:Message>{$message/*}</ns2:Message>
          </ns2:IncompleteValidation>
        }
    </ns2:checkINRSP>
};

local:getCheckINRSP($type, $message, $result)
