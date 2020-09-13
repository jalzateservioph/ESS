Imports System.Net.Mail

Public Class EmailSetup

    Public Property ID As Int16
    Public Property Type As String
    Public Property Server As String
    Public Property Port As Int16
    Public Property Username As String
    Public Property Password As String
    Public Property _From As MailAddress
    Public Property Subject As String
    Public Property OrigBodyHtml As String
    Public Property OrigBodyText As String
    Public Property BodyHtml As String
    Public Property BodyText As String

End Class
