CREATE TABLE Line (
                      line_id INT PRIMARY KEY,
                      duration_time INT,
                      arrival_terminal_name VARCHAR(255),
                      departure_terminal_name VARCHAR(255)
);

CREATE TABLE Terminal (
                          terminal_name VARCHAR(255) PRIMARY KEY,
                          county VARCHAR(255),
                          city VARCHAR(255)
);

CREATE TABLE Sea_Vehicle (
                             name VARCHAR(255) PRIMARY KEY,
                             type_name VARCHAR(255)
);

CREATE TABLE Sea_vehicle_type (
                                  type_name VARCHAR(255) PRIMARY KEY,
                                  max_seats INT,
                                  can_lpg_enter BOOLEAN,
                                  can_disabled_enter BOOLEAN
);

CREATE TABLE Line_Instance (
                               line_id INT,
                               line_instance_id INT PRIMARY KEY,
                               departure_time DATETIME,
                               arrival_time DATETIME,
                               date DATE,
                               sea_vehicle_name VARCHAR(255),
                               FOREIGN KEY (line_id) REFERENCES Line(line_id),
                               FOREIGN KEY (sea_vehicle_name) REFERENCES Sea_Vehicle(name)
);

CREATE TABLE Ferry_Voyage (
                        line_id INT,
                        line_instance_id INT,
                        voyage_id INT PRIMARY KEY,
                        boarding_time DATETIME,
                        landing_time DATETIME,
                        duration_time INT,
                        no_of_available_seats INT,
                        boarding_terminal_name VARCHAR(255),
                        landing_terminal_name VARCHAR(255),
                        FOREIGN KEY (line_id, line_instance_id) REFERENCES Line_Instance(line_id, line_instance_id),
                        FOREIGN KEY (boarding_terminal_name) REFERENCES Terminal(terminal_name),
                        FOREIGN KEY (landing_terminal_name) REFERENCES Terminal(terminal_name)
);

CREATE TABLE has_line (
                          terminal_name_1 VARCHAR(255),
                          terminal_name_2 VARCHAR(255),
                          PRIMARY KEY (terminal_name_1, terminal_name_2),
                          FOREIGN KEY (terminal_name_1) REFERENCES Terminal(terminal_name),
                          FOREIGN KEY (terminal_name_2) REFERENCES Terminal(terminal_name)
);

CREATE TABLE can_approach (
                              terminal_name VARCHAR(255),
                              type_name VARCHAR(255),
                              PRIMARY KEY (terminal_name, type_name),
                              FOREIGN KEY (terminal_name) REFERENCES Terminal(terminal_name),
                              FOREIGN KEY (type_name) REFERENCES Sea_vehicle_type(type_name)
);

CREATE TABLE is_ferry_applicable (
                               line_id INT,
                               type_name VARCHAR(255),
                               PRIMARY KEY (line_id, type_name),
                               FOREIGN KEY (line_id) REFERENCES Line(line_id),
                               FOREIGN KEY (type_name) REFERENCES Sea_vehicle_type(type_name)
);
CREATE TABLE Martı (
                       martı_id INT PRIMARY KEY,
                       price_per_minute DECIMAL(10, 2),
                       current_longitude DECIMAL(9, 6),
                       current_latitude DECIMAL(8, 6),
                       current_charge INT,
                       need_driver_license BOOLEAN,
                       martı_type VARCHAR(255)
);

CREATE TABLE Martı_location_history (
                                        Martı_id INT,
                                        date DATE,
                                        latitude DECIMAL(8, 6),
                                        longitude DECIMAL(9, 6),
                                        time TIME,
                                        PRIMARY KEY (Martı_id, date, time),
                                        FOREIGN KEY (Martı_id) REFERENCES Martı(martı_id)
);
CREATE TABLE İzban (
                       izban_id INT PRIMARY KEY,
                       price DECIMAL(10, 2),
                       first_station_name VARCHAR(255),
                       last_station_name VARCHAR(255)
);

CREATE TABLE Station (
                         name VARCHAR(255) PRIMARY KEY,
                         county VARCHAR(255),
                         previous_station_name VARCHAR(255),
                         next_station_name VARCHAR(255)
);

