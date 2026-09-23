# OTT Streaming Content Trend Analysis

## Overview
Professional EDA project for OTT streaming catalog trends using the supplied Netflix dataset.

**Important scope:** The uploaded file contains Netflix records only. This package does not invent Prime Video or Hotstar records. A `platform` column has been added so compatible datasets can be merged later.

## Dataset
- Rows: 8,807
- Original columns: 12
- Duplicate rows: 0
- Duplicate show IDs: 0
- Release years: 1925-2021

## Tools
Python, Pandas, NumPy, Matplotlib, SQL, Excel.

## Key findings
1. Movies: 6,131 (69.6%); TV Shows: 2,676 (30.4%).
2. Peak titles added: 2019 with 2,016.
3. Top category: International Movies (2,752 title-category records).
4. Top country: United States (3,690 title-country records).
5. Top rating: TV-MA (3,207 titles).

## Recommendations
- Track Movie/TV Show mix over time instead of total volume alone.
- Monitor both high-frequency and emerging categories.
- Use country-level reporting to identify regional catalog gaps.

## Limitations
Historical snapshot; not a live catalog. Multi-value genre/country fields are non-exclusive. Missing descriptive fields remain. No views/revenue/subscriber data is available. Multi-platform comparison requires verified Prime Video and Hotstar/Disney+ datasets.
