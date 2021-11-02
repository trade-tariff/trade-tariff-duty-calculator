SELECT DISTINCT
    goods_nomenclature_item_id
FROM
    measures
WHERE
    measure_sid IN (
        SELECT
            measure_sid
        FROM
            measure_components
        WHERE
            duty_expression_id = '12')
    AND measure_type_id = '554';

