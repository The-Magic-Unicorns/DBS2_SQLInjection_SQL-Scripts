use datenbanken01;
go

CREATE TABLE mitre_groups
    (
            ID varchar(5) NOT NULL PRIMARY KEY,
            Name varchar(30) NOT NULL,
            AssociatedGroups varchar(200),
            Description varchar(2000)
    );

CREATE TABLE mitre_software
    (
        ID varchar(5) NOT NULL PRIMARY KEY,
        Name varchar(100) NOT NULL,
        AssociatedSoftware varchar(100),
        Description varchar(2000)
    );

CREATE TABLE mitre_tactics
    (
        ID varchar(6) NOT NULL PRIMARY KEY,
        Name varchar(30) NOT NULL,
        Description varchar(1000)
    );

CREATE TABLE mitre_techniques
    (
        ID varchar(5) NOT NULL,
        SubID varchar(5),
        Name varchar(100) NOT NULL,
        Description varchar(2000),
        PRIMARY KEY(ID, SubID)
    );

CREATE TABLE mitre_mitigations
    (
        ID varchar(5) NOT NULL PRIMARY KEY,
        Name varchar(100) NOT NULL,
        Description varchar(1000)
    );

CREATE TABLE TacticHasTechnique
    (
        Tactic varchar(6),
        Technique varchar(5),
        Subtechnique varchar(5),
        FOREIGN KEY(Technique, Subtechnique) REFERENCES mitre_techniques(ID, SubID),
        FOREIGN KEY(Tactic) REFERENCES mitre_tactics(ID),
        PRIMARY KEY(Tactic, Technique, Subtechnique)
    );

CREATE TABLE mitigates
    (
        Mitigation varchar(5),
        Technique varchar(5),
        Subtechnique varchar(5),
        FOREIGN KEY(Mitigation) REFERENCES mitre_mitigations(ID),
        FOREIGN KEY(Technique, Subtechnique) REFERENCES mitre_techniques(ID, SubID),
        PRIMARY KEY(Mitigation, Technique, Subtechnique)
    );

CREATE TABLE GroupUsesTechniques
    (
        GroupID varchar(5),
        Technique varchar (5),
        Subtechnique varchar(5),
        FOREIGN KEY(Technique, Subtechnique) REFERENCES mitre_techniques(ID, SubID),
        FOREIGN KEY(GroupID) REFERENCES mitre_groups(ID),
        PRIMARY KEY(GroupID, Technique, Subtechnique)
    );