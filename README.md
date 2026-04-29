# PowerFlexConversionTools
- A Pair of tools for Migrating from older Rockwell VFD's to the Newer Versions.
- I experienced stumbles upgrading the (now obsolete) PF70 to the new PF525. So I wrote a pair of Migration Tools.

<ol>
    <li>If you are going from an Ethernet PF70 to an Ethernet PF525, the <a href="https://github.com/staceylance/PowerFlexConversionTools/tree/main/PF70-PF525EthernetConversionTool">Ethernet Conversion Tool </a>, written in Powershell, will work.</li>
    <ol><li>It will Export a .PF5 file that can be directly downloaded to the drive and imported into ConnectedComponents Workbench.</li></ol>
    <li>If you are going from a DeviceNet PF70/PF40 to a PF525, You can use the "PFx0-PF525_DNet_Conversion" Jupyter Notebook for that. It runs based on a single NetworkProperties HTML report created for the network in RSNetworx.</li>
    <li>If you are migrating from an ArmorStart (284D) to an ArmorPowerflex, then you can use the 284D-35s_Dnet_Conversion Jupyter Notebook for that. You still have to manually build the AOP for the new drive, but you usually don't have to consider parameters.</li>
</ol>

Disclaimer: I am not accepting responsibility for equipment damage as a result of oversights when migrating. It has worked for me 12+ times, but I haven't proofed unusual parameters.
