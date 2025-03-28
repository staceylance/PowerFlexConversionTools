This tool will Convert the NetworkProperties.HTML file that RSNetworx exports for a given Network/Drive into a CSV which could be used for:
 <ol>
   <li>ConnectedComponents (for a Ethernet PF70)</li>
   <li>Converting To a PF525 drive with the <a href="https://github.com/staceylance/PowerFlexConversionTools/tree/main/PF70-PF525EthernetConversionTool">PF70-to-PF525-ConversionTool.</a></li>
 </ol>
File Structure:

<ol>
  <li>DeviceNetConversionTool
     <ol>
       <li>00_Inputs</li>
           <ol>
             <li>XAC151.csv (default file that is included in the Repo)</li>
             <li>DesiredNetworkPropertiesFile.HTML (Must be named 'Network Properties.html')</li>
           </ol>
        <li>01_Outputs</li>
        <li>RSNetworxTool.py</li>
     </ol>
</ol>

Running the Python File will perform 4 things:
  1) Loop through the 'Network Properties.html', looking for any Powerflex 70 Drives
  2) Populate the Parameters for each Drive in a table for each drive
  3) Prompt the User for IP Addresses, Subnets, and Gateways for each PF70 that it finds.
  4) Exports a CSV in the '01_Outputs' folder with a name matching the one mentioned in the 'Network Properties.html' file

How to use the Script:
  1) use RSNetworx to Generate a Report of the DeviceNet Network (or the individual drive)
    A) Connect to DeviceNet Network > File > Generate Report
  2) Place the 'Network Properties.html' file in the '00_Inputs' folder
  3) Run the Script.

Dependencies:
  1) BS4, RE, CSV, Pandas.
  2) YML for conda environment is included, if desired.
    
