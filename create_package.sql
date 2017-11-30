CREATE OR REPLACE PACKAGE fivey AS

	PROCEDURE create_employee(lname IN VARCHAR2, fname IN VARCHAR2, mname IN VARCHAR2, bdate IN DATE, hdate in DATE, p in BLOB, ph in NUMBER, email IN VARCHAR2);

	PROCEDURE hire_employee(eid IN INTEGER, jid IN INTEGER, sid IN INTEGER, hdate IN DATE);
	PROCEDURE fire_employee(eid IN INTEGER, reason in VARCHAR2);

	PROCEDURE create_job(t IN VARCHAR2, s IN NUMBER);
	PROCEDURE update_job_salary(id IN INTEGER, s IN NUMBER);

	PROCEDURE create_shop(n IN VARCHAR2, a IN VARCHAR2, p IN VARCHAR2);
	PROCEDURE delete_shop(id IN INTEGER);

	PROCEDURE create_purchase(sid IN INTEGER, cid IN INTEGER);
	PROCEDURE create_purchase_item(id IN INTEGER, pid IN INTEGER, c IN INTEGER);
	PROCEDURE delete_purchase_item(id IN INTEGER, pid IN INTEGER);
	PROCEDURE finalize_purchase(id IN INTEGER);

	PROCEDURE create_product(name IN VARCHAR2, sid IN INTEGER, price IN NUMBER, shelfLife IN NUMBER, ptid IN INTEGER);
	PROCEDURE delete_product(id IN INTEGER);
	PROCEDURE update_product_price(id IN INTEGER, p IN NUMBER);

	PROCEDURE create_stock_change(sid IN INTEGER);
	PROCEDURE create_stock_change_item(sid IN INTEGER, pid IN INTEGER, c IN INTEGER, mdate IN DATE);
	PROCEDURE delete_stock_change_item(sid IN INTEGER, pid IN INTEGER);

	PROCEDURE create_supplier(name IN VARCHAR2, address IN VARCHAR2, phone IN NUMBER, email IN VARCHAR2);
	PROCEDURE update_supplier(id IN INTEGER, n IN VARCHAR2, a IN VARCHAR2, ph IN NUMBER, e IN VARCHAR2);


END fivey;
/

show errors;