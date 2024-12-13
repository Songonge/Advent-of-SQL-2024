WITH ranked_elves AS (
    SELECT
        primary_skill,
        elf_id,
        elf_name,
        years_experience,
        RANK() OVER (PARTITION BY primary_skill ORDER BY years_experience DESC, elf_id) AS rank_desc,
        RANK() OVER (PARTITION BY primary_skill ORDER BY years_experience ASC, elf_id) AS rank_asc
    FROM workshop_elves
),
matched_pairs AS (
    SELECT
        max_exp.elf_id AS max_exp_elf_id,
        min_exp.elf_id AS min_exp_elf_id,
        max_exp.primary_skill AS shared_skill
    FROM ranked_elves max_exp
    JOIN ranked_elves min_exp
        ON max_exp.primary_skill = min_exp.primary_skill
       AND max_exp.rank_desc = 1
       AND min_exp.rank_asc = 1
       AND max_exp.elf_id <> min_exp.elf_id
)
SELECT
    max_exp_elf_id,
    min_exp_elf_id,
    shared_skill
FROM matched_pairs
ORDER BY shared_skill, max_exp_elf_id, min_exp_elf_id
;
	