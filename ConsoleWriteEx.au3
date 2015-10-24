#include-once

; #INDEX# =======================================================================================================================
; Title .........: ConsoleWriteEx
; UDF Version....: 1.0.0
; AutoIt Version : 3.3.14.2
; Description ...: Advanced console functions (based on ConsoleWrite)
; Author(s) .....: Juno_okyo
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
Global Const $CONSOLE_ERROR = 16
Global Const $CONSOLE_DANGER = 16 ; Alias of error
Global Const $CONSOLE_SUCCESS = 32
Global Const $CONSOLE_WARNING = 48
Global Const $CONSOLE_INFO = 64
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _ConsoleWrite...: Main function
; _ConsoleWriteLn : _ConsoleWrite + @CRLF
; ConsoleWriteEx..: Alias of _ConsoleWrite
; ===============================================================================================================================

#Region FUNCTIONS
Func _ConsoleWrite($sData = '', $iType = 0)
	Local $sPrefix = ''

	; Make sure flag is a number
	$iType = Int($iType)

	Switch $iType
		Case $CONSOLE_ERROR
			$sPrefix = '!'

		Case $CONSOLE_SUCCESS
			$sPrefix = '+'

		Case $CONSOLE_WARNING
			$sPrefix = '-'

		Case $CONSOLE_INFO
			$sPrefix = '>'
	EndSwitch

	If StringLen($sPrefix) > 0 Then
		$sPrefix &= ' '

		; Fix bug:
		; -----------------------------------------------
		; _ConsoleWrite('Info type', $CONSOLE_INFO)
		; _ConsoleWrite('Warning type', $CONSOLE_WARNING)
		; -----------------------------------------------
		; > Info type- Warning type
		$sData &= @CRLF
	EndIf

	Return ConsoleWrite($sPrefix & $sData)
EndFunc   ;==>_ConsoleWrite

Func _ConsoleWriteLn($sData, $iType = 0)
	Return _ConsoleWrite($sData & @CRLF, $iType)
EndFunc   ;==>_ConsoleWriteLn

Func ConsoleWriteEx($sData, $iType = 0) ; Alias
	Return _ConsoleWrite($sData, $iType)
EndFunc   ;==>ConsoleWriteEx
#EndRegion FUNCTIONS
