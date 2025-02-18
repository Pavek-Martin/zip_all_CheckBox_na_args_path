
# vlozit do mechaniky D: BD-RW 50 GB z formatem Windows 10 jako fleska

cls

[string] $scriptName = pwd
$scriptName += "\"
$scriptName += $MyInvocation.MyCommand.Name
$host.UI.RawUI.WindowTitle = $scriptName

#$adresar_kam="C:\work\"
#$adresar_kam="D:\"

$delka_args = $args.length 
if ($delka_args -clike 0) {
echo "jako paramer args[0] zadat cetu kam se bude zalohavat"
echo "mapr. z:\"
echo "a nebo treba C:\Users\DELL\Documents\zaloha\ruzne\" # lotiko na konci !
sleep 5
Exit
}

$adresar_kam = $args[0]
#echo $adresar_kam
#echo $adresar_kam.GetTypeCode()
#exit 1

$kontrola = 0

# exituje cilova cesta ?
$exist = Test-Path -Path $adresar_kam
#echo $exist
if ( $exist -ilike "False" ){
echo "chyby cilovy adresar pro zalohy - $adresar_kam"
sleep 5
Exit 1
}

# na kterou jednotu se bud zalohovat 
# jesli na opticky disk a nebo na hdda flesku
# podle toho potom na konci budto cekat 20 vterin z kontlorou inzipem a nebo na c:\ atd. necekat

$jednotka_kam = $adresar_kam.Substring(0,1)
#echo $jednotka_kam
#echo $jednotka_kam.GetTypeCode()
#exit 1

$pole_opticke_jednotky=@("D","d","Z","z")
# uzivatel v batce muze napsat jako args[0] d:\ a nebo D:\ ( velkym pismem, malim pismem) cili oba stavy at sou
$d_pole_opticke_jednotky = $pole_opticke_jednotky.Length -1
#echo $d_pole_opticke_jednotky

$opticka_jednotka = 0
for ( $aa1 = 0; $aa1 -le $d_pole_opticke_jednotky; $aa1++) {
if ( $pole_opticke_jednotky[$aa1] -like $jednotka_kam ) {
$opticka_jednotka = 1
}
}
#echo $opticka_jednotka
#exit 1

$datum="{0:dd_MM_yyyy-HH_mm_ss}" -f (Get-Date)

$muj_font = "Times New Roman',13"

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$objForm = New-Object System.Windows.Forms.Form

$objForm.Text = "Zalohovani adresaru"
#$objForm.Size = New-Object System.Drawing.Size(800, 500) # 800,600 puvodni
$objForm.Text = "      VYBER ADRESARE KTERE SE BUDOU ZALOHOVAT"
# novy
$width_main = 800 #--\/
$objForm.Width = $width_main # sirka hlavniho okna a zakomentovat radek 48 - $objForm.Size = New-Object System.Drawing.Size(800, 500) # 800,600 puvodni
$objForm.Height = 25*22 # 525 # vyska hlavniho okna, 21 je pocet polozek
#
$objForm.StartPosition = "CenterScreen"
#$objForm.Font.Bold = ?
#$objForm.Font.Size = 15 ? este hledat nekde na netu co stim, aby se dalo zvetsit pismo popisku u CheckBoxu

#------------------------------------------------------------------------------------------------------------------

# 1
$CheckBox_1         = New-Object System.Windows.Forms.CheckBox
$CheckBox_1.Location = New-Object System.Drawing.Size(10, 10) # pozice radku
$CheckBox_1.Size     = New-Object System.Drawing.Size(500, 20) # velikost radku
#$CheckBox_1.Checked  = $true
$CheckBox_1.Checked  = $false
$CheckBox_1.text     = "C:\Users\DELL\Documents\ps1"
#$CheckBox_1.ForeColor = "Black"
#$CheckBox_1.BackColor = "Black"
#$CheckBox_1.Font = 'Microsoft Sant Serif,12'
$CheckBox_1.Font = $muj_font
$objForm.controls.Add($CheckBox_1)
$name1="$datum-ps1.zip" # musi bejt takto $datum-neco.zip, kvuli kontrole unzipem, jinak to pak blbne !!!

