xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $intervalDayToSecond as xs:string external;

declare function local:getDayTimeDuration($intervalDayToSecond as xs:string) as xs:dayTimeDuration {
    let $day := fn:substring($intervalDayToSecond, 2, 2)
    let $hour := fn:substring($intervalDayToSecond, 5, 2)
    let $minute := fn:substring($intervalDayToSecond, 8, 2)
    let $second := fn:substring($intervalDayToSecond, 11, 2)
    return
      xs:dayTimeDuration(concat('P',$day,'D','T',$hour,'H',$minute,'M',$second,'S'))
};

local:getDayTimeDuration($intervalDayToSecond)
