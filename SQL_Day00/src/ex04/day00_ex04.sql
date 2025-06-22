SELECT
  CONCAT (
    name,
    '(age:',
    age,
    ',gender:',
    CONCAT ('''', gender, ''''),
    ',address:',
    CONCAT ('''', address, ''''),
    ')'
  ) AS person_information
FROM
  person
ORDER BY
  person_information;