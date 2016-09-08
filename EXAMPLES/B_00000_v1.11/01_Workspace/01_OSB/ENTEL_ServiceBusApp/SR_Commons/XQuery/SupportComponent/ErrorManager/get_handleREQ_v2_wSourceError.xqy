xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns12="http://www.entel.cl/SC/ErrorManager/handle/v1";

declare namespace ns10="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../XSD/ESO/MessageHeader_v1_ESO.xsd" ::)

declare namespace ns1="http://www.entel.cl/EDD/Dictionary/v1";
(:: import schema at "../../../XSD/EDD/Dictionary_v1_EDD.xsd" ::)

declare namespace ns2 = "http://www.entel.cl/ESO/Tracer/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";
(:: import schema at "../../../XSD/ESO/Error_v1_ESO.xsd" ::)

declare variable $componentName as xs:string external;
declare variable $componentOperation as xs:string? external;
declare variable $messageHeader as element() (:: element(*, ns10:MessageHeader_Type) ::) external;
declare variable $errorIndexModule as xs:string? external;
declare variable $errorIndexSubModule as xs:string? external;
declare variable $errorPlaceHolderPlace as xs:string? external;
declare variable $errorPlaceHolderTime as xs:string? external;
declare variable $sourceError as element() (:: schema-element(ns3:SourceError) ::) external;

declare function local:get_handleREQ_V2_wSourceError($componentName as xs:string, 
                            $componentOperation as xs:string?, 
                            $messageHeader as element() (:: element(*, ns10:MessageHeader_Type) ::), 
                            $errorIndexModule as xs:string?,
                            $errorIndexSubModule as xs:string?,
                            $errorPlaceHolderPlace as xs:string?,
                            $errorPlaceHolderTime as xs:string?,
                            $sourceError as element() (:: schema-element(ns3:SourceError) ::)
                            ) as element() {
                            
    (:The difference with the previous version (v1), relies on the fact that this version allows its consumers to 
    send an errorPlaceHolderTime, whether the previous versions did not. In this case, the errorPlaceHolderTime
    gains precision as it is sent by the consumer. In the previous version that same field was taken as the dateTime
    on which the XQuery executes.:)
    
    (: The feature implemented on this "_wSourceError:" version allows consumers which have a SourceError made already, 
    to use it instead of sending each of its attributes separately:)
                                                   
    <ns12:HandleREQ>
        <ns2:ErrorTracer component="{fn:data($componentName)}" operation="{fn:data($componentOperation)}">
            <ns2:Header>
            {
                $messageHeader/*
            }
            </ns2:Header>
            {
              $sourceError
            }
        </ns2:ErrorTracer>
        <ns3:ErrorIndex module="{fn:data($errorIndexModule)}" subModule="{fn:data($errorIndexSubModule)}"/>
        <ns12:ErrorPlaceHolder time="{$errorPlaceHolderTime}" place="{$errorPlaceHolderPlace}"/>
    </ns12:HandleREQ>
};

local:get_handleREQ_V2_wSourceError(
            $componentName,
            $componentOperation,
            $messageHeader,
            $errorIndexModule,
            $errorIndexSubModule,
            $errorPlaceHolderPlace,
            $errorPlaceHolderTime,
            $sourceError)