-- Belize School Survey & Grant Request Schema

/*
Process for reading MOE spreadsheet and getting it into the MySQL moe_school_info table

Convert MOE xlsx file into LibreCalc ODS file.

	Swap the columns so that Code is first then Name

	Replace any missing Codes with 0XXX1, 0XXX2, etc. - To be fixed later

	Remove all columns except in the following order: 
	    Code
	    Name    
	    Address 
	    Contact Person  
	    Telephone   -  These needs hand editing
	    Telephone_Alt1  
	    Telephone_Alt2  
	    Email   
	    Website 
	    Year Opened 
	    Longitude
	    Latitude
	    Area Administrative Locality  (this becomes 'district' in sql)
	    Type    
	    Ownership   
	    Sector  
	    School Administrator 1  
	    School Administrator 2

	Manually correct each cell especially phone numbers

	Fix cells that have a CR/LF imbedded in the cells value
		- You can do this by saving the sheet as a CSV with a ";" 
		  seperator and look for anomolies then fix in Calc.

	Change missing or bad longitude and lattitude values to 0
	
	For each tab do a SaveAs... with the name 
	        Dir-2025-Preschool
	        Dir-2025-Primary
	        Dir-2025-Secondary
        	Dir-2025-Tertiary
	        Dir-2025-Vocational
	        Dir-2025-AdultContinuing
	        Dir-2025-University
	        Dir-2025-Testing
	    Text CSV
	    Click Edit File Settings
	    Field delimiter ;
	    String delimiter "
	    Click Save cell content as shown
	    All else NOT clicked

	Load the following schema into phpmyadmin

	sudo mysql
	    USE Belize_Project;
	    WARNINGS;
	    LOAD DATA LOCAL INFILE '/home/doug/Downloads/Dir-2025-Preschool.csv'       INTO TABLE moe_school_info FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES;
	    LOAD DATA LOCAL INFILE '/home/doug/Downloads/Dir-2025-Primary.csv'         INTO TABLE moe_school_info FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES;
	    LOAD DATA LOCAL INFILE '/home/doug/Downloads/Dir-2025-Secondary.csv'       INTO TABLE moe_school_info FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES;
	    LOAD DATA LOCAL INFILE '/home/doug/Downloads/Dir-2025-Tertiary.csv'        INTO TABLE moe_school_info FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES;
	    LOAD DATA LOCAL INFILE '/home/doug/Downloads/Dir-2025-Vocational.csv'      INTO TABLE moe_school_info FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES;
	    LOAD DATA LOCAL INFILE '/home/doug/Downloads/Dir-2025-AdultContinuing.csv' INTO TABLE moe_school_info FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES;
	    LOAD DATA LOCAL INFILE '/home/doug/Downloads/Dir-2025-University.csv'      INTO TABLE moe_school_info FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES;
	    LOAD DATA LOCAL INFILE '/home/doug/Downloads/Dir-2025-Testing.csv'         INTO TABLE moe_school_info FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES;

	    Load the additional MOE spreadsheet info Giga Connected Schools and Code Dot Org schools

	    LOAD DATA LOCAL INFILE '/home/doug/Downloads/Dir-2025-CodeDotOrg.csv'      INTO TABLE moe_code_org FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES;
	    LOAD DATA LOCAL INFILE '/home/doug/Downloads/Dir-2025-GigaFromMOE.csv'     INTO TABLE moe_giga_connected FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES;    

	    -- TESTING: The Dir-2025-Testing.csv file has our testing mock schools in it - - - -

	    LOAD DATA LOCAL INFILE '/home/doug/Downloads/Dir-2025-Testing.csv'         INTO TABLE moe_school_info FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES;

	    WARNING! - Check each database table to ensure the data is correct. If a cell in the original spread sheet has a CR in rows will be screwed up

	    Set created_at which by inference sets updated_at

	    UPDATE `moe_school_info` SET created_at = CURRENT_TIMESTAMP;
	    UPDATE `moe_giga_connected` SET created_at = CURRENT_TIMESTAMP;
	    UPDATE `moe_code_org` SET created_at = CURRENT_TIMESTAMP;

	    -- SQL to prefill the school_info and school tables from the moe_school_info table

	    INSERT INTO school_info (code, name, address, contact_person, telephone, telephone_alt1, telephone_alt2, 
	        email, website, year_opened, longitude, latitude, district, locality, type, ownership, 
	        sector, administrator_1, administrator_2)
	    SELECT code, name, address, contact_person, telephone, telephone_alt1, telephone_alt2, 
	        email, website, year_opened, longitude, latitude, district, locality, type, ownership, 
	        sector, administrator_1, administrator_2 
	    FROM moe_school_info;

	    INSERT INTO school (code, name) SELECT code, name FROM moe_school_info;
*/

