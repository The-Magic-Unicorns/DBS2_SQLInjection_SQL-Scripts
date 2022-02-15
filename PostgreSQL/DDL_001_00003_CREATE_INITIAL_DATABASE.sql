CREATE TABLE apl.economic_area
    (
        Continent varchar(50) NOT NULL PRIMARY KEY,
        economic_area varchar(10) NOT NULL
    );

CREATE TABLE apl.country
    (
        Country varchar(50) NOT NULL PRIMARY KEY,
        Continent varchar (50) NOT NULL,
        FOREIGN KEY (Continent) REFERENCES apl.economic_area(Continent)
    );

CREATE TABLE apl.targets_industrytype
    (
        IndustryType varchar(100) NOT NULL PRIMARY KEY ,
        description varchar(1000)
        );


CREATE TABLE apl.GroupAttacksCountry
    (
        Attacker varchar(5),
        Country varchar(50),
        FOREIGN KEY(Attacker) REFERENCES apl.mitre_groups(ID),
        FOREIGN KEY(Country) REFERENCES apl.country(country),
        PRIMARY KEY(Attacker, Country)
    );

CREATE TABLE apl.GroupAttacksIndustry
    (
        Attacker varchar(5),
        Industry varchar(50),
        FOREIGN KEY(Attacker) REFERENCES apl.mitre_groups(ID),
        FOREIGN KEY(Industry) REFERENCES apl.targets_industrytype(IndustryType),
        PRIMARY KEY(Attacker, Industry)
    );