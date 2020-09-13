-- Added body to EmailLU - Training Attendees Notification record
update EmailLU
set Body = '<p>Dear <strong><%PARAM[Name]%></strong><br /></p><p>This is to inform you that you have been nominated to be part of:</p><p>Training Event: <strong><%PARAM[EventNum]%></strong>&nbsp;</p><p>Course: <strong><%PARAM[Course]%></strong></p><br />*** Notices ***<p>Please note that this account is an unattended account, do not reply to this email.</p><p>If you have any questions please contact your HR Administrator.</p>'
where [Type] = 'Training - Attendees Notification'