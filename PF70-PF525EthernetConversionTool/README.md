Structure: This system has the following file structure:

	1)PF Drive Upgrade (or similar folder name)
	    1)CSVFilesForTest
	        A)Inputs
	        B)Outputs
	        C)Templates
	            i)pf525Test.CSV
	    2)PF70toPF525.ps1
 
 This Script is intended to Automate the conversion problems going from a PF70 to a PF525. There are a few assumptions:

	1) It will be an Ethernet Drive. If you have a DeviceNet PF70, you must first use the DeviceNet PF70 Tool I have written.
	2) you can connect to the drive in CCW, or have a project file that contains the drive setup.


To perform the Conversion:

	1) Connect to the drive in CCW.
	2) Open the Parameters, ensure you are not filtering out any (not using non-default only button, nothing in search box), click "Export CSV"
	3) Save CSV File as drive name in the 'PF Drive Upgrade/Inputs' folder
	4) Right Click PF70toPF525.ps1, click "Run with Powershell"
	5) Once Black Terminal closes, 'PF Drive Upgrade/Outputs/PF5 Files' should have an identically named .PF5 file.
	6) This file can be downloaded directly to the PF525, although I HIGHLY recommend importing the file into CCW to ensure nothing looks out of the ordinary.
Please include input CSV and Output CSV with all questions.
