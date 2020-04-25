CREATE TABLE iata_codes(
	airport_name VARCHAR,
	iata VARCHAR primary key,
	icao VARCHAR,
	location_served VARCHAR, 
	time VARCHAR);
	
CREATE TABLE january_flights(

	callsign VARCHAR,
	number VARCHAR,
	icao24 VARCHAR,
	registration VARCHAR,
	typecode VARCHAR,
	origin VARCHAR,
	destination VARCHAR,
	day VARCHAR,
	firstseen_date VARCHAR,
	firstseen_time VARCHAR,
	lastseen_date VARCHAR,
	lastseen_time VARCHAR
	);
	
SELECT * from iata_codes
SELECT * from january_flights



