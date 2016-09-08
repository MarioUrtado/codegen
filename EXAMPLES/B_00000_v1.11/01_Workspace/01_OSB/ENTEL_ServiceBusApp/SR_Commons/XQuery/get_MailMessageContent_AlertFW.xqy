xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare variable $componentName as xs:string external;
declare variable $componentOperation as xs:string? external;
declare variable $componentType as xs:string external;
declare variable $messageHeader as element()? (:: schema-element(ns1:RequestHeader) ::) external;
declare variable $mailHeader as xs:string? external;
declare variable $mailBody as xs:string? external;
declare variable $mailFooter as xs:string? external;

declare function local:get_MailMessageContent_AlertFW($componentName as xs:string, 
                                                      $componentOperation as xs:string?, 
                                                      $componentType as xs:string, 
                                                      $messageHeader as element()?,
                                                      $mailHeader as xs:string?,
                                                      $mailBody as xs:string?,
                                                      $mailFooter as xs:string?) 
                                                      as xs:string {
    concat(
    "
      Component Name: ", $componentName, "&#10;&#10;",
    if ($componentOperation != '') then
      fn:concat ("Component Operation: ", $componentOperation, "&#10;")
    else (), "&#10;",
    " Component Type: ", $componentType, "&#10;&#10;",
    if ($messageHeader/ns1:Trace/ns1:Service/@name) then
    fn:concat ("Enterprise Service Name: ", data($messageHeader/ns1:Trace/ns1:Service/@name))
    else (), "&#10;&#10;",
    if ($messageHeader/ns1:Trace/ns1:Service/@code) then
    fn:concat ("Enterprise Service Code: ", data($messageHeader/ns1:Trace/ns1:Service/@code), "&#10;")
    else (), "&#10;&#10;&#10;",
    if ($mailHeader != '') then
        fn:data($mailHeader)
    else (), "&#10;&#10;",
    if ($mailBody != '') then
        fn:data($mailBody)
    else (), "&#10;&#10;",
    if ($mailFooter != '') then
        fn:data($mailFooter)
    else (), "&#10;&#10;")
};

local:get_MailMessageContent_AlertFW($componentName, $componentOperation, $componentType, $messageHeader, $mailHeader, $mailBody, $mailFooter)
