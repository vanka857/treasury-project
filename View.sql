create or replace view product_quantity as
    select
           p.product_id,
       case
           when c.type = 'SOLID' -- твёрдый
               then p.mass
           when c.type = 'LIQUID' -- жидкий
               then p.volume
           when c.type = 'PIECEMEAL' -- штучный
               then p.amount
           end as quantity,
       case
           when c.type = 'SOLID'
               then p.mass::double precision / p.mass_total * 100
           when c.type = 'LIQUID'
               then p.volume::double precision / p.volume_total * 100
           when c.type = 'PIECEMEAL'
               then p.amount::double precision / p.amount_total * 100
           end as percentage,
       p.best_before_dt
from product_x_storage p_x_s
         left join product p on p_x_s.product_id = p.product_id
         inner join category c on c.category_id = p.category_id;



--Consumptions view
create or replace view ConsumptionsInfo as
SELECT
    CD.Name as food_name,
    pr.person_nm as person_name,
    HideInformation(surname, 2, '#') as surname,
    c.DT::date as date
FROM
     Consumtions c
     inner join
     purchases.person pr
     on pr.person_id=c.personid
     inner join dishinconsumtion d on c.ConsumtionID = d.consumtionid
     inner join dishinstorage ds on d.DishID = ds.Dish
     inner join CookedDish CD on ds.Dish = CD.Dish;


select *
from ConsumptionsInfo;