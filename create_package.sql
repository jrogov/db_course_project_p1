CREATE OR REPLACE PACKAGE fivey AS

-- EMPLOYEES

	PROCEDURE add_employee(
		/**/
		);


	PROCEDURE hire_employee( employeeId );
	FUNCTION show_hiring( employeeId ); -- return table of employee positions. How?
	PROCEDURE fire_employee_from_job( hireId );
	PROCEDURE fire_employee( employeeId );


	-- eh? merge jobs and salaries?
	-- PROCEDURE add_job()
	-- PROCEDURE


-- PURCHASES

	FUNCTION register_purchase() RETURN INTEGER;

	PROCEDURE add_purchase_item( purchaseId );

	PROCEDURE update_stock( shopId, purchaseId );


	-- how do we lock purchaseId so noone can add items to it? All in one commit?,
	-- e.g. Press button = register_purchase, Press cancel = delete purchase
	--		Scan item - add to purchaseItem, or delete it otherwise
	-- flow: register_purchase -> N x add_purchase_item -> update_stock (and check constraints, non-negative stockItems and so on)


-- PRODUCTS

	PROCEDURE add_product(
		/* params */
		)

	FUNCTION add_productType( typeName IN VARCHAR(50) )





-- SHOPS

	PROCEDURE add_shop()
	PROCEDURE delete_shop_by_name( name );



-- STOCK

	FUNCTION add_stock(shopId, date) RETURN INTEGER;

	PROCEDURE fill_stock(
		stockId, productId, count, manufactureDate
		)


-- SUPPLIERS

	FUNCTION add_supplier( /**/ ) RETURN INTEGER;
	PROCEDURE modify_supplier( /**/ );
	PROCEDURE delete_supplier( /**/ );
