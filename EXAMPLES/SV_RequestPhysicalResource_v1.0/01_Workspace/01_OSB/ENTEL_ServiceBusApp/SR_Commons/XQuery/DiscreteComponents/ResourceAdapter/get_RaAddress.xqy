xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $TargetProvider as xs:string external;
declare variable $RaName as xs:string external;
declare variable $RaVersion as xs:string external;
declare variable $LwVersion as xs:string external;

declare function local:get_RaAddress(
        $TargetProvider as xs:string,
        $RaName as xs:string,
        $RaVersion as xs:string,
        $LwVersion as xs:string
    ) as xs:string {
    
    
    concat('DC_RA_',$TargetProvider,'_v',$LwVersion,'/ResourceAdapters/',$RaName,'_v',$RaVersion,'/',$RaName,'_AC')

};

local:get_RaAddress($TargetProvider, $RaName, $RaVersion, $LwVersion)
