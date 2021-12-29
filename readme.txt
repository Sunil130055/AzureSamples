Objective:
The objective for this script is to get status of pipeline involved in data factory version 1 and trigger the pipeline with desired status as per requirements

Azure Datafactory is a cloud-based data integration service that allows you to create data-driven workflows in the cloud that orchestrate and 
automate data movement and data transformation. We can create and schedule data driven workflows called as pipelines. A pipeline can have one or more activities.
Activities define the actions to perform on your data. An activity takes zero or more datasets as inputs and one or more datasets as outputs.
Datasets represent data structures within the data stores. 

How to use : Run the script in powershell ISE and can connect to Azure datafactory to check pipeline status.

Azure datafactory piplines has different status types-

Waiting        --> its ready for execution 
Failed	       --> the actiivty is failed 
Ready          --> acivity is sucessful 
InProgress     --> Acitivity is in progress 

User has to provide following details :
	1.$DataSet_Name & $DataSet_Name2 - Set the search pattern for the data sets to be updated. User can leave $DataSet_Name2 null to process one set or enter a second value to process a second set 
					of data sets in case of a dataset name search.
	2.$Start_DateTime & $End_DateTime -  User needs to consider first and the last slice dates. Date format "YYYY-MM-DDTHH:MM:SS.ssssss" is required.

	*Process controls (which controls execution of this script):

	3. $Set_Pipeline_Status : Pipeline status can be set to "Waiting" #Failed, InProgress, Ready, Skipped, Waiting as per the requirement. #generally waiting is used
	4. $do_update = (False/True) Make sure that status is set to false before running the script. This will provide us a list of the current status of activity based 
			     on dataset information user has provided. $do_update true will update activity status to the status mentioned for pipline status.


Pre-Requisites:

1.    Azure Subscription
2.    Azure resource group 
3.    Azure datafactory  
4.    Datafactory contributor access to azure datafactory v1
5.    Windows powershell ISE (for script execution) 