# 2
$CheckBox_2          = New-Object System.Windows.Forms.CheckBox
$CheckBox_2.Location = New-Object System.Drawing.Size(10, 30) # vzdy +20 svisle rozestupy
$CheckBox_2.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_2.Checked  = $false
#$CheckBox_2.Checked  = $true
$CheckBox_2.text     = "C:\Users\DELL\Documents\256_Basic"
$CheckBox_2.Font = $muj_font
$objForm.controls.Add($CheckBox_2)
$name2="$datum-256_basic.zip"

# 3
$CheckBox_3          = New-Object System.Windows.Forms.CheckBox
$CheckBox_3.Location = New-Object System.Drawing.Size(10, 50)
$CheckBox_3.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_3.Checked  = $false
$CheckBox_3.text     = "C:\Users\DELL\Documents\dvd"
$CheckBox_3.Font = $muj_font
$objForm.controls.Add($CheckBox_3)
$name3="$datum-dvd.txt"

# 4
$CheckBox_4          = New-Object System.Windows.Forms.CheckBox
$CheckBox_4.Location = New-Object System.Drawing.Size(10, 70)
$CheckBox_4.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_4.Checked  = $false
$CheckBox_4.text     = "C:\Users\DELL\Documents\Můj Garmin"
$objForm.controls.Add($CheckBox_4)
$CheckBox_4.Font = $muj_font
$name4="$datum-Můj Garmin.zip"

# 5
$CheckBox_5          = New-Object System.Windows.Forms.CheckBox
$CheckBox_5.Location = New-Object System.Drawing.Size(10, 90)
$CheckBox_5.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_5.Checked  = $false
$CheckBox_5.text     = "C:\Users\DELL\Documents\zaloha\dvd_katalog"
$objForm.controls.Add($CheckBox_5)
$CheckBox_5.Font = $muj_font
$name5="$datum-dvd_katalog.zip"

# 6
$CheckBox_6          = New-Object System.Windows.Forms.CheckBox
$CheckBox_6.Location = New-Object System.Drawing.Size(10, 110)
$CheckBox_6.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_6.Checked  = $false # nebude predem, muri noha u CheckBoxu 6
#$CheckBox_6.Checked  = $true # bude predem zaskrtnuty policko
$CheckBox_6.text     = "C:\ProgramData\Microsoft\Windows\Start Menu"
$objForm.controls.Add($CheckBox_6)
$CheckBox_6.Font = $muj_font
$name6="$datum-start_menu.zip"

# 7
$CheckBox_7         = New-Object System.Windows.Forms.CheckBox
$CheckBox_7.Location = New-Object System.Drawing.Size(10, 130)
$CheckBox_7.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_7.Checked  = $false
$CheckBox_7.text     = "C:\Users\DELL\Documents\java_script"
$objForm.controls.Add($CheckBox_7)
$CheckBox_7.Font = $muj_font
$name7="$datum-java_script.zip"

# 8
$CheckBox_8         = New-Object System.Windows.Forms.CheckBox
$CheckBox_8.Location = New-Object System.Drawing.Size(10, 150)
$CheckBox_8.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_8.Checked  = $false
$CheckBox_8.text     = "C:\Users\DELL\Documents\ubuntu"
$objForm.controls.Add($CheckBox_8)
$CheckBox_8.Font = $muj_font
$name8="$datum-ubuntu.zip"

# 9
$CheckBox_9        = New-Object System.Windows.Forms.CheckBox
$CheckBox_9.Location = New-Object System.Drawing.Size(10, 170)
$CheckBox_9.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_9.Checked  = $false
$CheckBox_9.text     = "C:\Users\DELL\Documents\Lua52_Win32"
$objForm.controls.Add($CheckBox_9)
$CheckBox_9.Font = $muj_font
$name9="$datum-Lua52_Win32.zip"

