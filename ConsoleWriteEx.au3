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

	If StringLen($sPrefix) > 0 Then $sPrefix &= ' '
	$sData = _AddPrefix($sData, $sPrefix)

	Return ConsoleWrite($sData)
EndFunc   ;==>_ConsoleWrite

Func _ConsoleWriteLn($sData, $iType = 0)
	Return _ConsoleWrite($sData & @CRLF, $iType)
EndFunc   ;==>_ConsoleWriteLn

Func ConsoleWriteEx($sData, $iType = 0) ; Alias
	Return _ConsoleWrite($sData, $iType)
EndFunc   ;==>ConsoleWriteEx

Func _AddPrefix($sData, $sPrefix = '')
	$sData = StringReplace($sData, @CRLF, @CR)
	$sData = StringReplace($sData, @LF, @CR)

	Local $lines = StringSplit($sData, @CR, 1)
	Local $t = $lines[0] - 1

	If $t > 0 Then ; If is multi-line
		If StringLen($sPrefix) == 0 Then Return $sData

		Local $sResult = ''

		; Add prefix to all line
		For $i = 1 To $t
			$sResult &= $sPrefix & $lines[$i] & @CRLF
		Next

		Return $sResult
	Else
		If StringLen($sPrefix) > 0 Then
			; Fix bug:
			; -----------------------------------------------
			; _ConsoleWrite('Info type', $CONSOLE_INFO)
			; _ConsoleWrite('Warning type', $CONSOLE_WARNING)
			; -----------------------------------------------
			; > Info type- Warning type
			$sData &= @CRLF
		EndIf

		Return $sPrefix & $sData
	EndIf
EndFunc   ;==>_AddPrefix
#EndRegion FUNCTIONS
