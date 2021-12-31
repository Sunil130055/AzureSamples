$SubscriptionID	   = <Subscription Name of the data factory>
$ResourceGroupName = <ResourceGroup Name of the data factory>  
$DataFactoryName   = <Name of the data factory>
$CompareDate1      = <Comparision Start Date> #"YYYY-MM-DD"
$CompareDate2      = <Comparision End Date>   #"YYYY-MM-DD"
$StartDateTime     = <Start DateTime of dates between which status are taken from Datafactory>  #"YYYY-MM-DDThh:mm:ssZ"
$EndDateTime 	   = <End DateTime of dates between which status are taken from Datafactory>  #"YYYY-MM-DDThh:mm:ssZ"

$sub     = Get-AzureRmSubscription -SubscriptionId $SubscriptionID        
$thissub = set-AzureRmContext -SubscriptionObject $sub

$totalresults =Get-AzureRmDataFactoryActivityWindow `
				 -DataFactoryName $DataFactoryName `
				 -ResourceGroupName $ResourceGroupName `
				 -RunStart $StartDateTime |`    
				  Select-Object PipelineName, ActivityName, Duration ,@{Name='RunDate';Expression={Get-Date $_.RunStart -Format 'yyyy-MM-dd'}},ActivityType, WindowState, `
						  PercentComplete,   RunEnd `
				 | Sort-Object WindowState #|Export-csv -Path "C:\Users\spoluri001\Documents\pipelineactivitydurationcompare.csv"

$PipelineActivity = New-Object System.Data.DataTable
$PipelineActivity.Columns.Add("Pipeline_Name", "System.String") | Out-Null
$PipelineActivity.Columns.Add("Activity_Name", "System.String") | Out-Null
$PipelineActivity.Columns.Add("CompareDate1_Duration","System.String") | Out-Null
$PipelineActivity.Columns.Add("CompareDate2_Duration","System.String") | Out-Null

# $totalresults
$dataset1 = $totalresults |Where-object {$_.RunDate -eq $CompareDate1}
$dataset2 = $totalresults |Where-object {$_.RunDate -eq $CompareDate2}

foreach($DataSetItem in $dataset1){
	  $CompareDate2_Duration     = $dataset2 |where-object {$_.pipelinename -eq $DataSetItem.pipelinename -and $_.activityname -eq $DataSetItem.activityname } |Select Duration	  
      $Row			    		 = $pipelineActivity.newrow()
	  $Row.Pipeline_Name 		 = $DataSetItem.pipelinename;  
	  $Row.Activity_Name 		 = $DataSetItem.activityname;
	  $Row.CompareDate1_Duration = $DataSetItem.duration; 
	  $Row.CompareDate2_Duration = $date2duration;
	  $PipelineActivity.rows.add($Row)

	  write-host "Pipeline Duration " + $DataSetItem.duration
}

$pipelineactivityresultset  
