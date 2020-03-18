<#
	���棺ǧ��Ҫ��δ�����ĳ�����ִ�д��ļ�
#>
echo '��ʼִ������'
#��ȡĿ¼
$currentDirectory=$MyInvocation.MyCommand.Definition;
$currentDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition
#���ƻ�Ա������ļ�
Copy-Item ($currentDirectory+'\usercenter\App_GlobalResources\*.resx')  ($currentDirectory+'\App_GlobalResources\')
Copy-Item ($currentDirectory+'\usercenter\bin\Zm.Web.UserCenter.dll')  ($currentDirectory+'\bin\')
#��������
$files=@();
#ɾ��css
$files+=($currentDirectory+'\dist\css\core\');
$files+=($currentDirectory+'\dist\css\core.css');
$files+=($currentDirectory+'\dist\css\user.css');
#ɾ��js
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
#ɾ���������ļ�
$files+=($currentDirectory+'\packages.config');
$files+=($currentDirectory+'\bundleconfig.json.bindings');
$files+=($currentDirectory+'\bundleconfig.json');
#ɾ�������̨����ļ�
$files+=($currentDirectory+'\manage\bin\');
$files+=($currentDirectory+'\manage\ApplicationInsights.config');
$files+=($currentDirectory+'\manage\packages.config');
$files+=($currentDirectory+'\manage\web.config');
$files+=($currentDirectory+'\manage\zm.signature.pfx');
#ɾ��bin���е��޹�����
$files+=($currentDirectory+'\bin\roslyn\');
$files+=($currentDirectory+'\bin\ApplicationInsights.config');
$files+=($currentDirectory+'\bin\*.config');
#ɾ����Ŀ¼�޹�����
$files+=($currentDirectory+'\sql\');
$files+=($currentDirectory+'\zm.signature.pfx');
$files+=($currentDirectory+'\packages.config');

#ɾ����Ա��������ļ�
$files+=($currentDirectory+'\usercenter\bin\');
$files+=($currentDirectory+'\usercenter\web.config');
$files+=($currentDirectory+'\usercenter\zm.signature.pfx');

#ɾ����Ա������ԴĿ¼
$files+=($currentDirectory+'\usercenter\App_GlobalResources\');
#ɾ��pdb
$files+=($currentDirectory+'\bin\*.pdb')
 #ɾ���޹ص�theme
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
#ɾ���޹ص�db
$pdb=$currentDirectory+'\App_Data\';
Get-ChildItem $pdb | ForEach-Object -Process{
	if(($_.name -ne 'db-source.sdf') -and ($_.name -ne 'country.db') -and ($_.name -ne 'db-source.db')){
		$files+=($pdb+$_.name)
	}
}
#����վ��ȫɾ��
foreach($file in $files){
	if(Test-Path $file)
	{
		echo 'ɾ��:'$file
	   $flag=(Get-Item $file) -is [IO.fileinfo]
		if($flag -eq "true")
		{
			Remove-Item $file;
        
		}else{
			Remove-Item $file -recurse
		}
	}
}

 echo '����ִ�����'
 #������ʾ
 Write-Host 'Press Any Key!' -NoNewline
$null = [Console]::ReadKey('?')


