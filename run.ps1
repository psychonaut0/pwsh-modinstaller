Add-Type -assembly System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$form_width = 398
$form_height = 250


$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = 'BLVCKServer Minecraft Mod installer'

$main_form.Width = $form_width
$main_form.Height = $form_height

$main_form.FormBorderStyle = "FixedSingle"

$main_form.AutoSize = $false


$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(286, 165)
$Button.Size = New-Object System.Drawing.Size(84, 35)
$Button.Text = "Installa"
$Button.FlatStyle = "Standard"
$Button.FlatAppearance.BorderSize = 0

$Button.Add_Click(
  {
    Write-Output $Button.text
    if ( $Button.text -cne "Close" ) {
      if ( Test-Path -Path  $Env:HOMEDRIVE$Env:HOMEPATH\Appdata\Roaming\.minecraft) {
        $Button.Enabled = $false;
        $ProgressBar.Value = 10;
        $Content.Text = "Installing Chocolatey...";
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));
        $Content.Text = "Done.";
        $ProgressBar.Value = 20;
        $Content.Text = "Installing wget...";
        choco install -y wget;
        $Content.Text = "Done.";
        $ProgressBar.Value = 30;
        $Content.Text = "Installing Java runtime...";
        choco install -y javaruntime;
        $Content.Text = "Done.";
        $ProgressBar.Value = 40;
        $Content.Text = "Downloading forge installer...";
        wget -O $Env:HOMEDRIVE$Env:HOMEPATH\Appdata\Local\Temp\ForgeScriptInstaller.jar "https://maven.minecraftforge.net/net/minecraftforge/forge/1.18.2-40.1.73/forge-1.18.2-40.1.73-installer.jar";
        $Content.Text = "Download of forge installer is Done.";
        $ProgressBar.Value = 50;
        $Content.Text = "Downloading forge CLI...";
        wget -O $Env:HOMEDRIVE$Env:HOMEPATH\Appdata\Local\Temp\ForgeCli.jar "https://github.com/TeamKun/ForgeCLI/releases/download/1.0.1/ForgeCLI-1.0.1-all.jar";
        $Content.Text = "Download of forge CLI Done.";
        $ProgressBar.Value = 60;
        $Content.Text = "Installing forge...";
        java -jar $Env:HOMEDRIVE$Env:HOMEPATH\Appdata\Local\Temp\ForgeCli.jar --installer $Env:HOMEDRIVE$Env:HOMEPATH\Appdata\Local\Temp\ForgeScriptInstaller.jar --target $Env:HOMEDRIVE$Env:HOMEPATH\AppData\Roaming\.minecraft\
        $Content.Text = "Installation Done.";
        $ProgressBar.Value = 70;
        $Content.Text = "Downloading Mods from server...";
        wget -O $Env:HOMEDRIVE$Env:HOMEPATH\Appdata\Local\Temp\modpack.zip "https://cloud.blvckhat.dev/s/a7k7MQjSHiDAWZc/download";
        $Content.Text = "Download of Mods Done.";
        $ProgressBar.Value = 80;
        $Content.Text = "Extracting mods...";
        Expand-Archive -Force $Env:HOMEDRIVE$Env:HOMEPATH\Appdata\Local\Temp\modpack.zip -DestinationPath $Env:HOMEDRIVE$Env:HOMEPATH\Appdata\Local\Temp\modpack;
        $Content.Text = "Extraction completed";
        $ProgressBar.Value = 90;
        $Content.Text = "moving mods in mc directory...";
	  Remove-Item $Env:HOMEDRIVE$Env:HOMEPATH\Appdata\Roaming\.minecraft\mods\* -Force
        Move-Item $Env:HOMEDRIVE$Env:HOMEPATH'\Appdata\Local\Temp\modpack\Minecraft mods\*' $Env:HOMEDRIVE$Env:HOMEPATH\Appdata\Roaming\.minecraft\mods -Force;
        $Content.Text = "completed!";
        $Content.Text = "Clearing files...";
        Remove-Item $Env:HOMEDRIVE$Env:HOMEPATH'\Appdata\Local\Temp\modpack\Minecraft mods' -Force;
        Remove-Item $Env:HOMEDRIVE$Env:HOMEPATH'\Appdata\Local\Temp\modpack\ForgeScriptInstaller.jar' -Force;
        Remove-Item $Env:HOMEDRIVE$Env:HOMEPATH'\Appdata\Local\Temp\modpack\ForgeCli.jar' -Force;
        Remove-Item $Env:HOMEDRIVE$Env:HOMEPATH'\Appdata\Local\Temp\modpack\modpack.zip' -Force;
        $Content.Text = "completed!";
        $ProgressBar.Value = 100;
        $Button.Enabled = $true;
        $Button.Text = "Close";       
      }
    }
    else {
      $main_form.Close()
    }
  }
)


$ProgressBar = New-Object System.Windows.Forms.ProgressBar
$ProgressBar.Location = New-Object System.Drawing.Size(10, 120)
$ProgressBar.Size = New-Object System.Drawing.Size(358, 35)
$ProgressBar.Maximum = 100
$ProgressBar.Minimum = 0
$ProgressBar.MarqueeAnimationSpeed = 100
$ProgressBar.Step = 10


$Heading = New-Object System.Windows.Forms.TextBox
$Heading.Text = "Cosi' non mi chiedete piu' come si fa!"
$Heading.BorderStyle = "None"
$Heading.ReadOnly = $true
$Heading.Font = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$Heading.Location = New-Object System.Drawing.Size(10, 10)
$Heading.Size = New-Object System.Drawing.Size(300, 20)


$Content = New-Object System.Windows.Forms.RichTextBox
$Content.Text = "Con questo piccolo installer verra' eseguita automaticamente l'installazione di tutti i software necessari e le mod per il server minecraft cb.
MAMA MIA!"
$Content.BorderStyle = "None"
$Content.ReadOnly = $true
$Content.Font = [System.Drawing.Font]::new("Segoe UI", 10)
$Content.Location = New-Object System.Drawing.Size(10, 40)
$Content.Size = New-Object System.Drawing.Size(360, 85)




$main_form.Controls.Add($Button)
$main_form.Controls.Add($ProgressBar)
$main_form.Controls.Add($Heading)
$main_form.Controls.Add($Content)


$main_form.ShowDialog()
