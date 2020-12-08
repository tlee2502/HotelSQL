USE hotelproject;

/*  1) Write a query that returns a list of reservations that end in July 2023
	   including the name of the guest, the room number(s), and the reservation dates.
*/
SELECT CONCAT(g.firstName, ' ', g.lastName) fullame, r.roomNumber, res.startDate, res.endDate
FROM GUEST g
INNER JOIN RESERVATION res on g.guestId = res.guestId
INNER JOIN ROOM_RESERVATION rr ON res.reservationId = rr.reservationId
INNER JOIN ROOM r ON rr.roomNumber = r.roomNumber
WHERE endDate BETWEEN '2023-07-01' AND '2023-07-31';

/*  RESULT:
    Tom Lee			205	 2023-06-28	2023-07-02
    Walter Holaway	204	 2023-07-13	2023-07-14
    Wilfred Vise	401	 2023-07-18	2023-07-21
    Bettyann Seery	303	 2023-07-28	2023-07-29
*/


/*  2) Write a query that returns a list of all reservations for rooms with a jacuzzi
	   displaying the guest's name, the room number, and the dates of the reservation.
*/
SELECT CONCAT(g.firstName, ' ', g.lastName) fullame, r.roomNumber, res.startDate, res.endDate
FROM ROOM r
INNER JOIN ROOM_RESERVATION rr ON r.roomNumber = rr.roomNumber
INNER JOIN RESERVATION res ON rr.reservationId = res.reservationId
INNER JOIN GUEST g ON res.guestId = g.guestId
WHERE hasJacuzzi = TRUE;

/*  RESULT:
	Karie Yang		 201	  2023-03-06	2023-03-07
	Bettyann Seery	 203	  2023-02-05	2023-02-10
	Karie Yang		 203	  2023-09-13	2023-09-15
	Tom Lee			 205	  2023-06-28	2023-07-02
	Wilfred Vise	 207	  2023-04-23	2023-04-24
	Walter Holaway	 301	  2023-04-09	2023-04-13
	Mack Simmer		 301	  2023-11-22	2023-11-25
	Bettyann Seery	 303	  2023-07-28	2023-07-29
	Duane Cullison	 305	  2023-02-22	2023-02-24
	Bettyann Seery	 305	  2023-08-30	2023-09-01
	Tom Lee			 307	  2023-03-17	2023-03-20
*/


/*  3) Write a query that returns all the rooms reserved for a specific guest
	   including the guest's name, the room(s) reserved, the starting date of the reservation, 
	   and how many people were included in the reservation. 
	   (Choose a guest's name from the existing data.)
	   >>> CHOOSE Walter Holaway AS GUEST NAME <<<
*/
SELECT CONCAT(g.firstName, ' ', g.lastName) fullname, r.roomNumber, res.startDate, res.adults + res.children AS people
FROM GUEST g
INNER JOIN RESERVATION res ON g.guestId  = res.guestId 
INNER JOIN ROOM_RESERVATION rr ON res.reservationId = rr.reservationId
INNER JOIN ROOM r ON rr.roomNumber = r.roomNumber
WHERE g.firstName = 'Walter' AND g.lastName = 'Holaway';

/*  RESULT:
	Walter Holaway	301	 2023-04-09	  1
	Walter Holaway	204	 2023-07-13   4
*/


/*  4) Write a query that returns a list of rooms, reservation ID, and per-room cost for each reservation.
	   include all rooms, whether or not there is a reservation associated with the room.
*/
SELECT r.roomNumber, IFNULL(res.reservationId, 'N/A') AS resId, 
	 IFNULL(res.totalCost, 'N/A') AS totalPrice
From GUEST g
RIGHT OUTER JOIN RESERVATION res ON g.guestId = res.guestId
RIGHT OUTER JOIN ROOM_RESERVATION rr ON res.reservationId = rr.reservationid
RIGHT OUTER JOIN ROOM r ON rr.roomNumber = r.roomNumber;
	
/*  RESULT:
201	 4	 199.99
202	 7	 349.98
203	 2	 999.95
203	 21	 399.98
204	 16	 184.99
205	 15	 699.96
206	 12	 599.96
206	 23	 449.97
207	 10	 174.99
208	 13	 599.96
208	 20	 149.99
301	 9	 799.96
301	 24	 599.97
302	 6	 924.95
302	 25	 699.96
303	 18	 199.99
304	 14	 184.99
305	 3	 349.98
305	 19	 349.98
306	 N/A N/A
307	 5	 524.97
308	 1	 299.98
401	 11	 1199.97
401	 17	 1259.97
401	 22	 1199.97
402	 N/A N/A	
*/


/*  5) Write a query that returns all rooms with a capacity of three or more and 
	   that are reserved on any date in April 2023.
*/
SELECT r.roomNumber
FROM RESERVATION res
INNER JOIN ROOM_RESERVATION rr ON res.reservationId = rr.reservationId
INNER JOIN ROOM r ON rr.roomNumber = r.roomNumber
WHERE r.maxOccupancy >= 3 AND ( (res.startDate BETWEEN '2023-04-01' AND '2023-04-30') 
	OR (res.endDate BETWEEN '2023-04-01' AND '2023-04-30') );
	
/*  RESULT:
	301
*/


/*  6) Write a query that returns a list of all guest names and the number of reservations per guest
	   sorted starting with the guest with the most reservations and then by the guest's last name.
*/
SELECT CONCAT(g.firstName, ' ', g.lastName) fullame, COUNT(res.guestId) AS totalReservations
FROM RESERVATION res
INNER JOIN GUEST g ON res.guestId = g.guestId
GROUP BY g.firstName
ORDER BY totalReservations DESC, g.lastName;

/*  RESULT:
	Mack Simmer			4
	Bettyann Seery		3
	Duane Cullison		2
	Walter Holaway		2
	Tom Lee				2
	Aurore Lipton		2
	Maritza Tilton		2
	Joleen Tison		2
	Wilfred Vise		2
	Karie Yang			2
	Zachery Luechtefeld	1
*/


/*  7) Write a query that displays the name, address, and phone number of a guest based on their phone number
	   Choose a phone number from the existing data.
	   >>> Choose Walter's phone number <<<
*/
SELECT CONCAT(g.firstName, ' ', g.lastName) fullname, g.address, g.phone
FROM GUEST g
WHERE g.phone LIKE '(446) 396-6785';

/*  RESULT:
	Walter Holaway	7556 Arrowhead St.	(446) 396-6785
*/