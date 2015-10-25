#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.14.2
	Author:         Juno_okyo

	Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#NoTrayIcon
#include 'ConsoleWriteEx.au3'

Example()
Example2()

Func Example()
	_ConsoleWriteLn('Hello World') ; Default
	_ConsoleWrite('Info type', $CONSOLE_INFO)
	_ConsoleWrite('Warning type', $CONSOLE_WARNING)
	_ConsoleWrite('Danger type', $CONSOLE_DANGER)
	_ConsoleWrite('Error type', $CONSOLE_ERROR)
	_ConsoleWrite('Success type', $CONSOLE_SUCCESS)
EndFunc   ;==>Example

Func Example2() ; Multi-line demo
	Local $msg = ''
	For $i = 1 to 5
		$msg &= 'This is line: ' & $i & @CRLF
	Next

	_ConsoleWrite($msg, $CONSOLE_INFO)
EndFunc