# 10
$CheckBox_10          = New-Object System.Windows.Forms.CheckBox
$CheckBox_10.Location = New-Object System.Drawing.Size(10, 190)
$CheckBox_10.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_10.Checked  = $false
$CheckBox_10.text     = "C:\Users\DELL\Documents\BaseCamp"
$objForm.controls.Add($CheckBox_10)
$CheckBox_10.Font = $muj_font
$name10="$datum-BaseCamp-backup.zip"

# 11
$CheckBox_11          = New-Object System.Windows.Forms.CheckBox
$CheckBox_11.Location = New-Object System.Drawing.Size(10, 210)
$CheckBox_11.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_11.Checked  = $false
$CheckBox_11.text     = "C:\Users\DELL\Pictures\Ballon_story"
$objForm.controls.Add($CheckBox_11)
$CheckBox_11.Font = $muj_font
$name11="$datum-ballon_story_backup.zip"

# 12
$CheckBox_12          = New-Object System.Windows.Forms.CheckBox
$CheckBox_12.Location = New-Object System.Drawing.Size(10, 230)
$CheckBox_12.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_12.Checked  = $false
$CheckBox_12.text     = "C:\Users\DELL\Documents\DOS"
$objForm.controls.Add($CheckBox_12)
$CheckBox_12.Font = $muj_font
$name12="$datum-DOS.zip"

# 13
$CheckBox_13         = New-Object System.Windows.Forms.CheckBox
$CheckBox_13.Location = New-Object System.Drawing.Size(10, 250)
$CheckBox_13.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_13.Checked  = $false
$CheckBox_13.text     = "C:\Users\DELL\Documents\zaloha\save_hry"
$objForm.controls.Add($CheckBox_13)
$CheckBox_13.Font = $muj_font
$name13="$datum-save_hry.zip"

# 14
$CheckBox_14         = New-Object System.Windows.Forms.CheckBox
$CheckBox_14.Location = New-Object System.Drawing.Size(10, 270)
$CheckBox_14.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_14.Checked  = $false
$CheckBox_14.text     = "C:\Users\DELL\Documents\zaloha\login"
$objForm.controls.Add($CheckBox_14)
$CheckBox_14.Font = $muj_font
$name14="$datum-login.zip"

# 15
$CheckBox_15         = New-Object System.Windows.Forms.CheckBox
$CheckBox_15.Location = New-Object System.Drawing.Size(10, 290)
$CheckBox_15.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_15.Checked  = $false
$CheckBox_15.text     = "C:\Users\DELL\Documents\Dev-Cpp"
$objForm.controls.Add($CheckBox_15)
$CheckBox_15.Font = $muj_font
$name15="$datum-Dev-Cpp.zip"

# 16
$CheckBox_16         = New-Object System.Windows.Forms.CheckBox
$CheckBox_16.Location = New-Object System.Drawing.Size(10, 310)
$CheckBox_16.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_16.Checked  = $false
$CheckBox_16.text     = "C:\Users\DELL\Pictures"
$objForm.controls.Add($CheckBox_16)
$CheckBox_16.Font = $muj_font
$name16="$datum-Pictures.zip"

# 17
$CheckBox_17         = New-Object System.Windows.Forms.CheckBox
$CheckBox_17.Location = New-Object System.Drawing.Size(10, 330)
$CheckBox_17.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_17.Checked  = $false
$CheckBox_17.text     = "C:\Users\DELL\Music"
$objForm.controls.Add($CheckBox_17)
$CheckBox_17.Font = $muj_font
$name17="$datum-Music.zip"

# 18
$CheckBox_18         = New-Object System.Windows.Forms.CheckBox
$CheckBox_18.Location = New-Object System.Drawing.Size(10, 350)
$CheckBox_18.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_18.Checked  = $false
$CheckBox_18.text     = "C:\Users\DELL\Documents\LibreOffice"
$objForm.controls.Add($CheckBox_18)
$CheckBox_18.Font = $muj_font
$name18="$datum-LibreOffice.zip"

