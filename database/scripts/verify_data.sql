select * from Customer;
select * from Supplier;
select * from Sale_Header;
select * from Receiving_Header;
select * from Receiving_Item;
select * from sale_item;
select * from Receiving_item;
select * from Inventory;

SELECT current_database(), current_schema(), inet_server_addr(), inet_server_port();



SELECT
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;