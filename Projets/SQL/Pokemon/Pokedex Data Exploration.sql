-- =========================================================
-- 🎯 Combien de Pokémon y a-t-il en aujourd'hui en 2025?
-- =========================================================

SELECT count(*) as 'Nombre de Pokemon Total'
FROM pokemon;

-- +-------------------------+
-- | Nombre de Pokemon Total |
-- +=========================+
-- | 1025                    |
-- +-------------------------+


-- =========================================================
-- 🎯 Combien de y a t-il de Pokémon par génération ? 
-- =========================================================

SELECT generation_id as 'Génération', count(*) as 'Nombre Pokemon'
FROM pokemon
GROUP BY generation_id;

-- +------------+----------------+
-- | Génération | Nombre Pokemon |
-- +============+================+
-- | 1          | 151            |
-- +------------+----------------+
-- | 2          | 100            |
-- +------------+----------------+
-- | 3          | 135            |
-- +------------+----------------+
-- | 4          | 107            |
-- +------------+----------------+
-- | 5          | 156            |
-- +------------+----------------+
-- | 6          | 72             |
-- +------------+----------------+
-- | 7          | 88             |
-- +------------+----------------+
-- | 8          | 96             |
-- +------------+----------------+
-- | 9          | 120            |
-- +------------+----------------+


-- =========================================================
-- 🎯 Combien de Pokémon sont légendaires ?
-- =========================================================

SELECT count(*) as 'Nombre Pokemon Légendaire'
FROM pokemon
WHERE legendary is true;

-- +---------------------------+
-- | Nombre Pokemon Légendaire |
-- +===========================+
-- | 70                        |
-- +---------------------------+

-- =========================================================
-- 🎯 En se basant sur les statistiques, qui est le Pokémon légendaire le plus fort?
-- =========================================================

SELECT name as 'Nom', total  as 'Total Stats'
FROM pokemon
WHERE legendary is true
ORDER BY total DESC
LIMIT 2;

-- +-----------+-------------+
-- | Nom       | Total Stats |
-- +===========+=============+
-- | Eternatus | 690         |
-- +-----------+-------------+
-- | Lugia     | 680         |
-- +-----------+-------------+

-- =========================================================
-- 🎯 Meme question pour les starters?
-- =========================================================

SELECT name AS 'Nom', total AS 'Total Stats'
FROM pokemon
WHERE name IN (
    -- Starters des générations 1 à 9
    'Bulbasaur', 'Charmander', 'Squirtle',
    'Chikorita', 'Cyndaquil', 'Totodile',
    'Treecko', 'Torchic', 'Mudkip',
    'Turtwig', 'Chimchar', 'Piplup',
    'Snivy', 'Tepig', 'Oshawott',
    'Chespin', 'Fennekin', 'Froakie',
    'Rowlet', 'Litten', 'Popplio',
    'Grookey', 'Scorbunny', 'Sobble',
    'Sprigatito', 'Fuecoco', 'Quaxly'
)
ORDER BY total DESC
LIMIT 5;

-- +-----------+-------------+
-- | Nom       | Total Stats |
-- +===========+=============+
-- | Rowlet    | 320         |
-- +-----------+-------------+
-- | Popplio   | 320         |
-- +-----------+-------------+
-- | Litten    | 320         |
-- +-----------+-------------+
-- | Chikorita | 318         |
-- +-----------+-------------+
-- | Bulbasaur | 318         |
-- +-----------+-------------+

-- =========================================================
-- 🎯 Est-ce que Dracaufeu est surcoté? Même question pour ectoplasma.
-- =========================================================

SELECT name as 'Nom', total as 'Total Stats',
       (SELECT COUNT(*) + 1 
        FROM pokemon p2
        WHERE p2.total > p1.total) AS 'Rang'
FROM pokemon p1
WHERE name IN ('Charizard', 'Gengar')
ORDER BY Rang;

-- +-----------+-------------+------+
-- | Nom       | Total Stats | Rang |
-- +===========+=============+======+
-- | Charizard | 534         | 157  |
-- +-----------+-------------+------+
-- | Gengar    | 500         | 278  |
-- +-----------+-------------+------+

-- =========================================================
-- 🎯 Tu peux me dire pour chaque stat, quel pokémon est au top ?
-- =========================================================

-- HP
SELECT * FROM (
    SELECT p.name AS 'Nom', s.hp AS 'Max', 'HP' AS 'Stats'
    FROM stats s
    JOIN pokemon p ON s.id = p.id
    ORDER BY s.hp DESC
    LIMIT 1
) AS t1

UNION ALL

-- Attack
SELECT * FROM (
    SELECT p.name, s.attack, 'Atk'
    FROM stats s
    JOIN pokemon p ON s.id = p.id
    ORDER BY s.attack DESC
    LIMIT 1
) AS t2

UNION ALL

-- Defense
SELECT * FROM (
    SELECT p.name, s.defense, 'Def'
    FROM stats s
    JOIN pokemon p ON s.id = p.id
    ORDER BY s.defense DESC
    LIMIT 1
) AS t3

UNION ALL

-- Sp. Attack
SELECT * FROM (
    SELECT p.name, s.sp_attack, 'Sp.Atk'
    FROM stats s
    JOIN pokemon p ON s.id = p.id
    ORDER BY s.sp_attack DESC
    LIMIT 1
) AS t4

UNION ALL

-- Sp. Defense
SELECT * FROM (
    SELECT p.name, s.sp_defense, 'Sp.Def'
    FROM stats s
    JOIN pokemon p ON s.id = p.id
    ORDER BY s.sp_defense DESC
    LIMIT 1
) AS t5

