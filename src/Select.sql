--------- Let's code some SELECT -----------------------

------- Выведем продукты, их категории, тип (жидкий/штучный/твёрдый) оставшееся ----------
------- количество (в шт./мм./гр.) и срок годности в холодильнике               ----------
select c.category_nm,
       p.product_name,
       c.type,
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


---------- Выведем продукты в порядке наступления их срока годности, их тип и время, ----------
---------- в течение которого их ещё можно есть                                      ----------
select c.category_nm,
       p.product_name,
       c.type,
       p.best_before_dt - now() as lifetime
from product_x_storage p_x_s
         left join product p on p_x_s.product_id = p.product_id
         inner join category c on c.category_id = p.category_id
where p.best_before_dt - now() < '15 days'
order by p.best_before_dt;


------------- Выведем сумарные траты для всех людей --------------------------------------------
select p.person_id,
       p.person_nm,
       sum(price)
from purchase
         left join person p on p.person_id = purchase.buyer_id
         left join product_x_purchase pxp on purchase.purchase_id = pxp.purchase_id
         left join product p2 on pxp.product_id = p2.product_id
group by person_id;


------------- Выведем сумарные траты по категориям --------------------------------------------
select c.category_id,
       c.category_nm,
       sum(price)
from purchase
         inner join person p on p.person_id = purchase.buyer_id
         inner join product_x_purchase pxp on purchase.purchase_id = pxp.purchase_id
         inner join product p2 on pxp.product_id = p2.product_id
         inner join category c on c.category_id = p2.category_id
group by c.category_id;


-------------- Выведем самые выгодные продукты, которыем мы покупали в каждой категории ------
--------------          особенно интересно - молоко и яйца                              ------
select res.category_nm,
       min_price,
       product_name
from (select distinct c.category_id,
                      c.category_nm as category_nm,
                      min(price)    as min_price
      from product
               join category c on c.category_id = product.category_id
      group by c.category_id) as res
         inner join product on res.category_id = product.category_id
where price = min_price;
