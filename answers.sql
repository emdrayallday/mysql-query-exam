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
4) Provide a distinct list of airlines that conducts flights departing from ATL.
*/
SELECT DISTINCT a.name Airline FROM airline a INNER JOIN flight f ON f.airlineID = a.ID WHERE departAirport = 'ATL';
/*
5) Provide a list of airlines, flight numbers, departing airports, and arrival airports where flights departed on time.
*/ 
SELECT a.name, f.flightNumber, f.departAirport, f.arriveAirport FROM flight f INNER JOIN airline a ON a.ID = f.airlineID WHERE f.scheduledDepartDateTime = f.actualDepartDateTime;
/*
6) Provide a list of airlines, flight numbers, gates, status, and arrival times arriving into Charlotte (CLT) on 10-30-2017. Order your results by the arrival time.
*/ 
SELECT a.name Airline, f.flightNumber Flight, f.gate Gate, time(f.scheduledArriveDateTime) Arrival, f.status Status FROM flight f INNER JOIN airline a ON a.ID = f.airlineID WHERE f.arriveAirport = 'CLT' AND date(f.scheduledArriveDateTime)='2017-10-30' ORDER BY Arrival;
/*
7) List the number of reservations by flight number. Order by reservations in descending order.
*/
SELECT f.flightNumber flight, count(r.flightID) reservations FROM flight f INNER JOIN reservation r ON f.ID = r.flightID GROUP BY r.flightID ORDER BY reservations DESC;
/*
8)List the average ticket cost for coach by airline and route. Order by AverageCost in descending order.
*/
SELECT a.name airline, f.departAirport, f.arriveAirport, avg(r.cost) AverageCost FROM airline a INNER JOIN flight f ON a.ID = f.airlineID INNER JOIN reservation r ON r.flightID = f.ID WHERE r.class = 'coach'  GROUP BY r.flightID ORDER BY AverageCost DESC;
/*
9) Which flight is the longest?
*/
SELECT  departAirport, arriveAirport , max(miles) FROM flight GROUP BY ID ORDER BY miles DESC LIMIT 1;
/*
10) List the top 5 passengers that have flown the most miles. Order by miles.
*/
SELECT p.firstName, p.lastName, sum(miles) miles FROM flight f INNER JOIN reservation r ON r.flightID = f.ID INNER JOIN passenger p ON p.ID = r.passengerID GROUP BY r.passengerID ORDER BY miles DESC LIMIT 5;
/*
11) Provide a list of American airline flights ordered by route and arrival date and time.
*/
SELECT a.name Name, concat(f.departAirport, ' --> ', f.arriveAirport) Route, date(f.scheduledArriveDateTime) 'Arrive Date', time(f.scheduledArriveDateTime) 'Arrive Time' FROM airline a INNER JOIN flight f ON f.airlineID = a.ID WHERE a.name = 'American' ORDER BY Route,  'Arrive Date', 'Arrive Time';
/*
12) Provide a report that counts the number of reservations and totals the reservation costs (as Revenue) by Airline, flight, and route. 
		Order the report by total revenue in descending order.
*/
SELECT a.name Airline, f.flightNumber Flight, concat(f.departAirport, ' --> ', f.arriveAirport) Route, count(r.flightID) 'Reservation Count', sum(r.cost) Revenue FROM airline a INNER JOIN flight f ON f.airlineID = a.ID INNER JOIN reservation r ON r.flightID = f.ID GROUP BY r.flightID ORDER BY Revenue DESC;
/*
13)List the average cost per reservation by route. Round results down to the dollar.
*/
SELECT concat(f.departAirport, ' --> ', f.arriveAirport) Route, round(avg(r.cost)) 'Avg Revenue' FROM flight f INNER JOIN reservation r ON r.flightID = f.ID GROUP BY Route ORDER BY round(avg(r.cost)) DESC;
/*
14) List the average miles per flight by airline.
*/
SELECT a.name Airline, avg(f.miles) 'Avg Miles Per Flight' FROM airline a INNER JOIN flight f ON f.airlineID = a.ID GROUP BY a.name ORDER BY a.name;
/*
15) Which airlines had flights that arrived early?
*/
SELECT DISTINCT a.name Airline FROM airline a INNER JOIN flight f ON f.airlineID = a.ID WHERE f.actualArriveDateTime < f.scheduledArriveDateTime