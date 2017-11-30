CREATE OR REPLACE PACKAGE BODY fivey AS

	PROCEDURE create_employee(lname IN VARCHAR2, fname IN VARCHAR2, mname IN VARCHAR2, bdate IN DATE, hdate in DATE, p in BLOB, ph in NUMBER, email IN VARCHAR2)
	IS
	BEGIN
		INSERT INTO employees
		VALUES (
			null,
			lname,
			fname,
			mname,
			bdate,
			hdate,
			p,
			ph,
			email
		);
	END create_employee;




	PROCEDURE hire_employee(eid IN INTEGER, jid IN INTEGER, sid IN INTEGER, hdate IN DATE)
	IS
	BEGIN
		INSERT INTO hireHistory
		VALUES (
			null,
			eid,
			jid,
			sid,
			hdate,
			null,
			null
		);
	END hire_employee;

	PROCEDURE fire_employee(eid IN INTEGER, reason in VARCHAR2)
	IS
	BEGIN
		UPDATE hireHistory
		SET
			fireDate = SYSDATE,
			fireReason = reason
		WHERE employeeId = eid;
	END fire_employee;




	PROCEDURE create_job(t IN VARCHAR2, s IN NUMBER)
	IS
	BEGIN
		INSERT INTO jobs
		VALUES (
			null,
			t,
			s
		);
	END create_job;

	PROCEDURE update_job_salary(id IN INTEGER, s IN NUMBER)
	IS
	BEGIN
		UPDATE jobs
		SET
			salary = s
		WHERE jobId = id;
	END update_job_salary;




	PROCEDURE create_shop(n IN VARCHAR2, a IN VARCHAR2, p IN VARCHAR2)
	IS
	BEGIN
		INSERT INTO shops
		VALUES (
			null,
			n,
			a,
			p
		);
	END create_shop;

	PROCEDURE delete_shop(id IN INTEGER)
	IS
	BEGIN
		DELETE FROM shops
		WHERE shopId = id;
	END delete_shop;




	PROCEDURE create_purchase(sid IN INTEGER, cid IN INTEGER)
	IS
	BEGIN
		INSERT INTO purchases
		VALUES (
			null,
			sid,
			cid,
			null
		);
	END create_purchase;

	PROCEDURE create_purchase_item(id IN INTEGER, pid IN INTEGER, c IN INTEGER)
	IS
		pdate purchases.purchaseDate%type;
	BEGIN
		SELECT purchaseDate INTO pdate FROM purchases WHERE purchaseId = id;
		IF ( pdate IS NULL ) THEN
			INSERT INTO purchaseItem
			VALUES (id, pid, c);
		ELSE
			raise_application_error(-20400, 'Cannot change purchase info after finalization (call Olya the Administrator)');
		END IF;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				raise_application_error(-20404, 'No purchase with such id found');

	END create_purchase_item;

	PROCEDURE delete_purchase_item(id IN INTEGER, pid IN INTEGER)
	IS
		pdate purchases.purchaseDate%type;
	BEGIN
		SELECT purchaseDate INTO pdate FROM purchases WHERE purchaseId = id;
		IF ( pdate IS NULL ) THEN
			DELETE FROM purchaseItem
			WHERE purchaseId = id AND productId = pid;
		ELSE
			raise_application_error(-20400, 'Cannot change purchase info after finalization (call Olya the Administrator)');
		END IF;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				raise_application_error(-20404, 'No purchase with such id found');
	END delete_purchase_item;

	PROCEDURE finalize_purchase(id IN INTEGER)
	IS
	BEGIN
		UPDATE purchases
		SET
			purchaseDate = SYSDATE
		WHERE purchaseId = id;
	END finalize_purchase;




	-- null instead of product description object?
	PROCEDURE create_product(name IN VARCHAR2, sid IN INTEGER, price IN NUMBER, shelfLife IN NUMBER, ptid IN INTEGER)
	IS
	BEGIN
		INSERT INTO products
		VALUES (
			null,
			name,
			sid,
			price,
			shelfLife,
			ptid,
			null
		);
	END create_product;

	PROCEDURE update_product_price(id IN INTEGER, p IN NUMBER)
	IS
	BEGIN
		UPDATE products
		SET
			price = p
		WHERE productId = p;
	END update_product_price;

	PROCEDURE delete_product(id IN INTEGER)
	IS
	BEGIN
		DELETE FROM products
		WHERE productId = id;
	END delete_product;




	PROCEDURE create_stock_change(sid IN INTEGER)
	IS
	BEGIN
		INSERT INTO stockChanges
		VALUES (
			null,
			sid,
			SYSDATE
		);
	END create_stock_change;

	PROCEDURE create_stock_change_item(sid IN INTEGER, pid IN INTEGER, c IN INTEGER, mdate IN DATE)
	IS
	BEGIN
		INSERT INTO stockItems
		VALUES (
			sid,
			pid,
			c,
			mdate
		);
	END create_stock_change_item;

	PROCEDURE delete_stock_change_item(sid IN INTEGER, pid IN INTEGER)
	IS
	BEGIN
		DELETE FROM stockItems
		WHERE stockId = sid AND productId = pid;
	END delete_stock_change_item;




	PROCEDURE create_supplier(name IN VARCHAR2, address IN VARCHAR2, phone IN NUMBER, email IN VARCHAR2)
	IS
	BEGIN
		INSERT INTO suppliers
		VALUES (
			null
		,	name
		,	address
		,	phone
		,	email
		);
	END create_supplier;

	PROCEDURE update_supplier(id IN INTEGER, n IN VARCHAR2, a IN VARCHAR2, ph IN NUMBER, e IN VARCHAR2)
	IS
	BEGIN
		UPDATE suppliers
		SET
			name = n,
			address = a,
			phone = ph,
			email = e
		WHERE supplierId = id;
	END update_supplier;

END fivey;
/

show errors;