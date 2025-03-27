#Import Tools
import bs4, re, csv
import pandas as pd
from io import StringIO

#Variable Definition
pf70Template = pd.read_csv('00_Inputs\XAC151.csv')
PowerFlex_List = []
Drive_Names = []
DriveParameters = {}
d = {}
csv_header = ['#', 'Name', 'Value']
DriveDf = pd.DataFrame({
    'Port': pd.Series(dtype='str'),
    '#': pd.Series(dtype='str'),
    'Name': pd.Series(dtype='str'),
    'Value': pd.Series(dtype='str'),
    'Units': pd.Series(dtype='str'),
    'Default': pd.Series(dtype='str'),
    'Min': pd.Series(dtype='str'),
    'Max': pd.Series(dtype='str')
    })

#Function Definitions
def remove_units(Value):
    if " " in str(Value):
        return Value.split()[0]
    return None

def make_dataframe(Number):
    DriveDf['Port'] = pf70Template['Port']
    DriveDf['#'] = pf70Template['#']
    DriveDf['Name'] = pf70Template['Name']
    DriveDf['Units'] = pf70Template['Units']
    DriveDf['Default'] = pf70Template['Default']
    DriveDf['Min'] = pf70Template['Min']
    DriveDf['Max'] = pf70Template['Max']

    
    for i in range(0, DriveDf.index.stop - 1):
    
        #conditional establishing
        check1 = str(DriveDf.at[i, 'Name']) in str(d[Number]['Name'].values)
        check2 = str(DriveDf.at[i, 'Port']) == '0'
        allOkay = check1 and check2
        if allOkay:
            NewValue = get_new_value(i, Number)
            #Look for missing units, to decide if I truncate off the Units
            if str(DriveDf.at[i, 'Units']) != 'nan':
                DriveDf.at[i, 'Value'] = remove_units(str(NewValue))
            else:
                DriveDf.at[i, 'Value'] = str(NewValue)
        else:
            #catch for if the name doesn't exist, or if it is on a different port
            DriveDf.at[i, 'Value'] = str(DriveDf.at[i, 'Default'])
    return DriveDf

def get_new_value(iteration, Number):
    conditional = d[Number]['Name'] == DriveDf.at[iteration, 'Name']
    location = d[Number].loc[conditional]
    return next(iter(location['Value'].values))

def IPConfig(Address, Number):
    FirstOctetIndex = DriveParameters[Number].loc[DriveParameters[Number]['Name'] == 'IP Addr Cfg 1'].index[0]
    SecondOctetIndex = DriveParameters[Number].loc[DriveParameters[Number]['Name'] == 'IP Addr Cfg 2'].index[0]
    ThirdOctetIndex = DriveParameters[Number].loc[DriveParameters[Number]['Name'] == 'IP Addr Cfg 3'].index[0]
    FourthOctetIndex = DriveParameters[Number].loc[DriveParameters[Number]['Name'] == 'IP Addr Cfg 4'].index[0]
    DriveParameters[Number].at[FirstOctetIndex, 'Value'] = Address.split(".")[0]
    DriveParameters[Number].at[SecondOctetIndex, 'Value'] = Address.split(".")[1]
    DriveParameters[Number].at[ThirdOctetIndex, 'Value'] = Address.split(".")[2]
    DriveParameters[Number].at[FourthOctetIndex, 'Value'] = Address.split(".")[3]

def SubnetConfig(Address, Number):
    FirstOctetIndex = DriveParameters[Number].loc[DriveParameters[Number]['Name'] == 'Subnet Cfg 1'].index[0]
    SecondOctetIndex = DriveParameters[Number].loc[DriveParameters[Number]['Name'] == 'Subnet Cfg 2'].index[0]
    ThirdOctetIndex = DriveParameters[Number].loc[DriveParameters[Number]['Name'] == 'Subnet Cfg 3'].index[0]
    FourthOctetIndex = DriveParameters[Number].loc[DriveParameters[Number]['Name'] == 'Subnet Cfg 4'].index[0]
    DriveParameters[Number].at[FirstOctetIndex, 'Value'] = Address.split(".")[0]
    DriveParameters[Number].at[SecondOctetIndex, 'Value'] = Address.split(".")[1]
    DriveParameters[Number].at[ThirdOctetIndex, 'Value'] = Address.split(".")[2]
    DriveParameters[Number].at[FourthOctetIndex, 'Value'] = Address.split(".")[3]

def GateWayConfig(Address, Number):
    FirstOctetIndex = DriveParameters[Number].loc[DriveParameters[Number]['Name'] == 'Gateway Cfg 1'].index[0]
    SecondOctetIndex = DriveParameters[Number].loc[DriveParameters[Number]['Name'] == 'Gateway Cfg 2'].index[0]
    ThirdOctetIndex = DriveParameters[Number].loc[DriveParameters[Number]['Name'] == 'Gateway Cfg 3'].index[0]
    FourthOctetIndex = DriveParameters[Number].loc[DriveParameters[Number]['Name'] == 'Gateway Cfg 4'].index[0]
    DriveParameters[Number].at[FirstOctetIndex, 'Value'] = Address.split(".")[0]
    DriveParameters[Number].at[SecondOctetIndex, 'Value'] = Address.split(".")[1]
    DriveParameters[Number].at[ThirdOctetIndex, 'Value'] = Address.split(".")[2]
    DriveParameters[Number].at[FourthOctetIndex, 'Value'] = Address.split(".")[3]



def main():
    #reads HTML from RSNetworx
    networkproperties = open('00_Inputs/Network Properties.html')
    networkHTML = bs4.BeautifulSoup(networkproperties.read(), 'html.parser')

    #Scrapes HTML for Devices
    devices = networkHTML.find_all('div', id='DEVICE_SEPARATOR')

    for div in devices:
        device_title = div.find('div', id='DEVICE_TITLE')
        if device_title:
            a_tag = device_title.find('a',  attrs={'name': re.compile('PowerFlex 70')})
            if a_tag:
                PowerFlex_List.append(div)
    DriveNumber = 1
    for Drive in PowerFlex_List:
        Drive_Names.append(Drive.find('div', id='DEVICE_TITLE').find('a')['name'])
        applet_table = StringIO(str(Drive.find('table', id = 'APPLET_TABLE_1')))
        if applet_table is not None:
            d[DriveNumber] = pd.read_html(applet_table)[0]
            DriveNumber = DriveNumber + 1
        
    for dataFrame in d:
        d[dataFrame].columns = csv_header
    
    for Drive in range(1, len(Drive_Names)+1):
        DriveParameters[f'{Drive}'] = make_dataframe(Drive)



    for Drive in range(1, len(DriveParameters)):
        IP = input(f"Please enter full IP for {Drive_Names[Drive]} \n")
        IPConfig(IP, str(Drive))
        Subnet = input(f"Please enter full Subnet for {Drive_Names[Drive]} \n")
        SubnetConfig(Subnet, str(Drive))
        Gateway = input(f"Please enter full Gateway for {Drive_Names[Drive]} \n")
        GateWayConfig(Gateway, str(Drive))

        fileNameIndex = Drive - 1
        fileName = '01_Outputs/' + Drive_Names[fileNameIndex] + '.csv'
        DriveParameters.get(f"{Drive}").to_csv(fileName, index=False)

if __name__ == "__main__":
    main() 