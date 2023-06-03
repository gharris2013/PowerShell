$shell = New-Object -ComObject Shell.Application
$recycleBin = $shell.Namespace(0xA)
$recycleBin.Items() | foreach {
    $recycleBin.InvokeVerb("Delete")
}
