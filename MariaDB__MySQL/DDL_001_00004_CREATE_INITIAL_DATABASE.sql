use datenbanken01;
go

-- DDL 4
CREATE TABLE group_campaigns
    (
        GroupID varchar(5) NOT NULL,
        campaign_name varchar(50) NOT NULL PRIMARY KEY,
        description varchar(1000),
        FOREIGN KEY(GroupID) REFERENCES mitre_groups(ID)
    );

CREATE TABLE known_target
    (
        name varchar(50) NOT NULL PRIMARY KEY,
        description varchar(1000)
    );

CREATE TABLE GroupAttacksTarget
    (
        GroupID varchar(5),
        target_name varchar(50),
        FOREIGN KEY(GroupID) REFERENCES mitre_groups(ID),
        FOREIGN KEY(target_name) REFERENCES known_target(name),
        PRIMARY KEY(GroupID, target_name)
    );

go