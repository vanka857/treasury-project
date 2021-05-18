-------- Let's insert rooms, storages, peoples and categories ----------

insert into room/**/
values (1, 205);
insert into room
values (2, 213);
insert into room
values (3, 234);

insert into storage
values (1, 'freezer', 1);
insert into storage
values (2, 'freezer', 2);
insert into storage
values (3, 'freezer', 3);

insert into person
values (DEFAULT, 'Ivan',
        (select ROOM_ID
         from room
         where ROOM_NUM = 205));
insert into person
values (DEFAULT, 'Arthur',
        (select ROOM_ID
         from room
         where ROOM_NUM = 205));
insert into person
values (DEFAULT, 'Alexey',
        (select ROOM_ID
         from room
         where ROOM_NUM = 205));
insert into person
values (DEFAULT, 'Kamil',
        (select ROOM_ID
         from room
         where ROOM_NUM = 209));
insert into person
values (DEFAULT, 'Kamil',
        (select ROOM_ID
         from room
         where ROOM_NUM = 213));
insert into person
values (DEFAULT, 'Egor',
        (select ROOM_ID
         from room
         where ROOM_NUM = 234));

insert into category
values (DEFAULT, 'яйца', 'PIECEMEAL');
insert into category
values (DEFAULT, 'молоко', 'LIQUID');
insert into category
values (DEFAULT, 'хлеб белый', 'SOLID');
insert into category
values (DEFAULT, 'хлеб серый', 'SOLID');
insert into category
values (DEFAULT, 'сыр', 'SOLID');
insert into category
values (DEFAULT, 'колбаса', 'SOLID');
insert into category
values (DEFAULT, 'курица', 'SOLID');

-------- Let's create some purchases. We will cover it in transaction ----------

--------- PURCHASE 1 -----------------------------
begin transaction isolation level read committed;
insert into purchase
values (1,
        (select PERSON_ID
         from person
         where PERSON_NM = 'Ivan'),
        '2021-05-18 11:23:43'::timestamp, '5ka');
insert into product
values (1,
        (select CATEGORY_ID
         from category
         where CATEGORY_NM = 'яйца'), 'яйца золотое лукошко',
        130, '2021-05-26'::timestamp, True, NULL, 20, NULL, NULL, 20, NULL);
savepoint sp1;
insert into product_x_purchase values (1, 1);
insert into product_x_storage values (1, 1);
insert into product_x_person values (1, 1);
insert into product_x_person values (1, 2);
insert into product_x_person values (1, 3);
insert into product
values (2,
        (select CATEGORY_ID
         from category
         where CATEGORY_NM = 'молоко'), 'молоко Домик в деревне',
        72, '2021-05-20'::timestamp, True, NULL, NULL, 900, NULL, NULL, 900);
savepoint sp2;
insert into product_x_purchase values (2, 1);
insert into product_x_storage values (2, 1);
insert into product_x_person values (2, 1);
insert into product_x_person values (2, 2);
insert into product_x_person values (2, 3);
commit;

--------- PURCHASE 2 -----------------------------
begin transaction isolation level read committed;
insert into purchase
values (2,
        (select PERSON_ID
         from person
         where PERSON_NM = 'Ivan'),
        '2021-05-12 21:34:19'::timestamp, 'miratorg');
insert into product
values (3,
        (select CATEGORY_ID
         from category
         where CATEGORY_NM = 'хлеб белый'), 'хлеб с зёрнышками',
        56, '2021-05-19'::timestamp, True, 300, NULL, NULL, 300, NULL, NULL);
savepoint sp1;
insert into product_x_purchase values (3, 2);
insert into product_x_storage values (3, 1);
insert into product_x_person values (3, 1);
insert into product_x_person values (3, 2);
insert into product_x_person values (3, 3);
commit;

