$pf70FilePath = ".\CSVFilesForTest\Inputs\"
$newFilePath = ".\CSVFilesForTest\Outputs\"


#Define Global Variables
$Pf525DataTable = New-Object System.Data.DataTable
$Pf70DataTable = New-Object System.Data.DataTable
$files = Get-ChildItem $pf70FilePath -Filter *.csv

#Function Declaration

function Create-DataTable($driveFilePath) {
# Create DataTable, Import-CSV
    $csvData = Import-Csv -Path $driveFilePath
    $newDrive = New-Object System.Data.DataTable

#Column Declaration
    $newDrive.Columns.Add("Port")
    $newDrive.Columns.Add("#")
    $newDrive.Columns.Add("Name")
    $newDrive.Columns.Add("Value")
    $newDrive.Columns.Add("Units")
    $newDrive.Columns.Add("Default")
    $newDrive.Columns.Add("Min")
    $newDrive.Columns.Add("Max")

    for ($i = 0; $i -lt $csvData.Count; $i++){
        $newRow = $newDrive.NewRow()
        $newRow[0] = $csvData[$i].Port
        $newRow[1] = $csvData[$i].'#'
        $newRow[2] = $csvData[$i].Name
        $newRow[3] = $csvData[$i].Value
        $newRow[4] = $csvData[$i].Units
        $newRow[5] = $csvData[$i].Default
        $newRow[6] = $csvData[$i].Min
        $newRow[7] = $csvData[$i].Max
        $newDrive.Rows.Add($newRow)
    }

    return $newDrive
}

function Search-and-Replace(){
#Search and Replace. Moves value from PF70 to PF525 if values match
     for ($i = 0; $i -lt $Pf525DataTable[0].Table[0].Rows.Count; $i++)
       {
            $searchTerm = "Name = " + "'" + $pf525DataTable[0].Table[0].Rows[$i].Name + "'"
            $searchTerm
            $foundRow = $pf70DataTable[0].Table[0].Select($SearchTerm, "#")
            if ($foundRow.Value -ne $null) {
                
                if($foundRow.Value | select-string -pattern '.' -SimpleMatch -Quiet)  {
                        if ($foundRow.Value.ToString().Split('.')[1] -eq 1) {
                            $pf525DataTable[0].Table[0].Rows[$i].Value = [MATH]::Truncate(([decimal]$foundRow.Value) * 10)
                            }
                        elseif ($foundRow.Value.ToString().Split('.')[1] -eq 2) {
                            $pf525DataTable[0].Table[0].Rows[$i].Value = [MATH]::Truncate(([decimal]$foundRow.Value) * 100) 
                            }
                } else {
                     $pf525DataTable[0].Table[0].Rows[$i].Value = ($foundRow.Value)
                    }
            } else {
                $pf525DataTable[0].Table[0].Rows[$i].Value = ($pf525DataTable[0].Table[0].Rows[$i].Default)
                    if($pf525DataTable[0].Table[0].Rows[$i].Default | select-string -pattern '.' -SimpleMatch -Quiet)
                        {
                            if ($foundRow.Value.ToString().Split('.')[1] -eq 1){
                                $pf525DataTable[0].Table[0].Rows[$i].Value = [MATH]::Truncate(([decimal]$foundRow.Value) * 10)
                                }
                            elseif ($foundRow.Value.ToString().Split('.')[1] -eq 2){
                                $pf525DataTable[0].Table[0].Rows[$i].Value = [MATH]::Truncate(([decimal]$foundRow.Value) * 100)
                            }
                        }
                    else {
                     $pf525DataTable[0].Table[0].Rows[$i].Value = ($pf525DataTable[0].Table[0].Rows[$i].Default)
                    }
                }
        }
}

function Replace-Read-Only(){
 #Replace Individual Parameters that are Read Only
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Drive Status'")."#" - 1].Value = $pf525DataTable[0].Table[0].select("Name = 'Drive Status'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Process Display'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Process Display'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Process Fract'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Process Fract'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Control Source'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Control Source'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Contrl In Status'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Contrl In Status'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Output RPM'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Output RPM'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Output Speed'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Output Speed'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Power Saved'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Power Saved'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Average Power'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Average Power'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Energy Saved'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Energy Saved'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Accum kWh Sav'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Accum kWh Sav'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Accum Cost Sav'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Accum Cost Sav'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Accum CO2 Sav'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Accum CO2 Sav'").Default
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Control Temp'")."#" - 1].Value = $PF525DataTable[0].Table[0].select("Name = 'Control Temp'").Default

 }

