# Entity-Resolution

What This Project Is About

In this project, the goal is to find unique companies in a messy dataset that has duplicates because the data was imported from multiple systems. Because companies might appear with small differences (like extra spaces, different capital letters, etc.), we need to clean up the data and group duplicates together.

How I Tackled the Problem

1. What I Learned About the Data

- The data has a bunch of information on companies, but only some of it is really useful for matching duplicates.
- Since there can be small differences (like "NETFLIX" vs "netflix" or "  Netflix "), I decided to standardize these fields before doing any grouping.

2. Cleaning Up the Data

- I normalized the text fields, which means:
  - Converting everything to lowercase
  - Removing extra spaces  
  This way, small formatting differences won't stop records from matching.

3. Grouping the Data

- Once I cleaned the data, I grouped the records by the normalized company name and address.
- For each group, I picked the record with the smallest `id` as the “canonical” one (which is like the main representative for that company).
- I also counted how many records were grouped together as duplicates.

4. Putting It All Together

- I wrote a SQL script that loads the data, cleans it up, groups duplicates, and then produces an updated dataset that shows the unique company records along with a `canonical_id` and how many duplicates were found.

Files in This Project

- **solution.sql**: This file has the full SQL code that performs all the steps (loading, cleaning, grouping, and merging) to get the final dataset.
- **README.md**: It explains the approach, what I did, and some notes on how to run the solution.

How to Run It

1. **Setup**:  
   Make sure you have a SQL engine that supports Parquet files (like Apache Spark SQL or Hive). Update the file path in the SQL script to the location of your Parquet file.

2. **Run the Code**:  
   Execute the script in your SQL environment. The script does everything step-by-step to clean and deduplicate the company records.

3. **Check the Results**:  
   The final query outputs a dataset where each record has:
   - The original `id`
   - The normalized company name and address
   - A `canonical_id` (which is the unique ID for each group of duplicates)
   - A `duplicate_count` (showing how many duplicate records there were)
   - Other available fields (like phone, website, etc.)

What’s Next?

- In the future, I might try adding more advanced matching (like fuzzy matching) if there are lots of typos.
- If more company details become important, additional fields like tax numbers or website URLs could be included for a more precise grouping.


