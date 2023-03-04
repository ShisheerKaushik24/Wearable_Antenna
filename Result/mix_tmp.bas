' This is a script template to be modified by the "Mix complex 1D results" template. Some parts of the code will be replaced by the corresponding formulas.
'
' Version history
' -----------------------------------------------------------------------------------------------------------------------------
' 02-Sep-2011 fsr: small changes to Copy1DC to allow 1D results with only 1 sample
' 06-Apr-2011 fsr: slightly changed wording of generic error message
' 21-Dec-2010 fsr: reduced iCharNumber to 5 in agreement with the rtp file
' 15-Nov-2010 fsr: included 0D and 1D cases (1D code is present but rerouted to 1DC for extended 1DC command set)
' 27-Oct-2010 fsr: adjusted for DS
' -----------------------------------------------------------------------------------------------------------------------------

Option Explicit
'include tmp libraries, these have to be built (and deleted) dynamically from the originial libraries before (after) calling the template
'#include "vba_globals_all.lib"
'#include "infix_postfix.lib"
'#include "complex.lib"

' replacement, either "MWS", "DSMWS", or "DS"
Public Const callingApp = "MWS"
' replacement, either "0D", "1D", or "1DC"
Public Const complexityLevel = "1DC"

'Const lib_rundef = -1.23456e27

