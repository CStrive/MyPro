<#
	警告：千万不要在未发布的程序中执行此文件
#>
echo '开始执行清理'
#获取目录
$currentDirectory=$MyInvocation.MyCommand.Definition;
$currentDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition
#复制会员中相关文件
Copy-Item ($currentDirectory+'\usercenter\App_GlobalResources\*.resx')  ($currentDirectory+'\App_GlobalResources\')
Copy-Item ($currentDirectory+'\usercenter\bin\Zm.Web.UserCenter.dll')  ($currentDirectory+'\bin\')
#创建数组
$files=@();
#删除css
$files+=($currentDirectory+'\dist\css\core\');
$files+=($currentDirectory+'\dist\css\core.css');
$files+=($currentDirectory+'\dist\css\user.css');
#删除js
$files+=($currentDirectory+'\dist\js\core\');
$files+=($currentDirectory+'\dist\js\master\');
$files+=($currentDirectory+'\dist\js\vue\');
$files+=($currentDirectory+'\dist\js\core.js');
$files+=($currentDirectory+'\dist\js\user.js');
$files+=($currentDirectory+'\dist\js\vue.js');
$files+=($currentDirectory+'\dist\js\content.js');
$files+=($currentDirectory+'\dist\js\upload\uploader.js');
$files+=($currentDirectory+'\dist\js\upload\plupload.full.min.js');
$files+=($currentDirectory+'\dist\js\upload\zh_cn.js');
$files+=($currentDirectory+'\dist\js\upload\config.js');
$files+=($currentDirectory+'\dist\js\upload\initialize.js');
$files+=($currentDirectory+'\dist\js\page\role.js');
$files+=($currentDirectory+'\dist\js\codemirror\core\');
$files+=($currentDirectory+'\dist\js\codemirror\mode\');
#删除包管理文件
$files+=($currentDirectory+'\packages.config');
$files+=($currentDirectory+'\bundleconfig.json.bindings');
$files+=($currentDirectory+'\bundleconfig.json');
#删除管理后台相关文件
$files+=($currentDirectory+'\manage\bin\');
$files+=($currentDirectory+'\manage\ApplicationInsights.config');
$files+=($currentDirectory+'\manage\packages.config');
$files+=($currentDirectory+'\manage\web.config');
$files+=($currentDirectory+'\manage\zm.signature.pfx');
#删除bin包中的无关内容
$files+=($currentDirectory+'\bin\roslyn\');
$files+=($currentDirectory+'\bin\ApplicationInsights.config');
$files+=($currentDirectory+'\bin\*.config');
#删除根目录无关内容
$files+=($currentDirectory+'\sql\');
$files+=($currentDirectory+'\zm.signature.pfx');
$files+=($currentDirectory+'\packages.config');

#删除会员中心相关文件
$files+=($currentDirectory+'\usercenter\bin\');
$files+=($currentDirectory+'\usercenter\web.config');
$files+=($currentDirectory+'\usercenter\zm.signature.pfx');

#删除会员中心资源目录
$files+=($currentDirectory+'\usercenter\App_GlobalResources\');
#删除pdb
$files+=($currentDirectory+'\bin\*.pdb')
 #删除无关的theme
 $pdb=$currentDirectory+'\theme\';
Get-ChildItem $pdb | ForEach-Object -Process{
if($_.name -ne 'skin' -and $_.name -ne 'skin4' -and $_.name -ne 'skin4-native'){
	Remove-Item $pdb$_ -recurse;
	}
else{
	$files+= ($pdb+$_+'\dist\css\core\');
	$files+=($pdb+$_+'\dist\css\shared.css');
	$files+=($pdb+$_+'\dist\css\shared-all.css');
	$files+=($pdb+$_+'\dist\css\shared-v4.css');
	$files+=($pdb+$_+'\dist\css\shared-all-v4.css');
	$files+=($pdb+$_+'\dist\css\shared-pc-v4.css');
	$files+=($pdb+$_+'\dist\css\shared-mobile-v4.css');
	$files+=($pdb+$_+'\dist\css\video.css');
	$files+=($pdb+$_+'\dist\js\core\');
	$files+=($pdb+$_+'\dist\js\shared.js');
	$files+=($pdb+$_+'\dist\js\shared-all.js');
	$files+=($pdb+$_+'\dist\js\shared-v4.js');
	$files+=($pdb+$_+'\dist\js\shared-all-v4.js');
	$files+=($pdb+$_+'\dist\js\shared-pc-v4.js');
	$files+=($pdb+$_+'\dist\js\shared-mobile-v4.js');
	$files+=($pdb+$_+'\assist\thumb\magicthumb-crack.js');
	$files+=($pdb+$_+'\assist\thumb\magicthumb.css');
	$files+=($pdb+$_+'\assist\videojs\videojs.css');
	}
}
#删除无关的db
$pdb=$currentDirectory+'\App_Data\';
Get-ChildItem $pdb | ForEach-Object -Process{
	if(($_.name -ne 'db-source.sdf') -and ($_.name -ne 'country.db') -and ($_.name -ne 'db-source.db')){
		$files+=($pdb+$_.name)
	}
}
#回收站安全删除
foreach($file in $files){
	if(Test-Path $file)
	{
		echo '删除:'$file
	   $flag=(Get-Item $file) -is [IO.fileinfo]
		if($flag -eq "true")
		{
			Remove-Item $file;
        
		}else{
			Remove-Item $file -recurse
		}
	}
}

 echo '清理执行完成'
 #输入提示
 Write-Host 'Press Any Key!' -NoNewline
$null = [Console]::ReadKey('?')


