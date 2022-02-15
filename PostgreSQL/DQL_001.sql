use datenbanken01;

-- ANDRE PEUKER
-- Zeige Mitigations mit zugehöriger Technik, wenn diese keine Subtechnik nutzt
SELECT apl.mitre_mitigations.name, apl.mitre_mitigations.description,
       apl.mitre_techniques.name, apl.mitre_techniques.description
    FROM apl.mitre_mitigations
    INNER JOIN apl.mitigates ON apl.mitre_mitigations.id = apl.mitigates.mitigation
    INNER JOIN apl.mitre_techniques ON apl.mitigates.technique = apl.mitre_techniques.id
    GROUP BY apl.mitre_mitigations.name, apl.mitre_mitigations.description,
             apl.mitre_techniques.name, apl.mitre_techniques.description, apl.mitigates.subtechnique
    HAVING LENGTH(apl.mitigates.subtechnique) < 1
    ORDER BY mitre_mitigations.name;

-- Zeige Anzahl der Gruppen, die eine bestimmte Software nutzt, sortiere diese absteigend nach Anzahl der Gruppen
SELECT apl.mitre_software.name,
       COUNT(apl.mitre_software.name) as CountSoftware
    FROM apl.mitre_software
    INNER JOIN apl.groupusessoftware ON apl.mitre_software.Id = apl.groupusessoftware.softwareid
    GROUP BY apl.mitre_software.name
    ORDER BY CountSoftware DESC;

-- Zeige alle Techniken, die für die Taktik 'Command and Control' verwendet werden
SELECT apl.mitre_tactics.name, apl.mitre_tactics.description, apl.mitre_techniques.name, apl.mitre_techniques.description
    FROM apl.mitre_tactics
    INNER JOIN apl.tactichastechnique ON apl.mitre_tactics.id = apl.tactichastechnique.tactic
    INNER JOIN apl.mitre_techniques ON apl.tactichastechnique.technique = apl.mitre_techniques.id
    WHERE apl.mitre_tactics.name = 'Command and Control'
    GROUP BY apl.mitre_tactics.name, apl.mitre_tactics.description, apl.mitre_techniques.name, apl.mitre_techniques.description
    ORDER BY apl.mitre_techniques.name;

-- Zeige Anzahl der Techniken für jede Taktik - Sortiere das Ergebnis in absteigener Reihenfolge nach Anzahl
SELECT apl.mitre_tactics.name, apl.mitre_tactics.description, COUNT(apl.tactichastechnique.tactic) as CountTechniques
    FROM apl.mitre_tactics
    INNER JOIN apl.tactichastechnique ON apl.mitre_tactics.id = apl.tactichastechnique.tactic
    GROUP BY apl.mitre_tactics.name, apl.mitre_tactics.description
    ORDER BY CountTechniques DESC, apl.mitre_tactics.name;

-- Zeige Gruppen, die / deren andere Gruppen zugeordnet sind
SELECT name, associatedgroups, description FROM apl.mitre_groups
    GROUP BY  name, associatedgroups, description
    HAVING LENGTH(associatedgroups) > 0;