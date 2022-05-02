 param([String]$filePath, [String]$env)

$smtpServer = "10.64.33.40"
$smtpFrom = "USRIUHIPTechnology@ri.uhip.gov"
$messageSubject = $env + " Infra Smoke test Execution Failure Details"

$message = New-Object System.Net.Mail.MailMessage
$message.Subject = $messageSubject
$message.IsBodyHTML = $true
$message.Body = Get-Content $filePath
$message.from = 'USRIUHIPTechnology@ri.uhip.gov'

#List of email addresses to whom the failure report has to be sent
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

$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
$smtp.Send($message)