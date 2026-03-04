function InstallFonts {
    $fontFolder = ".\Data\Fonts"
    $destinationPath = "C:\Windows\Fonts"
    $destinationRegKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
    $files = Get-ChildItem -Path $fontFolder -Recurse -Include *.*tf


    if (!(Test-Path $destinationPath -PathType Container)) {
        Write-Host "👽 dosya olusturuluyor"
        New-Item -ItemType Directory $destinationPath
    }

    foreach ($file in $files) {
    
        $newFontPath = $file.Name
        $fontName = $file.BaseName
        switch ($file.Extension) {  
            ".ttf" {$fontName = "$fontName (TrueType)"}  
            ".otf" {$fontName = "$fontName (OpenType)"}  
        }

        write-host "🖋️ Font dosyası: $file.BaseName => '$fontName' adı ile kopyalanıyor"

        If(!(Test-Path ($destinationPath + "\" + $file.Name))) {
            write-host "🥳 Font dosyası kopyalanıyor: $file"
            Copy-Item $file.FullName  $destinationPath
        }
        else {
            write-host "🎉 Font zaten var: $file.BaseName"
        }

        If (!(Get-ItemProperty -Name $fontName -Path $destinationRegKey -ErrorAction SilentlyContinue)) {  
            write-host "🧯 Font dosyası registera kaydedılıyor: $file"
            New-ItemProperty -Name $fontName -Path $destinationRegKey -Value $newFontPath | Out-Null 
        } 
        else {  
            write-host "🎉 Font zaten kayıtlı: $file.BaseName" 
        }
    }
}

Export-ModuleMember -Function "InstallFonts"
