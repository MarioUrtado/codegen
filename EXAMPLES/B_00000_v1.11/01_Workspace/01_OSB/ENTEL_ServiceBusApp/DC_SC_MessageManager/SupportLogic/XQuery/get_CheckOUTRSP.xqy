xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/SC/MessageManager/checkOUT/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/checkOUT_MessageManager_v1_CSM.xsd" ::)

declare variable $message as element() external;
declare variable $result as element()? (:: schema-element(ns1:Result) ::) external;

declare function local:get_CheckOUTRSP($message as element(), 
                                       $result as element()? (:: schema-element(ns1:Result)? ::)) 
                                       as element() (:: schema-element(ns2:checkOUTRSP) ::) {
    <ns2:checkOUTRSP>
      {if($result) then
        <ns2:InvalidHeader>
          {$result}
        </ns2:InvalidHeader>
       else (
        <ns2:ValidMessage>
          <ns2:Message>{$message}</ns2:Message>
        </ns2:ValidMessage>
       )}
    </ns2:checkOUTRSP>
};

local:get_CheckOUTRSP($message, $result)
