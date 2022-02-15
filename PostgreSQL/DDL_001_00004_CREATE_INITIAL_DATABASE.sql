CREATE TABLE apl.group_campaigns
    (
        GroupID varchar(5) NOT NULL,
        campaign_name varchar(50) NOT NULL PRIMARY KEY,
        description varchar(1000),
        FOREIGN KEY(GroupID) REFERENCES apl.mitre_groups(ID)
    );

CREATE TABLE apl.known_target
    (
        name varchar(50) NOT NULL PRIMARY KEY,
        description varchar(1000)
    );

CREATE TABLE apl.GroupAttacksTarget
    (
        GroupID varchar(5),
        target_name varchar(50),
        FOREIGN KEY(GroupID) REFERENCES apl.mitre_groups(ID),
        FOREIGN KEY(target_name) REFERENCES apl.known_target(name),
        PRIMARY KEY(GroupID, target_name)
    );

-- Transaction
BEGIN TRANSACTION;
-- Erstelle Index
create unique index technique on apl.mitre_techniques(id, subid);
create unique index groups on apl.mitre_groups(id);
COMMIT TRANSACTION;