# 19
$CheckBox_19         = New-Object System.Windows.Forms.CheckBox
$CheckBox_19.Location = New-Object System.Drawing.Size(10, 370)
$CheckBox_19.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_19.Checked  = $false
$CheckBox_19.text     = "C:\Users\DELL\Documents\PDF"
$objForm.controls.Add($CheckBox_19)
$CheckBox_19.Font = $muj_font
$name19="$datum-PDF.zip"

# 20
<#
$CheckBox_20        = New-Object System.Windows.Forms.CheckBox
$CheckBox_20.Location = New-Object System.Drawing.Size(10, 390)
$CheckBox_20.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_20.Checked  = $false
$CheckBox_20.text     = "C:\Users\DELL\Documents\ZX"
$objForm.controls.Add($CheckBox_20)
$CheckBox_20.Font = $muj_font
$name20="$datum-ZX.zip"
#>


# 21
$CheckBox_21        = New-Object System.Windows.Forms.CheckBox
$CheckBox_21.Location = New-Object System.Drawing.Size(10, 410)
$CheckBox_21.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_21.Checked  = $false
$CheckBox_21.text     = "C:\Users\DELL\Desktop"
$objForm.controls.Add($CheckBox_21)
$CheckBox_21.Font = $muj_font
$name21="$datum-plocha.zip"

# 22
$CheckBox_22        = New-Object System.Windows.Forms.CheckBox
$CheckBox_22.Location = New-Object System.Drawing.Size(10, 430)
$CheckBox_22.Size     = New-Object System.Drawing.Size(500, 20)
$CheckBox_22.Checked  = $false
$CheckBox_22.text     = "C:\Users\DELL\Documents\dnes"
$objForm.controls.Add( $CheckBox_22 )
$CheckBox_22.Font = $muj_font
$name22="$datum-dnes.zip"



$celkem = 22 # kolik *.zip bude celkem
$pocitadlo = 1
#echo $datum

# -------------------------------------------------------------------------------------------------------------------------

$OKButton              = New-Object System.Windows.Forms.Button
$pos_x_ok = 325
$OKButton.Location     = New-Object System.Drawing.Size($pos_x_ok, 460) # 10,420 BYLO ,zde pak posouvat dolu postupne (posledni +30)
$OKButton.Size         = New-Object System.Drawing.Size(150, 30) # 150, 30  - velikost tlacitka OK 
$OKButton.Text         = "OK"
#$OKButton.Enabled      = $false
#$OKButton.Enabled      = $true
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$objForm.Controls.Add($OKButton)
$objForm.AcceptButton = $OKButton

#$objForm.TopMost = $True

#$objForm.Controls | Where-Object { $PSItem -is [System.Windows.Forms.RadioButton] } | ForEach-Object { $PSItem.Add_Click( { If (-Not $OKButton.Enabled){ $OKButton.Enabled = $True} }) }

$objForm.Controls | Where-Object { $PSItem -is [System.Windows.Forms.RadioButton] } | ForEach-Object { $PSItem.Add_Click( { If (-Not $OKButton.Enabled){ $OKButton.Enabled = $True} }) }

$Form = $objForm.ShowDialog()
#echo $form"<"
#echo $v"<<"
#echo $PSItem"<<<"
#echo $objForm"<-"

# naseka prazdny radky na zacatku, odsazeni 15x
for ($aa = 1; $aa -le 15; $aa++) {
echo ""
}

# ------------------ vyhodnocovani CheckBoxu a pakovani adresaru zipem, pripadne pak kontorla unzipem


