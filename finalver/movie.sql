DROP DATABASE IF EXISTS movie;
CREATE DATABASE movie;
USE movie;
DROP TABLE IF EXISTS `account`, movie, ticket, snack, orderline_ticket, seat, orderline_snack, `order`; 
# Create table
CREATE TABLE `account`(
    account_ID 				INT 					NOT NULL AUTO_INCREMENT,
    account_name 			NVARCHAR(100) 			NOT NULL,
    `role`					ENUM('staff','admin') 	NOT NULL,
    age						TINYINT 				NOT NULL,
    email 					VARCHAR(255)			NOT NULL,
    `password` 				VARCHAR(800)			NOT NULL,
    PRIMARY KEY (account_ID)
);

CREATE TABLE movie(
	movie_ID 				INT 					NOT NULL AUTO_INCREMENT,
	movie_name 				NVARCHAR(100) 			NOT NULL,
     director 				NVARCHAR(50)			NOT NULL,
    `cast`					NVARCHAR(255) 			NOT NULL,
    duration_start 				TIME 					NOT NULL,
    duration_end 				TIME 					NOT NULL ,
    genre 					NVARCHAR(50)			NOT NULL,
    release_date 			DATE 					NOT NULL ,
    `language` 				NVARCHAR(100) 			NOT NULL,
    rated 					NVARCHAR(100) 			NOT NULL,
	poster 					VARCHAR(1000)			NOT NULL, 
    PRIMARY KEY(movie_ID)
);
CREATE TABLE ticket(
	ticket_ID 				INT 					NOT NULL ,
    accom_time 				TIME 					NOT NULL,
    ticket_price 			INT 					NOT NULL,
    movie_ID 				INT 					NOT NULL,
    PRIMARY KEY (ticket_ID),
    FOREIGN KEY (movie_ID) 							REFERENCES movie(movie_ID) 		ON DELETE CASCADE on update cascade
);
CREATE TABLE seat(
	seat_ID 				INT 					NOT NULL  AUTO_INCREMENT,
    seat_status 			ENUM('occupied','empty','selected') NOT NULL, 
    ticket_ID 				INT 					NOT NULL,
    PRIMARY KEY (seat_ID)
);
CREATE TABLE snack(
	snack_ID 				INT 					NOT NULL AUTO_INCREMENT,
    snack_name 				VARCHAR(100) 			NOT NULL,
    picture 				VARCHAR(1000)           NOT NULL,
    snack_price 			DOUBLE 					NOT NULL,
    snack_type				enum('popcorn', 'drink') NOT NULL,
    PRIMARY KEY (snack_ID)
);

CREATE TABLE orderline_ticket(
	orderline_ticket_ID 	INT 					NOT NULL AUTO_INCREMENT,
    ticket_ID 				INT 					NOT NULL unique key,
	ticket_number 			INT 					NOT NULL,
    ticket_type 			ENUM('regular 2D','Gold Class 2D') 	NOT NULL, 
	PRIMARY KEY (orderline_ticket_ID)
    -- FOREIGN KEY (ticket_ID) 							REFERENCES ticket(ticket_ID) 		ON DELETE CASCADE on update cascade
); 
CREATE TABLE orderline_snack(
	orderline_snack_ID 		INT 					NOT NULL AUTO_INCREMENT,
    snack_ID 				INT 					NOT NULL,
	snack_number 			INT 					NOT NULL,
    snack_type 				ENUM('middle','big','small')			NOT NULL, 
    PRIMARY KEY(orderline_snack_ID),
    FOREIGN KEY (snack_ID)							REFERENCES snack(snack_ID) 
);
CREATE TABLE `order`(
	order_ID 				INT 					NOT NULL AUTO_INCREMENT,
    order_date 				DATE 					NOT NULL,
    time_start 				TIME 					NOT NULL,
    payment 				NVARCHAR(100)			NOT NULL,
	account_ID 				INT 					NOT NULL,
    orderline_ticket_ID 	INT 					NOT NULL unique key,
    PRIMARY KEY(order_ID)
);

