xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $RA_Name as xs:string external;

declare function local:get_FaultReason_RA_UnableToReplyWError($RA_Name as xs:string) as xs:string {
    concat(
          'El Componente : ',
          $RA_Name,
          'No pudo publicar su respuesta de error, sobre su cola JMS de Respuesta : ',$RA_Name,'_RSP_Queue. ',
          'Se deriva el mensaje a la ErrorQueue : ',$RA_Name,'_REQ_ErrorQueue.'
          )
};

local:get_FaultReason_RA_UnableToReplyWError($RA_Name)
