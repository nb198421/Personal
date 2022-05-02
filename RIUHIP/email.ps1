 param([String]$filePath,[String]$attachmentPath,[String] $env,[String] $outputFolder )

$smtpServer = "10.64.33.40"
$smtpFrom = "USRIUHIPTechnology@ri.uhip.gov"
$messageSubject = $env + " Infra Smoke test Execution Summary"

$message = New-Object System.Net.Mail.MailMessage
$message.Subject = $messageSubject
$message.IsBodyHTML = $true
$message.Body = Get-Content $filePath
$message.from = 'USRIUHIPTechnology@ri.uhip.gov'

#List of email addresses to whom the email should be triggered
#M&O QA
$message.to.add('sanupati@deloitte.com')
$message.to.add('radomakonda@deloitte.com')
$message.to.add('vgopishetty@deloitte.com')
$message.to.add('ssivasubramani@deloitte.com')
#Infra
$message.to.add('USRIUHIPTechnology@deloitte.com')
$message.to.add('sgunupudi@deloitte.com')
$message.to.add('rbhalerao@deloitte.com')
$message.to.add('bgouripeddi@deloitte.com')
$message.to.add('pthadur@deloitte.com')
$message.to.add('npanguluri@deloitte.com')
$message.to.add('bhagg@deloitte.com')
$message.to.add('vijakumar@deloitte.com')
$message.to.add('kravipati@deloitte.com')
#CP QA
$message.to.add('skoturiya@deloitte.com')
$message.to.add('vbathula@deloitte.com')
$message.to.add('sikonduru@deloitte.com')
$message.to.add('shyerramilli@deloitte.com')
$message.to.add('jkulshrestha@deloitte.com')
$message.to.add('panjain@deloitte.com')
$message.to.add('maswal@deloitte.com')
$message.to.add('akontham@deloitte.com')
$message.to.add('vpedada@deloitte.com')
$message.to.add('nbanyal@deloitte.com')
$message.to.add('nsingapuram@deloitte.com')
$message.to.add('pgovindareddigari@DELOITTE.com')
$message.to.add('aakshitha@deloitte.com')
$message.to.add('ssuryajitt@deloitte.com')

$attachment = new-object System.Net.Mail.Attachment $attachmentPath
$message.Attachments.Add($attachment)
	
# PowerShell script to list the PNG files under the Output Folder\env folder
$Dir = get-childitem C:\$outputFolder\$env -recurse
$List = $Dir | where {$_.extension -eq ".png"}

ForEach($att in $List){
	$attachment1 = new-object System.Net.Mail.Attachment C:\$outputFolder\$env\$att
	$message.Attachments.Add($attachment1)
}

$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
$smtp.Send($message)