# 1
#echo $CheckBox_1.Checked ( typ boolean )
if ( $CheckBox_1.Checked -like "True" ){
Write-host -ForegroundColor green " $pocitadlo/$celkem) $adresar_kam$name1"
Compress-Archive -Path C:\Users\DELL\Documents\ps1 -CompressionLevel Optimal -DestinationPath "$adresar_kam$name1"
$kontrola=1
}else{
Write-host -ForegroundColor red " $pocitadlo/$celkem) $adresar_kam$name1"
}
$pocitadlo++

# 2
if ( $CheckBox_2.Checked -like "True" ){ 
Write-host -ForegroundColor green " $pocitadlo/$celkem) $adresar_kam$name2"
Compress-Archive -Path C:\Users\DELL\Documents\256_Basic -CompressionLevel Optimal -DestinationPath "$adresar_kam$name2"
$kontrola=1
}else{
Write-host -ForegroundColor red " $pocitadlo/$celkem) $adresar_kam$name2"
}
$pocitadlo++

# 3
if ( $CheckBox_3.Checked -like "True" ){ 
Write-host -ForegroundColor green " $pocitadlo/$celkem) $adresar_kam$name3"
Copy-Item -Path C:\Users\DELL\Documents\dvd -Destination "$adresar_kam$name3"
$kontrola=1
}else{
Write-host -ForegroundColor red " $pocitadlo/$celkem) $adresar_kam$name3"
}
$pocitadlo++

# 4
if ( $CheckBox_4.Checked -like "True" ){ 
Write-host -ForegroundColor green " $pocitadlo/$celkem) $adresar_kam$name4"
Compress-Archive -Path 'C:\Users\DELL\Documents\Můj Garmin'  -CompressionLevel Optimal -DestinationPath "$adresar_kam$name4"
$kontrola=1
}else{
Write-host -ForegroundColor red " $pocitadlo/$celkem) $adresar_kam$name4"
}
$pocitadlo++

# 5
if ( $CheckBox_5.Checked -like "True" ){ 
Write-host -ForegroundColor green " $pocitadlo/$celkem) $adresar_kam$name5"
Compress-Archive -Path "C:\Users\DELL\Documents\zaloha\dvd_katalog" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name5"
$kontrola=1
}else{
Write-host -ForegroundColor red " $pocitadlo/$celkem) $adresar_kam$name5"
}
$pocitadlo++

# 6
if ( $CheckBox_6.Checked -like "True" ){ 
Write-host -ForegroundColor green " $pocitadlo/$celkem) $adresar_kam$name6"
Compress-Archive -Path "C:\ProgramData\Microsoft\Windows\Start Menu" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name6"
$kontrola=1
}else{
Write-host -ForegroundColor red " $pocitadlo/$celkem) $adresar_kam$name6"
}
$pocitadlo++

# 7
if ( $CheckBox_7.Checked -like "True" ){ 
Write-host -ForegroundColor green " $pocitadlo/$celkem) $adresar_kam$name7"
Compress-Archive -Path "C:\Users\DELL\Documents\java_script" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name7"
$kontrola=1
}else{
Write-host -ForegroundColor red " $pocitadlo/$celkem) $adresar_kam$name7"
}
$pocitadlo++

# 8
if ( $CheckBox_8.Checked -like "True" ){ 
Write-host -ForegroundColor green " $pocitadlo/$celkem) $adresar_kam$name8"
Compress-Archive -Path "C:\Users\DELL\Documents\ubuntu" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name8"
$kontrola=1
}else{
Write-host -ForegroundColor red " $pocitadlo/$celkem) $adresar_kam$name8"
}
$pocitadlo++

# 9
if ( $CheckBox_9.Checked -like "True" ){ 
Write-host -ForegroundColor green " $pocitadlo/$celkem) $adresar_kam$name9"
Compress-Archive -Path "C:\Users\DELL\Documents\Lua52_Win32" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name9"
$kontrola=1
}else{
Write-host -ForegroundColor red " $pocitadlo/$celkem) $adresar_kam$name9"
}
$pocitadlo++

