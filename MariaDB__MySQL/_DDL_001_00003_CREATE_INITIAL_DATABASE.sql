use datenbanken01;
go

-- DDL 3

CREATE TABLE economic_area
    (
        Continent varchar(50) NOT NULL PRIMARY KEY,
        economic_area varchar(10) NOT NULL
    );

CREATE TABLE country
    (
        Country varchar(50) NOT NULL PRIMARY KEY,
        Continent varchar (50) NOT NULL,
        FOREIGN KEY (Continent) REFERENCES economic_area(Continent)
    );

CREATE TABLE targets_industrytype
    (
        IndustryType varchar(100) NOT NULL PRIMARY KEY ,
        description varchar(1000)
        );


CREATE TABLE GroupAttacksCountry
    (
        Attacker varchar(5),
        Country varchar(50),
        FOREIGN KEY(Attacker) REFERENCES mitre_groups(ID),
        FOREIGN KEY(Country) REFERENCES country(country),
        PRIMARY KEY(Attacker, Country)
    );

CREATE TABLE GroupAttacksIndustry
    (
        Attacker varchar(5),
        Country varchar(50),
        FOREIGN KEY(Attacker) REFERENCES mitre_groups(ID),
        FOREIGN KEY(Country) REFERENCES country(country),
        PRIMARY KEY(Attacker, Country)
    );
	
go