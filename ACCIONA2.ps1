$hostname= get-vmhost adcmad09ho72.adc.bt.es

get-VMHost $hostname| Get-VirtualSwitch -Name "vSwitch0" | New-VirtualPortGroup -Name “PortGroup-VM92” -VLanId 92
get-VMHost $hostname| Get-VirtualSwitch -Name "vSwitch0" | get-nicteamingpolicy|set-nicteamingpolicy -makenicactive vmnic1

get-vmhost $hostname|Add-VMHostNtpServer -NtpServer 10.5.0.191
get-vmhost $hostname|Get-VmHostService | Where-Object {$_.key -eq "ntpd"} | Start-VMHostService
get-vmhost $hostname|Get-VmHostService | Where-Object {$_.key -eq "ntpd"} | Set-VMHostService -policy "automatic"
get-vmhost $hostname|Get-VMHostService | Where {$_.Key –eq “TSM-SSH”} | Set-VMHostService –Policy “On”

new-virtualswitch -host $hostname -name "vSwitch1" -Nic vmnic2,vmnic3

get-VMHost $hostname| Get-VirtualSwitch -Name "vSwitch1" | New-VirtualPortGroup -Name “VM3043_BESTINVER” -VLanId 3043 

new-virtualswitch -host $hostname -name "vSwitch2" -Nic vmnic4,vmnic5

get-VMHost $hostname| Get-VirtualSwitch -Name "vSwitch2" | New-VirtualPortGroup -Name “VF189_ACCIONA” -VLanId 189
