use datenbanken01;

-- LEA SCHERTEL
-- Zeige alle Gruppen mit zugehöriger, eingesetzter Software
SELECT mitre_groups.name, mitre_groups.associatedgroups,
       mitre_groups.description, mitre_software.name,
       mitre_software.associatedsoftware, mitre_software.description
    FROM mitre_groups
    INNER JOIN GroupUsesSoftware ON mitre_groups.id = GroupUsesSoftware.groupid
    INNER JOIN mitre_software ON GroupUsesSoftware.softwareid = mitre_software.id
    ORDER BY mitre_groups.name;

-- Anzahl aller Datensätze der Gruppen - Software
SELECT COUNT(*)
    FROM mitre_groups
    INNER JOIN GroupUsesSoftware ON mitre_groups.id = GroupUsesSoftware.groupid
    INNER JOIN mitre_software ON GroupUsesSoftware.softwareid = mitre_software.id;

-- Zeige Anzahl unterschiedlicher Software, die eine Gruppe nutzt, Sortiere absteigend nach Anzahl der genutzer Software
SELECT mitre_groups.name,
       COUNT(mitre_groups.name) as CountSoftware
    FROM mitre_groups
    INNER JOIN GroupUsesSoftware ON mitre_groups.id = GroupUsesSoftware.groupid
    GROUP BY mitre_groups.name
    ORDER BY CountSoftware DESC;

-- Zeige Software mit zugehöriger Angriffstechnik
SELECT *
    FROM mitre_software
    INNER JOIN SoftwareUsesTechnique ON mitre_software.id = SoftwareUsesTechnique.softwareid
    INNER JOIN mitre_techniques ON SoftwareUsesTechnique.technique = mitre_techniques.id
    ORDER BY mitre_software.name;

-- Zeige Techniken, die zugleich eine Sub-Technik sind
SELECT name, description FROM mitre_techniques
    GROUP BY  name, description, subid
    HAVING LENGTH(subid) > 0;