function Name-Switch-Params(){
#Replace Individual Parameters that are Named Differently, But mean the same
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Motor NP FLA'")."#" - 1].Value = [MATH]::Truncate(([decimal]($PF70DataTable[0].Table[0].select("Name = 'Motor NP FLA'").Value)) * 10)
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Motor OL Current'")."#" - 1].Value = [MATH]::Truncate(([decimal]($PF70DataTable[0].Table[0].select("Name = 'Motor NP FLA'").Value)) * 10*1.25)
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Motor NP Poles'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'Motor Poles'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Minimum Freq'")."#" - 1].Value = [MATH]::Truncate((([decimal]($PF70DataTable[0].Table[0].select("Name = 'Minimum Speed'").Value)) * 100))
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Maximum Freq'")."#" - 1].Value = [MATH]::Truncate((([decimal]($PF70DataTable[0].Table[0].select("Name = 'Maximum Speed'").Value)) * 100))
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Start Source 1'")."#" - 1].Value = "5"
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Speed Reference1'")."#" - 1].Value = "15"
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN IP Addr Cfg 1'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'IP Addr Cfg 1'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN IP Addr Cfg 2'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'IP Addr Cfg 2'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN IP Addr Cfg 3'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'IP Addr Cfg 3'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN IP Addr Cfg 4'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'IP Addr Cfg 4'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN Subnet Cfg 1'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'Subnet Cfg 1'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN Subnet Cfg 2'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'Subnet Cfg 2'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN Subnet Cfg 3'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'Subnet Cfg 3'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN Subnet Cfg 4'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'Subnet Cfg 4'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN Gateway Cfg 1'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'Gateway Cfg 1'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN Gateway Cfg 2'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'Gateway Cfg 2'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN Gateway Cfg 3'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'Gateway Cfg 3'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN Gateway Cfg 4'")."#" - 1].Value = $PF70DataTable[0].Table[0].select("Name = 'Gateway Cfg 4'").Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'PWM Frequency'")."#" - 1].Value = ([decimal]$PF70DataTable[0].Table[0].select("Name = 'PWM Frequency'").Value) * 10

     
    Switch($PF70DataTable[0].Table[0].select("Name = 'Motor Cntl Sel'").Value){
    “Sensrls Vect" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Torque Perf Mode'")."#" - 1].Value = "1"}
    “SV Economize" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Torque Perf Mode'")."#" - 1].Value = "2"}
    “Custom V/Hz" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Torque Perf Mode'")."#" - 1].Value = "0"}
    “Fan/Pmp V/Hz" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Torque Perf Mode'")."#" - 1].Value = "0"}
    “FVC Vector" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Torque Perf Mode'")."#" - 1].Value = "3"}
    }

    Switch($PF70DataTable[0].Table[0].select("Name = 'Stop/Brk Mode A'").Value){
    “Coast" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Stop Mode'")."#" - 1].Value = "1"}
    “Ramp" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Stop Mode'")."#" - 1].Value = "0"}
    “Ramp to Hold" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Stop Mode'")."#" - 1].Value = "9"}
    “DC Brake" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Stop Mode'")."#" - 1].Value = "6"}
    “Fast Brake" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Stop Mode'")."#" - 1].Value = "6"}
    }

    Switch($PF70DataTable[0].Table[0].select("Name = 'Comm Flt Action'").Value){
    “Fault" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Comm Loss Action'")."#" - 1].Value = "0"}
    “Stop" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Comm Loss Action'")."#" - 1].Value = "1"}
    “Zero Data" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Comm Loss Action'")."#" - 1].Value = "1"}
    “Hold Last" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Comm Loss Action'")."#" - 1].Value = "3"}
    “Send Flt Cfg" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Comm Loss Action'")."#" - 1].Value = "0"}
    }

    Switch($PF70DataTable[0].Table[0].select("Name = 'BootP'").Value){
    “Disabled" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN Addr Sel'")."#" - 1].Value = "1"}
    “Enabled" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'EN Addr Sel'")."#" - 1].Value = "2"}
    }

    Switch($PF70DataTable[0].Table[0].select("Name = 'Autotune'").Value){
    “Ready" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Autotune'")."#" - 1].Value = "0"}
    “Static Tune" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Autotune'")."#" - 1].Value = "1"}
    “Rotate Tune" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Autotune'")."#" - 1].Value = "2"}
    “Calculate" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Autotune'")."#" - 1].Value = "0"}
    }


}

