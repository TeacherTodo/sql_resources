-- Create Databse
DROP DATABASE IF EXISTS teachertodo;
CREATE DATABASE teachertodo;

-- Create Lookup Tables
CREATE TABLE Majors (
	major varchar(50) PRIMARY KEY
);

CREATE TABLE Requirements (
	id int PRIMARY KEY AUTO_INCREMENT,
    major varchar(50) NOT NULL,
    description varchar(255) NOT NULL,
    documentation_required bool NOT NULL,
    FOREIGN KEY (major) REFERENCES Majors(major)
);

CREATE TABLE Requirement_Statuses (
	status varchar(20) PRIMARY KEY
);

CREATE TABLE Approval_Statuses (
	status varchar(20) PRIMARY KEY
);

CREATE TABLE Terms (
	term varchar(10) PRIMARY KEY
);

-- Create Data Tables
CREATE TABLE Approved_Users (
	uid varchar(256) PRIMARY KEY,
    major varchar(50) NOT NULL,
    grad_term varchar(10) NOT NULL,
    grad_year int NOT NULL,
    FOREIGN KEY (major) REFERENCES Majors(major),
    FOREIGN KEY (grad_term) REFERENCES Terms(term)
);

CREATE TABLE Requirement_Instances (
	id int PRIMARY KEY AUTO_INCREMENT,
    req_id int NOT NULL,
    uid varchar(256) NOT NULL,
    status varchar(20) NOT NULL,
    doc_guid varchar(20),
    retake_date date,
    FOREIGN KEY (req_id) REFERENCES Requiremnets(id),
    FOREIGN KEY (uid) REFERENCES Approved_Users(uid),
    FOREIGN KEY (status) REFERENCES Requirement_Statuses(status)
);

CREATE TABLE Documents (
	guid varchar(30) PRIMARY KEY,
    approval_status varchar(20) NOT NULL,
    req_instance_id int NOT NULL,
    upload_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (approval_status) REFERENCES Approval_Statuses(status),
    FOREIGN KEY (req_instance_id) REFERENCES Requirement_Instances(id)
);

CREATE TABLE Admin_Users (
	uid varchar(8) PRIMARY KEY
);

CREATE TABLE FMP_Imports (
	guid varchar(20) PRIMARY KEY,
    upload_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    uploaded_by varchar(8) NOT NULL,
    FOREIGN KEY (uploaded_by) REFERENCES Admin_Usres(uid)
);

-- Populate Requirement Statuses Table
INSERT INTO Requirement_Statuses VALUES ('Not Started');
INSERT INTO Requirement_Statuses VALUES ('In Progress');
INSERT INTO Requirement_Statuses VALUES ('Pending Re-Take');
INSERT INTO Requirement_Statuses VALUES ('Waiting for Approval');
INSERT INTO Requirement_Statuses VALUES ('Complete');

-- Populate Approval Statuses Table
INSERT INTO Approval_Statuses VALUES ('Waiting for Approval');
INSERT INTO Approval_Statuses VALUES ('Approved');
INSERT INTO Approval_Statuses VALUES ('Denied');

-- Populate Terms Table
INSERT INTO Terms VALUES ('Fall');
INSERT INTO Terms VALUES ('Winter');
INSERT INTO Terms VALUES ('Spring');
INSERT INTO Terms VALUES ('Summer');


-- Populate Majors Table
INSERT INTO Majors VALUES ('Elementary Education (BSED)');
INSERT INTO Majors VALUES ('Seconday Education - Physics (BSED)');
INSERT INTO Majors VALUES ('Secondary Education - Biology (BSED)');
INSERT INTO Majors VALUES ('Secondary Education - Chemistry (BSED)');
INSERT INTO Majors VALUES ('Secondary Education - Earth Science (BSED)');
INSERT INTO Majors VALUES ('Secondary Education - General Science (BSED)');
INSERT INTO Majors VALUES ('Secondary Education - Mathematics (BSED)');
INSERT INTO Majors VALUES ('Teaching Science with Certification');
INSERT INTO Majors VALUES ('Physical Education (BSED)');