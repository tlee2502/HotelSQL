DROP DATABASE IF EXISTS hotelproject;
CREATE DATABASE hotelproject;
USE hotelproject;

CREATE TABLE GUEST (
	guestId INT AUTO_INCREMENT,
	firstName VARCHAR(45) NOT NULL,
	lastName VARCHAR(45) NOT NULL,
	address VARCHAR(100) NOT NULL,
	city VARCHAR(25) NOT NULL,
	state CHAR(2) NOT NULL,
	zip CHAR(5) NOT NULL,
	phone VARCHAR(15) NOT NULL,
    CONSTRAINT pk_guest
		PRIMARY KEY (guestId)
);

CREATE TABLE AMENITY (
	amenityId INT AUTO_INCREMENT,
	amenityType VARCHAR(25) NOT NULL,
    CONSTRAINT pk_amenity
		PRIMARY KEY (amenityId)
);

CREATE TABLE ROOM (
	roomNumber INT,
	roomType VARCHAR(15) NOT NULL,
	isADA BOOL NOT NULL,
	standardOccupancy TINYINT NOT NULL,
	maxOccupancy TINYINT NOT NULL,
	basePrice DECIMAL(5,2) NOT NULL,
	extraPersonPrice DECIMAL(4,2),
	hasJacuzzi BOOL NOT NULL,
    CONSTRAINT pk_room
		PRIMARY KEY (roomNumber)
);

DROP TABLE IF EXISTS RESERVATION;
CREATE TABLE reservation (
	reservationId INT AUTO_INCREMENT,
	adults TINYINT NOT NULL,
	children TINYINT NOT NULL,
	startDate DATE NOT NULL,
	endDate DATE NOT NULL,
	totalCost DECIMAL(6,2) NOT NULL,
	guestId INT NOT NULL,
	CONSTRAINT pk_reservation
		PRIMARY KEY (reservationId),
	CONSTRAINT fk_reservation_guest
		FOREIGN KEY (guestId) REFERENCES GUEST(guestId)
);

DROP TABLE IF EXISTS ROOM_RESERVATION;
CREATE TABLE ROOM_RESERVATION (
	roomNumber INT,
	reservationId INT,
	CONSTRAINT pk_roomReservation
		PRIMARY KEY (roomNumber, reservationId),
	CONSTRAINT fk_roomReservation_room
		FOREIGN KEY (roomNumber) REFERENCES ROOM(roomNumber),
	CONSTRAINT fk_roomReservation_reservation
		FOREIGN KEY(reservationId) REFERENCES RESERVATION(reservationId)
);

DROP TABLE IF EXISTS ROOM_AMENITY;
CREATE TABLE ROOM_AMENITY (
	roomNumber INT,
	amenityId INT,
	CONSTRAINT pk_roomAmenity
		PRIMARY KEY (roomNumber, amenityId),
	CONSTRAINT pk_roomAmenity_room
		FOREIGN KEY (roomNumber) REFERENCES ROOM(roomNumber),
	CONSTRAINT pk_roomAmenity_amenity
		FOREIGN KEY (amenityId) REFERENCES AMENITY(amenityId)
);