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
  
CREATE TABLE open_flights(
	open_flights_id int primary key,
	airline_name VARCHAR,
	airline_alias VARCHAR,
	iato_code VARCHAR,
	icao_code VARCHAR,
	airline_callsign VARCHAR,
	country VARCHAR,
	active VARCHAR);
	
SELECT * from iata_codes
SELECT * from january_flights
SELECT * from open_flights


