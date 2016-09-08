xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/SC/MessageManager/CheckExecutorHelper/v1";
(:: import schema at "../XSD/CheckExecutorHelper.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare variable $message as element() external;
declare variable $result as element()? (:: schema-element(ns1:Result)? ::) external;

declare function local:checkExecutorHelperRSP($message as element(), 
                                              $result as element()? (:: schema-element(ns1:Result)? ::)) 
                                              as element() (:: schema-element(ns2:checkExecutorHelperRSP) ::) {
    <ns2:checkExecutorHelperRSP>
        <ns2:Message>{$message}</ns2:Message>
    {  if(empty($result)) then ()
       else
        $result
       }
    </ns2:checkExecutorHelperRSP>
};

local:checkExecutorHelperRSP($message, $result)