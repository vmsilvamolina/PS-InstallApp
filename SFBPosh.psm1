Function Clean-SFBUsers {
    <#
    .SYNOPSIS
        Este Cmdlet permite borrar los valores de los atributos que usa Skyoe for Business/Lync Server
        en un usuario (o varios) de la organización.
    .EXAMPLE
        Clean-SFBUsers -User 'vsilva'

        Con el ejemplo anterior, todos los atributos de la indentidad 'vsilva'
        que estén con información pasarán a quedar de forma predeterminada sin valores asignados.
    .PARAMETER User
        Identidad a la que se pretende modificar los atributos.
    #>
    param (
      [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$User
    )
    process {
      $adUser = Get-ADUser $User
      $ldapDN = "LDAP://" + $adUser.distinguishedName
      $userObject = New-Object DirectoryServices.DirectoryEntry $ldapDN
      $userObject.PutEx(1, "msRTCSIP-UserEnabled", $null)
      $userObject.PutEx(1, "msRTCSIP-PrimaryHomeServer", $null)
      $userObject.PutEx(1, "msRTCSIP-PrimaryUserAddress", $null)
      $userObject.PutEx(1, "msRTCSIP-ArchivingEnabled", $null)
      $userObject.PutEx(1, "msRTCSIP-OptionFlags", $null)
      $userObject.PutEx(1, "msRTCSIP-DeploymentLocator", $null)
      $userObject.PutEx(1, "msRTCSIP-UserPolicies", $null)
      $userObject.PutEx(1, "msRTCSIP-FederationEnabled", $null)
      $userObject.PutEx(1, "msRTCSIP-InternetAccessEnabled", $null)
      $adUser.SetInfo()
    }
}
