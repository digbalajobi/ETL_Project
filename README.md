# ETL_Project

## Data:

CSV File  from OpenSky Network:  https://opensky-network.org/datasets/covid-19/flightlist_20200101_20200131.csv.gz

Wikipedia Table: https://en.wikipedia.org/wiki/List_of_airports_by_IATA_airport_code:_A

Kaggle CSV: https://www.kaggle.com/open-flights/airline-database


## Extract 

CSV File  from OpenSky Network:  We were looking for flight data corresponding to the  Covid-19 crisis.  By searching flight APIs, we found a csv for every flight that landed in January 2020 from The OpenSky Network’s Covid-19 database. It contains data on individual flights, including the flight’s callsign, flight number, ICAO 24-bit code, registration number, typecode, flight origin, flight destination, the time the flight was first seen, last seen, and the date.  Due to the size of the csv file, it was more efficient to open it directly in jupyter notebook.  To do this we imported the gzip package and specified the compression attribute in the pandas read csv method.


Wikipedia Table: The above mentioned CSV file only had airport codes, so we decided to find the corresponding airport name. We found a chart on Wikipedia that had IATA codes with the areas they serve, and did a web scrape of the table using pandas. We used a ‘for loop’ to pull every letter, as every letter was on a separate page.  We used ascii_uppercase from the string library to generate a string of the alphabet.  We used this string to iterate through the Wikipedia pages and then read the table from each page with pandas. 

Kaggle CSV: We then started looking for more general airport and airline data. From Kaggle, we found a CSV pulled from an open source database on OpenFlights.org. The data consists of information about individual airlines including the OpenFlight ID, the airline name, airline alias, 2 letter IATO code, 3 letter ICAO code, airline callsign, the affiliated country, and whether the airline is still active.  We used pandas to read the csv into a jupyter notebook. The data dates to 2012 and was last updated in 2017. 


## Transform 

CSV File  from OpenSky Network:   After loading in 100 rows, we dropped rows that had any NaN vales which reduced the 100 rows tremendously. We then decided that 100 rows would not represent the entire dataset well enough.  So, we decided to pull all 1400 + rows and once the rows with ‘NaN’ were dropped, the dataframe was reduced to just over 1300 rows. 

Next, we focused on the columns firstseen, lastseen, and day.  Those columns contained values that represented the takeoff and landing time and date. All three columns had times that ended with “00:00+00:00” which was superfluous. We used the .str.strip function to drop these values.  We decided that the values in the firstseen and lastseen columns needed to split into new columns that we called date and time using the .str.split() function.  Once the date and time columns were created, the firstseen and lastseen columns could be dropped.


Wikipedia Table:  When we looped through the pages, each table that we pulled in had two layers of headers, so in our loop, we dropped the first level of header columns as we added each letter to our dataframe.  We also dropped columns for daylight savings time. 

Our dataframe contained subheader rows demarcating the codes by the second letter, resulting in over 100 columns of ‘-AB-‘, ‘-AC-‘, ‘-AD-‘, etc. that did not correspond to any airport codes.  We used the ‘~’ combined with the ‘starts with’ pandas function to delete those rows.  

We were unable to transform the column names to remove the spaces. We discovered that Wikipedia uses ISO 8859 (Latin-1) encoding which has a non-breaking space that we didn’t originally see.   The .columns() function revealed that the non-breaking space was coming across as ‘\xa0’.  We used the .replace() function to get rid of the ‘\xa0’.  Then we were able to use the a.lower() function to delete any capital letters and replace all spaces with underscores with a list comprehension using c.replace.  Finally, we used the .concat() function to compile the tables.

Kaggle CSV:  The Kaggle data was fairly clean to begin with. The transformation primarily consisted of cleaning up null values and renaming columns to be more friendly to the Postgres database. Like the Wikipedia tables, the csv was ISO 8859 (Latin-1) encoded. It also had several kinds of null values. Since some of the original data was imported from a MySQL database (according to the Kaggle ‘about information’), some null values used “\N” to signify a null value. Due to the encoding, these characters proved difficult to isolate. Eventually we settled on reading in the file with pandas and specifying UTF-8 encoding. We then used the .replace() method to replace all “\N” with numpy NaN values. We then replaced all NaN values with spaces. We also dropped the first two rows of data since it was not relevant. Finally, we renamed the columns with lowercase letters and underscores instead of spaces.

## Load

We used create_engine from sqlalchemy to load the tables into PG Admin after first setting up the tables with their data types and primary keys.  We then used the to_sql function to load the data into the SQL database.   We attempted to use foreign keys when creating tables, hoping that we could easily access fields such as  IATA or ICAO codes from different tables. However, we ran into a few unforeseen conflicts, for example, some of the code types did not line up. Additionally, the datasets may just not overlap. We may have been able to successfully build the tables with foreign keys with more time and more analysis.