CREATE TABLE Izban_Voyage (
                        izban_id INT,
                        voyage_instance_id INT PRIMARY KEY,
                        start_date DATE,
                        start_time TIME,
                        finish_date DATE,
                        finish_time TIME,
                        duration_time INT,
                        refund_amount DECIMAL(10, 2),
                        first_station_name VARCHAR(255),
                        last_station_name VARCHAR(255),
                        FOREIGN KEY (izban_id) REFERENCES İzban(izban_id),
                        FOREIGN KEY (first_station_name) REFERENCES Station(name),
                        FOREIGN KEY (last_station_name) REFERENCES Station(name)
);
CREATE TABLE Train_Line (
                            line_name VARCHAR(255) PRIMARY KEY,
                            duration_time INT,
                            arrival_station_name VARCHAR(255),
                            departure_station_name VARCHAR(255)
);

CREATE TABLE Train_Station (
                               station_name VARCHAR(255) PRIMARY KEY,
                               city VARCHAR(255),
                               county VARCHAR(255)
);

CREATE TABLE Train_type (
                            type_name VARCHAR(255) PRIMARY KEY,
                            max_seats INT
);

CREATE TABLE Train (
                       train_id INT PRIMARY KEY,
                       no_of_vagons INT,
                       capacity INT,
                       current_location VARCHAR(255),
                       type_name VARCHAR(255),
                       FOREIGN KEY (type_name) REFERENCES Train_type(type_name)
);

