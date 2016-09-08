xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getTransactionInfo";
(:: import schema at "../JCA/getTransactionInfo/getTransactionInfo_sp.xsd" ::)

declare variable $TransactionInfoRSP as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $RequestHeader as element() external;
declare variable $CapabilityID as xs:integer external;

declare function local:refactor( $transactions as element()) as element(){
      <Transactions>    
      {for $row in $transactions/*:MESSAGE_TRANSACTION[1]/*:Row 
      return 
          <Transaction ID="{$row/*:Column[ upper-case(@name)='ID']/text()}" 
              STATUS="{$row/*:Column[ upper-case(@name)='STATUS']/text()}" 
              MSG_TIMESTAMP="{$row/*:Column[ upper-case(@name)='MSG_TIMESTAMP']/text()}" 
              CAPABILITY_ID="{$row/*:Column[ upper-case(@name)='CAPABILITY_ID']/text()}" 
              SEQUENCE="{$row/*:Column[ upper-case(@name)='SEQUENCE']/text()}" 
              CORRELATION_ID="{$row/*:Column[ upper-case(@name)='CORRELATION_ID']/text()}" />
          }
      </Transactions>
};

(: 

Roles posibles de los mensajes a partir de las transacciones existentes 

Main Transaction Instance Owner = MTIO
Main Transaction Instance Member = MTIM
Main Transaction Clone Owner = MTCO
Main Transaction Clone Member = MTCM

:)

declare function local:getMessageType($TransactionInfoRSP as element() (:: schema-element(ns1:OutputParameters) ::), 
                                 $RequestHeader as element(),
                                 $CapabilityID as xs:integer
                                 ) (: En la version Inicial solo se usa el /RequestHeader/Trace/@correlationID :)
                                 as xs:string {
  let $Txs := local:refactor($TransactionInfoRSP)
  let $correlationID := if ($RequestHeader/*[2]/@correlationID) then $RequestHeader/*[2]/@correlationID else ''
  return 
  
  (: No existe Tx con PROC_ID + EVENT_ID, El mensaje sera el creador de la transaccion, y sera Main Transaction Instace Owner :)
  if( (count($Txs/*) = 0 ) or 
         ( $Txs/*[@SEQUENCE = 0 and @CORRELATION_ID = $correlationID and @CAPABILITY_ID = $CapabilityID ] ))
  then "MTIO"
  (: Si existe Tx con PROC_ID + EVENT_ID. Identificar Si se trata de Main Transaction Instance o Main Transaction Clone :)
  (: Si la transaccion es de SEQUENCE = 0, y la correlacionID es la misma que la del mensaje entrante, es un Main Transaction Instance Member  :)
  else if ( $Txs/*[@SEQUENCE = 0 and @CORRELATION_ID = $correlationID and @CAPABILITY_ID != $CapabilityID ] )
       then "MTIM" 
       (: Si la SEQUENCE > 1, se trata de un Main Trnsaction Clone. Se debe determinar si se trata del Owner o Member :)
       (: Si existe la Main Transaction Clone, con PROC_ID + EVENT_ID + CORRELATION_ID, Es Una Main Transaction Clone Member  :)
       else if ( $Txs/*[ @SEQUENCE > 0 and @CORRELATION_ID = $correlationID and @CAPABILITY_ID != $CapabilityID ] )
            then "MTCM"
            (: Si NO existe la Main Transaction Clone, con PROC_ID + EVENT_ID + CORRELATION_ID, se trata de una Main Transaction Clone Owner :)
            else if ( $Txs/*[ @CAPABILITY_ID = $CapabilityID ] )
            (: ($Txs/*[   not(@CORRELATION_ID = $RequestHeader/*[2]/@correlationID) ])  :)
                then "MTCO"
                (: Si no existe transaccion contemplada por los escenarios anteriores, se trata de una transaccion no soportada por el FRW :)
                else "UNK"
};

local:getMessageType($TransactionInfoRSP, $RequestHeader, $CapabilityID )