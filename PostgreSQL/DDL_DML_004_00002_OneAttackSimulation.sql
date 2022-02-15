SELECT * FROM apl.targets_industrytype;
SELECT * FROM apl.mitre_groups WHERE NAME = 'FIN6';
SELECT * FROM apl.GroupAttacksIndustry;

INSERT INTO apl.GroupAttacksIndustry
(Attacker, Industry) VALUES
(
    (SELECT ID FROM apl.mitre_groups WHERE AssociatedGroups LIKE '%Magecart Group 6%'),
    (SELECT IndustryType FROM apl.targets_industrytype WHERE description = 'Aerospace & Defense')
);

SELECT * FROM apl.known_target;
SELECT * FROM apl.GroupAttacksTarget;

INSERT INTO apl.known_target
(name, description) VALUES
('LuftTaxi', 'The most important industry for our APL');

INSERT INTO apl.GroupAttacksTarget
(GroupID, target_name) VALUES
(
    (SELECT ID FROM apl.mitre_groups WHERE AssociatedGroups LIKE '%Magecart Group 6%'),
    (SELECT name FROM apl.known_target WHERE name = 'LuftTaxi')
);

-- Query 1

SELECT Continent, count(*) AS Count
FROM apl.country
GROUP BY Continent;

SELECT * FROM apl.country WHERE Continent = 'Europe';


-- INSERT: Ziele der angreifenden Gruppe "Megacart Group 6" befinden sich in den Ländern: Frankreich, UK, Spanien und Deutschland
INSERT INTO apl.GroupAttacksCountry
(Attacker, Country) VALUES
(
    (SELECT ID FROM apl.mitre_groups WHERE AssociatedGroups LIKE '%Magecart Group 6%'),
    (SELECT Country FROM apl.country WHERE country.Country = 'Germany')
),
(
    (SELECT ID FROM apl.mitre_groups WHERE AssociatedGroups LIKE '%Magecart Group 6%'),
    (SELECT Country FROM apl.country WHERE country.Country = 'France')
),
(
    (SELECT ID FROM apl.mitre_groups WHERE AssociatedGroups LIKE '%Magecart Group 6%'),
    (SELECT Country FROM apl.country WHERE country.Country = 'Spain')
),
(
    (SELECT ID FROM apl.mitre_groups WHERE AssociatedGroups LIKE '%Magecart Group 6%'),
    (SELECT Country FROM apl.country WHERE country.Country = 'United Kingdom')
);

INSERT INTO apl.group_campaigns
(GroupID, campaign_name, description) VALUES
(
    (SELECT ID FROM apl.mitre_groups WHERE AssociatedGroups LIKE '%Magecart Group 6%'),
    'SuperMegaAngriff',
    'Dieser Angriff sollte unsere APL endgültig zerstören, aber wir waren vorbereitet'
);

-- Query 2
-- HIer funktioniert ein Kreuzprodukt, weil ich nicht mehr Daten habe

SELECT g.Name, eco.economic_area, count(*) AS Count_Of_ECO
FROM apl.mitre_groups g, apl.economic_area eco, apl.country co, apl.GroupAttacksCountry attack
WHERE g.ID = attack.Attacker and attack.Country = co.Country AND co.Continent = eco.Continent
      AND g.Name = 'FIN6'
GROUP BY eco.economic_area, g.Name;

-- Query 3

SELECT g.Name, tech.ID, tech.SubID, tech.Name, count(*) AS CountOfDefenseMethods
FROM apl.mitre_groups g
INNER JOIN apl.GroupUsesTechniques uses ON g.ID = uses.GroupID
INNER JOIN apl.mitre_techniques tech ON uses.Technique = tech.ID and uses.Subtechnique = tech.SubID
INNER JOIN apl.mitigates mitigates ON tech.ID = mitigates.Technique and tech.SubID = mitigates.Subtechnique
INNER JOIN apl.mitre_mitigations mit ON mitigates.Mitigation = mit.ID
WHERE g.Name = 'FIN6'
GROUP BY tech.ID, tech.SubID, tech.Name, g.Name
ORDER BY tech.ID, tech.SubID;

-- Query 4
-- Welche Software könnte eine Gruppe bei einem Angriff einsetzen (nach welcher lohnt es sich zu suchen) und dabei ein Ranking zu erstellen?
SELECT ind.description, gr.Name, soft.Name, count(*) AS Ranking
FROM apl.targets_industrytype ind
INNER JOIN apl.GroupAttacksIndustry attacks ON ind.IndustryType = attacks.Industry
INNER JOIN apl.mitre_groups gr ON attacks.Attacker = gr.ID
INNER JOIN apl.GroupUsesSoftware uses ON gr.ID = uses.GroupID
INNER JOIN apl.mitre_software soft ON uses.SoftwareID = soft.ID
INNER JOIN apl.SoftwareUsesTechnique used ON soft.ID = used.SoftwareID
INNER JOIN apl.mitre_techniques tech ON used.Technique = tech.ID and used.Subtechnique = tech.SubID
WHERE ind.IndustryType LIKE '%Aerospace%'
GROUP BY soft.Name, gr.Name, ind.description
HAVING gr.Name = 'FIN6'
ORDER BY Ranking DESC , gr.Name, soft.Name;

-- Query 5
-- Wie aktiv sind sonst gerade die Gruppen, die mich angreifen?
BEGIN TRANSACTION;

SELECT t.name, g.Name, count(*) AS Ranking
FROM apl.known_target t
INNER JOIN apl.GroupAttacksTarget attacks ON t.name = attacks.target_name
INNER JOIN apl.mitre_groups g ON attacks.GroupID = g.ID
INNER JOIN apl.group_campaigns gc ON g.ID = gc.GroupID
GROUP BY  g.Name, t.name
HAVING t.name = 'LuftTaxi';

COMMIT TRANSACTION;