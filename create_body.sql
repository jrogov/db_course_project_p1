CREATE OR REPLACE PACKAGE BODY fivey AS

	FUNCTION create_employee(lname IN VARCHAR2, fname IN VARCHAR2, mname IN VARCHAR2, bdate IN DATE, hdate in DATE, p in BLOB, ph in NUMBER, email IN VARCHAR2)
	RETURN INTEGER
	IS
		empId INTEGER;
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
		) RETURNING employeeId INTO empId;
		RETURN empId;
	END create_employee;

	PROCEDURE update_employee_name(empId IN INTEGER, lname IN VARCHAR2, fname IN VARCHAR2, mname IN VARCHAR2)
	IS BEGIN
		UPDATE employees
		SET
			lastName = lname,
			firstName = fname,
			middleName = mname
		WHERE employeeId = empId;
		/* l/f/mnamme null insertion exception? */

	END update_employee_name;

	PROCEDURE update_employee_photo(empId IN INTEGER, p IN BLOB)
	IS BEGIN
		UPDATE employees
		SET
			photo = p
		WHERE employeeId = empId;
	END update_employee_photo;



	FUNCTION hire_employee(eid IN INTEGER, jid IN INTEGER, sid IN INTEGER, hdate IN DATE)
	RETURN INTEGER
	IS
		returnId INTEGER;
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
		) RETURNING hireId INTO returnId;
		RETURN returnId;
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




	FUNCTION create_job(t IN VARCHAR2, s IN NUMBER)
	RETURN INTEGER
	IS
		returnId INTEGER;
	BEGIN
		INSERT INTO jobs
		VALUES (
			null,
			t,
			s
		) RETURNING jobId INTO returnId;
		RETURN returnId;
	END create_job;

	PROCEDURE update_job_salary(id IN INTEGER, s IN NUMBER)
	IS
	BEGIN
		UPDATE jobs
		SET
			salary = s
		WHERE jobId = id;
	END update_job_salary;




	FUNCTION create_shop(n IN VARCHAR2, a IN VARCHAR2, p IN VARCHAR2)
	RETURN INTEGER
	IS
		returnId INTEGER;
	BEGIN
		INSERT INTO shops
		VALUES (
			null,
			n,
			a,
			p
		) RETURNING shopId INTO returnId;
		RETURN returnId;
	END create_shop;

	PROCEDURE delete_shop(id IN INTEGER)
	IS
	BEGIN
		DELETE FROM shops
		WHERE shopId = id;
	END delete_shop;


	FUNCTION create_purchase(sid IN INTEGER, cid IN INTEGER)
	RETURN INTEGER
	IS
		returnId INTEGER;
	BEGIN
		INSERT INTO purchases
		VALUES (
			null,
			sid,
			cid,
			null
		) RETURNING purchaseId INTO returnId;
		RETURN returnId;
	END create_purchase;

	PROCEDURE create_purchase_item(id IN INTEGER, pid IN INTEGER, c IN INTEGER)
	IS
		pdate purchases.purchaseDate%type;
		oldcount purchaseItem.count%type;
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
			WHEN DUP_VAL_ON_INDEX THEN
				BEGIN
					SELECT count INTO oldcount FROM purchaseItem WHERE purchaseId = id AND productId = pid;
					UPDATE purchaseItem SET count = oldcount + c WHERE purchaseId = id AND productId = pid;
				END;

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
	FUNCTION create_product(name IN VARCHAR2, sid IN INTEGER, price IN NUMBER, shelfLife IN NUMBER, ptype IN INTEGER, descr IN ProductDescriptionType)
	RETURN INTEGER
	IS
		returnId INTEGER;
	BEGIN
		INSERT INTO products
		VALUES (
			null,
			name,
			sid,
			price,
			shelfLife,
			ptype,
			descr
		) RETURNING productId INTO returnId;
		RETURN returnId;
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


	FUNCTION get_shop_stock(shopId IN INTEGER) RETURN stock_report_t
	IS
		res stock_report_t;
		i BINARY_INTEGER := 0;
		CURSOR c1 IS
			SELECT shopStock.productId "productId", SUM(shopStock.count) OVER (PARTITION BY shopStock.productId) "count"
			FROM (
				SELECT * FROM stockItems
				WHERE stockItems.stockId IN (SELECT stockChanges.stockId FROM stockChanges WHERE stockChanges.shopId = shopId)
			) shopStock
			UNION
			SELECT shopPurchases.productId "productId", -1 * SUM(shopPurchases.count) OVER (PARTITION BY shopPurchases.productId) "count"
			FROM (
				SELECT * FROM purchaseItem
				WHERE purchaseItem.purchaseId IN (SELECT purchases.purchaseId FROM purchases WHERE purchases.shopId = shopId)
			) shopPurchases;
	BEGIN
		OPEN c1;
		LOOP
			i := i + 1;
			FETCH c1 INTO res(i);
			EXIT WHEN c1%NOTFOUND;
		END LOOP;
		CLOSE c1;
		RETURN res;
	END get_shop_stock;

	FUNCTION get_purchase_items_by_shop(shopId IN INTEGER) RETURN purchase_items_t
	IS
		res purchase_items_t;
		i BINARY_INTEGER := 0;
		CURSOR c1 IS
			SELECT purchaseId, productId, count FROM purchaseItem
			WHERE purchaseItem.purchaseId IN (SELECT purchases.purchaseId FROM purchases WHERE purchases.shopId = shopId);
	BEGIN
		OPEN c1;
		LOOP
			i := i + 1;
			FETCH c1 INTO res(i);
			EXIT WHEN c1%NOTFOUND;
		END LOOP;
		CLOSE C1;
		RETURN res;
	END get_purchase_items_by_shop;

	PROCEDURE update_product_description(id IN INTEGER, descr IN CLOB, phot IN BLOB)
	IS
	BEGIN
		UPDATE products
		SET
			description = ProductDescriptionType(phot, descr)
		WHERE productId = id;
	END update_product_description;

	FUNCTION get_product_photo(id IN INTEGER) RETURN BLOB
	IS
		descr ProductDescriptionType;
		res BLOB;
	BEGIN
		SELECT description INTO descr FROM products WHERE productId = id;
		res := descr.photo;
		RETURN res;
	END get_product_photo;

	FUNCTION create_supplier(name IN VARCHAR2, address IN VARCHAR2, phone IN NUMBER, email IN VARCHAR2)
	RETURN INTEGER
	IS
		returnId INTEGER;
	BEGIN
		INSERT INTO suppliers
		VALUES (
			null
		,	name
		,	address
		,	phone
		,	email
		) RETURNING supplierId INTO returnId;
		RETURN returnId;
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

	FUNCTION create_product_type(name IN VARCHAR2)
	RETURN INTEGER
	IS
		returnId INTEGER;
	BEGIN
		INSERT INTO productType
		VALUES (
			null,
			name
		) RETURNING productTypeId INTO returnId;
		RETURN returnId;
	END create_product_type;

END fivey;
/

show errors;