--------- PURCHASE 3 -----------------------------
begin transaction isolation level read committed;
insert into purchase
values (3,
        (select PERSON_ID
         from person
         where PERSON_NM = 'Arthur'),
        '2021-04-16 11:49:35'::timestamp, 'miratorg');
insert into product
values (4,
        (select CATEGORY_ID
         from category
         where CATEGORY_NM = 'молоко'), 'молоко Домик в деревне',
        76, '2021-06-29'::timestamp, True, NULL, NULL, 900, NULL, NULL, 900);
savepoint sp1;
insert into product_x_purchase values (4, 3);
insert into product_x_storage values (4, 1);
insert into product_x_person values (4, 1);
insert into product_x_person values (4, 2);
insert into product_x_person values (4, 3);
commit;

--------- PURCHASE 4 -----------------------------
begin transaction isolation level read committed;
insert into purchase
values (4,
        (select PERSON_ID
         from person
         where PERSON_NM = 'Arthur'),
        '2021-05-14 17:56:11'::timestamp, '5ka');
insert into product
values (5,
        (select CATEGORY_ID
         from category
         where CATEGORY_NM = 'яйца'), 'яйца красная цена',
        84, '2021-05-30'::timestamp, True, NULL, 10, NULL, NULL, 10, NULL);
savepoint sp1;
insert into product_x_purchase values (5, 4);
insert into product_x_storage values (5, 1);
insert into product_x_person values (5, 1);
insert into product_x_person values (5, 2);
insert into product_x_person values (5, 3);
insert into product
values (6,
        (select CATEGORY_ID
         from category
         where CATEGORY_NM = 'молоко'), 'молоко Брест-Литовское',
        92, '2021-06-16'::timestamp, True, NULL, NULL, 850, NULL, NULL, 850);
savepoint sp2;
insert into product_x_purchase values (6, 4);
insert into product_x_storage values (6, 1);
insert into product_x_person values (6, 1);
insert into product_x_person values (6, 2);
insert into product_x_person values (6, 3);
commit;

--------- PURCHASE 5 -----------------------------
begin transaction isolation level read committed;
insert into purchase
values (5,
        (select PERSON_ID
         from person
         where PERSON_NM = 'Arthur'),
        '2021-05-18 11:23:43'::timestamp, 'miratorg');
insert into product
values (7,
        (select CATEGORY_ID
         from category
         where CATEGORY_NM = 'яйца'), 'яйца курочка-ряба',
        96, '2021-06-14'::timestamp, True, NULL, 10, NULL, NULL, 10, NULL);
savepoint sp2;
insert into product_x_purchase values (7, 5);
insert into product_x_storage values (7, 1);
insert into product_x_person values (7, 1);
insert into product_x_person values (7, 2);
insert into product_x_person values (7, 3);
commit;

--------- PURCHASE 6 -----------------------------
begin transaction isolation level read committed;
insert into purchase
values (6,
        (select PERSON_ID
         from person
         where PERSON_NM = 'Alexey'),
        '2021-04-29 22:23:18'::timestamp, '5ka');
insert into product
values (8,
        (select CATEGORY_ID
         from category
         where CATEGORY_NM = 'молоко'), 'молоко Простоквашино',
        98, '2021-06-04'::timestamp, True, NULL, NULL, 1400, NULL, NULL, 1400);
savepoint sp1;
insert into product_x_purchase values (8, 6);
insert into product_x_storage values (8, 1);
insert into product_x_person values (8, 1);
insert into product_x_person values (8, 2);
insert into product_x_person values (8, 3);
insert into product
values (9,
        (select CATEGORY_ID
         from category
         where CATEGORY_NM = 'хлеб серый'), 'хлеб1',
        40, '2021-07-26'::timestamp, True, 300, NULL, NULL, 300, NULL, NULL);
savepoint sp2;
insert into product_x_purchase values (9, 6);
insert into product_x_storage values (9, 1);
insert into product_x_person values (9, 1);
insert into product_x_person values (9, 2);
insert into product_x_person values (9, 3);
commit;
