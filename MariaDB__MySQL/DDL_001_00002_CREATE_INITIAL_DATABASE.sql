CREATE TABLE SoftwareUsesTechnique
    (
        SoftwareID varchar(5),
        Technique varchar (5),
        Subtechnique varchar(5),
        Description varchar(2000),
        FOREIGN KEY(Technique, Subtechnique) REFERENCES mitre_techniques(ID, SubID),
        FOREIGN KEY(SoftwareID) REFERENCES mitre_software(ID),
        PRIMARY KEY(SoftwareID, Technique, Subtechnique)
    );


CREATE TABLE GroupUsesSoftware
    (
        GroupID varchar(5),
        SoftwareID varchar(5),
        FOREIGN KEY(GroupID) REFERENCES mitre_groups(ID),
        FOREIGN KEY(SoftwareID) REFERENCES mitre_software(ID),
        PRIMARY KEY(GroupID, SoftwareID)
    );