# Table Account
INSERT INTO `account`(account_name, `role`, age, email, `password`)
VALUE 
('Nguyen Phuong Tan', 'admin', 25, 'nguyenphuongtan@gmail.com','$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi'),
('Nguyen Hai Ninh', 'staff', 19, 'nguyenhaininh@gmail.com','$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi'),
('Nguyen Huu Thanh', 'staff', 20, 'nguyenhuuthanh@gmail.com','$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi'),
('Dang Thu Trang', 'admin', 23, 'dangthutrang@gmail.com','$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi'),
('Le Mai Anh', 'staff', 21, 'lemaianh@gmail.com','$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi');
# Table Movie 
INSERT INTO movie(movie_name, director, cast, genre, release_date, duration_start, duration_end, `language`,rated, poster)
VALUE
('THE BAD GUYS', 'Pierre Perifel', 'Sam Rockwell, Awkwafina, Anthony Ramos, Marc Maron, etc', 'Comedy, Animation', '2022-03-25', '01:40:00','01:40:00', 'English', 'P- General movie to all customers', 'https://www.cgv.vn/media/catalog/product/cache/1/image/1800x/71252117777b696995f01934522c402d/p/o/poster_bad_guys_nh_ng_k_x_u_xa_25.03.2022_1_.jpg' ),
('THE BATMAN','Matt Reeves', 'Robert Pattinson, Zoë Kravitz, Paul Dano', 'Action, Crime', '2022-03-04','03:03:00','01:40:00', 'English', ' C16 - No children under 16 years old', 'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/p/o/poster_batman-1.jpg'),
('THE LOST CITY', 'Aaron Nee, Adam Nee', 'Sandra Bullock, Channing Tatum, Daniel Radcliffe, Brad Pitt, etc.', 'Action, Adventure, Comedy', '2022-03-25', '01:52:00','01:40:00', 'English', 'C13 - No children under 13 years old', 'https://www.cgv.vn/media/catalog/product/cache/1/image/1800x/71252117777b696995f01934522c402d/p/o/poster_th_nh_ph_m_t_t_ch_-_25.03.2022_1_.jpg'),
('TURNING RED', 'Domee Shi','Rosalie Chiang, Sandra Oh, James Hong','Animation','2022-03-11', '01:39:00','01:40:00', 'English', 'P - GENERAL MOVIE TO ALL CUSTOMERS', 'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/t/u/turning_red-final_poster_1_.jpg'),
('WRATH OF MAN', 'Guy Ritchie', 'Jason Statham, Holt McCallany, Jeffrey Donovan, Josh Hartnett, Scott Eastwood, Eddie Marsan', 'Action','2022-03-11', '01:58:00','01:40:00', 'English with Vietnamese subtitle', 'C18 - No children under 18 years old', 'https://www.cgv.vn/media/catalog/product/cache/1/image/1800x/71252117777b696995f01934522c402d/m/a/main-poster_wom-2_1_.jpg');
# Table Seat 
INSERT INTO seat(seat_status, ticket_ID)
VALUE
('empty',1),
('empty',1),
('empty',0),
('empty',0),
('empty', 0),
('empty',0),
('empty',0),
('empty',0),
('empty',0),
('empty',0),
('empty',0),
('empty',0),
('empty',0),
('empty',0),
('empty',0),
('empty',0),
('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('occupied',1),
('empty',0),
('empty',0),
('empty',0),
('empty', 0),
('empty',0),
('empty',0),
('empty',0),
('occupied',3),
('selected',0),
('selected',0),
('selected',0),
('empty',0),
('occupied',3),
('empty',0),
('empty',0),
('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('occupied',1),
('occupied',1),
('selected',0),
('occupied',5),
('empty', 0),
('empty',0),
('empty',0),
('empty',0),
('occupied',3),
('selected',0),
('selected',0),
('selected',0),
('empty',0),
('occupied',3),
('empty',0),
('empty',0),
('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('occupied',1),
('occupied',1),
('selected',0),
('occupied',5),
('empty', 0),
('empty',0),
('empty',0),
('empty',0),
('occupied',3),
('selected',0),
('selected',0),
('selected',0),
('empty',0),
('occupied',3),
('empty',0),
('empty',0),
('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('occupied',1),
('occupied',1),
('selected',0),
('occupied',5),
('empty', 0),
('empty',0),
('empty',0),
('empty',0),
('occupied',3),
('selected',0),
('selected',0),
('selected',0),
('empty',0),
('occupied',3),
('empty',0),
('empty',0),
('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0),('empty',0),
('empty',0),('empty',0),
('empty',0),('empty',0)
;

#Table Ticket 
INSERT INTO ticket(ticket_ID,accom_time, ticket_price, movie_ID)
VAlUE 
(1,'01:40:00', '250000', 1),
(2,'01:58:00', '180000',5),
(3,'01:40:00', '300000', 1),
(4,'03:03:00', '220000', 2),
(5,'01:52:00', '150000', 3)

;
INSERT INTO ticket(ticket_ID, accom_time, ticket_price, movie_ID)
VAlUE (0,'00:00:00', '0', 1);
-- SET SQL_SAFE_UPDATES = 0;
-- UPDATE `movie`.`ticket` SET `ticket_ID` = '0' WHERE (`ticket_ID` = '7');
#Table Snack 
INSERT INTO snack(snack_name, snack_price,picture, snack_type)
VALUE 
('POPCORN', '30000', 'https://p4.wallpaperbetter.com/wallpaper/335/368/957/popcorn-film-photography-wallpaper-preview.jpg', 'popcorn'),
('CHOCOLATE POPCORN', '50000', 'https://www.foodgal.com/wp-content/uploads/2019/02/Chocolate-Popcorn.jpg', 'popcorn'),
('CARAMEL POPCORN', '45000', 'https://assets.voxcinemas.com/content/F_B-Salt_and_caramel_popcorn_1586941720.jpg' , 'popcorn'),
('COCA COLA', '25000', 'https://media-api.advertisingvietnam.com/oapi/v1/media?uuid=public%2Fwp-content%2Fuploads%2F2019%2F06%2F6-quang-cao-dang-nho-cua-coca-cola.jpg&resolution=1440x756&type=image', 'drink'),
('PEPSI', '27000','https://www.albawaba.com/sites/default/files/im_new/israa/Pepsi3.jpg?width=1200&enable=upscale', 'drink');
#Table Orderine_Ticket
INSERT INTO orderline_ticket(ticket_number, ticket_type, ticket_ID)
VALUE 
(2,'regular 2D', 2 ),
(3,'gold class 2D', 1 ),
(1,'regular 2D', 3 ),
(4,'gold class 2D',4 ),
(1,'regular 2D', 5 );
-- INSERT INTO orderline_ticket(orderline_ticket_ID,ticket_number, ticket_type, ticket_ID)
-- VALUE 
-- (0, 0,'regular 2D', 0 );
-- SET SQL_SAFE_UPDATES = 0;
-- UPDATE `movie`.`orderline_ticket` SET `orderline_ticket_ID` = '0' WHERE (`orderline_ticket_ID` = '6');
#Table Orderline_snack
INSERT INTO orderline_snack(snack_number, snack_type, snack_ID)
VALUE
(1,'middle',1),
(2,'small',3),
(1,'big',5),
(1,'middle',4),
(3,'big',2);
#Table Order
INSERT INTO `Order`(order_date, time_start,payment, orderline_ticket_ID, account_ID)
VALUE 
('2022-03-25', '08:30:00', 'card', 1, 5),
('2022-03-26', '14:20:00', 'card', 2, 5),
('2022-03-26', '15:15:00', 'card', 3, 3),
('2022-03-27', '09:00:00', 'card', 4, 2),
('2022-03-27', '09:00:00', 'card', 5, 2);