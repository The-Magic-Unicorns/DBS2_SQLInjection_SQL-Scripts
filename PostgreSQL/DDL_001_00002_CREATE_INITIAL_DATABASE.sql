CREATE TABLE apl.SoftwareUsesTechnique
    (
        SoftwareID varchar(5),
        Technique varchar (5),
        Subtechnique varchar(5),
        Description varchar(2000),
        FOREIGN KEY(Technique, Subtechnique) REFERENCES apl.mitre_techniques(ID, SubID),
        FOREIGN KEY(SoftwareID) REFERENCES apl.mitre_software(ID),
        PRIMARY KEY(SoftwareID, Technique, Subtechnique)
    );


CREATE TABLE apl.GroupUsesSoftware
    (
        GroupID varchar(5),
        SoftwareID varchar(5),
        FOREIGN KEY(GroupID) REFERENCES apl.mitre_groups(ID),
        FOREIGN KEY(SoftwareID) REFERENCES apl.mitre_software(ID),
        PRIMARY KEY(GroupID, SoftwareID)
    );