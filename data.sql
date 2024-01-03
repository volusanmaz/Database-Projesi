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

CREATE TABLE passed_terminal (
                                 line_id INT,
                                 terminal_name VARCHAR(255),
                                 PRIMARY KEY (line_id, terminal_name),
                                 FOREIGN KEY (line_id) REFERENCES Line(line_id),
                                 FOREIGN KEY (terminal_name) REFERENCES Terminal(terminal_name)
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

CREATE TABLE Train (
                       train_id INT PRIMARY KEY,
                       no_of_vagons INT,
                       capacity INT,
                       current_location VARCHAR(255),
                       type_name VARCHAR(255),
                       FOREIGN KEY (type_name) REFERENCES Train_type(type_name)
);

CREATE TABLE Train_type (
                            type_name VARCHAR(255) PRIMARY KEY,
                            max_seats INT
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

CREATE TABLE Airport (
                         airport_code VARCHAR(255) PRIMARY KEY,
                         city VARCHAR(255),
                         country VARCHAR(255),
                         airport_name VARCHAR(255)
);

CREATE TABLE Airplane (
                          airplane_id INT PRIMARY KEY,
                          airplane_name VARCHAR(255),
                          total_no_of_seats INT,
                          current_location VARCHAR(255),
                          type_id VARCHAR(255),
                          FOREIGN KEY (type_id) REFERENCES Airplane_Type(type_id)
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
                                      FOREIGN KEY (dropped_branch_name) REFERENCES Branch(Company_name, branch_name),
                                      FOREIGN KEY (taken_branch_name) REFERENCES Branch(Company_name, branch_name)
);

CREATE TABLE Company (
                         company_name VARCHAR(255) PRIMARY KEY,
                         company_rating INT
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
                     FOREIGN KEY (current_branch_name) REFERENCES Branch(Company_name, branch_name)
);

CREATE TABLE Branch (
                        Company_name VARCHAR(255),
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
                        FOREIGN KEY (Company_name) REFERENCES Company(company_name)
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



