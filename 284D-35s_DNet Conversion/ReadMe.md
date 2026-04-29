
# 284D ArmorStart → Armor PowerFlex (35E / 35S) Conversion Tool

A Python-based **Jupyter Notebook utility** that parses **RSNetWorx DeviceNet NetworkProperties HTML** files, extracts configuration data for **284D ArmorStart** starters, converts them to equivalent **Armor PowerFlex 35E / 35S** drive parameters, and exports the results to a single **Excel (.xlsx)** workbook.

Each converted drive is written to its **own worksheet**, making the output suitable for engineering review, bulk programming preparation, and project documentation.

> ⚠️ **IMPORTANT SAFETY NOTICE**  
> This tool generates drive configuration data intended for use on industrial equipment.  
> **All output must be reviewed and validated by a qualified engineer before use.**  
> The author assumes **no liability** for equipment damage, downtime, or safety incidents resulting from the use of this tool or failure to validate its output.

---

## Overview

Legacy DeviceNet systems commonly use **284D ArmorStart** motor starters configured and documented in **RSNetWorx**. Migrating these devices to modern **Armor PowerFlex 35E / 35S** drives is often manual and error‑prone.

This notebook automates that migration step by:

- Parsing RSNetWorx **NetworkProperties HTML**
- Identifying and extracting **284D ArmorStart** configuration data
- Converting parameters to their **35E / 35S Armor PowerFlex equivalents**
- Exporting all converted data to a **single Excel file**, with:
  - **One worksheet per drive**

---

## Supported Devices

### Source
- **284D ArmorStart**
- DeviceNet configuration documented via RSNetWorx

### Target
- **Armor PowerFlex 35E**
- **Armor PowerFlex 35S**

---

## How It Works

1. **Input**
   - RSNetWorx *NetworkProperties HTML* export

2. **Parsing**
   - HTML is parsed using BeautifulSoup
   - All detected **284D ArmorStart** devices are identified
   - Each device is converted into a structured data table

3. **Conversion**
   - 284D parameters are mapped to corresponding **35E / 35S** parameters
   - All standard parameters are mapped

4. **Export**
   - Results are written to an **XLSX workbook**
   - Each drive is placed on its **own worksheet**

5. **Review**
   - Output is intended for engineering validation and downstream programming

---

## Requirements

### Runtime
- Python
- Jupyter Notebook

### Python Packages
- `bs4`
- `openpyxl`
- `re`
- `os`
- `pandas`
- `beautifulsoup4`

### Operating System
- Cross‑platform (Windows, Linux, macOS)

> RSNetWorx is required **only** to generate the NetworkProperties HTML export.

---

### Usage

- Export NetworkProperties HTML from RSNetWorx DeviceNet
- Place the HTML file in the configured input directory
- Open the conversion notebook
- Update file paths if required
- Run the notebook top‑to‑bottom
- Review the generated Excel file

### Input / Output
 - Input

> RSNetWorx NetworkProperties HTML

> Contains DeviceNet configuration data
> May contain multiple DeviceNet nodes



### Output

- Excel (.xlsx) file

> One worksheet per 284D ArmorStart
> Sheets contain converted 35E / 35S parameter values
> Intended for:

> - Engineering review
> - Programming reference
> - Project documentation