function Map-Values-to-Numbers(){
    #Although the PF70 csv uses strings for different parameters, the 525 uses numbers.


    $TermBlkString = "Name = 'Autotune'"
    $OptionArray = 'Ready', 'Static Tune', 'Rotary Tune'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Language'"
    $OptionArray = 'Not Used', 'English', 'Français', 'Español', 'Italiano', 'Deutsch', 'Japanese', 'Português', 'Chinese', 'Reserved', 'Reserved', 'Korean', 'Polish', 'Reserved', 'Turkish', 'Czech'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Start Source 2'"
    $OptionArray = 'Keypad', 'DigIn TrmBlk', 'Serial/DSI', 'Network Opt', 'EtherNet/IP'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Start Source 3'"
    $OptionArray = 'Keypad', 'DigIn TrmBlk', 'Serial/DSI', 'Network Opt', 'EtherNet/IP'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Speed Reference2'"
    $OptionArray = 'Drive Pot', 'Keypad Freq', 'Serial/DSI', 'Network Opt', '0-10V Input', '4-20mA Input', 'Preset Freq', 'Anlg In Mult', 'MOP', 'Pulse Input', 'PID1 Output', 'PID2 Output', 'Step Logic', 'Encoder','EtherNet/IP', 'Positioning' 
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'Speed Reference3'"
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'DigIn TermBlk 02'"
    $OptionArray = 'Not Used', 'Speed Ref 2', 'Speed Ref 3', 'Start Src 2', 'Start Src 3', 'Preset Freq', 'Jog', 'Jog Forward', 'Jog Reverse', 'Acc/Decc Sel2', 'Aux Fault', 'Clear Fault', 'RampStop,CF', 'CoastStop,CF','DCInjStop,CF', 'MOP Up', 'MOP Down', 'Timer Start', 'Counter In', 'Reset Timer', 'Reset Countr', 'Rset Tim&Cnt', 'Logic In 1', 'Logic In 2', 'Current Lmt2', 'Anlg Invert', 'EM Brk Rlse', 'Acc/Dec Sel3', 'Precharge En', 'Inertia Dcel','Sync Enable', 'Traverse Dis', 'Home Limit', 'Find Home', 'Hold Step', 'Pos Redefine', 'Force DC', 'Damper Input', 'Purge', 'Freeze-Fire', 'SW Enable', 'SherPin1 Dis', 'Reserver', 'Reserved', 'Reserved', 'Reserved','2-Wire FWD', '3-Wire Start', '2-Wire REV', '3-Wire Dir', 'Pulse Train'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'DigIn TermBlk 03'"
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'DigIn TermBlk 05'"
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'DigIn TermBlk 06'"
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'DigIn TermBlk 07'"
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'DigIn TermBlk 08'"
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = '2-Wire Mode'"
    $OptionArray = 'Edge Trigger', 'Level Sense', 'Hi-Spd Edge', 'Momentary'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = '10V Bipolar Enbl'"
    $OptionArray = 'Uni-Polar In', 'Bi-Polar In', 'Hi-Spd Edge', 'Momentary'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Opto Out1 Sel'"
    $OptionArray = 'Ready/Fault', 'At Frequency', 'MotorRunning', 'Reverse', 'Motor Overld', 'Ramp Reg', 'Above Freq', 'Above Cur', 'Above DCVolt', 'Retries Exst', 'Above Anlg V', 'Above PF Ang', 'Anlg In Loss', 'ParamControl','NonRec Fault', 'EM Brk Cntrl', 'Thermal OL', 'Amb OverTemp', 'Local Active', 'Comm Loss', 'Logic In 1', 'Logic In 2', 'Logic 1 & 2', 'Logic 1 or 2', 'StpLogic Out', 'Timer Out', 'Counter Out', 'At Position', 'At Home', 'Safe-Off','SafeTqPermit', 'AutoRst Ctdn'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'Opto Out2 Sel'"
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'Relay Out1 Sel'"
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))


    $TermBlkString = "Name = 'Relay Out2 Sel'"
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'MOP Reset Sel'"
    $OptionArray = 'Zero MOP Ref', 'Save MOP Ref'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'MOP Preload'"
    $OptionArray = 'No preload', 'Preload'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'DB Resistor Sel'"
    $OptionArray = 'Disabled', 'Norml RA Res', 'NoProtection', '99“3...99% DutyCycle'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'PID 1 Trim Sel'"
    $OptionArray = 'Disabled', 'TrimOn Pot', 'TrimOn Keypd', 'TrimOn DSI', 'TrimOn NetOp', 'TrimOn 0-10V', 'TrimOn 4-20', 'TrimOn Prset', 'TrimOn AnMlt', 'TrimOn MOP', 'TrimOn Pulse', 'TrimOn Slgic', 'TrimOn Encdr', 'TrimOn ENet'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'PID 2 Trim Sel'"
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'PID 1 Ref Sel'"
    $OptionArray = 'PID Setpoint', 'Drive Pot', 'Keypad Freq', 'Serial/DSI', 'Network Opt', '0-10V Input', '4-20mA Input', 'Preset Freq', 'AnlgIn Multi', 'MOP Freq', 'Pulse Input', 'Step Logic', 'Encoder', 'EtherNet/IP'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'PID 2 Ref Sel'"
    $OptionArray = 'PID Setpoint', 'Drive Pot', 'Keypad Freq', 'Serial/DSI', 'Network Opt', '0-10V Input', '4-20mA Input', 'Preset Freq', 'AnlgIn Multi', 'MOP Freq', 'Pulse Input', 'Step Logic', 'Encoder', 'EtherNet/IP'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'PID 1 Fdback Sel'"
    $OptionArray = '0-10V Input', '4-20mA Input', 'Serial/DSI', 'Network Opt', 'Pulse Input', 'Encoder', 'EtherNet/IP'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'PID 2 Fdback Sel'"
    $OptionArray = '0-10V Input', '4-20mA Input', 'Serial/DSI', 'Network Opt', 'Pulse Input', 'Encoder', 'EtherNet/IP'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'Stall Fault Time'"
    $OptionArray = '60 Seconds', '120 Seconds', '240 Seconds', '360 Seconds', '480 Seconds', 'Flt Disabled'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'Motor OL Select'"
    $OptionArray = 'No Derate', 'Min Derate', 'Max Derate'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'Motor OL Ret'"
    $OptionArray = 'Reset', 'Save'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Drive OL Mode'"
    $OptionArray = 'Disabled', 'Reduce CLim','Reduce PWM', 'Both-PWM 1st'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Speed Reg Sel'"
    $OptionArray = 'Automatic', 'Manual' 
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'PM Initial Sel'"
    $OptionArray = 'Align', 'HFI','Six Pulse'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Boost Select'"
    $OptionArray = 'Custom V/Hz', '30.0, VT','35.0, VT', '40.0, VT', '45.0, VT', '0.0, no IR', '2.5, CT', '2.5, CT', '5.0, CT', '7.5, CT', '10.0, CT', '12.5, CT', '15.0, CT', '17.5, CT', '20.0, CT'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Motor Fdbk Type'"
    $OptionArray = 'None', 'Pulse Train','Single Chan', 'Single Check', 'Quadrature', 'Quad Check'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Var PWM Disable'"
    $OptionArray = 'Enabled', 'Disabled'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Reverse Disable'"
    $OptionArray = 'Rev Enabled', 'Rev Disabled'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Flying Start En'"
    $OptionArray = 'Disabled', 'Enabled'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Compensation'"
    $OptionArray = 'Disabled', 'Electrical', 'Mechanical', 'Both'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Power Loss Mode'"
    $OptionArray = 'Coast', 'Decel'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Half Bus Enable'"
    $OptionArray = 'Disabled', 'Enabled'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Bus Reg Enable'"
    $OptionArray = 'Disabled', 'Enabled'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Fault Clear'"
    $OptionArray = 'Ready/Idle', 'Reset Fault', 'Clear Buffer'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Program Lock Mod'"
    $OptionArray = 'Full Lock', 'Keypad Lock', 'Custom Only', 'KeyPd Custom'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Drv Ambient Sel'"
    $OptionArray = 'Normal', '55C', '60C', '60C +Fan Kit', '70C +Fan Kit'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Text Scroll'"
    $OptionArray = 'Off', 'Low Speed', 'Mid Speed', 'High Speed'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Out Phas Loss En'"
    $OptionArray = 'Disable', 'Enable'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Positioning Mode'"
    $OptionArray = 'Time Steps', 'Preset Input', 'Step Logic', 'Preset StpL', 'StpLogic-Lst'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Home Save'"
    $OptionArray = 'Home Reset', 'Home Saved'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'Find Home Dir'"
    $OptionArray = 'Forward', 'Reverse'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'PM Algor Sel'"
    $OptionArray = 'Algorithm 1', 'Algorithm 2'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'EN Addr Src'"
    $OptionArray = 'Parameters', 'BOOTP'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))
    
    $TermBlkString = "Name = 'EN Rate Act'"
    $OptionArray = 'No Link', '10Mbps Full', '10Mbps Half', '100Mbps Full', '100Mbps Half', 'Dup IP Addr', 'Disabled'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'RdyBit Mode Cfg'"
    $OptionArray = 'Standard', 'Enhanced'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'RdyBit Mode Act'"
    $OptionArray = 'Standard', 'Enhanced'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'PID 1 Invert Err'"
    $OptionArray = 'Normal', 'Inverted'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'PID 2 Invert Err'"
    $OptionArray = 'Normal', 'Inverted'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'Start At PowerUp'"
    $OptionArray = 'Disabled', 'Enabled'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    $TermBlkString = "Name = 'Flux Braking En'"
    $OptionArray = 'Disabled', 'Enabled'
    $DesiredName = $pf525DataTable[0].Table[0].select($TermBlkString).Value
    $pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = [Math]::Abs([Array]::IndexOf($OptionArray, $DesiredName))

    Switch($pf525DataTable[0].Table[0].select("Name = 'Reset to Defalts'").Value){
        “Ready/Idle" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Reset to Defalts'")."#" - 1].Value = "0"}
        “Ready" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Reset to Defalts'")."#" - 1].Value = "0"}
        “Param Reset" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Reset to Defalts'")."#" - 1].Value = "1"}
        “Factory Rset" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Reset to Defalts'")."#" - 1].Value = "2"}
        “Power Reset" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Reset to Defalts'")."#" - 1].Value = "3"}
        “Module Reset" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Reset to Defalts'")."#" - 1].Value = "4"}
        }

    Switch($PF525DataTable[0].Table[0].select("Name = 'Display Param'").Value){
        “Keypad Disp" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Display Param'")."#" - 1].Value = "0"}
        “Output Freq" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Display Param'")."#" - 1].Value = "1"}
    }

    $TermBlkString = "Name = 'Reset Meters'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “Ready/Idle" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “Ready" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “Reset Meters" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        “Reset Time" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "2"}
        
        }
         
    $TermBlkString = "Name = 'Analog Out Sel'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “OutFreq 0-10" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “OutCurr 0-10" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        “OutVolt 0-10" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "2"}
        “OutPowr 0-10" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "3"}
        “OutTorq 0-10" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "4"}
        “TstData 0-10" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "5"}
        “Setpnt 0-10" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "6"}
        “DCVolt 0-10” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "7"}
        “OutFreq 0-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "8"}
        “OutCurr 0-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "9"}
        “OutVolt 0-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "10"}
        “OutPowr 0-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "11"}
        “OutTorq 0-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "12"}
        “TstData 0-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "13"}
        “Setpnt 0-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "14"}
        “DCVolt 0-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "15"}
        “OutFreq 4-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "16"}
        “OutCurr 4-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "17"}
        “OutVolt 4-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "18"}
        “OutPowr 4-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "19"}
        “OutTorq 4-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "20"}
        “TstData 4-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "21"}
        “Setpnt 4-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "22"}
        “DCVolt 4-20" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "23"}
        }


    Switch($pf525DataTable[0].Table[0].select("Name = 'Anlg In V Loss'").Value){
        “Disabled" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In V Loss'")."#" - 1].Value = "0"}
        “Fault (F29)" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In V Loss'")."#" - 1].Value = "1"}
        “Stop" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In V Loss'")."#" - 1].Value = "2"}
        “Zero Ref" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In V Loss'")."#" - 1].Value = "3"}
        “Min Freq Ref" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In V Loss'")."#" - 1].Value = "4"}
        “Max Freq Ref" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In V Loss'")."#" - 1].Value = "5"}
        “Key Freq Ref" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In V Loss'")."#" - 1].Value = "6"}
        “MOP Freq Ref" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In V Loss'")."#" - 1].Value = "7"}
        “Continu Last" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In V Loss'")."#" - 1].Value = "8"}
        }

    Switch($pf525DataTable[0].Table[0].select("Name = 'Anlg In mA Loss'").Value){
        “Disabled" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In mA Loss'")."#" - 1].Value = "0"}
        “Fault (F29)" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In mA Loss'")."#" - 1].Value = "1"}
        “Stop" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In mA Loss'")."#" - 1].Value = "2"}
        “Zero Ref" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In mA Loss'")."#" - 1].Value = "3"}
        “Min Freq Ref" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In mA Loss'")."#" - 1].Value = "4"}
        “Max Freq Ref" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In mA Loss'")."#" - 1].Value = "5"}
        “Key Freq Ref" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In mA Loss'")."#" - 1].Value = "6"}
        “MOP Freq Ref" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In mA Loss'")."#" - 1].Value = "7"}
        “Continu Last" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Anlg In mA Loss'")."#" - 1].Value = "8"}
        }

    $TermBlkString = "Name = 'Sleep-Wake Sel'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “Disabled" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “0-10V Input" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        “4-20mA Input" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "2"}
        “Command Freq" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "3"}
        }

    $TermBlkString = "Name = 'Safety Open En'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “FaultEnable" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “FaultDisable" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        }

    $TermBlkString = "Name = 'SafetyFlt RstCfg'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “PwrCycleRset" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “FltClr Reset" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        }

    $TermBlkString = "Name = 'Comm Write Mode'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “Save" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “RAM Only" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        }

    $TermBlkString = "Name = 'Cmd Stat Select'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “Velocity" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “Position" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        }

    $TermBlkString = "Name = 'RS485 Data Rate'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “1200" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “2400" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        “4800" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "2"}
        “9600" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "3"}
        “19,200" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "4"}
        “38,400" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "5"}
        }

    $TermBlkString = "Name = 'Comm Loss Action'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “Fault" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “Coast Stop" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        “Stop" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "2"}
        “Continu Last" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "3"}
        }

    $TermBlkString = "Name = 'RS485 Format'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “RTU 8-N-1" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “RTU 8-E-1" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        “RTU 8-O-1” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "2"}
        “RTU 8-N-2” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "3"}
        “RTU 8-E-2” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "4"}
        “RTU 8-O-2” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "5"}
        }

    $TermBlkString = "Name = 'EN Addr Sel'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “Parameters" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “BOOTP" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        }

    $TermBlkString = "Name = 'EN Rate Cfg'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “Auto Detect" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “Autodetect" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “Auto detect" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “10Mbps Full" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        “10Mbps Half” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "2"}
        “100Mbps Full” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "3"}
        “100Mbps Half” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "4"}
        }

    $TermBlkString = "Name = 'EN Comm Flt Actn'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “Fault" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “Stop" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        “Zero Data” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "2"}
        “Hold Last” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "3"}
        “Send Flt Cfg” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "4"}
        }

    $TermBlkString = "Name = 'EN Idle Flt Actn'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “Fault" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “Stop" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        “Zero Data” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "2"}
        “Hold Last” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "3"}
        “Send Flt Cfg” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "4"}
        }

    $TermBlkString = "Name = 'MultiDrv Sel'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “Disabled" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “Network Opt" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        “EtherNet/IP” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "2"}
        }

    $TermBlkString = "Name = 'DSI I/O Cfg'"
    Switch($pf525DataTable[0].Table[0].select($TermBlkString).Value){
        “Drive 0" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "0"}
        “Drive 0-1" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "1"}
        “Drive 0-2” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "2"}
        “Drive 0-3” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "3"}
        “Drive 0-4” {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select($TermBlkString)."#" - 1].Value = "4"}
        }
        
    Switch($pf525DataTable[0].Table[0].select("Name = 'Opto Out Logic'").Value){
        “1=NO / 2=NO" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Opto Out Logic'")."#" - 1].Value = "0"}
        “1=NC / 2=NO" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Opto Out Logic'")."#" - 1].Value = "1"}
        “1=NO / 2=NC" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Opto Out Logic'")."#" - 1].Value = "2"}
        “1=NC / 2=Nc" {$pf525DataTable[0].Table[0].Rows[$PF525DataTable[0].Table[0].select("Name = 'Opto Out Logic'")."#" - 1].Value = "3"}
        }

}

