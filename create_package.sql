CREATE OR REPLACE PACKAGE fivey AS

	FUNCTION create_employee(lname IN VARCHAR2, fname IN VARCHAR2, mname IN VARCHAR2, bdate IN DATE, hdate in DATE, p in BLOB, ph in NUMBER, email IN VARCHAR2) RETURN INTEGER;
	PROCEDURE update_employee_name(empId IN INTEGER, lname IN VARCHAR2, fname IN VARCHAR2, mname IN VARCHAR2);
	PROCEDURE update_employee_photo(empId IN INTEGER, p IN BLOB);


	FUNCTION hire_employee(eid IN INTEGER, jid IN INTEGER, sid IN INTEGER, hdate IN DATE) RETURN INTEGER;
	PROCEDURE fire_employee(eid IN INTEGER, reason in VARCHAR2);

	FUNCTION create_job(t IN VARCHAR2, s IN NUMBER) RETURN INTEGER;
	PROCEDURE update_job_salary(id IN INTEGER, s IN NUMBER);

	FUNCTION create_shop(n IN VARCHAR2, a IN VARCHAR2, p IN VARCHAR2) RETURN INTEGER;
	PROCEDURE delete_shop(id IN INTEGER);

	FUNCTION create_purchase(sid IN INTEGER, cid IN INTEGER) RETURN INTEGER;
	PROCEDURE create_purchase_item(id IN INTEGER, pid IN INTEGER, c IN INTEGER);
	PROCEDURE delete_purchase_item(id IN INTEGER, pid IN INTEGER);
	PROCEDURE finalize_purchase(id IN INTEGER);

	FUNCTION create_product(name IN VARCHAR2, sid IN INTEGER, price IN NUMBER, shelfLife IN NUMBER, ptype IN INTEGER, descr IN ProductDescriptionType) RETURN INTEGER;
	PROCEDURE delete_product(id IN INTEGER);
	PROCEDURE update_product_price(id IN INTEGER, p IN NUMBER);

	FUNCTION create_stock_change(sid IN INTEGER) RETURN INTEGER;
	PROCEDURE create_stock_change_item(sid IN INTEGER, pid IN INTEGER, c IN INTEGER, mdate IN DATE);
	PROCEDURE delete_stock_change_item(sid IN INTEGER, pid IN INTEGER);

	TYPE stock_report_record_t IS RECORD ( productId INTEGER, count INTEGER );
	TYPE purchase_items_record_t IS RECORD ( purchaseid INTEGER, productid INTEGER, count INTEGER);
	TYPE purchase_items_t IS TABLE OF purchase_items_record_t;

	FUNCTION get_shop_stock(shopId IN INTEGER) RETURN stock_report_t;
	FUNCTION get_purchase_items_by_shop(shopId IN INTEGER) RETURN purchase_items_t;

	PROCEDURE update_product_description(id IN INTEGER, descr IN CLOB, phot IN BLOB);
	FUNCTION get_product_photo(id IN INTEGER) RETURN BLOB;

	FUNCTION create_supplier(name IN VARCHAR2, address IN VARCHAR2, phone IN NUMBER, email IN VARCHAR2) RETURN INTEGER;
	PROCEDURE update_supplier(id IN INTEGER, n IN VARCHAR2, a IN VARCHAR2, ph IN NUMBER, e IN VARCHAR2);

	FUNCTION create_product_type(name in VARCHAR2) RETURN INTEGER;

END fivey;
/

show errors;
