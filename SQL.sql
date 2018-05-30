CREATE TABLE IF NOT EXISTS SPONSOR
(
    Name				VARCHAR(150)		NOT NULL,
    SponsorType			VARCHAR(150)		NOT NULL,
    SponsorID			INT					NOT NULL
);
ALTER TABLE SPONSOR
	ADD PRIMARY KEY IF NOT EXISTS (SponsorID);


CREATE TABLE IF NOT EXISTS SPONSOR_CONTACT
(
    SponsorID			INT					NOT NULL,
    Phone				CHAR(15)			NOT NULL      
);
ALTER TABLE SPONSOR_CONTACT
	ADD PRIMARY KEY IF NOT EXISTS (SponsorID, Phone),
	ADD CONSTRAINT fk_contact_sponsor FOREIGN KEY IF NOT EXISTS (SponsorID) REFERENCES SPONSOR(SponsorID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS SPONSOR_EMAIL
(
    SponsorID			INT					NOT NULL,
    Email				CHAR(150)		NOT NULL     
);
ALTER TABLE SPONSOR_EMAIL
	ADD PRIMARY KEY IF NOT EXISTS (SponsorID, Email),
	ADD CONSTRAINT fk_email_sponsor FOREIGN KEY IF NOT EXISTS (SponsorID) REFERENCES SPONSOR(SponsorID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS LAB
(
	Room				INT					NOT NULL,
	Building			CHAR(15)			NOT NULL,
	RoomName			VARCHAR(150)	
);
ALTER TABLE LAB
	ADD PRIMARY KEY IF NOT EXISTS (Room, Building);


CREATE TABLE IF NOT EXISTS STUDENT
(
	StudentID			INT,
	StudentType			VARCHAR(150),
	Name 				VARCHAR(150)		NOT NULL,
	Email 				CHAR(150),
	Phone 				CHAR(15)
);
ALTER TABLE STUDENT
	ADD PRIMARY KEY IF NOT EXISTS (StudentID);


CREATE TABLE IF NOT EXISTS SUBJECT
(
	SubjectID 			INT					NOT NULL,
	SubjectName			VARCHAR(150)		NOT NULL,
	SubjectLeader		VARCHAR(150)		NOT NULL
);
ALTER TABLE SUBJECT
	ADD PRIMARY KEY IF NOT EXISTS (SubjectID);


CREATE TABLE IF NOT EXISTS MANAGE
(
    StudentID			INT					NOT NULL,
    Room				INT					NOT NULL,
    Building			CHAR(15)			NOT NULL,
    DutyTime			VARCHAR(255)		NOT NULL,
    BackUpPassword		VARCHAR(150)   
);
ALTER TABLE MANAGE
	ADD PRIMARY KEY IF NOT EXISTS (StudentID, Room, Building),
	ADD CONSTRAINT fk_manage_lab FOREIGN KEY IF NOT EXISTS (Room, Building) REFERENCES LAB(Room, Building) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE IF NOT EXISTS FUNDING
(
    SponsorID 			INT					NOT NULL,
    Room				INT					NOT NULL,
    Building			CHAR(15)			NOT NULL
);
ALTER TABLE FUNDING 
	ADD PRIMARY KEY IF NOT EXISTS (SponsorID, Room, Building),
	ADD CONSTRAINT fk_funding_lab FOREIGN KEY IF NOT EXISTS (Room, Building) REFERENCES LAB(Room, Building) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS PARTICIPATE_IN
(
	StudentID			INT					NOT NULL,
	Room				INT					NOT NULL,
    Building			CHAR(15)			NOT NULL   			
);
ALTER TABLE PARTICIPATE_IN
	ADD PRIMARY KEY IF NOT EXISTS (StudentID, Room, Building),
	ADD CONSTRAINT fk_particapatein_lab FOREIGN KEY IF NOT EXISTS (Room, Building) REFERENCES LAB(Room, Building) ON DELETE CASCADE ON UPDATE CASCADE,
	ADD CONSTRAINT fk_student_participatein FOREIGN KEY IF NOT EXISTS (StudentID) REFERENCES STUDENT(StudentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS GUEST
(
	VisitorID			INT 				NOT NULL
);
ALTER TABLE GUEST
	ADD PRIMARY KEY IF NOT EXISTS (VisitorID);


CREATE TABLE IF NOT EXISTS WANDERER
(	
	IdentityCard		INT 				NOT NULL,
    Name				VARCHAR(150)		NOT NULL,
    Phone				CHAR(15),
    Email				CHAR(150),
    VisitorID			INT					NOT NULL     
);
ALTER TABLE WANDERER
	ADD PRIMARY KEY IF NOT EXISTS (IdentityCard),
	ADD CONSTRAINT	fk_wanderer_guest FOREIGN KEY IF NOT EXISTS (VisitorID) REFERENCES GUEST(VisitorID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS VISIT
(
	VisitorID			INT					NOT NULL,
	Room 				INT					NOT NULL,
	Building 			CHAR(15)			NOT NULL,
	FeedbackID			INT,
	Reason				VARCHAR(200),
	Date 				DATETIME			NOT NULL,
	Duration			INT					NOT NULL
);
ALTER TABLE VISIT
	ADD PRIMARY KEY IF NOT EXISTS (VisitorID, Room, Building),
	ADD CONSTRAINT fk_visit_guest FOREIGN KEY IF NOT EXISTS (VisitorID) REFERENCES GUEST(VisitorID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS STU_VISITOR
(
	StudentID			INT 				NOT NULL,
	VisitorID			INT					NOT NULL
);
ALTER TABLE STU_VISITOR
	ADD PRIMARY KEY IF NOT EXISTS (StudentID),
	ADD CONSTRAINT fk_visitor_guest FOREIGN KEY IF NOT EXISTS (VisitorID) REFERENCES GUEST(VisitorID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS LAB_USING_STUDENT
(
	StudentID			INT					NOT NULL,
	RFID				CHAR(150) 			NOT NULL,
	Status				VARCHAR(150)
);
ALTER TABLE LAB_USING_STUDENT
	ADD PRIMARY KEY IF NOT EXISTS (StudentID),
	ADD CONSTRAINT fk_labusingstudent_ FOREIGN KEY IF NOT EXISTS (StudentID) REFERENCES STUDENT(StudentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS LAB_LEARNING_STUDENT
(
	StudentID			INT					NOT NULL
);
ALTER TABLE LAB_LEARNING_STUDENT
	ADD PRIMARY KEY IF NOT EXISTS (StudentID),
	ADD CONSTRAINT fk_lablearningstudent_labusingstudent FOREIGN KEY IF NOT EXISTS (StudentID) REFERENCES LAB_USING_STUDENT(StudentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS LAB_RESEARCH_STUDENT
(
	StudentID			INT					NOT NULL,
	ResearchTopic		VARCHAR(255) 		NOT NULL
);
ALTER TABLE LAB_RESEARCH_STUDENT
	ADD PRIMARY KEY IF NOT EXISTS (StudentID),
	ADD CONSTRAINT fk_labreseachstudent_labusingstudent FOREIGN KEY IF NOT EXISTS (StudentID) REFERENCES LAB_USING_STUDENT(StudentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS THESIS_STUDENT
(
	StudentID			INT					NOT NULL,
	ThesisTopic			VARCHAR(255)		NOT NULL
);
ALTER TABLE THESIS_STUDENT
	ADD PRIMARY KEY IF NOT EXISTS (StudentID),
	ADD CONSTRAINT fk_thesisstudent_labusingstudent FOREIGN KEY IF NOT EXISTS (StudentID) REFERENCES LAB_USING_STUDENT(StudentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS THESIS_TEACHER
(
	StudentID			INT					NOT NULL,
	TeacherName 		VARCHAR(150) 		NOT NULL
);
ALTER TABLE THESIS_TEACHER
	ADD PRIMARY KEY IF NOT EXISTS (StudentID, TeacherName),
	ADD CONSTRAINT fk_thesisteacher_thesisstudent FOREIGN KEY IF NOT EXISTS (StudentID) REFERENCES THESIS_STUDENT(StudentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS STUDY
(
	StudentID			INT					NOT NULL,
	SubjectID			INT					NOT NULL,
	SubjectName			VARCHAR(200)		NOT NULL,
	PeriodID			CHAR(15)			NOT NULL,
	TeacherName			VARCHAR(150)		NOT NULL,
	TeacherID 			INT					NOT NULL,
	Room 				INT					NOT NULL,
	Building 			CHAR(15)			NOT NULL
);
ALTER TABLE STUDY
	ADD PRIMARY KEY IF NOT EXISTS (StudentID, SubjectID),
	ADD CONSTRAINT fk_study_lablearningstudent FOREIGN KEY IF NOT EXISTS (StudentID) REFERENCES LAB_LEARNING_STUDENT(StudentID) ON DELETE CASCADE ON UPDATE CASCADE,
	ADD CONSTRAINT fk_study_lab FOREIGN KEY IF NOT EXISTS (Room, Building) REFERENCES LAB(Room, Building) ON DELETE CASCADE ON UPDATE CASCADE,
	ADD CONSTRAINT fk_study_subject FOREIGN KEY IF NOT EXISTS (SubjectID) REFERENCES SUBJECT(SubjectID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS SCHEDULE
(
	StudentID			INT					NOT NULL,
	SubjectID			INT					NOT NULL,
	TeachingTime		VARCHAR(255)		NOT NULL,
	Room 				INT					NOT NULL,
	Building 			CHAR(15)			NOT NULL
);
ALTER TABLE SCHEDULE
	ADD PRIMARY KEY IF NOT EXISTS (StudentID, SubjectID, TeachingTime),
	ADD CONSTRAINT fk_schedule_lab FOREIGN KEY IF NOT EXISTS (Room, Building) REFERENCES LAB(Room, Building) ON DELETE CASCADE ON UPDATE CASCADE,
	ADD CONSTRAINT fk_schedule_study FOREIGN KEY IF NOT EXISTS (StudentID, SubjectID) REFERENCES STUDY(StudentID, SubjectID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS EQUIPMENT
(
	EquipmentID			INT 				NOT NULL,
	Name 				VARCHAR(150)		NOT NULL,
	Room 				INT					NOT NULL,
	Building 			CHAR(15)			NOT NULL
);
ALTER TABLE EQUIPMENT
	ADD PRIMARY KEY IF NOT EXISTS (EquipmentID),
	ADD CONSTRAINT fk_equipment_lab FOREIGN KEY IF NOT EXISTS (Room, Building) REFERENCES LAB(Room, Building) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS ACCOUNT
(
	StudentID			INT					NOT NULL,
	Username			CHAR(200)			NOT NULL,
	EquipmentID			INT 				NOT NULL,
	Password 			CHAR(200)			NOT NULL

);
ALTER TABLE ACCOUNT
	ADD PRIMARY KEY IF NOT EXISTS (StudentID, Username, EquipmentID),
	ADD CONSTRAINT fk_account_student FOREIGN KEY IF NOT EXISTS (StudentID) REFERENCES LAB_USING_STUDENT(StudentID) ON DELETE CASCADE ON UPDATE CASCADE,
	ADD CONSTRAINT fk_account_equipment FOREIGN KEY IF NOT EXISTS (EquipmentID) REFERENCES EQUIPMENT(EquipmentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS APPLICATION
(
	StudentID			INT					NOT NULL,
	Username			CHAR(200)			NOT NULL,
	AppName				VARCHAR(200)		NOT NULL
);
ALTER TABLE APPLICATION
	ADD PRIMARY KEY IF NOT EXISTS (StudentID, Username, AppName),
	ADD CONSTRAINT fk_application_account FOREIGN KEY IF NOT EXISTS (StudentID, Username) REFERENCES ACCOUNT(StudentID, Username) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE IF NOT EXISTS FOLDER
(
	StudentID			INT					NOT NULL,
	Username			CHAR(200)			NOT NULL,
	FolderName			VARCHAR(200)		NOT NULL,
	FolderLocation		VARCHAR(255)		NOT NULL
);
ALTER TABLE FOLDER
	ADD PRIMARY KEY IF NOT EXISTS (StudentID, Username, FolderName, FolderLocation),
	ADD CONSTRAINT fk_folder_account FOREIGN KEY IF NOT EXISTS (StudentID, Username) REFERENCES ACCOUNT(StudentID, Username) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS LAB_TEACHER
(
	Room 				INT					NOT NULL,
	Building 			CHAR(15)			NOT NULL,
	TeacherID 			INT					NOT NULL,
	TeacherName 		VARCHAR(150) 		NOT NULL,
	Contact 			VARCHAR(200)		NOT NULL
);
ALTER TABLE LAB_TEACHER
	ADD PRIMARY KEY IF NOT EXISTS (Room, Building, TeacherID, TeacherName, Contact),
	ADD CONSTRAINT fk_labteacher_lab FOREIGN KEY IF NOT EXISTS (Room, Building) REFERENCES LAB(Room, Building) ON DELETE
 CASCADE;


CREATE TABLE IF NOT EXISTS DOCUMENT
(
	EquipmentID			INT					NOT NULL,
	Author				VARCHAR(150)
);
ALTER TABLE DOCUMENT
	ADD PRIMARY KEY IF NOT EXISTS (EquipmentID),
	ADD CONSTRAINT fk_document_equipment FOREIGN KEY IF NOT EXISTS (EquipmentID) REFERENCES EQUIPMENT(EquipmentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS SENSOR
(
	EquipmentID			INT					NOT NULL,
	SensorType 			VARCHAR(150)		NOT NULL
);
ALTER TABLE SENSOR
	ADD PRIMARY KEY IF NOT EXISTS (EquipmentID),
	ADD CONSTRAINT fk_sensor_equipment FOREIGN KEY IF NOT EXISTS (EquipmentID) REFERENCES EQUIPMENT(EquipmentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS PC
(
	EquipmentID			INT 				NOT NULL,
	Type 				VARCHAR(150)		NOT NULL,
	ADMINUsername		CHAR(200)			NOT NULL,
	ADMINPassword 		CHAR(200)			NOT NULL		
);
ALTER TABLE PC
	ADD PRIMARY KEY IF NOT EXISTS (EquipmentID),
	ADD CONSTRAINT fk_pc_equipment FOREIGN KEY IF NOT EXISTS (EquipmentID) REFERENCES EQUIPMENT(EquipmentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS KIT
(
	EquipmentID			INT 				NOT NULL,
	Type 				VARCHAR(150)		NOT NULL,
	Note				VARCHAR(150)
);
ALTER TABLE	KIT
	ADD PRIMARY KEY IF NOT EXISTS (EquipmentID),
	ADD CONSTRAINT fk_kit_equipment FOREIGN KEY IF NOT EXISTS (EquipmentID) REFERENCES EQUIPMENT(EquipmentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS KIT_ADDON
(
	EquipmentID			INT 				NOT NULL,
	AddonName			VARCHAR(200)		NOT NULL
);
ALTER TABLE KIT_ADDON
	ADD PRIMARY KEY IF NOT EXISTS (EquipmentID, AddonName),
	ADD CONSTRAINT fk_kitaddon_kit FOREIGN KEY IF NOT EXISTS (EquipmentID) REFERENCES KIT(EquipmentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS BELONGS_TO
(
	Room				INT					NOT NULL,
    Building			CHAR(15)			NOT NULL,
    SubjectID 			INT					NOT NULL
);
ALTER TABLE BELONGS_TO
	ADD PRIMARY KEY IF NOT EXISTS (Room, Building, SubjectID),
	ADD CONSTRAINT fk_belongsto_subject FOREIGN KEY IF NOT EXISTS (SubjectID) REFERENCES SUBJECT(SubjectID) ON DELETE CASCADE ON UPDATE CASCADE,
	ADD CONSTRAINT fk_belongsto_lab FOREIGN KEY IF NOT EXISTS (Room, Building) REFERENCES LAB(Room, Building) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS BORROW
(
	StudentID			INT 				NOT NULL,
	EquipmentID			INT 				NOT NULL,
	BorrowDate			DATETIME 			NOT NULL,
	ReturnDate 			DATETIME 			NOT NULL
);
ALTER TABLE BORROW
	ADD PRIMARY KEY IF NOT EXISTS (StudentID, EquipmentID),
	ADD CONSTRAINT fk_borrow_labusingstudent FOREIGN KEY IF NOT EXISTS (StudentID) REFERENCES LAB_USING_STUDENT(StudentID) ON DELETE CASCADE ON UPDATE CASCADE,
	ADD CONSTRAINT fk_borrow_equipment FOREIGN KEY IF NOT EXISTS (EquipmentID) REFERENCES EQUIPMENT(EquipmentID) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS BORROW_TO_HOME 
(
	StudentID			INT 				NOT NULL,
	EquipmentID			INT 				NOT NULL,
	BorrowDate			DATETIME 			NOT NULL,
	ReturnDate 			DATETIME 			NOT NULL,
	TeacherID 			INT					NOT NULL,
	TeacherName			VARCHAR(150)		NOT NULL
);
ALTER TABLE BORROW_TO_HOME
	ADD PRIMARY KEY IF NOT EXISTS (StudentID, EquipmentID),
	ADD CONSTRAINT fk_borrowtohome_labusingstudent FOREIGN KEY IF NOT EXISTS (StudentID) REFERENCES LAB_USING_STUDENT(StudentID) ON DELETE CASCADE ON UPDATE CASCADE,
	ADD CONSTRAINT fk_borrowtohome_equipment FOREIGN KEY IF NOT EXISTS (EquipmentID) REFERENCES EQUIPMENT(EquipmentID) ON DELETE CASCADE ON UPDATE CASCADE;


SAVEPOINT save_finish_table;

CREATE OR REPLACE VIEW student_on_guard_view
 AS SELECT * FROM STUDENT;

CREATE OR REPLACE VIEW student_on_borrow
 AS SELECT * FROM BORROW_TO_HOME;

SAVEPOINT save_finish_view;

DROP PROCEDURE IF EXISTS sponsor_select;
DELIMITER //
CREATE PROCEDURE sponsor_select(
	IN sponsorID_in					int(11),
	OUT name_out 					varchar(150),
	OUT sponsortype_out 			varchar(150),
	OUT sponsorID_out				int(11),
	OUT phone_out					char(15),
	OUT email_out					char(150)
)
BEGIN
  SELECT Name, SponsorType, SponsorID
  INTO name_out, sponsortype_out, sponsorID_out
  FROM SPONSOR
  WHERE SponsorID = sponsorID_in;

  SELECT Phone
  INTO phone_out
  FROM  SPONSOR_CONTACT
  WHERE SponsorID = sponsorID_in;

  SELECT Email
  INTO email_out
  FROM SPONSOR_EMAIL
  WHERE SponsorID = sponsorID_in;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sponsor_insert;
DELIMITER //
CREATE PROCEDURE sponsor_insert(
	IN name_in 					varchar(150),
	IN sponsortype_in 			varchar(150),
	IN sponsorID_in				int(11),
	IN phone_in					char(15),
	IN email_in					char(150))
BEGIN
    INSERT INTO SPONSOR(Name, SponsorType, SponsorID) 
    VALUES 
    	(name_in, sponsortype_in, sponsorID_in);

    INSERT INTO SPONSOR_CONTACT(SponsorID, Phone)
    VALUES (sponsorID_in, phone_in);

    INSERT INTO SPONSOR_EMAIL(SponsorID, Email)
	VALUES (sponsorID_in, email_in);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sponsor_update;
DELIMITER //
CREATE PROCEDURE sponsor_update(
	IN name_in 					varchar(150),
	IN sponsortype_in 			varchar(150),
	IN sponsorID_in				int(11),
	IN phone_in					char(15),
	IN email_in					char(150))
BEGIN
    UPDATE SPONSOR
    SET 
    	Name = 
    		CASE 	
    			WHEN (name_in IS NOT NULL) THEN name_in ELSE Name END,
    	SponsorType = 
    		CASE 	
    			WHEN (sponsortype_in IS NOT NULL) THEN sponsortype_in ELSE SponsorType END
    WHERE
    	SponsorID = sponsorID_in;

    UPDATE SPONSOR_CONTACT
    SET 
    	Phone = 
    		CASE 	
    			WHEN (phone_in IS NOT NULL) THEN phone_in ELSE Phone END
    WHERE
    	SponsorID = sponsorID_in;

    UPDATE SPONSOR_EMAIL
    SET 
    	Email = 
    		CASE 	
    			WHEN (email_in IS NOT NULL) THEN email_in ELSE Email END
    WHERE
    	SponsorID = sponsorID_in;

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sponsor_delete;
DELIMITER //
CREATE PROCEDURE sponsor_delete(
	IN sponsorID_in	int(11)
)
BEGIN
  DELETE FROM SPONSOR
  WHERE SponsorID = sponsorID_in;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS dyn_log;
DELIMITER //
CREATE PROCEDURE dyn_log (
	IN s VARCHAR(500)
)
BEGIN
	SELECT s INTO OUTFILE '/tmp/result.txt';
	DO SLEEP(1);
END //
DELIMITER ;

SAVEPOINT save_finish_procedure;

DELIMITER //
DROP INDEX IF EXISTS index_ten_sv ON STUDENT
CREATE UNIQUE INDEX index_ten_sv
 ON STUDENT (Name(10));

DROP INDEX IF EXISTS index_ten_sponsor ON SPONSOR
CREATE UNIQUE INDEX index_ten_sponsor
 ON SPONSOR (Name(10));

DROP INDEX IF EXISTS index_ten_lab ON LAB
CREATE UNIQUE INDEX index_ten_lab
 ON LAB (RoomName);

DROP INDEX IF EXISTS index_username ON ACCOUNT
CREATE UNIQUE INDEX index_username
 ON ACCOUNT (Username);
DELIMITER ;

SAVEPOINT save_finish_index;

DELETE FROM SPONSOR;
INSERT INTO SPONSOR (Name, SponsorType, SponsorID)
VALUES 
	('TMA', 'Gold', '1'),
	('DEK', 'Silver', '2'),
	('Ban Vien', 'Bronze', '3'),
	('Ong Kim Dong Chu', 'Diamond', '4');

DELETE FROM SPONSOR_CONTACT;
INSERT INTO SPONSOR_CONTACT(SponsorID, Phone)
VALUES
	('1', '0903998911'),
	('2', '0903998912'),
	('3', '0903998913'),
	('4', '0903998914');

DELETE FROM SPONSOR_EMAIL;
INSERT INTO SPONSOR_EMAIL(SponsorID, Email)
VALUES
	('1', 'tma@tma.com'),
	('2', 'dek@dek.com'),
	('3', 'banvien@banvien.com'),
	('4', 'diamond@diamond.com');

DELETE FROM LAB;
INSERT INTO LAB(Room, Building, RoomName)
VALUES
	('710', 'H6', 'HPC Lab'),
	('711', 'H6', 'IoT Develope and Research');

DELETE FROM STUDENT;
INSERT INTO STUDENT(StudentID, StudentType, Name, Email, Phone)
VALUES
	('1412091', 'Normal', 'Nguyen Thanh Long', '1412091@hcmut.edu.vn', '01239236239'),
	('1413785', 'Normal', 'Nguyen Phuoc Thinh', '1413785@hcmut.edu.vn', '01239236240'),
	('1413772', 'Normal', 'Le Huy Thinh', '1413772@hcmut.edu.vn', '01239236241'),
	('1414327', 'Normal', 'Huynh Dang Tru', '1414327@hcmut.edu.vn', '01239236242'),
	('1414151', 'Normal', 'Nguyen Khong Biet', '1414151@hcmut.edu.vn', '01239236243');

DELETE FROM SUBJECT;
INSERT INTO SUBJECT(SubjectID, SubjectName, SubjectLeader)
VALUES
	('01', 'IoT', 'Mr.Hoang Anh'),
	('02', 'Tinh toan song song', 'Mr.Nam');

DELETE FROM MANAGE;
INSERT INTO MANAGE(StudentID, Room, Building, DutyTime, BackupPassword)
VALUES
	('1412091', '710', 'H6', '1,2,3 - 5/5/2018', '1234'),
	('1413785', '710', 'H6', '1,2,3 - 5/5/2018', '1234'),
	('1412091', '711', 'H6', '4,5,6 - 5/5/2018', '1234'),
	('1413785', '711', 'H6', '4,5,6 - 5/5/2018', '1234');

DELETE FROM FUNDING;
INSERT INTO FUNDING(SponsorID, Room, Building)
VALUES
	('1', '710', 'H6'),
	('2', '710', 'H6'),
	('3', '711', 'H6'),
	('4', '711', 'H6');

DELETE FROM PARTICIPATE_IN;
INSERT INTO PARTICIPATE_IN(StudentID, Room, Building)
VALUES 
	('1412091', '711', 'H6'),
	('1413785', '710', 'H6'),
	('1413772', '711', 'H6'),
	('1414327', '710', 'H6');

DELETE FROM GUEST;
INSERT INTO GUEST(VisitorID)
VALUES
	('1'),
	('2'),
	('3'),
	('4'),
	('5'),
	('6'),
	('7'),
	('8');

DELETE FROM WANDERER;
INSERT INTO WANDERER(IdentityCard, Name, Phone, Email, VisitorID)
VALUES
	('125639546', 'Nguyen A', '0123456789', 'A@gmail.com', '1'),
	('125639547', 'Nguyen B', '0123456780', 'B@gmail.com', '2'),
	('125639548', 'Nguyen C', '0123456781', 'C@gmail.com', '3'),
	('125639549', 'Nguyen D', '0123456782', 'D@gmail.com', '4');

DELETE FROM VISIT;
INSERT INTO VISIT(VisitorID, Room, Building, FeedbackID, Reason, Date, Duration)
VALUES 
	('1', '711', 'H6',  NULL, 'Tham quan', '2018-05-05', '15'),
	('2', '711', 'H6',  'Thieu tien', 'Tham quan', '2018-05-06', '30'),
	('3', '710', 'H6',  NULL, 'Tham quan', '2018-05-07', '45'),
	('4', '710', 'H6',  NULL, 'Tham quan', '2018-05-08', '60');

DELETE FROM STU_VISITOR;
INSERT INTO STU_VISITOR(StudentID, VisitorID)
VALUES
	('1414141', '5'),
	('1412345', '6'),
	('1414567', '7'),
	('1411001', '8');

DELETE FROM LAB_USING_STUDENT;
INSERT INTO LAB_USING_STUDENT(StudentID, RFID, Status)
VALUES
	('1412091', '1412091', 'Off'),
	('1413785', '1413785', 'Off'),
	('1413772', '1413772', 'On'),
	('1414327', '1414327', 'On');

DELETE FROM LAB_LEARNING_STUDENT;
INSERT INTO LAB_LEARNING_STUDENT(StudentID)
VALUES
	('1412091'),
	('1413785'),
	('1413772'),
	('1414327');

DELETE FROM LAB_RESEARCH_STUDENT;
INSERT INTO LAB_RESEARCH_STUDENT(StudentID, ResearchTopic)
VALUES
	('1412091', 'IoT'),
	('1413785', 'MPI');

DELETE FROM THESIS_STUDENT;
INSERT INTO THESIS_STUDENT(StudentID, ThesisTopic)
VALUES
	('1412091', 'IoT'),
	('1413785', 'MPI');

DELETE FROM THESIS_TEACHER;
INSERT INTO THESIS_TEACHER(StudentID, TeacherName)
VALUES
	('1412091', 'Cuong'),
	('1413785', 'Nam'),
	('1412091', 'Thanh'),
	('1413785', 'Hong');

DELETE FROM STUDY;
INSERT INTO STUDY(StudentID, SubjectID, SubjectName, PeriodID, TeacherName, TeacherID, Room, Building)
VALUES
	('1412091', '1', 'IoT', 'P1', 'Anh', '1', '711', 'H6' ),
	('1413785', '2', 'IoT', 'P2', 'Nam', '2', '711', 'H6' ),
	('1413772', '1', 'IoT', 'P1', 'Anh', '1', '710', 'H6' ),
	('1414327', '2', 'IoT', 'P2', 'Nam', '2', '711', 'H6' );

DELETE FROM SCHEDULE;
INSERT INTO SCHEDULE(StudentID, SubjectID, TeachingTime, Room, Building)
VALUES
	('1412091', '1', '1, 2, 3', '711', 'H6' ),
	('1413785', '2', '1, 2, 4', '711', 'H6' ),
	('1413772', '1', '1, 2, 5', '710', 'H6' ),
	('1414327', '2', '1, 2, 6', '711', 'H6' );

DELETE FROM EQUIPMENT;
INSERT INTO EQUIPMENT(EquipmentID, Name, Room, Building)
VALUES
	('711001', 'MAC', '711', 'H6'),
	('711002', 'Windows 8,1 Computer', '711', 'H6'),
	('711003', 'Edison', '711', 'H6'),
	('710001', 'Computer Engineering Tutorial', '710', 'H6'),
	('710002', 'EC Sensor', '710', 'H6');

DELETE FROM ACCOUNT;
INSERT INTO ACCOUNT(StudentID, Username, EquipmentID, Password)
VALUES
	('1412091', '1412091', '711001', MD5('1412091')),
	('1413785', '1413785', '711002', MD5('1413785')),
	('1413772', '1413772', '711002', MD5('1413772')),
	('1414327', '1414327', '711002', MD5('1414327'));

DELETE FROM APPLICATION;
INSERT INTO APPLICATION(StudentID, Username, AppName)
VALUES
	('1412091', '1412091', 'VisualStudio'),
	('1413785', '1413785', 'CrypTool'),
	('1413772', '1413772', 'SuperMario'),
	('1414327', '1414327', 'FireFox');

DELETE FROM FOLDER;
INSERT INTO FOLDER(StudentID, Username, FolderName, FolderLocation)
VALUES
	('1412091', '1412091', '1412091', 'D:/'),
	('1413785', '1413785', '1413785', 'D:/'),
	('1413772', '1413772', '1413772', 'D:/'),
	('1414327', '1414327', '1414327', 'D:/');

DELETE FROM LAB_TEACHER;
INSERT INTO LAB_TEACHER(Room, Building, TeacherID, TeacherName, Contact)
VALUES
	('711', 'H6', '1', 'Anh', 'anh@hcmut.edu.vn'),
	('711', 'H6', '2', 'Hong', 'hong@hcmut.edu.vn'),
	('710', 'H6', '3', 'Nam', 'nam@hcmut.edu.vn'),
	('710', 'H6', '4', 'Thanh', 'thanh@hcmut.edu.vn');

DELETE FROM DOCUMENT;
INSERT INTO DOCUMENT(EquipmentID, Author)
VALUES
	('710001', 'Thinh_sensei');

DELETE FROM SENSOR;
INSERT INTO SENSOR(EquipmentID, SensorType)
VALUES
	('710002', 'EC');

DELETE FROM PC;
INSERT INTO PC(EquipmentID, Type, ADMINUsername, ADMINPassword)
VALUES
	('711001', 'MAC', 'admin', MD5('1234')),
	('711002', 'Windows 8.1 Computer', 'admin', MD5('1234'));

DELETE FROM KIT;
INSERT INTO KIT(EquipmentID, Type, Note)
VALUES
	('711003', 'Edison', 'Kit he thong nhung');

DELETE FROM KIT_ADDON;
INSERT INTO KIT_ADDON(EquipmentID, AddonName)
VALUES
	('711003', 'Edison Header'),
	('711003', 'Edison Button'),
	('711003', 'Edison Sensor'),
	('711003', 'Edison LCD');

DELETE FROM BELONGS_TO;
INSERT INTO BELONGS_TO(Room, Building, SubjectID)
VALUES
	('710', 'H6', '1'),
	('711', 'H6', '2');

DELETE FROM BORROW;
INSERT INTO BORROW(StudentID, EquipmentID, BorrowDate, ReturnDate)
VALUES
	('1413772', '710001', '2017-12-31', '2017-12-31'),
	('1412091', '711002', '2018-1-2', '2018-1-2'),
	('1412091', '711003', '2018-1-3', '2018-1-3'),
	('1412091', '710002', '2018-1-4', '2018-1-4');

DELETE FROM BORROW_TO_HOME;
INSERT INTO BORROW_TO_HOME(StudentID, EquipmentID, BorrowDate, ReturnDate, TeacherID, TeacherName)
VALUES
	('1414327', '711001', '2018-1-4', '2018-1-5', '1', 'Anh'),
	('1413772', '711002', '2018-1-2', '2018-1-4', '1', 'Anh'),
	('1413785', '711003', '2018-1-3', '2018-1-12', '2', 'Nam'),
	('1412091', '710001', '2018-1-12', '2018-1-18', '2', 'Nam');


SAVEPOINT save_finish_insert;

DROP FUNCTION IF EXISTS get_sponsor_phone;
DELIMITER //
CREATE FUNCTION get_sponsor_phone(sponsorID_in  int) RETURNS VARCHAR(15)
BEGIN
  DECLARE Phone_return VARCHAR(15);
  SET Phone_return = '';
    SELECT Phone
      INTO Phone_return
      FROM  SPONSOR_CONTACT
      WHERE SponsorID = sponsorID_in;
    RETURN Phone_return;
END; //
DELIMITER ;

DROP FUNCTION IF EXISTS get_sponsor_name;
DELIMITER //
CREATE FUNCTION get_sponsor_name(sponsorID_in int) RETURNS VARCHAR(150)
BEGIN
  DECLARE Name_return VARCHAR(150);
  SET Name_return = '';
    SELECT Name
      INTO Name_return
      FROM  SPONSOR
      WHERE SponsorID = sponsorID_in;
    RETURN Name_return;
END; //
DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS get_all_std //
CREATE PROCEDURE get_all_std ()
BEGIN
	SELECT s.StudentID, s.StudentType, s.Name, s.Email, s.Phone, l.Status
    FROM STUDENT AS s
    LEFT JOIN LAB_USING_STUDENT AS l ON s.StudentID = l.StudentID
    ORDER BY s.StudentID ASC;
END //

DROP PROCEDURE IF EXISTS get_std //
CREATE PROCEDURE get_std (
	IN std_id INT(11))
BEGIN
	SELECT * FROM STUDENT WHERE StudentID = std_id;
END //

DROP PROCEDURE IF EXISTS add_std //
CREATE PROCEDURE add_std (
	IN std_id INT(11),
	IN std_type VARCHAR(150),
	IN std_name VARCHAR(150),
	IN std_email CHAR(150),
	IN std_phone CHAR(15))
BEGIN
	INSERT INTO STUDENT(StudentID,StudentType,Name,Email,Phone) VALUES (std_id,std_type,std_name,std_email,std_phone);
END //

DROP PROCEDURE IF EXISTS delete_std //
CREATE PROCEDURE delete_std (
	IN std_id INT(11))
BEGIN
	DELETE FROM STUDENT WHERE StudentID = std_id;
END //

DROP PROCEDURE IF EXISTS edit_std //
CREATE PROCEDURE edit_std (
	IN std_id INT(11),
	IN std_type VARCHAR(150),
	IN std_name VARCHAR(150),
	IN std_email CHAR(150),
	IN std_phone CHAR(15))
BEGIN
	UPDATE STUDENT SET
           StudentID = std_id,
           StudentType = std_type,
		   Name = std_name,
		   Email = std_email,
           Phone = std_phone
           WHERE StudentID = std_id;
END //

DROP PROCEDURE IF EXISTS get_trash //
CREATE PROCEDURE get_trash ()
BEGIN
	SELECT * FROM TMP_STUDENT_DE
    ORDER BY StudentID ASC;
END //

DROP PROCEDURE IF EXISTS delete_trash //
CREATE PROCEDURE delete_trash (
	IN std_id INT(11))
BEGIN
	DELETE FROM TMP_STUDENT_DE WHERE StudentID = std_id;
END //

DROP PROCEDURE IF EXISTS login //
CREATE PROCEDURE login (
	IN user INT(11),
	IN pass CHAR(200))
BEGIN
	SELECT * FROM ACCOUNT WHERE StudentID = user AND Password = pass;
END //

DROP TRIGGER IF EXISTS TRI_STUDENT_ED //
CREATE TRIGGER TRI_STUDENT_ED
BEFORE UPDATE ON STUDENT
FOR EACH ROW
BEGIN
	DELETE FROM TMP_STUDENT_ED WHERE StudentID = OLD.StudentID;
	INSERT INTO TMP_STUDENT_ED (StudentID,StudentType,Name,Email,Phone)
    VALUES (OLD.StudentID,OLD.StudentType,OLD.Name,OLD.Email,OLD.Phone);
END //

DROP TRIGGER IF EXISTS TRI_STUDENT_DE //
CREATE TRIGGER TRI_STUDENT_DE
BEFORE DELETE ON STUDENT
FOR EACH ROW
BEGIN
	INSERT INTO TMP_STUDENT_DE (StudentID,StudentType,Name,Email,Phone)
    VALUES (OLD.StudentID,OLD.StudentType,OLD.Name,OLD.Email,OLD.Phone);
END //

DELIMITER ;

DROP TABLE IF EXISTS TMP_STUDENT_ED;
CREATE TABLE TMP_STUDENT_ED (
	StudentID INT(11) NOT NULL,
    StudentType VARCHAR(150),
    Name VARCHAR(150) NOT NULL,
    Email CHAR(150),
	Phone CHAR(15),
    PRIMARY KEY(StudentID)
);

DROP TABLE IF EXISTS TMP_STUDENT_DE;
CREATE TABLE TMP_STUDENT_DE (
	StudentID INT(11) NOT NULL,
    StudentType VARCHAR(150),
    Name VARCHAR(150) NOT NULL,
    Email CHAR(150),
	Phone CHAR(15),
    PRIMARY KEY(StudentID)
);