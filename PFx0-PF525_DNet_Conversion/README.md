
# PFx0 → PF525 DeviceNet Conversion Tool

A Python-based **Jupyter Notebook utility** for converting legacy **PowerFlex 70 / PowerFlex 40** DeviceNet configurations into **PowerFlex 525 (EtherNet/IP)** parameter files and project-ready CSVs.

This tool is intended to accelerate modernization efforts by automating parameter extraction and conversion from **RSNetWorx DeviceNet NetworkProperties HTML exports**.

> ⚠️ **IMPORTANT SAFETY NOTICE**  
> This tool generates drive configuration data intended for use on industrial equipment.  
> **All outputs must be validated by a qualified engineer in a test environment before use.**  
> The author assumes **no liability** for equipment damage, downtime, or safety incidents resulting from use of this tool or failure to properly validate its output.

---

## Overview

Legacy DeviceNet systems often rely on RSNetWorx NetworkProperties exports for documentation and configuration reference. Manually migrating these configurations to modern Ethernet-based drives is time‑consuming and error‑prone.

This notebook:

- Parses **RSNetWorx NetworkProperties HTML** files  
- Extracts DeviceNet configuration data for each drive  
- Converts all supported parameters to their **PowerFlex 525 Ethernet equivalents**  
- Generates:
  - **PF5 local programming files**
  - **CSV files** suitable for project-level programming and review

---

## Supported Devices

### Source (Legacy)

- PowerFlex 70  
- PowerFlex 40  
- DeviceNet networks documented via RSNetWorx

### Target

- PowerFlex 525  
- EtherNet/IP

---

## How It Works

1. **Input**  
   - RSNetWorx *NetworkProperties HTML* export

2. **Parsing**  
   - HTML is parsed using BeautifulSoup  
   - Each drive is converted into structured data tables

3. **Conversion**  
   - DeviceNet parameters are mapped to PowerFlex 525 Ethernet parameters  
   - All standard parameters are mapped

4. **Output**  
   - PF5 files for **local programming**  
   - CSV files for **project-level programming and documentation**

5. **Review**  
   - Output is intended for **engineering validation prior to deployment**

---


## Repository Structure

The repository uses a fixed directory layout to separate inputs, templates,
working data, and generated outputs.


PFx0_PF525_DNet_Conversion/
│
├── DNetConversion.ipynb
│   Main Jupyter Notebook used to parse RSNetWorx DeviceNet
│   NetworkProperties HTML files and generate PF525 outputs.
│
├── Inputs/
│   ├── Templates/
│   │   Parameter templates used during conversion.
│   │
│   │   ├── PF40Template.csv
│   │   ├── PF70Template.csv
│   │   └── PF525Template.csv
│   │
│   └── NetworkProperties.html
│       RSNetWorx DeviceNet NetworkProperties export file.
│
├── Outputs/
│   └── PF5 Files/
│       Generated PF5 files for local programming of
│       PowerFlex 525 drives.
│
└── WorkingFolder/
│   Temporary working area used during conversion.
│
│   ├── Inputs/
│   │   ├── PF40/
│   │   │   Parsed PF40 drive data
│   │   │
│   │   └── PF70/
│   │       Parsed PF70 drive data
│   │
│   └── Outputs/
│       └── CSV Files/
│           Generated CSV files intended for
│           project-level programming and review.


## Requirements

### Runtime

- Python  
- Jupyter Notebook

### Python Packages

- os  
- glob  
- math  
- re  
- csv  
- xml  
- pandas  
- beautifulsoup4 (BS4)

### Operating System

- Cross‑platform (Windows, Linux, macOS)

> RSNetWorx is required only to generate the input HTML — it is **not** required to run this tool.

---

## Usage

- Export NetworkProperties HTML from RSNetWorx DeviceNet
-Place the HTML file in the expected input directory
-Open the Jupyter Notebook
- Update any required file paths
- Run the notebook top‑to‑bottom
- Review generated PF5 and CSV outputs


## Input / Output
### Input

- RSNetWorx NetworkProperties HTML
> Contains DeviceNet configuration and parameter data



### Output

- PF5 files

> For local programming of PowerFlex 525 drives


- CSV files

> For project programming, review, and documentation




## Parameter Mapping

- All standard parameters are mapped from PF70 / PF40 to PF525 equivalents
- Mapping assumes typical configurations

## Manual Review Required

- IP address and subnet must be manually entered
- Exotic or uncommon parameters have not been fully tested
- Engineering review is mandatory before commissioning


## Known Limitations

- Not tested with unusual or rarely used parameters
- Assumes RSNetWorx HTML structure is unmodified
- Does not configure network addressing automatically
- No automatic validation against physical wiring or external hardware


# Validation Checklist (Strongly Recommended)
Before applying output to hardware:

- Verify motor nameplate data
- Confirm speed reference and control source
- Validate accel/decel times
- Review braking configuration and behavior
- Manually configure IP address and subnet
- Test in a non‑production environment


## Disclaimer
This software is provided “as is”, without warranty of any kind.
The author accepts no responsibility or liability for:

- Equipment damage
- Production downtime
- Safety incidents
- Incorrect configurations

Use of this tool implies acceptance of full responsibility for validation, testing, and deployment.

Contact
For questions, issues, or suggestions:
📧 kainelance@gmail.com
GitHub Issues are also welcome.

License
This project is released under the MIT License.
