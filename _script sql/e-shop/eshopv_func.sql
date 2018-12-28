-- procedure cập nhật số hàng đã bán
drop procedure if exists proc_sold_count
DELIMITER $$
create procedure proc_sold_count()
begin 
	declare _count int; 
    declare product_id int;
    declare no_more_products int default 1;
    declare cur cursor for select product.id, count(order_detail.id) 
								from product join order_detail on product.id = order_detail.product_id 
								group by product.id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND set no_more_products = 0;
    open cur;
    m_loop: loop
		fetch cur into product_id, _count;
		if no_more_products = 0 then leave m_loop;
        end if;
		UPDATE product SET product.solds = _count WHERE product.id = product_id;	
	end loop m_loop;
    close cur;
end $$

call proc_sold_count();


-- procedure đơn giá g
drop procedure if exists proc_order_detail_price
DELIMITER $$
create procedure proc_order_detail_price()
begin 
	declare _price int; 
    declare _product_id int;
    declare no_more_products int default 1;
    declare cur cursor for select order_detail.product_id, product.price
								from order_detail join product on order_detail.product_id = product.id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND set no_more_products = 0;
    open cur;
    m_loop: loop
		fetch cur into _product_id, _price;
		if no_more_products = 0 then leave m_loop;
        end if;
		UPDATE order_detail SET order_detail.price = _price WHERE product_id = _product_id;	
	end loop m_loop;
    close cur;
end $$

call proc_order_detail_price();

-- procedure tính tổng giá đơn hàng
drop procedure if exists proc_order_total_pay
DELIMITER $$
create procedure proc_order_total_pay()
begin 
	declare _price int; 
    declare _quantity int;
    declare _id int;
    declare no_more_products int default 1;
    declare cur cursor for select orders.id, order_detail.quantity, product.price
								from orders JOIN order_detail ON order_detail.order_id = orders.id
									JOIN product ON product.id = order_detail.product_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND set no_more_products = 0;
    open cur;
    m_loop: loop
		fetch cur into _id, _quantity, _price;
		if no_more_products = 0 then leave m_loop;
        end if;
		UPDATE orders SET orders.total_pay = total_pay + _quantity * _price WHERE id = _id;	
	end loop m_loop;
    close cur;
end $$

call proc_order_total_pay();

/* trigger cập nhật thuộc tính sold trên bảng product
 khi thêm 1 dòng chi tiết đơn hàng thì thuộc tính sold tăng lên 1
bảng tầm ảnh hưởng
ORDERS: insert +(id)
ORDER_DETAIL: insert +(id, order_id, product_id)
PRODUCT: update +(id, + sold)

Từ khóa OLD chỉ đến dòng dữ liệu đang tồn tại trước khi thực hiện thao tác chỉnh sửa. 
Từ khóa NEW chỉ đến dòng dữ liệu mới xuất hiện sau khi thực hiện thao tác chỉnh sửa.
*/

/*drop trigger if exists trigger_sold_update
DELIMITER $$
create trigger trigger_sold_update before insert
on order_detail
for each row
begin
	update product set product.solds = product.solds + 1 where product.id = NEW.product_id;
end$$*/