# 10
if ( $CheckBox_10.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name10"
Compress-Archive -Path "C:\Users\DELL\Documents\BaseCamp\*" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name10"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name10"
}
$pocitadlo++

# 11
if ( $CheckBox_11.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name11"
Compress-Archive -Path "C:\Users\DELL\Pictures\Ballon_story\" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name11"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name11"
}
$pocitadlo++

# 12
if ( $CheckBox_12.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name12"
Compress-Archive -Path "C:\Users\DELL\Documents\DOS" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name12"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name12"
}
$pocitadlo++

# 13
if ( $CheckBox_13.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name13"
Compress-Archive -Path "C:\Users\DELL\Documents\zaloha\save_hry" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name13"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name13"
}
$pocitadlo++

# 14
if ( $CheckBox_14.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name14"
Compress-Archive -Path "C:\Users\DELL\Documents\zaloha\login" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name14"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name14"
}
$pocitadlo++

# 15
if ( $CheckBox_15.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name15"
Compress-Archive -Path "C:\Users\DELL\Documents\Dev-Cpp" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name15"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name15"
}
$pocitadlo++

# 16
if ( $CheckBox_16.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name16"
Compress-Archive -Path "C:\Users\DELL\Pictures" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name16"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name16"
}
$pocitadlo++

# 17
if ( $CheckBox_17.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name17"
Compress-Archive -Path "C:\Users\DELL\Music" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name17"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name17"
}
$pocitadlo++

# 18
if ( $CheckBox_18.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name18"
Compress-Archive -Path "C:\Users\DELL\Documents\LibreOffice" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name18"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name18"
}
$pocitadlo++

# 19
if ( $CheckBox_19.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name19"
Compress-Archive -Path "C:\Users\DELL\Documents\PDF" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name19"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name19"
}
$pocitadlo++

# 20
if ( $CheckBox_20.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name20"
Compress-Archive -Path "C:\Users\DELL\Documents\ZX" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name20"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name20"
}

# 21
if ( $CheckBox_21.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name21"
Compress-Archive -Path "C:\Users\DELL\Desktop" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name21"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name21"
}


# 22
if ( $CheckBox_22.Checked -like "True" ){ 
Write-host -ForegroundColor green "$pocitadlo/$celkem) $adresar_kam$name22"
Compress-Archive -Path "C:\Users\DELL\Documents\dnes" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name22"
$kontrola=1
}else{
Write-host -ForegroundColor red "$pocitadlo/$celkem) $adresar_kam$name22"
}

<#----------------------------------------------------------------------------------------------------------------------------#>


#echo $kontrola
if ( $kontrola -eq 1 ) {
# vytori na ramdisku davku pro test unzipem, jenom kdyz $kontrola = 1
$file = "R:\test_zip.bat"
$stream = [System.IO.StreamWriter]::new($file)
$unzip="unzip -t "
$unzip+=$adresar_kam
$unzip+=$datum # kontroluje jenom soubory vytvorene ted
$unzip+="-*.zip"
#echo $unzip

#$stream.WriteLine("@echo off")
# caka 20 vterin jednotek kdyz zapisoval na optiku ( d:\, D:\, z:\, Z:\ ) jinak 5
if ( $opticka_jednotka -eq 1 ) {
$stream.WriteLine("REM ceka 30 vterin po zapisu na BD-cko")
$stream.WriteLine("sleep 30") # tady predelat, pouze jestli ze je d:\ nebo z:\
}else{
$stream.WriteLine("sleep 5")
}
$stream.WriteLine("$unzip")
$stream.WriteLine("REM kontroluje unzipem jenom ty souboru co byli vytvoreni ted, drivejsiho si nevsima, diky nahradnim znakum")
#$stream.WriteLine("@echo on")
$stream.WriteLine("pause") # okno zustane vyset v rezimu pause
$stream.WriteLine("del $file") # smaze "R:\test_zip.bat" sam sebe (v pameti RAM jeste je...)
$stream.close()
}

