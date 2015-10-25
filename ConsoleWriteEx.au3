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

; #INTERNAL_USE_ONLY# ===========================================================================================================
; __AddPrefix
; __GetTime
; __GetLogType
; __StringRepeat
; ===============================================================================================================================

#Region PUBLIC FUNCTIONS
Func _ConsoleWrite($sData = '', $iType = 0, $showTime = True)
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
	$sData = __AddPrefix($sData, $sPrefix, $showTime)

	Return ConsoleWrite($sData)
EndFunc   ;==>_ConsoleWrite

Func _ConsoleWriteLn($sData, $iType = 0)
	Return _ConsoleWrite($sData & @CRLF, $iType)
EndFunc   ;==>_ConsoleWriteLn

Func ConsoleWriteEx($sData, $iType = 0) ; Alias
	Return _ConsoleWrite($sData, $iType)
EndFunc   ;==>ConsoleWriteEx
#EndRegion PUBLIC FUNCTIONS

#Region PRIVATE FUNCTIONS
Func __AddPrefix($sData, $sPrefix = '', $showTime = False)
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

		If $showTime Then
			Local $time = __GetTime()
			Local $line1 = __StringRepeat('-', 40)
			Local $line2 = $sPrefix & $line1 & $line1 & __StringRepeat('-', StringLen($time))
			$line1 = $sPrefix & $line1 & $time & $line1 & @CRLF
			$sResult = $line1 & $sResult & $line2 & @CRLF
		EndIf

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

		Local $sResult = $sPrefix

		If $showTime Then $sResult &= __GetTime() & ' '

		$sResult &= $sData
		Return $sResult
	EndIf
EndFunc   ;==>__AddPrefix

Func __GetTime()
	Return StringFormat('[%02i:%02i:%02i]', @HOUR, @MIN, @SEC)
EndFunc   ;==>__GetTime

Func __GetLogType($sPrefix)
	$sPrefix = StringReplace($sPrefix, ' ', '')

	Local $sType

	Switch $sPrefix
		Case '!'
			$sType = 'error'

		Case '>'
			$sType = 'info'

		Case '+'
			$sType = 'success'

		Case '-'
			$sType = 'warning'

		Case Else
			$sType = 'none'
	EndSwitch

	Return StringUpper($sType)
EndFunc   ;==>__GetLogType

Func __StringRepeat($str, $length)
	Local $result = ''
	For $i = 1 To $length
		$result &= $str
	Next
	Return $result
EndFunc   ;==>__StringRepeat
#EndRegion PRIVATE FUNCTIONS