CREATE TABLE Vagon (
                       vagon_id INT PRIMARY KEY,
                       train_id INT,
                       min_price DECIMAL(10, 2),
                       FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

CREATE TABLE Train_Line_Instance (
                                     line_name VARCHAR(255),
                                     Line_instance_id INT PRIMARY KEY,
                                     departure_time DATETIME,
                                     arrival_time DATETIME,
                                     train_id INT,
                                     FOREIGN KEY (line_name) REFERENCES Train_Line(line_name),
                                     FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

CREATE TABLE passed_stations (
                                 line_name VARCHAR(255),
                                 station_name VARCHAR(255),
                                 PRIMARY KEY (line_name, station_name),
                                 FOREIGN KEY (line_name) REFERENCES Train_Line(line_name),
                                 FOREIGN KEY (station_name) REFERENCES Train_Station(station_name)
);

CREATE TABLE is_train_applicable (
                               line_name VARCHAR(255),
                               type_name VARCHAR(255),
                               PRIMARY KEY (line_name, type_name),
                               FOREIGN KEY (line_name) REFERENCES Train_Line(line_name),
                               FOREIGN KEY (type_name) REFERENCES Train_type(type_name)
);

CREATE TABLE Economy_Vagon (
                               vagon_id INT PRIMARY KEY,
                               no_of_seats INT,
                               train_id INT,
                               FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

CREATE TABLE Sleeper_Vagon (
                               vagon_id INT PRIMARY KEY,
                               no_of_beds INT,
                               train_id INT,
                               FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

CREATE TABLE Train_Voyage (
                              line_name VARCHAR(255),
                              Line_instance_id INT,
                              voyage_id INT PRIMARY KEY,
                              no_of_available_seats INT,
                              boarding_time DATETIME,
                              landing_time DATETIME,
                              duration_time INT,
                              boarding_station_name VARCHAR(255),
                              landing_station_name VARCHAR(255),
                              FOREIGN KEY (line_name, Line_instance_id) REFERENCES Train_Line_Instance(line_name, Line_instance_id),
                              FOREIGN KEY (boarding_station_name) REFERENCES Train_Station(station_name),
                              FOREIGN KEY (landing_station_name) REFERENCES Train_Station(station_name)
);

CREATE TABLE Airport (
                         airport_code VARCHAR(255) PRIMARY KEY,
                         city VARCHAR(255),
                         country VARCHAR(255),
                         airport_name VARCHAR(255)
);

CREATE TABLE Airplane_Type (
                               type_id VARCHAR(255) PRIMARY KEY,
                               type_name VARCHAR(255),
                               maximum_seat INT,
                               maximum_length INT,
                               maximum_speed INT,
                               length INT,
                               height INT,
                               wingspan INT
);

CREATE TABLE Airplane (
                          airplane_id INT PRIMARY KEY,
                          airplane_name VARCHAR(255),
                          total_no_of_seats INT,
                          current_location VARCHAR(255),
                          type_id VARCHAR(255),
                          FOREIGN KEY (type_id) REFERENCES Airplane_Type(type_id)
);

CREATE TABLE Flight (
                        flight_id INT PRIMARY KEY,
                        flight_duration INT,
                        is_domestic BOOLEAN,
                        arrival_airport_code VARCHAR(255),
                        departure_airport_code VARCHAR(255),
                        company_name VARCHAR(255),
                        FOREIGN KEY (arrival_airport_code) REFERENCES Airport(airport_code),
                        FOREIGN KEY (departure_airport_code) REFERENCES Airport(airport_code)
);

CREATE TABLE Flight_Leg (
                            flight_id INT,
                            leg_id INT PRIMARY KEY,
                            available_no_of_seats INT,
                            base_fare DECIMAL(10, 2),
                            fuel_surcharge DECIMAL(10, 2),
                            flight_price DECIMAL(10, 2),
                            taxes DECIMAL(10, 2),
                            ticket_service_fee DECIMAL(10, 2),
                            airplane_id INT,
                            FOREIGN KEY (flight_id) REFERENCES Flight(flight_id),
                            FOREIGN KEY (airplane_id) REFERENCES Airplane(airplane_id)
);

CREATE TABLE can_land (
                          airport_code VARCHAR(255),
                          type_id VARCHAR(255),
                          PRIMARY KEY (airport_code, type_id),
                          FOREIGN KEY (airport_code) REFERENCES Airport(airport_code),
                          FOREIGN KEY (type_id) REFERENCES Airplane_Type(type_id)
);

CREATE TABLE Company (
                         company_name VARCHAR(255) PRIMARY KEY,
                         company_rating INT
);

CREATE TABLE Branch (
                        company_name VARCHAR(255),
                        branch_name VARCHAR(255) PRIMARY KEY,
                        branch_rating INT,
                        operating_hours VARCHAR(255),
                        county VARCHAR(255),
                        address_explanation VARCHAR(255),
                        phone_number VARCHAR(255),
                        postal_code VARCHAR(255),
                        city VARCHAR(255),
                        door_no VARCHAR(255),
                        street VARCHAR(255),
                        FOREIGN KEY (company_name) REFERENCES Company(company_name)
);

CREATE TABLE Car (
                     Company_name VARCHAR(255),
                     license_plate VARCHAR(255) PRIMARY KEY,
                     car_type VARCHAR(255),
                     gear_type VARCHAR(255),
                     model VARCHAR(255),
                     brand VARCHAR(255),
                     fuel_type VARCHAR(255),
                     kilometer_made INT,
                     kilometer_limit INT,
                     price_per_day DECIMAL(10, 2),
                     current_branch_name VARCHAR(255),
                     arrival_date DATE,
                     arrival_time TIME,
                     FOREIGN KEY (Company_name) REFERENCES Company(company_name),
                     FOREIGN KEY (current_branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE rent_condition (
                                Company_name VARCHAR(255),
                                license_plate VARCHAR(255),
                                condition_date DATE,
                                deposit DECIMAL(10, 2),
                                total_km_limit INT,
                                min_driver_age INT,
                                day_price DECIMAL(10, 2),
                                delivery_type VARCHAR(255),
                                PRIMARY KEY (Company_name, license_plate, condition_date),
                                FOREIGN KEY (Company_name, license_plate) REFERENCES Car(Company_name, license_plate)
);

CREATE TABLE Company_business_areas (
                                        Company_name VARCHAR(255),
                                        business_area VARCHAR(255),
                                        PRIMARY KEY (Company_name, business_area),
                                        FOREIGN KEY (Company_name) REFERENCES Company(company_name)
);


CREATE TABLE Electrical_Car (
                                Company_name VARCHAR(255),
                                license_plate VARCHAR(255) PRIMARY KEY,
                                battery_life INT,
                                charging_time INT,
                                FOREIGN KEY (Company_name, license_plate) REFERENCES Car(Company_name, license_plate)
);

CREATE TABLE Non_Electrical_Car (
                                    Company_name VARCHAR(255),
                                    license_plate VARCHAR(255) PRIMARY KEY,
                                    engine_cylinder_volume INT,
                                    FOREIGN KEY (Company_name, license_plate) REFERENCES Car(Company_name, license_plate)
);

CREATE TABLE Bus (
                      license_plate INT PRIMARY KEY,
                      capacity INT
);

CREATE TABLE Bus_Line (
                          line_name VARCHAR(255) PRIMARY KEY,
                          duration_time INT,
                          arrival_station_name VARCHAR(255),
                          departure_station_name VARCHAR(255)
);

CREATE TABLE Bus_Station (
                          station_name VARCHAR(255) PRIMARY KEY,
                          county VARCHAR(255),
                          city VARCHAR(255)
);

CREATE TABLE Bus_Line_Instance (
                               line_name VARCHAR(255),
                               line_instance_id INT PRIMARY KEY,
                               departure_time DATETIME,
                               arrival_time DATETIME,
                               date DATE,
                               bus_license_plate INT,
                               FOREIGN KEY (line_name) REFERENCES Bus_Line(line_name),
                               FOREIGN KEY (bus_license_plate) REFERENCES Bus(license_plate)
);

CREATE TABLE Bus_Voyage (
                          line_name VARCHAR(255),
                          line_instance_id INT,
                          voyage_id INT PRIMARY KEY,
                          landing_time DATETIME,
                          boarding_time DATETIME,
                          duration_time INT,
                          no_of_available_seats INT,
                          arrival_station_name VARCHAR(255),
                          departure_station_name VARCHAR(255),
                          FOREIGN KEY (line_name) REFERENCES Bus_Line(line_name),
                          FOREIGN KEY (line_instance_id) REFERENCES Bus_Line_Instance(line_instance_id)
);

CREATE TABLE owns_bus (
                          company_name VARCHAR(255),
                          line_name VARCHAR(255),
                          PRIMARY KEY (company_name, line_name),
                          FOREIGN KEY (company_name) REFERENCES Company(company_name)
);

CREATE TABLE has_bus (
                          company_name VARCHAR(255),
                          line_name VARCHAR(255),
                          PRIMARY KEY (company_name, line_name),
                          FOREIGN KEY (company_name) REFERENCES Company(company_name),
                          FOREIGN KEY (line_name) REFERENCES Bus_Line(line_name)
);

CREATE TABLE bus_line_passed_stations (
                          line_name VARCHAR(255),
                          passed_station_name VARCHAR(255),
                          PRIMARY KEY (line_name, passed_station_name),
                          FOREIGN KEY (line_name) REFERENCES Bus_Line(line_name)
);



CREATE TABLE Customer (
                          customer_id INT PRIMARY KEY,
                          Fname VARCHAR(255),
                          Lname VARCHAR(255),
                          surname VARCHAR(255),
                          language VARCHAR(255),
                          TCKN VARCHAR(255),
                          passport_no VARCHAR(255),
                          nationality VARCHAR(255),
                          sex VARCHAR(10),
                          city VARCHAR(255),
                          country VARCHAR(255),
                          street VARCHAR(255),
                          phone_number VARCHAR(20),
                          gmail VARCHAR(255),
                          birthday DATE
);

CREATE TABLE Card (
                      Card_id INT PRIMARY KEY,
                      customer_id INT,
                      balance_amount DECIMAL(10, 2),
                      FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Search (
                        Card_id INT,
                        search_id INT PRIMARY KEY,
                        operation_date DATE,
                        operation_time TIME,
                        transportation_type VARCHAR(255),
                        starting_place VARCHAR(255),
                        end_place VARCHAR(255),
                        FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE History (
                         Card_id INT,
                         history_id INT PRIMARY KEY,
                         operation_date DATE,
                         operation_time TIME,
                         transportation_type VARCHAR(255),
                         departure_place VARCHAR(255),
                         destination VARCHAR(255),
                         payment_amount DECIMAL(10, 2),
                         FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE Preferences (
                             Card_id INT,
                             preference_id INT PRIMARY KEY,
                             car_rent_preference BOOLEAN,
                             trip_day_preference VARCHAR(255),
                             airplane_trip_preference BOOLEAN,
                             train_preference BOOLEAN,
                             trip_time_preference VARCHAR(255),
                             marti_preference BOOLEAN,
                             izban_preference BOOLEAN,
                             ferry_preference BOOLEAN,
                             FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE Marti_Rezervation (
                                   Card_id INT,
                                   Marti_id INT,
                                   taken_date DATE,
                                   taken_time TIME,
                                   left_date DATE,
                                   left_time TIME,
                                   rezerved_date DATE,
                                   photo_of_marti VARCHAR(255),
                                   left_latitude DECIMAL(8, 6),
                                   left_longitude DECIMAL(9, 6),
                                   taken_latitude DECIMAL(8, 6),
                                   taken_longitude DECIMAL(9, 6),
                                   PRIMARY KEY (Card_id, Marti_id),
                                   FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE Train_Ticket (
                              Card_id INT,
                              line_name VARCHAR(255),
                              Line_instance_id INT,
                              voyage_id INT,
                              vagon_no INT,
                              seat INT,
                              PRIMARY KEY (Card_id, line_name, Line_instance_id, voyage_id),
                              FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE Flight_Ticket (
                               Card_id INT,
                               flight_id INT,
                               leg_id INT,
                               seat INT,
                               flight_class VARCHAR(255),
                               ticket_class VARCHAR(255),
                               passenger_type VARCHAR(255),
                               lounge BOOLEAN,
                               pet BOOLEAN,
                               extra_baggage BOOLEAN,
                               sport_eq_s VARCHAR(255),
                               PRIMARY KEY (Card_id, flight_id, leg_id),
                               FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE Izban_Journey (
                               Card_id INT,
                               Izban_id INT,
                               voyage_instance_id INT,
                               check_in_station VARCHAR(255),
                               check_in_date DATE,
                               check_in_time TIME,
                               check_out_station VARCHAR(255),
                               check_out_date DATE,
                               check_out_time TIME,
                               refund_amount DECIMAL(10, 2),
                               PRIMARY KEY (Card_id, Izban_id, voyage_instance_id),
                               FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);

CREATE TABLE Ferry_Ticket (
                              Card_id INT,
                              line_id INT,
                              line_instance_id INT,
                              voyage_id INT,
                              age_type VARCHAR(255),
                              is_disabled BOOLEAN,
                              with_car BOOLEAN,
                              class_type VARCHAR(255),
                              seat_no INT,
                              has_pet BOOLEAN,
                              is_close_to_veteran BOOLEAN,
                              is_press BOOLEAN,
                              is_ibb_council_member BOOLEAN,
                              PRIMARY KEY (Card_id, line_id, line_instance_id, voyage_id),
                              FOREIGN KEY (Card_id) REFERENCES Card(Card_id)
);


CREATE TABLE Car_rent_rezervation (
                                      rezervation_no INT PRIMARY KEY,
                                      card_id INT,
                                      rezerved_date DATE,
                                      taken_date DATE,
                                      dropped_date DATE,
                                      spent_day INT,
                                      total_price DECIMAL(10, 2),
                                      Company_name VARCHAR(255),
                                      license_plate VARCHAR(255),
                                      dropped_branch_name VARCHAR(255),
                                      taken_branch_name VARCHAR(255),
                                      FOREIGN KEY (card_id) REFERENCES Card(Card_id),
                                      FOREIGN KEY (Company_name, license_plate) REFERENCES Car(Company_name, license_plate),
                                      FOREIGN KEY (dropped_branch_name) REFERENCES Branch(branch_name),
                                      FOREIGN KEY (taken_branch_name) REFERENCES Branch(branch_name)
);



INSERT INTO Line (line_id, duration_time, arrival_terminal_name, departure_terminal_name) VALUES
(1, 120, 'Kadikoy', 'Bursa'),
(2, 120, 'Armutlu', 'Bursa'),
(3, 150, 'Yenikapi', 'Bursa'),
(4, 150, 'Kabatas', 'Bursa'),
(5, 150, 'Pendik', 'Yalova'),
(6, 150, 'Yenikapi', 'Yalova'),
(7, 150, 'Yalova', 'Pendik'),
(8, 120, 'Yalova', 'Yenikapi');

INSERT INTO Terminal (terminal_name, county, city) VALUES
("Bursa", "Mudanya", "Bursa"),
("Yalova", "Suleyman Bey", "Yalova"),
("Kadikoy", "Kadikoy", "Istanbul"),
("Armutlu", "Armutlu", "Istanbul"),
("Yenikapi", "Yenikapi", "Istanbul"),
("Kabatas", "Kabatas", "Istanbul"),
("Pendik", "Pendik", "Istanbul");

INSERT INTO Sea_Vehicle (name, type_name) VALUES
("Murat Reis-7", "Yuksek Hizli Hafif Yolcu Gemisi"),
("Salih Reis-4", "Yuksek Hizli Hafif Yolcu Gemisi"),
("Burak Reis-3", "Yuksek Hizli Hafif Yolcu Gemisi"),
("Kemal Reis-5", "Yuksek Hizli Hafif Yolcu Gemisi"),
("Adnan Menderes", "Yuksek Hizli Hafif Yolcu Feribotu"),
("Sadabant", "Araba Ferisi"),
("Sahilbent", "Araba Ferisi"),
("Suhulet", "Araba Ferisi"),
("Fatih Sultan Mehmet", "Hafif Yolcu Feribotu"),
("Kanuni Sultan Suleyman", "Hafif Yolcu Feribotu");

INSERT INTO Sea_vehicle_type (type_name, max_seats, can_lpg_enter, can_disabled_enter) VALUES
("Yuksek Hizli Hafif Yolcu Gemisi", 449, true, true),
("Yuksek Hizli Hafif Yolcu Feribotu", 962, true, false),
("Araba Ferisi", 596, false, true),
("Hafif Yolcu Feribotu", 580, true, true);

INSERT INTO Line_Instance (line_id, line_instance_id, departure_time, arrival_time, date, sea_vehicle_name) VALUES
(1, 1, '2023-01-04 15:30:00', '2023-01-04 17:30:00', '2023-01-04', "Murat Reis-7"),
(1, 2, '2023-01-03 15:30:00', '2023-01-03 17:30:00', '2023-01-03', "Murat Reis-7"),
(1, 3, '2023-01-02 15:30:00', '2023-01-02 17:30:00', '2023-01-02', "Murat Reis-7"),
(2, 4, '2023-01-02 12:30:00', '2023-01-02 14:30:00', '2023-01-02', "Adnan Menderes"),
(2, 5, '2023-01-03 12:30:00', '2023-01-03 14:30:00', '2023-01-03', "Adnan Menderes"),
(3, 6, '2023-01-01 17:00:00', '2023-01-01 19:30:00', '2023-01-01', "Sadabant"),
(3, 7, '2023-01-03 17:00:00', '2023-01-03 19:30:00', '2023-01-03', "Sadabant"),
(4, 8, '2023-01-01 19:00:00', '2023-01-01 21:30:00', '2023-01-01', "Fatih Sultan Mehmet"),
(4, 9, '2023-01-02 19:00:00', '2023-01-02 21:30:00', '2023-01-02', "Fatih Sultan Mehmet"),
(5, 10, '2023-01-03 20:00:00', '2023-01-03 22:30:00', '2023-01-03', "Salih Reis-4"),
(6, 11, '2023-01-04 20:00:00', '2023-01-04 22:30:00', '2023-01-04', "Burak Reis-3"),
(7, 12, '2023-01-03 23:00:00', '2023-01-04 01:30:00', '2023-01-03', "Suhulet"),
(8, 13, '2023-01-02 22:30:00', '2023-01-03 00:30:00', '2023-01-02', "Sahilbent"),
(8, 14, '2023-01-03 08:30:00', '2023-01-03 10:30:00', '2023-01-03', "Sahilbent");

INSERT INTO Ferry_Voyage (line_id, line_instance_id, voyage_id, boarding_time, landing_time, duration_time, no_of_available_seats, boarding_terminal_name, landing_terminal_name) VALUES
(1, 1, 1, '2023-01-04 15:30:00', '2023-01-04 17:30:00', 120, 148, 'Bursa', "Kadikoy"),
(1, 2, 2, '2023-01-03 15:30:00', '2023-01-03 17:30:00', 120, 128, 'Bursa', "Kadikoy"),
(1, 3, 3, '2023-01-02 15:30:00', '2023-01-02 17:30:00', 120, 141, 'Bursa', "Kadikoy"),
(2, 4, 4, '2023-01-02 12:30:00', '2023-01-02 14:30:00', 120, 133, 'Bursa', "Armutlu"),
(2, 5, 5, '2023-01-03 12:30:00', '2023-01-03 14:30:00', 120, 179, 'Bursa', "Armutlu"),
(3, 6, 6, '2023-01-01 17:00:00', '2023-01-01 19:30:00', 150, 235, 'Bursa', "Yenikapi"),
(3, 7, 7, '2023-01-03 17:00:00', '2023-01-03 19:30:00', 150, 332, 'Bursa', "Yenikapi"),
(4, 8, 8, '2023-01-01 19:00:00', '2023-01-01 21:30:00', 150, 321, 'Bursa', "Kabatas"),
(4, 9, 9, '2023-01-02 19:00:00', '2023-01-02 21:30:00', 150, 135, 'Bursa', "Kabatas"),
(5, 10, 10, '2023-01-03 20:00:00', '2023-01-03 22:30:00', 150, 188, 'Yalova', "Pendik"),
(6, 11, 11, '2023-01-04 20:00:00', '2023-01-04 22:30:00', 150, 92, 'Yalova', "Yenikapi"),
(7, 12, 12, '2023-01-03 23:00:00', '2023-01-04 01:30:00', 150, 63, 'Pendik', "Yalova"),
(8, 13, 13, '2023-01-02 22:30:00', '2023-01-03 00:30:00', 120, 143, 'Yenikapi', "Yalova"),
(8, 14, 14, '2023-01-03 08:30:00', '2023-01-03 10:30:00', 120, 148, 'Yenikapi', "Yalova");

INSERT INTO has_line (terminal_name_1, terminal_name_2) VALUES
("Bursa", "Kadikoy"),
("Bursa", "Armutlu"),
("Bursa", "Yenikapi"),
("Bursa", "Kabatas"),
("Yalova", "Yenikapi"),
("Yalova", "Pendik");


INSERT INTO can_approach (terminal_name, type_name) VALUES
("Bursa", "Yuksek Hizli Hafif Yolcu Gemisi"),
("Bursa", "Araba Ferisi"),
("Bursa", "Hafif Yolcu Feribotu"),
("Kabatas", "Hafif Yolcu Feribotu"),
("Armutlu", "Yuksek Hizli Hafif Yolcu Gemisi"),
("Kadikoy", "Yuksek Hizli Hafif Yolcu Gemisi"),
("Yenikapi", "Yuksek Hizli Hafif Yolcu Gemisi"),
("Yenikapi", "Araba Ferisi"),
("Pendik", "Yuksek Hizli Hafif Yolcu Gemisi"),
("Pendik", "Araba Ferisi"),
("Yalova", "Yuksek Hizli Hafif Yolcu Gemisi"),
("Yalova", "Araba Ferisi");

INSERT INTO is_ferry_applicable (line_id, type_name) VALUES
(1, "Yuksek Hizli Hafif Yolcu Gemisi"),
(2, "Yuksek Hizli Hafif Yolcu Feribotu"),
(3, "Araba Ferisi"),
(4, "Hafif Yolcu Feribotu"),
(5, "Yuksek Hizli Hafif Yolcu Gemisi"),
(6, "Yuksek Hizli Hafif Yolcu Gemisi"),
(7, "Araba Ferisi"),
(8, "Araba Ferisi");

INSERT INTO Martı (martı_id, price_per_minute ,current_longitude, current_latitude, current_charge, need_driver_license, martı_type) VALUES
(1, 6.75, 41.0082, 28.5865, 42, true, "E-mopped"),
(2, 5.5, 41.2389, 29.1761, 42, false, "Scooter"),
(3, 6.75, 41.5627, 28.3769, 42, true, "E-mopped"),
(4, 5.5, 41.9253, 28.8863, 42, false, "Scooter"),
(5, 5.5, 42.6221, 28.3562, 42, false, "Scooter");

INSERT INTO Martı_location_history (Martı_id, date, longitude, latitude, time) VALUES
(1, '2023-01-04 15:32:27', 41.5226, 29.7254, '15:32:27'),
(1, '2023-01-06 22:18:22', 41.8263, 28.4337, '22:18:22'),
(1, '2023-01-07 07:22:35', 42.5458, 28.1478, '07:32:35'),
(2, '2023-01-05 16:41:35', 41.4391, 29.1933, '16:41:35'),
(2, '2023-01-06 11:16:17', 41.7813, 28.2681, '11:16:17'),
(3, '2023-01-02 13:22:15', 41.3985, 28.5681, '13:22:15'),
(3, '2023-01-03 17:16:35', 42.6141, 28.1381, '17:16:35'),
(4, '2023-01-04 15:23:32', 41.3678, 28.7145, '15:23:32'),
(4, '2023-01-05 12:33:11', 41.2696, 28.6008, '12:33:11'),
(5, '2023-01-05 13:41:21', 42.2359, 29.3316, '13:41:21');
