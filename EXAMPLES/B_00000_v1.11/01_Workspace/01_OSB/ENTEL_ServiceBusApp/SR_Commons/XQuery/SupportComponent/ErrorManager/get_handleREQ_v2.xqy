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
declare variable $errorSourceID as xs:string (:: ns1:sysCode_SType ::)  external;
declare variable $errorSourceDetails as xs:string? external;
declare variable $sourceFault as element()? external;
declare variable $messageHeader as element() (:: element(*, ns10:MessageHeader_Type) ::) external;
declare variable $sourceErrorCode as xs:string? external;
declare variable $sourceErrorDesc as xs:string? external;
declare variable $canonicalError as element()? (:: schema-element(ns3:CanonicalError) ::) external;
declare variable $errorIndexModule as xs:string? external;
declare variable $errorIndexSubModule as xs:string? external;
declare variable $errorPlaceHolderPlace as xs:string? external;
declare variable $errorPlaceHolderTime as xs:string? external;

declare function local:func($componentName as xs:string, 
                            $componentOperation as xs:string?, 
                            $errorSourceID as xs:string (:: ns1:sysCode_SType ::) , 
                            $errorSourceDetails as xs:string?, 
                            $sourceFault as element()?,
                            $messageHeader as element() (:: element(*, ns10:MessageHeader_Type) ::), 
                            $sourceErrorCode as xs:string?, 
                            $sourceErrorDesc as xs:string?,
                            $errorIndexModule as xs:string?,
                            $errorIndexSubModule as xs:string?,
                            $errorPlaceHolderPlace as xs:string?,
                            $errorPlaceHolderTime) as element() {
                            
    (:The difference with the previous version, relies on the fact that this version allows its consumers to 
    send an errorPlaceHolderTime, whether the previous versions did not. In this case, the errorPlaceHolderTime
    gains precision as it is sent by the consumer. In the previous version that same field was taken as the dateTime
    on which the XQuery executes.:)
                            
                            
    <ns12:HandleREQ>
        <ns2:ErrorTracer component="{fn:data($componentName)}" operation="{fn:data($componentOperation)}">
            <ns2:Header>
            {
                $messageHeader/*
            }
            </ns2:Header>
            {
              <ns3:SourceError code="{fn:data($sourceErrorCode)}" description="{fn:data($sourceErrorDesc)}">
                <ns3:ErrorSourceDetails source="{fn:data($errorSourceID)}" details="{fn:data($errorSourceDetails)}"/>
                <ns3:SourceFault>
                  {
                    $sourceFault
                  }
                </ns3:SourceFault>
              </ns3:SourceError>
            }
        </ns2:ErrorTracer>
        <ns3:ErrorIndex module="{fn:data($errorIndexModule)}" subModule="{fn:data($errorIndexSubModule)}"/>
        <ns12:ErrorPlaceHolder time="{$errorPlaceHolderTime}" place="{$errorPlaceHolderPlace}"/>
    </ns12:HandleREQ>
};

local:func( $componentName,
            $componentOperation,
            $errorSourceID,
            $errorSourceDetails,
            $sourceFault,
            $messageHeader,
            $sourceErrorCode,
            $sourceErrorDesc,
            $errorIndexModule,
            $errorIndexSubModule,
            $errorPlaceHolderPlace,
            $errorPlaceHolderTime)