/*
 1) Select a distinct list of ordered airports codes.
 */
SELECT DISTINCT departAirport Airports FROM flight ORDER BY departAirport;

/*
2) Provide a list of delayed flights departing from San Francisco (SFO).
*/
SELECT a.name, f.flightNumber, f.scheduledDepartDateTime, f.arriveAirport, f.status FROM flight f INNER JOIN airline a ON a.ID = f.airlineID WHERE f.status = 'delayed' AND  f.departAirport = 'SFO';
/*
3)Provide a distinct list of cities that American airlines departs from.
*/
SELECT DISTINCT departAirport Cities FROM flight INNER JOIN airline ON airline.ID = flight.airlineID WHERE airline.name = 'American';
/*
4)
*/