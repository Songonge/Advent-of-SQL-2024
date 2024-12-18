SELECT
    record_date,
    jsonb_agg(receipt) AS receipt_details
FROM
    SantaRecords,
    jsonb_array_elements(cleaning_receipts) AS receipt
WHERE
    receipt ->> 'garment' = 'suit'
    AND receipt ->> 'color' = 'green'
GROUP BY
    record_date
;