-- Drop old and Create the database if it doesn't exist

DROP DATABASE IF EXISTS belize_db;
CREATE DATABASE IF NOT EXISTS belize_db;
USE belize_db;

-- School information as proveded by the MOE - Giga connected schools

CREATE TABLE moe_giga_connected (
	code VARCHAR(10), -- MOE's code for this school
	name VARCHAR(80) PRIMARY KEY, -- This is the only unique column
	address VARCHAR(80), -- School's main address
	district ENUM ('Belize', 'Cayo', 'Corozal', 'Orange Walk', 'Stann Creek', 'Toledo'),
	contact_person VARCHAR(50), -- School's contact person (typically the principal)
	telephone VARCHAR(20), -- School's contact person's phone number
	email VARCHAR(50), -- School's email address
	contact_person_alt1 VARCHAR(50), -- School's contact person
	telephone_alt1 VARCHAR(20), -- School's contact person's phone number
	email_alt1 VARCHAR(50), -- School's email address
	email_alt2 VARCHAR(50), -- School's email address

	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- School information as proveded by the MOE - Code dot Org schools

CREATE TABLE moe_code_org (
	code VARCHAR(10), -- MOE's code for this school
	name VARCHAR(80) PRIMARY KEY, -- This is the only unique column
	contact_person VARCHAR(50), -- School's contact person
	email VARCHAR(50), -- School's email address
	email_alt1 VARCHAR(50), -- School's email address alternate 1
	telephone VARCHAR(20), -- School's contact person's phone number
	telephone_alt1 VARCHAR(20), -- Alternative school phone number
	telephone_alt2 VARCHAR(20), -- Alternative school phone number

	admin_comments TEXT, -- (Only seen by the administrator)    
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- School information as proveded by the MOE - Main School spreadsheet (with a bunch of hand edits)

CREATE TABLE moe_school_info (
	code VARCHAR(10) PRIMARY KEY, -- MOE's code for this school
	name VARCHAR(80), -- This is the only unique column
	address VARCHAR(80), -- School's main address
	contact_person VARCHAR(50), -- School's contact person (typically the principal)
	telephone VARCHAR(20), -- School's contact person's phone number
	telephone_alt1 VARCHAR(20), -- Alternative school phone number
	telephone_alt2 VARCHAR(20), -- Alternative school phone number
	email VARCHAR(50), -- School's email address
	website VARCHAR(50), -- Schools Web Site (optional)
	year_opened INT, -- Year the school opened
	longitude FLOAT, -- Longitude of school building
	latitude FLOAT, -- Latitude of school building

	        -- The following ENUMs are to flag and filter out bad data at SQL import time
	district ENUM ('Belize', 'Cayo', 'Corozal', 'Orange Walk', 'Stann Creek', 'Toledo'),
	locality ENUM ('Rural','Urban'),
	type ENUM ('Preschool', 'Primary', 'Secondary', 'Tertiary', 'Vocational', 'Adult and Continuing', 'University'),
	ownership VARCHAR(50), -- (Adventits Schools, Anglican Schools, Assemblies Of God Schools, Baptist, Catholic Schools,
	-- Government Schools, Mennonite Schools - Church Group. Mennonite Schools - H&B, Mennonite Schools - Spanish Lookout,
	-- Methodist Schools, Nazarene Schools, Presbyterian Schools, Private Schools, U.E.C.B Schools, Other)
	sector ENUM ('Government', 'Government Aided', 'Private','Specially Assisted'),
	administrator_1 VARCHAR(50),
	administrator_2 VARCHAR(50),
	
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table to store individual school

CREATE TABLE school (
	code VARCHAR(10) PRIMARY KEY, -- MOE's code for each school (username in WordPress)
	name VARCHAR(80), -- Name for this school
	password VARCHAR(255), -- Generated password/pin sent to specified email
	school_id INT,  -- An outside integer for use by WordPress to identify the particular school

	answered_filled_out BOOLEAN,  -- Yes, Have you filled out all the answers; or No, I did not know all the answers I will have someone else help me
	
	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- School information as originally proveded by the MOE and potentially updated by the school

CREATE TABLE school_info (
	code VARCHAR(10) PRIMARY KEY, -- MOE's code for each school
	name VARCHAR(80), -- This is the name of the school from the MOE and corrected (Same as in the "school" table)

	address VARCHAR(80), -- School's main address
	contact_person VARCHAR(50), -- School's contact person (from the MOE)
	telephone VARCHAR(20), -- School's phone number (from the MOE)
	telephone_alt1 VARCHAR(20), -- Alternate phone number (from the MOE)
	telephone_alt2 VARCHAR(20), -- Alternate phone number (from the MOE)
	email VARCHAR(50), -- Contact person's email address (from the MOE)
	website VARCHAR(50), -- Schools Web Site
	year_opened INT, -- Year the school opened
	longitude FLOAT, -- Longitude of school building
	latitude FLOAT, -- Latitude of school building
	district ENUM ('Belize', 'Cayo', 'Corozal', 'Orange Walk', 'Stann Creek', 'Toledo'),
	locality ENUM ('Rural','Urban'),
	type ENUM ('Preschool', 'Primary', 'Secondary', 'Tertiary', 'Vocational', 'Adult and Continuing', 'University'),
	ownership VARCHAR(50), -- (Adventits Schools, Anglican Schools, Assemblies Of God Schools, Baptist, Catholic Schools, 
	-- Government Schools, Mennonite Schools - Church Group. Mennonite Schools - H&B, Mennonite Schools - Spanish Lookout,
	-- Methodist Schools, Nazarene Schools, Presbyterian Schools, Private Schools, U.E.C.B Schools, Other)
	sector ENUM ('Government', 'Government Aided', 'Private','Specially Assisted'),

	administrator_1 VARCHAR(50), -- Alternate administrator 1 name (from MOE)
	administrator_2 VARCHAR(50), -- Alternate administrator 2 name (from MOE)
	email_1 VARCHAR(50), -- Alternate administrator 1 email address (not from MOE)
	email_2 VARCHAR(50), -- Alternate administrator 2 email address (not from MOE)

	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	verified_at DATETIME, -- Timestamp when the contact person / principal stated that this data was verified

	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table which stores the demographics of the schools

CREATE TABLE demographics (
	code VARCHAR(10) PRIMARY KEY, -- MOE's code for each school

	-- Principal section

	principals_name VARCHAR(50), -- Principal’s name
	principals_telephone VARCHAR(50), -- Principal’s phone number (WhatsApp preferred)
	principals_email VARCHAR(50), -- Principal’s email address
 
	-- Social media section

	facebook VARCHAR(100), -- Schools Facebook URL

	-- Teacher, student, building and classroom section

	number_of_students INT, -- Total number of students in your school
	number_of_teachers INT, -- Number of teachers (full or part-time)
	largest_class_size INT,  -- Number of students in your largest classroom
	number_of_buildings INT, -- Number of buildings at your school (not including storage buildings)
	number_of_classrooms INT, -- Number of classrooms in your school
	number_of_computer_labs INT,-- Number of computer labs / rooms in your school (0,1,2,3+)

	minutes_drive_from_road INT, -- How many minutes drive is your school from the main road?
	power_stability INT, -- Number of times per week the school’s power goes out (0, 1, 2, 3, 4, 5+)
	has_pta BOOLEAN, -- Does your school have a PTA or group to help with funding?

   -- Internet and Computer Section

	has_computers BOOLEAN, -- Does your school have computers, tablets, or laptops for the students to learn on
	has_internet BOOLEAN, -- Does your school have Internet access (yes, no)
	has_technician BOOLEAN, -- Does your school have a technician that can repair computers

	-- Ask the following if they have internet (if not then force fill the fields with NULL, 0, etc)

	internet_classrooms INT, -- Number of classrooms with Internet or WiFi
	internet_provider VARCHAR(50), -- Internet provider (e.g. 'DigiNet', 'NextGen', 'Other')
	internet_speed ENUM ('Don’t know', '10 to 49 Mbps', '50 to 99 Mbps', '100 to 249 Mbps', '250 to 500 Mbps'),  --  Internet speed in Mbps 
	internet_method VARCHAR(50), -- Internet connection method (‘Fiber’, ‘Cable’, ‘Wireless ISP’, ‘Hot Spot’, ‘Other’),
	internet_stability ENUM ('Very stable', 'Mostly OK','Comes in and out','Unstable'), -- Describe the Internet stability when all students are using the computer lab, laptops, and Chromebooks  –  

	-- General computer section

	teachers_with_laptops INT, -- How many of your teachers own laptops?
	full_time_IT_teachers INT, -- Number of full-time IT teachers
	teachers_that_also_teach_IT INT, -- Number of teachers who also teach IT

	-- If they have an IT teacher of either IT type is > 0 then ask the following. If the have an IT teacher then word this question as:  “... IT teacher …” else word it as “... main teacher that teaches IT..”.

	main_IT_teacher_name VARCHAR(50), -- Name of the main IT teacher
	main_IT_teacher_phone VARCHAR(50), -- Phone number of the main IT teacher
	main_IT_teacher_email VARCHAR(50), -- Email of the main IT teacher

	-- For the percentages below make a dropdown to fill in the INT (less than 20%, 20% - 40%, 40% - 60%, 60% - 80%, 80%+)

	students_own_computers INT, -- Estimate of the percentage of your students who own computers
	students_access_computers INT, -- Estimate of the percentage of your  students who have access to computers outside of school
	students_phones  INT, -- Estimate of the percentage of your students who use phones for their school work

	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Currently taught school computer curriculum

CREATE TABLE curriculum (
	code VARCHAR(10) PRIMARY KEY, -- MOE's code for each school

	keyboarding BOOLEAN, -- Does your school teach general keyboarding?
	computer_literacy BOOLEAN, -- Does your school teach computer literacy?
	word BOOLEAN, -- Does your school teach word processing such as Microsoft Word, LibreOffice/OpenOffice Write or Google Docs?
	spread_sheet BOOLEAN, -- Does your school teach spreadsheets such as Excel, LibreOffice Calc, or Google Sheets?
	data_base BOOLEAN, -- Does your school teach about databases such as MS Access, LibreOffice Base, MySQL?
	slide_show BOOLEAN, -- Does your school teach slide show design such as: PowerPoint, LibreOffice Present, Google Slides?
	google_workspace BOOLEAN, -- Does your school also teach Google Workspace such as Google Docs, Sheets, etc.?
	software_suite VARCHAR(50), -- Which software suite does your school prefer? (‘Do not know’, ‘Microsoft Office’, ‘LibreOffice’, ‘OpenOffice’, ‘Google WorkSpace’, ‘Both Office and Workspace’,'’No preference’)
	cloud_based_learning_tools BOOLEAN, -- Does your school use other learning websites such as typing, spelling, math, etc.?
	graphics_design BOOLEAN, -- Does your school teach graphics design tools such as Photoshop, Illustrator, Publisher, Canva, PosterMyWall or equivalent?
	graphics_animation BOOLEAN, -- Does your school teach graphics animation such as Blender or equivalent?
	graphics_cad_program BOOLEAN, -- Does your school teach graphics CAD tools such as AutoCad or equivalent?
	robotics BOOLEAN, -- Does your school teach robotics?
	code_dot_org BOOLEAN, -- Does your school use code.org?
	khan_accadamy BOOLEAN, -- Does your school use Khan Academy or similar online learning platforms?
	edpm BOOLEAN, -- Does your school teach EDPM?
	other_online_local_education_tools VARCHAR(50), -- What other Website tools does your school use or teach?
	formal_curriculum VARCHAR(50), -- What formal computer related curriculum does your school use if any?
	local_curriculum VARCHAR(50), -- What locally generated computer related curriculum does your school use?
	rachel_server BOOLEAN, -- Does your school participate in the Rachel server project?
	other VARCHAR(250), -- What other computer related teaching tools do you use that were not mentioned above?
	
	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Future computer room (if a new lab was donated)

-- "If your school was granted enough computers for your first or additional computer lab, what would you teach there?"

CREATE TABLE future_curriculum (
	code VARCHAR(10) PRIMARY KEY, -- MOE's code for each school
	
	keyboarding BOOLEAN,-- Would your school teach general keyboarding?
	computer_literacy BOOLEAN,-- Would your school  teach computer literacy?
	word BOOLEAN, -- Would your school teach word processing, such as Microsoft Word, LibreOffice/OpenOffice Write, or Google Docs?
	spread_sheet BOOLEAN, -- Would your school teach spreadsheets such as Excel, LibreOffice Calc, or Google Sheets?
	data_base BOOLEAN, -- Would your school teach about databases such as MS Access, LibreOffice Base, MySQL?
	slide_show BOOLEAN, -- Would your school teach slide show design, such as: PowerPoint, LibreOffice Present, Google Slides?
	google_workspace BOOLEAN, -- Would your school also teach Google Workspace, such as Google Docs, Sheets, etc.?
	software_suite VARCHAR(50),  -- Which software suite would your school prefer?  (‘Do not know’,’Microsoft Office’, ‘LibreOffice’, ‘OpenOffice’, ‘Google WorkSpace’,’Both Office and Workspace’, ’No preference’),
	cloud_based_learning_tools BOOLEAN, -- Would your school use other learning websites such as typing, spelling, math, etc.?
	graphics_design BOOLEAN,  -- Would your school teach graphics design tools such as Photoshop, Illustrator, Publisher, Canva, PosterMyWall, or equivalent?
	graphics_animation BOOLEAN, -- Would your school teach graphics animation such as Blender, SketchUP, or equivalent?
	graphics_cad_program BOOLEAN, -- Would your school teach graphics CAD tools such as AutoCad or equivalent?
	robotics BOOLEAN, -- Would your school teach robotics?
	code_dot_org BOOLEAN, -- Would your school use code.org
	khan_accadamy BOOLEAN, -- Would your school use Khan Academy or similar online learning platforms?
	edpm BOOLEAN, -- Would your school use EDPM?
	other_online_local_education_tools VARCHAR(50), -- What other Website tools would your school use or teach?
	formal_curriculum VARCHAR(50), -- What formal computer-related curriculum would your school use, if any? 
	local_curriculum VARCHAR(50),  -- What locally generated computer-related curriculum would your school use  -- ('Made by a local teacher’, ‘Made by our management’, ‘From an online book’, ‘We do not have a locally generated curriculum’,’Our teachers create their own’,’other)
	rachel_server BOOLEAN, -- Would your school participate in the Rachel server project?
	other VARCHAR(250), -- What other computer-related teaching tools would your school  use that were not mentioned above?
	
	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Current computer lab configuration table

	--  NOTE: THE FOLLOWING QUESTIONS ONLY ASKED IF THEY HAVE A COMPUTER ROOM; demographics.number_of_computer_labs > 0

CREATE TABLE computerRoom (
	code VARCHAR(10) PRIMARY KEY, -- MOE's code for each school 

	wired_for_lab BOOLEAN, -- Has your computer room been wired expressly for a computer lab?
	electrical BOOLEAN, -- Does your computer room have a dedicated electrical service panel in the computer room?
	electrical_ground BOOLEAN, -- Is there a quality ground wire connected to a ground rod?
	electrical_outlets INT, -- How many electrical outlets are in the computer room?
	air_condition INT, -- How many working air conditioners does your computer lab have?
	doors_secure BOOLEAN, --  Do all the doors in your computer room have burglar bars?
	partition_security BOOLEAN, -- Are all 4 walls in your computer room concrete including the partition to the next room?
	ceiling_secure BOOLEAN, -- Is your computer lab ceiling constructed of concrete or steel with no open spaces and secured from a thief climbing over the partitioned wall?
	windows_secure BOOLEAN, -- Are all the windows removed and blocked, or have strong burglar bars installed?
	lighting BOOLEAN, -- Is the lighting in your computer room sufficient (even when all windows are blocked)?
	location BOOLEAN, -- Is your computer room located at the end of your building (i.e. with 3 outside walls)?
	location_floor BOOLEAN, -- Is your computer room located on the first floor?

	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

	-- Future Computer Room Questions

	-- Ask these questions if they need to create a new computer room
/*
	A proper computer room requires good quality lighting, wiring, plugs, ground wire, grounding rod and quality service panel. 
	It also requires at least one working A/C units, burglar bars on doors and windows and secure walls and ceiling. 
	The following questions are designed to assess the appropriateness of your future computer lab. There may be some funding
	to help in upgrading your room.
*/

CREATE TABLE future_computerRoom (
	code VARCHAR(10) PRIMARY KEY, -- MOE's code for each school

	number_seats INT, -- How many student computer stations can your future computer room accommodate?
	wired_for_lab BOOLEAN, -- Is your future computer room wired for a computer lab with an Ethernet switch? 
	electrical BOOLEAN, -- Does your future computer room have a dedicated electrical service panel or one close by?
	electrical_ground  BOOLEAN, -- Is there a quality ground wire in your service panel connected to a ground rod?
	electrical_outlets  INT, -- How many electrical outlets are in the computer room?
	air_condition  INT, -- How many working air conditioners does your computer lab have?
	doors_secure BOOLEAN,  -- Do all the doors in your future computer room have burglar bars?
	partition_security BOOLEAN, -- Are all 4 walls in your future computer room concrete, including the partition to the next room?
	ceiling_secure BOOLEAN, -- Is your future  computer lab ceiling constructed of concrete or steel with no open spaces and secured from a thief climbing over the partitioned wall?
	windows_secure BOOLEAN, -- Are all the windows removed and blocked, or have strong burglar bars installed?
	lighting BOOLEAN, -- Is the lighting in your future computer room sufficient (even when all windows are blocked)?
	location BOOLEAN, -- Is your future computer room located at the end of your building (i.e. with 3 outside walls)?
	location_floor BOOLEAN, -- Is your future computer room located on the first floor?
	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table to store available resources

CREATE TABLE resources (
	code VARCHAR(10) PRIMARY KEY, -- MOE's code for each school

	-- Ask the following if resources.number_of_computer_labs > 0

	principals_computer BOOLEAN, -- Does the principal have a non-rented good working computer? 
	number_seats INT, -- How many student computer stations can your lab accommodate?
	desktop_working INT, --  How many working desktop computers does your main school lab / room have?   
	desktop_not_working INT, --  How many non-working desktops do you have?  Some people have reported a non-working desktop when the problem is the keyboard or mouse.

	-- has been that the monitor, keyboard or mouse is what is actually broken. Please report here the actual desktop.

	desktop_age INT, -- Estimate how old your desktops are in years?
	desktop_ownership INT, -- Approximately how long have you had your desktops in years?

	desktop_monitors INT, -- How many working monitors does your main school lab / room have?
	desktop_keyboards INT, -- How many working keyboards does your main school lab / room have?
	desktop_mice INT, -- How many working mice does your main school lab / room have?
	desktop_comments VARCHAR(250), -- Please enter any comments you may have about the reliability and usefulness of your desktop computers.

	-- End of if resources.number_of_computer_labs > 0

	chromebooks_working INT, -- How many working chromebooks does your school have?
	chromebooks_broken INT, -- How many chromebooks broke within their first two years?
	chromebooks_lost INT, -- How many chromebooks were lost or stolen in their first two years?
	chromebooks_comments VARCHAR(250), -- Please enter any comments you may have about the reliability and usefulness of the chromebooks.

	tablets_working INT, -- How many working tablets does your school have?
	tablets_broken INT, -- How many tablets broke within their first two years?
	tablets_lost INT, -- How many tablets were lost or stolen in their first two years?
	tablets_comments VARCHAR(250), -- Please enter any comments you may have about the reliability and usefulness of your tablets.

	old_computers_work VARCHAR(50), -- What do you plan to do with your old computers and tablets that still work?
	old_computers_broken VARCHAR(50), -- What do you plan to do with your broken computers and tablets?

	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table to store pictures uploaded by schools

CREATE TABLE pictures (
	id INT PRIMARY KEY AUTO_INCREMENT,
	code VARCHAR(10), -- MOE's code for each school

	category VARCHAR(50), -- such as 'school_building', 'lab', 'resources', 'students', 'events', 'district_map', 'management_map', 'other'
	description TEXT,
	file_url VARCHAR(50),
	file_type VARCHAR(50),
	approved_for_adver BOOLEAN, -- Set by the administrator

	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table to store current grant status - filled in by administrator

CREATE TABLE school_grant_status (
	id INT PRIMARY KEY AUTO_INCREMENT,
	code VARCHAR(10), -- MOE's code for each school
	
	status ENUM ('more info needed', 'pending_phone_call', 'pending site visit', 'pending final approval', 'approved for advertising', 'granted', 'pending shipment', 'pending installation', 'installed'),
	number_of_computers INT,
	type_of_computers VARCHAR(50),
	number_of_ethernet_switches INT,

	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table to specify the edit fields for a given table name.

CREATE TABLE form_fields (
	id INT(11) NOT NULL AUTO_INCREMENT,

	table_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	field_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	prompt VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	type VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	valuelist TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	field_width INT(11) DEFAULT NULL,
	required TINYINT(1) DEFAULT NULL,
	visible TINYINT(1) DEFAULT NULL,
	PRIMARY KEY (id)
);

-- Table to hold the correction requests -- Admin can go in and then correct

CREATE TABLE contact_corrections (
	id INT PRIMARY KEY AUTO_INCREMENT,
	code VARCHAR(10), -- MOE's code for each school
	school_name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	district ENUM ('Belize', 'Cayo', 'Corozal', 'Orange Walk', 'Stann Creek', 'Toledo'),
	type ENUM ('Preschool', 'Primary', 'Secondary', 'Tertiary', 'Vocational', 'Adult and Continuing', 'University'),

	contact_email VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	contact_name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	contact_phone VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	status ENUM('pending', 'approved', 'rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'pending',
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table to hold title, subtitle, etc. for a edit information on question pages

CREATE TABLE titles (
	id INT(11) NOT NULL AUTO_INCREMENT,

	table_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	title TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	subtitle TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	instructions TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	footer TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	PRIMARY KEY (id)
);

/*
-- Table to store information about the MOE district manager

CREATE TABLE district (
	name VARCHAR(80) PRIMARY KEY,  -- name of district ('Belize', 'Cayo', 'Corozal', 'Orange Walk', 'Stann Creek', 'Toledo')

	person VARCHAR(50), -- manager name
	phone VARCHAR(20), -- manager phone
	email VARCHAR(50),
	website VARCHAR(100),
	facebook VARCHAR(100),
	password VARCHAR(50),  -- password need to add/edit this information. 'name' is the username

	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table to store information about the ownership (ie. Nazareene, Baptist, etc.)

CREATE TABLE management (
	name VARCHAR(80) PRIMARY KEY,  -- name of management

	person VARCHAR(50),
	phone VARCHAR(20),
	email VARCHAR(50),
	website VARCHAR(100),
	facebook VARCHAR(100),
	password VARCHAR(50),  -- password need to add/edit this information. 'name' is the username

	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table to store staff details (teachers, managers, district representative)

CREATE TABLE school_staff (
	id INT PRIMARY KEY AUTO_INCREMENT,
	code VARCHAR(10) PRIMARY KEY, -- MOE's code for each school

	person VARCHAR(50), -- name of staff person
	phone VARCHAR(20),
	email VARCHAR(50),
	website VARCHAR(100),
	facebook VARCHAR(100),
	password VARCHAR(50),  -- password need to add/edit this information. 'name' is the username
	role VARCHAR(50),
	experience TEXT,
	resume_file_path VARCHAR(255),

	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	approved_for_advertising BOOLEAN,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- WE DON'T USE THIS TABLE YET - FOR SOME TIME IN FUTURE --
-- Table for managing staff laptops

CREATE TABLE school_staff_laptop (
	id INT PRIMARY KEY AUTO_INCREMENT,
	code VARCHAR(10) PRIMARY KEY, -- MOE's code for each school

	brand VARCHAR(50),
	model VARCHAR(50),
	issued_at DATE,
	eligible_for_renewal DATE,
	serial_number VARCHAR(50),
	quality VARCHAR(10), -- such as "good", "fair", "poor", "broken"

	comments TEXT,  -- Do you have any comments about the above information
	admin_comments TEXT, -- (Only seen by the administrator)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
*/