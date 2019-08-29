#Warnings
ECHO "*******************************"
ECHO "***Adding Power to this Shell**"
ECHO "****Supercharging this shell***"
ECHO "**Be Careful**Be Very Careful**"
ECHO "*******************************"
Write-Host "This is a radioactive shell" -ForegroundColor Red 
Write-Host "      ______________________________    . \  | / .
     /                            / \     \ \ / /
    |                            | ==========  - -
     \____________________________\_/     / / \ \
  ______________________________      \  | / | \
 /                            / \     \ \ / /.   .
|                            | ==========  - -
 \____________________________\_/     / / \ \    /
      ______________________________   / |\  | /  .
     /                            / \     \ \ / /
    |                            | ==========  -  - -
     \____________________________\_/     / / \ \
                                        .  / | \  ." -ForegroundColor white -BackgroundColor Red
										




# directory where my scripts are stored
$psdir="C:\Users\diq\Documents\WindowsPowerShell\Scripts"  
# load all 'autoload' scripts
Get-ChildItem "${psdir}\*.ps1" | %{.$_} 
Write-Host "Loading Custom PowerShell Environment" -ForegroundColor Magenta 
										
Write-Host " Adding function Get-Profile..." -ForegroundColor Magenta 

Function Get-Profile
{
<#
    .SYNOPSIS
      Opens the current profile in notepad
    .EXAMPLE
     Get-Profile 
     This command opens the current profile in notepad for editing.
#>

 Notepad $profile
} #end function get-profile

#begin  import-allmodules 
Function Import-AllModules
{<#
    .SYNOPSIS
      Loads all Modules listed in $PSModulePath
    .EXAMPLE
     Import-AllModules
     This command Loads all Modules listed in $PSModulePath.
    .Alias
     iam
     
#>
Get-Module -ListAvailable | Import-Module

}#endimport-allmodules
Write-Host " Adding function Import-AllModules..." -ForegroundColor Magenta

Function Remove-AllModules

{Get-Module -ListAvailable | Remove-Module}

Set-Alias -Name ram -Value Remove-AllModules

Set-Alias -Name iam -Value import-allmodules

Write-Host " Adding function Remove-AllModules..." -ForegroundColor Magenta

#begin Get-Commands
Function Get-Commands

{
<#
    .SYNOPSIS
      Get-Command works great. But the default output is not what I normally would do. For example, because of all the cmdlets and functions, the output invariably scrolls, so I need to pipe the results to More. In addition, I normally am looking for cmdlets from the same module, so I like to sort by the module. I therefore came up with this function that I call Get-Commands (I also created an alias for it)
    .EXAMPLE
    Get-Commands -verb
     About the only thing notable here, is the use of $psBoundParameters. This cool automatic variable keeps track of parameters that are supplied to a function. I need to know if –Verb or –Noun or both –Verb and –Noun are supplied so I can create the syntax for the Get-Command cmdlet.

In the past, I would have needed to use a series of If / Else / Elseif types of construction to get the correct syntax. By using $PSBoundParameters, I do not need to do this. I simply pass whatever is supplied as arguments to the function to the command line via $PSBoundParameters. I then sort the results on the Module parameter and send the results to the More command. It works great, and saves me a lot of repetitive typing.
    .Alias
     iam
     
#>
 Param($verb,

       $noun)

 Get-Command @PSBoundParameters | Sort-Object module | more

}#end Get-Commands

Set-Alias -Name gcms -Value get-commands
Write-Host " Adding function Get-Commands..." -ForegroundColor Magenta

#begin Test-IsAdmin functino
Function Test-IsAdmin

{

 <#

    .Synopsis

        Tests if the user is an administrator

    .Description

        Returns true if a user is an administrator, false if the user is not an administrator       

    .Example

        Test-IsAdmin

    #>

 $identity = [Security.Principal.WindowsIdentity]::GetCurrent()

 $principal = New-Object Security.Principal.WindowsPrincipal $identity

 $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

}

#check if this the Admin shell

Function Set-ConsoleConfig

{
<#
    .SYNOPSIS
     Check if the shell is admin or not and set the shell title accordingly
    .EXAMPLE
    Get-Commands -verb
     check if the shell is admin or not
     
#>

 if(-not (Test-IsAdmin))

  {$Host.ui.RawUI.WindowTitle = "Mr $($env:USERNAME)- Non-elevated Posh-Regular PowerShell dude"}

 else {$Host.ui.RawUI.WindowTitle = "Elevated PowerShell-SUPER PowerShell dude!"}

} #end function set-consoleconfig

Set-ConsoleConfig
Write-Host " Adding function Set-ConsoleConfig..." -ForegroundColor Magenta
Write-Host " Checking for Admin Rights..." -ForegroundColor Magenta




Function Edit-Profile

{ 
 <#

    .Synopsis

        Opens the profile in ise for editing

    .Description

        Returns true if a user is an administrator, false if the user is not an administrator       

    .Example

        Edit-Profile

    #>
    ISE $profile } #end Edit-Profile function

Write-Host " Adding function Edit-Profile..." -ForegroundColor Magenta

#begin Replace-InvalidFileCharacters
    
Function Replace-InvalidFileCharacters

{
 <#

    .Synopsis

        Replaces invalid characters with replacement character
    .Examples
        Replace-InvalidFileCharacters($stringIn,$replacementChar)

        #>

 Param ($stringIn,

        $replacementChar)

 # Replace-InvalidFileCharacters "my?string"

 # Replace-InvalidFileCharacters (get-date).tostring()

 $stringIN -replace "[$( [System.IO.Path]::GetInvalidFileNameChars() )]", $replacementChar

}
Write-Host " Adding function Replace-InvalidFileCharacters..." -ForegroundColor Magenta

#begin Get-WebPage
Function Get-WebPage

{

 Param($url)

 # Get-WebPage -url (Get-CmdletFwLink get-process)

 (New-Object -ComObject shell.application).open($url)

}#end function Get-Webpage

Write-Host " Adding function Get-WebPage..." -ForegroundColor Magenta




# display the appropriate warning
Write-Host "     _.-^^---....,,--       
 _--                  --_  
<                        >)
|                         | 
 \._                   _./  
    ```--. . , ; .--'''       
          | |   |             
       .-=||  | |=-.   
       `-=#$%&%$#=-'   
          | ;  :|     
 _____.,-#%&$@%#&#~,._____" -ForegroundColor white -BackgroundColor Black
 
Write-Host '--------------------------" -ForegroundColor Green
Write-Host 'Welcome to' "$env:computername" -ForegroundColor Green
Write-Host "You are logged in as" "$env:username"
Write-Host "Today:" (Get-Date)
Set-Location c:\
Write-Host "PowerShell"($PSVersionTable.PSVersion.Major)"awaiting your commands."