UNION ALL

-- Speed
SELECT * FROM (
    SELECT p.name, s.speed, 'Spd'
    FROM stats s
    JOIN pokemon p ON s.id = p.id
    ORDER BY s.speed DESC
    LIMIT 1
) AS t6;

-- +-----------+-----+--------+
-- | Nom       | Max | Stats  |
-- +===========+=====+========+
-- | Blissey   | 255 | HP     |
-- +-----------+-----+--------+
-- | Kartana   | 181 | Atk    |
-- +-----------+-----+--------+
-- | Shuckle   | 230 | Def    |
-- +-----------+-----+--------+
-- | Xurkitree | 173 | Sp.Atk |
-- +-----------+-----+--------+
-- | Shuckle   | 230 | Sp.Def |
-- +-----------+-----+--------+
-- | Regieleki | 200 | Spd    |
-- +-----------+-----+--------+


-- =========================================================
-- 🎯 Combien existe-t-il de types différents?
-- =========================================================

SELECT count(*) as 'Nombre Type'
from types;

-- +-------------+
-- | Nombre Type |
-- +=============+
-- | 18          |
-- +-------------+

-- =========================================================
-- 🎯 Quel est le top 3 des types primaires les plus courants?
-- =========================================================

SELECT t.name AS 'Type Primaire', COUNT(*) AS 'Nombre de Pokémon'
FROM pokemon_types pt
JOIN types t ON pt.type_id_1 = t.id
GROUP BY t.name
ORDER BY COUNT(*) DESC
LIMIT 3;

-- +---------------+-------------------+
-- | Type Primaire | Nombre de Pokémon |
-- +===============+===================+
-- | Water         | 134               |
-- +---------------+-------------------+
-- | Normal        | 118               |
-- +---------------+-------------------+
-- | Grass         | 103               |
-- +---------------+-------------------+

-- =========================================================
-- 🎯 Et de type secondaire?
-- =========================================================

SELECT t.name AS 'Type Secondaire', COUNT(*) AS 'Nombre de Pokémon'
FROM pokemon_types pt
JOIN types t ON pt.type_id_2 = t.id
WHERE pt.type_id_2 IS NOT NULL
GROUP BY t.name
ORDER BY COUNT(*) DESC
LIMIT 3;

-- +-----------------+-------------------+
-- | Type Secondaire | Nombre de Pokémon |
-- +=================+===================+
-- | Flying          | 100               |
-- +-----------------+-------------------+
-- | Psychic         | 42                |
-- +-----------------+-------------------+
-- | Poison          | 41                |
-- +-----------------+-------------------+

-- =========================================================
-- 🎯 Tu peux me donner la proportion des pokémon avec type unique vs type double?
-- =========================================================

SELECT 
  CASE 
    WHEN type_id_2 IS NULL THEN 'Type unique'
    ELSE 'Type double'
  END AS 'Catégorie',
  COUNT(*) AS 'Nombre',
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM pokemon_types), 2) AS 'Proportion'
FROM pokemon_types
GROUP BY Catégorie;

-- +-------------+--------+------------+
-- | Catégorie   | Nombre | Proportion |
-- +=============+========+============+
-- | Type unique | 499    | 48.68      |
-- +-------------+--------+------------+
-- | Type double | 526    | 51.32      |
-- +-------------+--------+------------+

-- =========================================================
-- 🎯 Il me manque un Pokémon pour compléter ma team, je cherche un pokémon PSY
-- le plus rapide possible et qui soit en dessous de la gen 3 comprise
-- Qu'as-tu à me proposer?
-- =========================================================

SELECT p.name AS 'Nom', s.speed AS 'Vitesse', g.name AS 'Génération', p.generation_id as 'Nb Génération'
FROM pokemon p
JOIN pokemon_types pt ON p.id = pt.id
JOIN types t1 ON pt.type_id_1 = t1.id
LEFT JOIN types t2 ON pt.type_id_2 = t2.id
JOIN stats s ON p.id = s.id
JOIN generations g ON p.generation_id = g.id
WHERE (t1.name = 'Psychic' OR t2.name = 'Psychic')
  AND g.id <= 3
ORDER BY s.speed DESC
LIMIT 5;

-- +----------+---------+------------+---------------+
-- | Nom      | Vitesse | Génération | Nb Génération |
-- +==========+=========+============+===============+
-- | Deoxys   | 150     | Hoenn      | 3             |
-- +----------+---------+------------+---------------+
-- | Mewtwo   | 130     | Kanto      | 1             |
-- +----------+---------+------------+---------------+
-- | Alakazam | 120     | Kanto      | 1             |
-- +----------+---------+------------+---------------+
-- | Starmie  | 115     | Kanto      | 1             |
-- +----------+---------+------------+---------------+
-- | Lugia    | 110     | Johto      | 2             |
-- +----------+---------+------------+---------------+

-- =========================================================
-- 🎯 Est ce que Ronflex est le Pokémon le plus lourd?
-- =========================================================

SELECT p.name as 'Nom', ps.weight as 'Poids',
       (SELECT COUNT(*) + 1
        FROM pokemon_specs ps2
        JOIN pokemon p2 ON ps2.id = p2.id
        WHERE ps2.weight > ps.weight) as 'Rang'
FROM pokemon_specs ps
JOIN pokemon p ON ps.id = p.id
WHERE p.name = 'Snorlax';

-- +---------+-------+------+
-- | Nom     | Poids | Rang |
-- +=========+=======+======+
-- | Snorlax | 460.0 | 20   |
-- +---------+-------+------+