function DataTable-to-XML($PF5FilePath){
    #Create Pf5 file from csv

    #instantiate XML file
    $xmlDoc = New-Object System.Xml.XmlDocument

    $xmlDeclaration = $xmlDoc.CreateXmlDeclaration("1.0", "utf-8", $null)
    $xmlDoc.InsertBefore($xmlDeclaration, $xmlDoc.DocumentElement)

    $root = $xmlDoc.CreateElement("Node")
    $xmlDoc.AppendChild($root)
    $drive = $xmlDoc.CreateElement("Drive")
    $drive.SetAttribute("Brand", "1")
    $drive.SetAttribute("Family", "9")
    $drive.SetAttribute("Config", "196")
    $drive.SetAttribute("MajorRev", "7")
    $drive.SetAttribute("MinorRev", "1")
    $root.AppendChild($drive)

    #setup of Parameters
    $element1 = $xmlDoc.CreateElement("Parameters")
    $drive.AppendChild($element1)


    #loop through parameters, checking for non defaults and adding it to the xml list.
    for ($parameter = 29; $parameter -lt $Pf525DataTable[0].Table[0].Rows.Count; $parameter++){
            $paramete
        if (($parameter -notin 201, 203, 205, 207, 209, 211, 213, 215) -and (!(($parameter -ge 360) -and ($parameter -le 369))) -and (!(($parameter -ge 375) -and ($parameter -le 394))) -and (!(($parameter -ge 604) -and ($parameter -le 670))) -and ($parameter -lt 681)) {
            if ($Pf525DataTable[0].Table[0].Rows[$parameter].Value -ne $Pf525DataTable[0].Table[0].Rows[$parameter].Default){
                $instanceNumber = $Pf525DataTable[0].Table[0].Rows[$parameter].'#'
                $newParameterChild = $xmlDoc.CreateElement("Parameter")
                $newParameterChild.SetAttribute("Instance", $instanceNumber)
                $newParameterChild.InnerText = $Pf525DataTable[0].Table[0].Rows[$parameter].Value

                $element1.AppendChild($newParameterChild)
            }
        }
    }

    $xmlDoc.Save($PF5FilePath)
}


# Instantiate Data Tables for New and Old Drive
foreach($f in $files){
$Pf525DataTable = Create-DataTable('.\CSVFilesForTest\Templates\pf525Test.csv')
$Pf70DataTable = Create-DataTable($f.FullName)
Search-and-Replace
Replace-Read-Only
Name-Switch-Params
Map-Values-to-Numbers
$PF5FilePath = [string]::Concat('', $newFilePath, 'PF5 Files\', $f.BaseName, '.pf5')
DataTable-to-xml($PF5FilePath)
#export to csv for import in Connected Component
$csvFileName = $f.BaseName + '.csv'
$pf525DataTable[0].Table[0] | export-csv -Path "$newFilePath\CSV Files\$csvFileName" -NoTypeInformation
}
