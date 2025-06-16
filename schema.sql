-- Belize School Survey & Grant Request Schema

-- Drop old and Create the database if it doesn't exist

DROP DATABASE IF EXISTS Belize_Project;
CREATE DATABASE IF NOT EXISTS Belize_Project;
USE Belize_Project;

-- Table to store information about any organizations (district, management or school)

CREATE TABLE organization (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type ENUM ('district', 'management', 'local_management', 'school'),
    name VARCHAR(80),  -- name of organization
    address VARCHAR(80),
    person VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(50),
    web_page VARCHAR(100),
    facebook_page VARCHAR(100),
    password VARCHAR(50),  -- password need to add/edit this information. 'name' is the username
    comments TEXT,
    admin_comments TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table to store staff details (principals, teachers, managers, district representative)

CREATE TABLE staff (
    id INT PRIMARY KEY AUTO_INCREMENT,
    organization_id INT,
    role VARCHAR(50),
    experience TEXT,
    resume_file_path VARCHAR(255),
    comments TEXT,
    admin_comments TEXT,
    approved_for_advertising BOOLEAN,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (organization_id) REFERENCES organization(id)
);

-- Table to store information about districts

CREATE TABLE district (
    id INT PRIMARY KEY AUTO_INCREMENT,
    organization_id INT,
    -- filler_unique_to_district VARCHAR(50),
    comments TEXT,
    admin_comments TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (organization_id) REFERENCES organization(id)
);

-- Table to store management information

CREATE TABLE management (
    id INT PRIMARY KEY AUTO_INCREMENT,
    organization_id INT,
    -- filler_unique_to_management VARCHAR(50),
    comments TEXT,
    admin_comments TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (organization_id) REFERENCES organization(id)
);

-- Table to store local management information

CREATE TABLE local_management (
    id INT PRIMARY KEY AUTO_INCREMENT,
    organization_id INT,
    -- filler_unique_to_local_management VARCHAR(50),
    comments TEXT,
    admin_comments TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (organization_id) REFERENCES organization(id)
);

-- Table to store individual school information

CREATE TABLE school (
    id INT PRIMARY KEY AUTO_INCREMENT,
    organization_id INT,
    district_id INT,
    management_id INT,
    local_management_id INT,
    comments TEXT,
    admin_comments TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (organization_id) REFERENCES organization(id),
    FOREIGN KEY (district_id) REFERENCES district(id),
    FOREIGN KEY (management_id) REFERENCES management(id),
    FOREIGN KEY (local_management_id) REFERENCES local_management(id)
);

-- Table to store current grant status - filled in by administrator

CREATE TABLE school_grant_status (
    id INT PRIMARY KEY AUTO_INCREMENT,
    school_id INT,
    status ENUM ('more info needed', 'pending_phone_call', 'pending site visit', 'pending final approval', 'approved for advertising', 'granted', 'pending shipment', 'pending installation', 'installed'),
    number_of_computers INT,
    type_of_computers VARCHAR(50),
    number_of_ethernet_switches INT,
    comments TEXT,
    admin_comments TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (school_id) REFERENCES school(id)
);

-- School information as proveded by the MOE DO NOT ALLOW UPDATES
--   From MOE XLS file, Edit by Hand, Export to CSV, Import into this table, Run SQL to prime 
--   THIS IS A TEMPORARY TABLE THAT WILL MOST LIKELY NOT BE USED BY OUR WEB SITE --

CREATE TABLE moe_school_info (
    name VARCHAR(80) PRIMARY KEY, -- This table is floating out there and does not have a pointer to the school
    giga_name VARCHAR(80), -- Name that Giga gave this school
    giga_code VARCHAR(10), -- Giga's code for this school
    code VARCHAR(10), -- MOE's code for each school
    address VARCHAR(80), -- School's main address
    contact_person VARCHAR(50), -- School's contact person (typically the principal)
    telephone VARCHAR(20), -- School's contact person's phone number
    telephone_alt1 VARCHAR(20), -- Alternative school phone number
    telephone_alt2 VARCHAR(20), -- Alternative school phone number
    email VARCHAR(50), -- School's email address
    website	VARCHAR(50), -- Schools Web Site (optional)
    year_opened INT, -- Year the school opened
    longitude FLOAT, -- Longitude of school building
    latitude FLOAT, -- Latitude of school building

            -- The following ENUMs are to flag and filter out bad data at SQL import time
    district ENUM ('Belize', 'Cayo', 'Corozal', 'Orange Walk', 'Stann Creek', 'Toledo'),
    locality ENUM ('Rural','Urban','Other'),
    type ENUM ('Preschool', 'Primary', 'Secondary', 'Tertiary', 'Vocational', 'Adult and Continuing', 'University'),
    ownership VARCHAR(50), -- 
    sector ENUM ('Government', 'Government Aided', 'Private','Specially Assisted'),
    school_Administrator_1 VARCHAR(50),
    school_Administrator_2 VARCHAR(50),
    admin_comments TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- School information as proveded by the MOE and potentially updated by the Organizational person.

CREATE TABLE school_info (
    id INT PRIMARY KEY AUTO_INCREMENT,
    school_id INT,
    moe_name VARCHAR(80), -- This is the name of the school from the latest MOE load
    name VARCHAR(80), -- This is the name of the school from the latest moe load - and changed by principal
    code VARCHAR(10), -- MOE's code for each school
    address VARCHAR(80), -- School's main address
    contact_person VARCHAR(50), -- School's contact person (typically the principal)
    telephone VARCHAR(20), -- School's contact person's phone number
    telephone_alt1 VARCHAR(20), -- Alternative school phone number
    telephone_alt2 VARCHAR(20), -- Alternative school phone number
    moe_email VARCHAR(50), -- School's email address from MOE load
    email VARCHAR(50), -- School's email address
    website	VARCHAR(50), -- Schools Web Site (optional)
    year_opened INT, -- Year the school opened
    longitude FLOAT, -- Longitude of school building
    latitude FLOAT, -- Latitude of school building

    district ENUM ('Belize', 'Cayo', 'Corozal', 'Orange Walk', 'Stann Creek', 'Toledo'),
    locality ENUM ('Rural','Urban','Other'),
    type ENUM ('Preschool', 'Primary', 'Secondary', 'Tertiary', 'Vocational', 'Adult and Continuing', 'University'),
    ownership VARCHAR(50), -- 
    sector ENUM ('Government', 'Government Aided', 'Private','Specially Assisted'),
    school_administrator_1 VARCHAR(50), -- Administrator 1 name
    School_administrator_2 VARCHAR(50), -- Administrator 2 name
    comments TEXT,
    admin_comments TEXT,
    verified_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (school_id) REFERENCES school(id)
);

-- Table which stores the demographics of the schools

CREATE TABLE demographics (
    id INT PRIMARY KEY,
    school_id INT,
    minutes_drive_from_road INT, -- How many minutes drive is your school from the main road?
    principals_name VARCHAR(50), -- Principal’s name
    principals_telephone VARCHAR(50), -- Principal’s phone number
    principals_email VARCHAR(50), -- Principal’s email address
    principals_computer BOOLEAN, -- Does the principal's office have a good working computer that is not rented?
    number_of_students INT, -- Total number of students in your school
    largest_class_size INT, -- Number of students in your largest class
    number_of_buildings INT, -- Number of buildings at your school (not including storage buildings)
    number_of_buildings_with_internet INT, -- Number of buildings with Internet or WiFi
    number_of_computer_labs INT, -- Number of computer labs
    internet_provider VARCHAR(50), -- Internet provider (e.g. 'DigiNet', 'NextGen', 'Other')
    internet_speed_Mbps INT, -- Internet speed in Mbps (e.g. '50', '100', '250', '500', 'Unknown')
    connection_method VARCHAR(50), -- Internet connection method (‘Fiber’, ‘Wireless ISP’, ‘Other’)
    internet_stability VARCHAR(50), -- Describe Internet stability when all students are using devices
    power_stability INT, -- Number of times per week the school’s power goes out
    has_pta BOOLEAN, -- Does your school have a PTA or group to help with funding?
    has_technician_to_maintain_computers VARCHAR(50), -- Who can fix computers? (‘no’, ‘teacher’, ‘parent’, etc.)
    number_of_teachers INT, -- Number of teachers (full or part-time)
    number_of_full_time_IT_teachers INT, -- Number of full-time IT teachers
    number_of_teachers_that_also_teach_IT INT, -- Number of teachers who also teach IT
    number_of_teachers_that_have_laptops INT, -- How many of your teachers own laptops?
    primary_IT_teacher_name VARCHAR(50), -- Name of the main IT teacher
    primary_IT_teacher_phone VARCHAR(50), -- Phone number of the main IT teacher
    primary_IT_teacher_email VARCHAR(50), -- Email of the main IT teacher
    percentage_of_students_who_have_personal_computers INT, -- % of students who own computers
    access_to_computers INT, -- % of students with computer access outside school
    access_to_phones_for_school_work INT, -- % of students using phones for school work
    comments TEXT,
    admin_comments TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (school_id) REFERENCES school(id)
);

-- Table of information on school computer curriculum

CREATE TABLE curriculum (
    id INT PRIMARY KEY AUTO_INCREMENT,
    school_id INT,
    keyboarding BOOLEAN, -- Does your school teach general keyboarding?
    computer_literacy BOOLEAN, -- Does your school teach computer literacy?
    word BOOLEAN, -- Does your school teach word processing such as Microsoft Word, LibreOffice/OpenOffice Write or Google Docs?
    spread_sheet BOOLEAN, -- Does your school teach spreadsheets such as Excel, LibreOffice Calc, or Google Sheets?
    data_base BOOLEAN, -- Does your school teach about databases such as MS Access, LibreOffice Base, MySQL?
    slide_show BOOLEAN, -- Does your school teach slide show design such as: PowerPoint, LibreOffice Present, Google Slides?
    google_workspace BOOLEAN, -- Does your school also teach Google Workspace such as Google Docs, Sheets, etc.?
    software_suite VARCHAR(50), -- Which software suite does your school prefer? (‘Do not know’, ‘Microsoft Office’, ‘LibreOffice’, ‘OpenOffice’, ‘Google WorkSpace’, ‘Both Office and Workspace’)
    cloud_based_learning_tools BOOLEAN, -- Does your school use other learning websites such as typing, spelling, match, etc.?
    graphics_design BOOLEAN, -- Does your school teach graphics design tools such as Photoshop, Illustrator, Publisher, Canva, PosterMyWall or equivalent?
    graphics_animation BOOLEAN, -- Does your school teach graphics animation such as Blender or equivalent?
    graphics_cad_program BOOLEAN, -- Does your school teach graphics CAD tools such as AutoCad or equivalent?
    robotics BOOLEAN, -- Does your school teach robotics?
    code_dot_org BOOLEAN, -- Does your school use code.org?
    khan_accadamy BOOLEAN, -- Does your school use Khan Academy or similar online learning platforms?
    other_on_liine_local_education_tools VARCHAR(50), -- What other Website tools does your school use or teach?
    formal_curriculum VARCHAR(50), -- What formal computer related curriculum does your school use if any?
    local_curriculum VARCHAR(50), -- What locally generated computer related curriculum does your school use?
    rachel_server BOOLEAN, -- Does your school participate in the Rachel server project?
    other VARCHAR(250), -- What other computer related teaching tools do you use that were not mentioned above?
    comments TEXT,
    admin_comments TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (school_id) REFERENCES school(id)
);

-- Table to store lab configuration information

CREATE TABLE computerRoom (
    id INT PRIMARY KEY AUTO_INCREMENT,
    school_id INT,
    wired_for_lab BOOLEAN, -- Has your computer room been wired expressly for a computer lab?
    electrical BOOLEAN, -- Does your computer room have a dedicated electrical service panel in the computer room?
    electrical_ground BOOLEAN, -- Is there a quality ground wire connected to a ground rod?
    electrical_outlets INT, -- How many electrical outlets are in the computer room?
    air_condition INT, -- How many working air conditioners does your computer lab have?
    num_of_doors INT, -- How many doors does the computer room have?
    num_of_doors_secure INT, -- How many doors that have burglar bars does the computer room have?
    partition_security BOOLEAN, -- Are all 4 walls in your computer room concrete including the partition to the next room?
    ceiling_secure BOOLEAN, -- Is your computer lab ceiling constructed of concrete or steel with no open spaces and secured from a thief climbing over the partitioned wall?
    windows_secure BOOLEAN, -- Are all the windows removed and blocked, or have strong burglar bars installed?
    lighting BOOLEAN, -- Is the lighting in your computer room sufficient (even when all windows are blocked)?
    location BOOLEAN, -- Is your computer room located at the end of your building (i.e. with 3 outside walls)?
    location_foor BOOLEAN, -- Is your computer room located on the first floor?
    comments TEXT,
    admin_comments TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (school_id) REFERENCES school(id)
);

-- Table to store available and requested resources

CREATE TABLE resources (
    id INT PRIMARY KEY AUTO_INCREMENT,
    school_id INT,
    number_seats INT, -- How many student computer stations can your lab accommodate?
    desktop_working INT, -- How many working desktop computers does your school have?
    desktop_not_working INT, -- How many non-working desktops do you have?
    desktop_age INT, -- Estimate how old your desktops are in years?
    desktop_ownership INT, -- Approximately how long have you had your desktops in years?
    desktop_monitors INT, -- How many working monitors do you have?
    desktop_keyboards INT, -- How many working keyboards do you have?
    desktop_mice INT, -- How many working mice do you have?
    desktop_comments VARCHAR(250), -- Please enter any comments you may have about the reliability and usefulness of your desktop computers.
    chromebooks_working INT, -- How many working chromebooks do you have?
    chromebooks_broken INT, -- How many chromebooks broke within their first three years?
    chromebooks_lost INT, -- How many chromebooks were lost or stolen in their first two years?
    chromebooks_comments VARCHAR(250), -- Please enter any comments you may have about the reliability and usefulness of the chromebooks.
    tablets_working INT, -- How many working tablets do you have?
    tablets_broken INT, -- How many tablets broke within their first two years?
    tablets_lost INT, -- How many tablets were lost or stolen in their first two years?
    tablets_comments VARCHAR(250), -- Please enter any comments you may have about the reliability and usefulness of your tablets.
    old_computers_work VARCHAR(50), -- What do you plan to do with your old computers and tablets that still work?
    old_computers_broken VARCHAR(50), -- What do you plan to do with your broken computers and tablets?
    comments TEXT,
    admin_comments TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (school_id) REFERENCES school(id)
);

-- WE DON'T USE THIS TABLE YET - FOR SOME TIME IN FUTURE --
-- Table for managing staff laptops

CREATE TABLE laptop (
    id INT PRIMARY KEY AUTO_INCREMENT,
    staff_id INT,
    brand VARCHAR(50),
    model VARCHAR(50),
    issued_at DATE,
    eligible_for_renewal DATE,
    serial_number VARCHAR(50),
    quality VARCHAR(10), -- such as "good", "fair", "poor", "broken"
    comments TEXT,
    admin_comments TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (staff_id) REFERENCES staff(id)
);

-- Table to store pictures uploaded by schools

CREATE TABLE pictures (
    id INT PRIMARY KEY AUTO_INCREMENT,
    organization_id INT,
    category VARCHAR(50), -- such as 'school_building', 'lab', 'resources', 'students', 'events', 'district_map', 'management_map', 'other'
    description TEXT,
    file_url VARCHAR(50),
    file_type VARCHAR(50),
    approved_for_adver BOOLEAN, -- Set by the administrator
    comments TEXT,
    admin_comments TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (organization_id) REFERENCES organization(id)
);

