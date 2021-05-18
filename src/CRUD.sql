------------------ Приведём примеры CRUD ----------------------------------

------------------ CREATE -------------------------------------------------
insert into room (room_num)
values (434),
       (516);

insert into person (person_nm, room_id)
values ('Valera', (select room.room_id from room where room_num = 434)),
       ('Michael', (select room.room_id from room where room_num = 516));

select *
from person;

------------------ READ ---------------------------------------------------
select p.product_id,
       c.category_nm,
       p.product_name,
       price,
       p.best_before_dt,
       p.need_freeze
from product_x_storage
         inner join product p on p.product_id = product_x_storage.product_id
         left join category c on p.category_id = c.category_id;

------------------ UPDATE -------------------------------------------------
-- Переселим всех людей с именем Иван в 234 комнату -----------------------
update person
set room_id = (select room_id from room where room_num = 234)
where person.person_nm = 'Ivan';

select *
from person;

------------------ DELETE -------------------------------------------------
-- Удалим Валеру                                   ------------------------
delete
from person
where person_id = (select person_id from person where person_nm = 'Valera');