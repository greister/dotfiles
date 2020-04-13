# Windows Features

# containers
# Hyper-V
# Virtual Machine Platform
# Telnet client
# Windows Hypervisor platform
# Windows SAndbox
# Windows subsystem for linux

Enable-WindowsOptionalFeature -FeatureName 'HypervisorPlatform' -All -Online -NoRestart
Enable-WindowsOptionalFeature -FeatureName 'Containers' -All -Online -NoRestart
Enable-WindowsOptionalFeature -FeatureName 'Containers-DisposableClientVM' -All -Online -NoRestart
Enable-WindowsOptionalFeature -FeatureName 'TelnetClient' -All -Online -NoRestart 
Enable-WindowsOptionalFeature -FeatureName 'VirtualMachinePlatform' -All -Online -NoRestart
Enable-WindowsOptionalFeature -FeatureName 'Microsoft-Windows-Subsystem-Linux' -All -Online -NoRestart
Enable-WindowsOptionalFeature -FeatureName 'Microsoft-Hyper-V' -All -Online
