-- Das Befüllen nach Aufgabenstellung
INSERT INTO apl.known_target
(name, description) VALUES
('HSWismar', 'The University with IT Forensics'),
('Ford', 'The car manufacturer of our rocking unicorn'),
('UnicornBurger', 'Das Lieblingsrestaurant unser Einhörner'),
('Munich Wings', 'Wenn die Einhörner mal nicht selbst laufen wollen.');

INSERT INTO apl.group_campaigns
(GroupID, campaign_name, description) VALUES
(
    (SELECT ID FROM apl.mitre_groups WHERE AssociatedGroups LIKE '%Magecart Group 6%'),
    'SolarStorm',
    'Die Gruppe wollte so berühmt werden wie die Gruppe hinter Solarwinds'
),
(
    (SELECT ID FROM apl.mitre_groups WHERE AssociatedGroups LIKE '%Magecart Group 6%'),
    'BreachHero',
    'Sie waren Helden'
),
('G0006', 'BurgerPanne', 'Wenn Die Verteidiger nichts mehr im Magen haben, gewinnen die Angreifer'),
('G0025', 'Dieselknappheit', 'Das Rockstar Unicorn bleibt auf dem Weg in die Arbeit liegen');

-- Update

UPDATE apl.known_target
SET description = 'The best University with IT Forensics'
WHERE name = 'HSWismar';

DELETE FROM apl.GroupAttacksIndustry WHERE Industry LIKE '%Aerospace%';

UPDATE apl.group_campaigns
SET campaign_name = 'BenzinKnappheit'
WHERE description LIKE '%Rockstar Unicorn%';

DELETE from apl.group_campaigns WHERE GroupID = 'FIN6'; -- Aufräumen nach Inaktivität der Gruppe

UPDATE apl.group_campaigns
SET GroupID = (SELECT ID FROM apl.mitre_groups WHERE Name = 'APT19')
WHERE campaign_name = 'BurgerPanne';