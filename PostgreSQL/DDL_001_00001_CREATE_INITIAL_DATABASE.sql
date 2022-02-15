CREATE TABLE apl.mitre_groups
    (
            ID varchar(5) NOT NULL PRIMARY KEY,
            Name varchar(30) NOT NULL,
            AssociatedGroups varchar(200),
            Description varchar(2000)
    );

CREATE TABLE apl.mitre_software
    (
        ID varchar(5) NOT NULL PRIMARY KEY,
        Name varchar(100) NOT NULL,
        AssociatedSoftware varchar(100),
        Description varchar(2000)
    );

CREATE TABLE apl.mitre_tactics
    (
        ID varchar(6) NOT NULL PRIMARY KEY,
        Name varchar(30) NOT NULL,
        Description varchar(1000)
    );

CREATE TABLE apl.mitre_techniques
    (
        ID varchar(5) NOT NULL,
        SubID varchar(5),
        Name varchar(100) NOT NULL,
        Description varchar(2000),
        PRIMARY KEY(ID, SubID)
    );

CREATE TABLE apl.mitre_mitigations
    (
        ID varchar(5) NOT NULL PRIMARY KEY,
        Name varchar(100) NOT NULL,
        Description varchar(1000)
    );

CREATE TABLE apl.TacticHasTechnique
    (
        Tactic varchar(6),
        Technique varchar(5),
        Subtechnique varchar(5),
        FOREIGN KEY(Technique, Subtechnique) REFERENCES apl.mitre_techniques(ID, SubID),
        FOREIGN KEY(Tactic) REFERENCES apl.mitre_tactics(ID),
        PRIMARY KEY(Tactic, Technique, Subtechnique)
    );

CREATE TABLE apl.mitigates
    (
        Mitigation varchar(5),
        Technique varchar(5),
        Subtechnique varchar(5),
        FOREIGN KEY(Mitigation) REFERENCES apl.mitre_mitigations(ID),
        FOREIGN KEY(Technique, Subtechnique) REFERENCES apl.mitre_techniques(ID, SubID),
        PRIMARY KEY(Mitigation, Technique, Subtechnique)
    );

CREATE TABLE apl.GroupUsesTechniques
    (
        GroupID varchar(5),
        Technique varchar (5),
        Subtechnique varchar(5),
        FOREIGN KEY(Technique, Subtechnique) REFERENCES apl.mitre_techniques(ID, SubID),
        FOREIGN KEY(GroupID) REFERENCES apl.mitre_groups(ID),
        PRIMARY KEY(GroupID, Technique, Subtechnique)
    );