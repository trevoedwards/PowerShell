Get-CimInstance -ClassName Win32_PhysicalMemory | Format-Table Capacity, Manufacturer, MemoryType, FormFactor, Name, Configuredclockspeed, Speed, Devicelocator, Serialnumber -AutoSize
