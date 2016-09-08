xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare variable $RaName as xs:string external;
declare variable $LwVersion as xs:string external;
declare variable $RaVersion as xs:string external;

declare function local:get_Ra_DynamicRouting(
        $RaName as xs:string,
        $LwVersion as xs:string,
        $RaVersion as xs:string 

      ) as element() {

    let $TargetProvider := tokenize($RaName, '_')[1]
    let $RSPProducerLocation := 
    
    concat('DC_RA_',$TargetProvider,'_v',$LwVersion,'/ResourceAdapters/',$RaName,'_v',$RaVersion,'/',$RaName,'_AP')

    return

    <ctx:route xmlns:ctx='http://www.bea.com/wli/sb/context'>
      <ctx:service isProxy="false">{$RSPProducerLocation}</ctx:service>
    </ctx:route>
};

local:get_Ra_DynamicRouting($RaName, $LwVersion, $RaVersion)