# PowerFlexConversionTools
a Pair of tools for Migrating from PowerFlex 70 to PowerFlex 525.
I experienced stumbles upgrading the (now obsolete) PF70 to the new PF525. So I wrote a pair of Migration Tools.

<ol>
    <li>If you are going from an Ethernet PF70 to an Ethernet PF525, the <a href="https://github.com/staceylance/PowerFlexConversionTools/tree/main/PF70-PF525EthernetConversionTool">Ethernet Conversion Tool </a>, written in Powershell, will work.</li>
    <ol><li>It will Export a .PF5 file that can be directly downloaded to the drive and imported into ConnectedComponents Workbench.</li></ol>
    <li>If you are going from a DeviceNet PF70 to an Ethernet PF525, You must run the <a href="https://github.com/staceylance/PowerFlexConversionTools/tree/main/DeviceNetConversionTool">DeviceNet Conversion Tool</a> first, then the Output CSV can be ran through the Conversion Tool.</li>
</ol>
