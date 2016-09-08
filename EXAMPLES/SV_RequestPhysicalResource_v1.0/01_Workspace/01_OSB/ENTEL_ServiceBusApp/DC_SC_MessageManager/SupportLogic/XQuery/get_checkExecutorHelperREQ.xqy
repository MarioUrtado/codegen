xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)
declare namespace ns1="http://www.entel.cl/SC/MessageManager/CheckExecutorHelper/v1";
(:: import schema at "../XSD/CheckExecutorHelper.xsd" ::)

declare variable $name as xs:string external;
declare variable $type as xs:int external;
declare variable $grade as xs:int external;
declare variable $elapsedTime as xs:string external;
declare variable $capability as xs:string external;
declare variable $isRetry as xs:string external;
declare variable $message as element() external;
declare variable $MessageType as xs:string external;

declare variable $TransactionInfo as element() external;

declare function local:checkExecutorHelperREQ($name as xs:string, 
                                              $type as xs:int, 
                                              $grade as xs:int, 
                                              $elapsedTime as xs:string,
                                              $capability as xs:string,
                                              $isRetry as xs:string,
                                              $MessageType as xs:string,
                                              $message as element(),
                                              $TransactionInfo as element()) as element() (:: schema-element(ns1:checkExecutorHelperREQ) ::) {
    <ns1:checkExecutorHelperREQ name="{fn:data($name)}" type="{fn:data($type)}" grade="{fn:data($grade)}" elapsedTime="{fn:data($elapsedTime)}" capability="{fn:data($capability)}" messageType="{$MessageType}" isRetry="{$isRetry}">
        <ns1:Message>{$message}</ns1:Message>
        {
        if( $TransactionInfo/@id ) 
        then $TransactionInfo
        else ()
        }
    </ns1:checkExecutorHelperREQ>
};

local:checkExecutorHelperREQ($name, $type, $grade, $elapsedTime, $capability, $isRetry, $MessageType, $message, $TransactionInfo)