Sub Main

	On Error GoTo EndOfSub

	Dim A_cst_tmp As Variant, B_cst_tmp As Variant, C_cst_tmp As Variant, D_cst_tmp As Variant, E_cst_tmp As Variant, F_cst_tmp As Variant
	Dim iCharNumber As Integer, iCharLoop As Integer
	iCharNumber = 5

	Dim TmpResult_Final As Variant

	Dim oResultTmp As Object, oResultNew() As Object, bResultExists() As Boolean
	ReDim oResultNew(iCharNumber)
	ReDim bResultExists(iCharNumber)

	Dim iiitmp As Long
	Dim bTreat1DAs1DC As Boolean	' used if any of the 1DC commands in infix_postfix.lib are used for 1D plots
	bTreat1DAs1DC = False

	Select Case complexityLevel
		Case "0D"
			If Left(callingApp, 2) = "DS" Then
				If (DS.RestoreGlobalDataValue("Mix_A")<>"") Then A_cst_tmp = Evaluate(DS.RestoreGlobalDataValue("Mix_A")) Else A_cst_tmp = lib_rundef
				If (DS.RestoreGlobalDataValue("Mix_B")<>"") Then B_cst_tmp = Evaluate(DS.RestoreGlobalDataValue("Mix_B")) Else B_cst_tmp = lib_rundef
				If (DS.RestoreGlobalDataValue("Mix_C")<>"") Then C_cst_tmp = Evaluate(DS.RestoreGlobalDataValue("Mix_C")) Else C_cst_tmp = lib_rundef
				If (DS.RestoreGlobalDataValue("Mix_D")<>"") Then D_cst_tmp = Evaluate(DS.RestoreGlobalDataValue("Mix_D")) Else D_cst_tmp = lib_rundef
				If (DS.RestoreGlobalDataValue("Mix_E")<>"") Then E_cst_tmp = Evaluate(DS.RestoreGlobalDataValue("Mix_E")) Else E_cst_tmp = lib_rundef
				If (DS.RestoreGlobalDataValue("Mix_F")<>"") Then F_cst_tmp = Evaluate(DS.RestoreGlobalDataValue("Mix_F")) Else F_cst_tmp = lib_rundef
			Else
				If (RestoreGlobalDataValue("Mix_A")<>"") Then A_cst_tmp = Evaluate(RestoreGlobalDataValue("Mix_A")) Else A_cst_tmp = lib_rundef
				If (RestoreGlobalDataValue("Mix_B")<>"") Then B_cst_tmp = Evaluate(RestoreGlobalDataValue("Mix_B")) Else B_cst_tmp = lib_rundef
				If (RestoreGlobalDataValue("Mix_C")<>"") Then C_cst_tmp = Evaluate(RestoreGlobalDataValue("Mix_C")) Else C_cst_tmp = lib_rundef
				If (RestoreGlobalDataValue("Mix_D")<>"") Then D_cst_tmp = Evaluate(RestoreGlobalDataValue("Mix_D")) Else D_cst_tmp = lib_rundef
				If (RestoreGlobalDataValue("Mix_E")<>"") Then E_cst_tmp = Evaluate(RestoreGlobalDataValue("Mix_E")) Else E_cst_tmp = lib_rundef
				If (RestoreGlobalDataValue("Mix_F")<>"") Then F_cst_tmp = Evaluate(RestoreGlobalDataValue("Mix_F")) Else F_cst_tmp = lib_rundef
			End If

			TmpResult_Final = EvaluateExpression(A_cst_tmp, B_cst_tmp, C_cst_tmp, D_cst_tmp, E_cst_tmp, F_cst_tmp)

			If (Left(callingApp, 2) = "DS") Then
				DS.StoreGlobalDataValue("mix_template_result"+complexityLevel, TmpResult_Final)
			Else
				StoreGlobalDataValue("mix_template_result"+complexityLevel, TmpResult_Final)
			End If

			' successful operation
			Exit Sub
		Case "1D"
			For iCharLoop = 0 To iCharNumber
				bResultExists(iCharLoop) = (ReStoreGlobalDataValue( "Mix_"+ Chr(65+iCharLoop) )) = "TRUE"
				If bResultExists(iCharLoop) Then
					Set oResultNew(iCharLoop) = Result1D("mix_tmp" + Chr(65+iCharLoop)+complexityLevel)
					' If no reference object has been defined yet, make the just found object the new reference
					If (oResultTmp Is Nothing) Then Set oResultTmp = oResultNew(iCharLoop)
				End If
			Next iCharLoop

			For iiitmp = 0 To oResultTmp.GetN-1
				If(bResultExists(0)) Then A_cst_tmp = oResultNew(0).GetY(iiitmp) Else A_cst_tmp = lib_rundef
				If(bResultExists(1)) Then B_cst_tmp = oResultNew(1).GetY(iiitmp) Else B_cst_tmp = lib_rundef
				If(bResultExists(2)) Then C_cst_tmp = oResultNew(2).GetY(iiitmp) Else C_cst_tmp = lib_rundef
				If(bResultExists(3)) Then D_cst_tmp = oResultNew(3).GetY(iiitmp) Else D_cst_tmp = lib_rundef
				If(bResultExists(4)) Then E_cst_tmp = oResultNew(4).GetY(iiitmp) Else E_cst_tmp = lib_rundef
				If(bResultExists(5)) Then F_cst_tmp = oResultNew(5).GetY(iiitmp) Else F_cst_tmp = lib_rundef
				oResultTmp.SetY(iiitmp, EvaluateExpression(A_cst_tmp, B_cst_tmp, C_cst_tmp, D_cst_tmp, E_cst_tmp, F_cst_tmp))
			Next iiitmp
			If Left(callingApp, 2) = "DS" Then
				oResultTmp.Save("mix_template_result"+complexityLevel+".sig")
				'r1dtmp.AddToTree "Design\Results\Test123\Test1"
				'SelectTreeItem "Design\Results\Test123\Test1"
			Else
				oResultTmp.Save(GetProjectPath("Result") + "mix_template_result"+complexityLevel+".sig")
				'r1dtmp.AddToTree "1D Results\Test123\Test1"
				'SelectTreeItem "1D Results\Test123\Test1"
			End If

			' successful operation
			Exit Sub
		Case "1DC"
			For iCharLoop = 0 To iCharNumber
				If Left(callingApp, 2) = "DS" Then
					bResultExists(iCharLoop) = (DS.ReStoreGlobalDataValue( "Mix_"+ Chr(65+iCharLoop) )) = "TRUE"
				Else
					bResultExists(iCharLoop) = (ReStoreGlobalDataValue( "Mix_"+ Chr(65+iCharLoop) )) = "TRUE"
				End If
				If bResultExists(iCharLoop) Then
					If Left(callingApp, 2) = "DS" Then
						'MsgBox("Found "+aCharName(iCharLoop))
						Set oResultNew(iCharLoop) = DS.Result1DComplex("mix_tmp" + Chr(65+iCharLoop)+complexityLevel)
					Else
						Set oResultNew(iCharLoop) = Result1DComplex("mix_tmp" + Chr(65+iCharLoop)+complexityLevel)
					End If
				End If
			Next iCharLoop

			If bResultExists(0) Then	Set A_cst_tmp  = oResultNew(0)
			If bResultExists(1) Then	Set B_cst_tmp  = oResultNew(1)
			If bResultExists(2) Then	Set C_cst_tmp  = oResultNew(2)
			If bResultExists(3) Then	Set D_cst_tmp  = oResultNew(3)
			If bResultExists(4) Then	Set E_cst_tmp  = oResultNew(4)
			If bResultExists(5) Then	Set F_cst_tmp  = oResultNew(5)

			Set TmpResult_Final = EvaluateExpression(A_cst_tmp, B_cst_tmp, C_cst_tmp, D_cst_tmp, E_cst_tmp, F_cst_tmp)

			' created expression ends with "TmpResult_Final"
			If Left(callingApp, 2) = "DS" Then
				TmpResult_Final.Save "mix_template_result"+complexityLevel
				'TmpResult_Final.AddToTree "Design\Results\TestMixTemplates\TestMT"
			Else
				TmpResult_Final.Save GetProjectPath("Result") + "mix_template_result"+complexityLevel
				' TmpResult_Final.AddToTree "1D Results\TestMixTemplates\TestMT"
				' SelectTreeItem "1D Results\TestMixTemplates\TestMT"
			End If

			' successful operation
			Exit Sub
	End Select

	' Error handling, do this if an error has occured
	EndOfSub:
		Dim FailedResult As Object
		Select Case complexityLevel
		Case "0D"
			If Left(callingApp, 2) = "DS" Then
				DS.StoreGlobalDataValue "mix_template_result0D", lib_rundef
			Else
				StoreGlobalDataValue "mix_template_result0D", lib_rundef
			End If
		Case "1D"
			If Left(callingApp, 2) = "DS" Then
				ReportError("Error in Mix1DC script execution. Typical reasons: Division by zero or unknown variable/function.")
				Set FailedResult = DS.Result1D("")
				FailedResult.AppendXY(0,-lib_rundef,-lib_rundef)
				FailedResult.Save "mix_template_result1D.sig"
			Else
				ReportError("Error in Mix1DC script execution. Typical reasons: Division by zero or unknown variable/function.")
				Set FailedResult = Result1D("")
				FailedResult.AppendXY(0,-lib_rundef,-lib_rundef)
				FailedResult.Save GetProjectPath("Result") + "mix_template_result1D.sig"
			End If
		Case "1DC"
			If Left(callingApp, 2) = "DS" Then
				ReportError("Error in Mix1DC script execution. Typical reasons: Division by zero or unknown variable/function.")
				Set FailedResult = DS.Result1DComplex("")
				FailedResult.AppendXY(0,-lib_rundef,-lib_rundef)
				FailedResult.Save "mix_template_result1DC"
			Else
				ReportError("Error in Mix1DC script execution. Typical reasons: Division by zero or unknown variable/function.")
				Set FailedResult = Result1DComplex("")
				FailedResult.AppendXY(0,-lib_rundef,-lib_rundef)
				FailedResult.Save GetProjectPath("Result") + "mix_template_result1DC"
			End If
		End Select
End Sub

Function EvaluateExpression(A_cst_tmp As Variant, B_cst_tmp As Variant, C_cst_tmp As Variant, D_cst_tmp As Variant, E_cst_tmp As Variant, F_cst_tmp As Variant) As Variant
Dim  TmpResult_Final As Object
' The following line in this template will be/has been replaced with the VBA command chain
Dim TmpResult_21 As Object
Set TmpResult_21 = A_cst_tmp.Copy()
TmpResult_21.Subtract(B_cst_tmp)
Set TmpResult_Final = TmpResult_21

Set EvaluateExpression = TmpResult_Final
End Function

Function Copy1DC(Original As Object) As Object

	If Left(callingApp, 2) = "DS" Then
		Set Copy1DC = DS.Result1DComplex("")
	Else
		Set Copy1DC = Result1DComplex("")
	End If
	Copy1DC.AppendXY(Original.GetX(0),0,0)
	Copy1DC.MakeCompatibleTo(Original)
	Copy1DC.Add(Original)

End Function
