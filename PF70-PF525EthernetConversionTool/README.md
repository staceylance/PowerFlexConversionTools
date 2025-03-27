Structure: This system has the following file structure:
<ol>
	<li>PF Drive Upgrade (or similar folder name)</li>
 	<ol>
		<li>CSVFilesForTest</li>
		<ol>
			<li>Inputs</li>
			<li>Outputs</li>
			<li>Templates</li>
			<ol>
				<li>pf525Test.csv</li>
			</ol>
		</ol>
		<li>PF70toPF525.ps1</li>
	</ol>
</ol>

 This Script is intended to Automate the conversion problems going from a PF70 to a PF525. There are a few assumptions:

<ol>
	<li>It will be an Ethernet Drive. If you have a DeviceNet PF70, you must first use the <a href="https://github.com/staceylance/PowerFlexConversionTools/tree/main/DeviceNetConversionTool">DeviceNet PF70 Tool</a> I have written.</li>
	<li>you can connect to the drive in CCW, or have a project file that contains the drive setup.</li>
</ol>

To perform the Conversion:
<ol>
	<li>Connect to the drive in CCW.</li>
	<li>Open the Parameters, ensure you are not filtering out any (not using non-default only button, nothing in search box), click "Export CSV"</li>
	<li>Save CSV File as drive name in the 'PF Drive Upgrade/Inputs' folder</li>
	<ol><li>Can be repeated for as many drives as you need to migrate, it will loop through and convert them all in one cycle</li></ol>
	<li>Right Click PF70toPF525.ps1, click "Run with Powershell"</li>
	<li>Once Black Terminal closes, 'PF Drive Upgrade/Outputs/PF5 Files' should have an identically named .PF5 file.</li>
	<li>This file can be downloaded directly to the PF525, although I HIGHLY recommend importing the file into CCW to ensure nothing looks out of the ordinary.</li>
</ol>
Please include input CSV and Output CSV with all questions.
