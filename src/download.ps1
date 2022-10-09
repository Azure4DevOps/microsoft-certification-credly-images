$page="https://www.credly.com/organizations/microsoft-certification/badges.json"

$cont="";
$cont_bb="";
$outPutPath="C:\DownloadBadgesImagesMS\"
$nl = [Environment]::NewLine

if (!(test-path -path $outPutPath)) {new-item -path $outPutPath -itemtype directory}
if (!(test-path -path $outPutPath\img)) {new-item -path $outPutPath\img -itemtype directory}

while($page -ne "")
{
    $response=Invoke-RestMethod -Uri $page
    $data=$response.data|Sort-Object -Property name -Descending
   
    Foreach ($i in $data)
    {
        #save images locally if you
        #Invoke-WebRequest $i.image_url -OutFile "$outPutPath/img/$($i.name.Replace(":"," ")).png"
    
        #output item html template
        $aa="<a href='$($i.url)' title='$($i.name)'><img src='$($i.image_url)' width='140' alt='$($i.name),$($i.description)'/></a>"
        $cont+=$aa+$nl     
        #$bb="<a href='$($i.url)' title='$($i.name)'><img src='$outPutPath/img/$($i.name.Replace(":"," ").Replace(" ","%20")).png' width='140' alt='$($i.name),$($i.description)'/></a>"
        $bb="<a href='$($i.url)' title='$($i.name)'><img src='downloads/img/$($i.name.Replace(":"," ").Replace(" ","%20")).png' width='140' alt='$($i.name),$($i.description)'/></a>"
        $cont_bb+=$bb+$nl             
    }
    if($response.metadata.next_page_url -eq $null)
    {
        $page=""
    }
    else
    {
        $page=$response.metadata.next_page_url
    }
}


$cont|Out-File -FilePath "$($outPutPath)creadexport_local.html"
$cont_bb|Out-File -FilePath "$($outPutPath)creadexport_local_img.html"
