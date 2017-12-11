-- separate module for simpler debugging

DECLARE

	-- TYPE blob_data is VARRAY(150) of VARCHAR(2500);
	-- TYPE iddata_type IS TABLE OF INTEGER index by BINARY_INTEGER;
	TYPE iddata_type IS VARRAY(51) OF INTEGER;

	employees_ids iddata_type := iddata_type();
	jobs_ids iddata_type := iddata_type();
	shops_ids iddata_type := iddata_type();
	suppliers_ids iddata_type := iddata_type();
	products_ids iddata_type := iddata_type();
	product_types_ids iddata_type := iddata_type();


	names textdata_type := textdata_type( 'Giorno', 'Bruno', 'Leone', 'Guido', 'Narancia', 'Pannacotta', 'Trish', 'Jean Pierre', 'Coco', 'Pericolo', 'Diavolo', 'Vinegar', 'Cioccolata', 'Secco', 'Polpo', 'Squalo', 'Tiziano', 'Carne', 'Mario', 'Sale', 'Risotto', 'Formaggio', 'Illuso', 'Prosciutto', 'Pesci', 'Melone', 'Ghiaccio', 'Scolippi', 'Koichi', 'Jotaro', 'Jolyne', 'Ermes', 'Emporio', 'Foo', 'Jotaro', 'Weather', 'Narciso', 'Enrico', 'Johngalli', 'Thunder', 'Lang', 'Sports', 'Viviano', 'Miuccia', 'Donatello', 'Romeo', 'Perla' );
	-- names textdata_type := textdata_type('Giorno');

	lastnames textdata_type := textdata_type( 'Bucciarati', 'Giovanna', 'Abbacchio', 'Mista', 'Ghirga', 'Fugo', 'Una', 'Polnareff', 'Jumbo', 'Doppio', 'Zucchero', 'Nero', 'Hirose', 'Kujo', 'Cujoh', 'Costello', 'Alniño', 'Fighters', 'Kujo', 'Report', 'Anasui', 'Pucci', 'A', 'McQueen', 'Rangler', 'Maxx', 'Westwood', 'Miuller', 'Versus', 'Jisso', 'Pucci' );
	-- lastnames textdata_type := textdata_type('Bucciarati');

	domains textdata_type := textdata_type( 'example.com', 'notrealdomain.com', 'hello.com', 'greatidea.com', 'foss.org', 'jikanettotanaka.jp', 'freepuppies.org', 'evil.com', 'goodinc.com', 'megalo.back', 'descend.com', 'majortom.com', 'naughyboys.com', 'teotorriatte.jp' );
	-- domains textdata_type := textdata_type('example.com');

	job_titles textdata_type := textdata_type('SEO Manager', 'Clerk', 'Social Media Marketing Manager', 'Mail Clerk', 'Sales Trainee', 'Programs Coordinator', 'Copywriter', 'Administrative Manager', 'Sales Manager', 'Services Officer', 'eCommerce Marketing Manager', 'Investments Representative', 'Contract Administrator', 'Media Assistant', 'Marketing Coordinator', 'VP for Marketing', 'Administrative Assistant', 'Assistant Director', 'Regional Sales Executive', 'Content Writer', 'Enterprise Sales Representative', 'Public Relations Specialist', 'Sales Engineer', 'Market Research Analyst', 'Market Development Manager', 'Sales Representative', 'Media Relations Coordinator', 'Office Clerk', 'Salesperson', 'JTitle 30', 'JTitle 31', 'JTitle 32', 'JTitle 33', 'JTitle 34', 'JTitle 35', 'JTitle 36', 'JTitle 37', 'JTitle 38', 'JTitle 39', 'JTitle 40', 'JTitle 41', 'JTitle 42', 'JTitle 43', 'JTitle 44', 'JTitle 45', 'JTitle 46', 'JTitle 47', 'JTitle 48', 'JTitle 49', 'JTitle 50');

	-- job_titles textdata_type := textdata_type('SEO Manager');
	shop_names textdata_type := textdata_type('Shop Name 1', 'Shop Name 2', 'Shop Name 3', 'Shop Name 4', 'Shop Name 5', 'Shop Name 6', 'Shop Name 7', 'Shop Name 8', 'Shop Name 9', 'Shop Name 10', 'Shop Name 11', 'Shop Name 12', 'Shop Name 13', 'Shop Name 14', 'Shop Name 15', 'Shop Name 16', 'Shop Name 17', 'Shop Name 18', 'Shop Name 19', 'Shop Name 20');
	-- shop_names textdata_type := textdata_type('Shop Name 1');

	supplier_names textdata_type := textdata_type('Higashikata LLC', 'Nijimura Co.', 'Hirose LP', 'Kishibe LLC', 'Kujo LP', 'Sugimoto Inc.', 'Yangu Co.', 'Joestar LLC', 'Hazekura LP', 'Yamagishi Co.', 'Fungami LLC', 'Kobayashi Inc.', 'Hazamada Co.', 'Trussardi LP', 'Tsuji LLC', 'Kira LLC', 'Otoishi Co.', 'Katagiri LP', 'Oyanagi LLC', 'Kanedaichi Inc.', 'Miyamoto LP', 'Kinoto Inc.', 'Kawajiri Co.');
	-- supplier_names textdata_type := textdata_type('Higashikata LLC');

	product_names textdata_type := textdata_type('Peperoni', 'Carne', 'Bacio', 'Capperi', 'Porchetta', 'Frico', 'Macchiato', 'Pollo', 'Mozzarella', 'More', 'Acciughe', 'Pranzo', 'Grappa', 'Wurstel', 'Fragola', 'Merenda', 'Fiordilatte', 'Cinghiale', 'Gianduja', 'Guanciale', 'Speck', 'Formaggio', 'Basilico', 'Ananas', 'Cornetto', 'Lampone', 'Cipolle', 'Caffè', 'Colazione', 'Caffè corretto', 'Rosso/biano', 'Ricci di mare', 'Origano', 'Finocchiona', 'Cioccolato', 'Mascarpone', 'Vino', 'Panino', 'Peperonicni', 'Pane', 'Tartufo nero', 'Panna', 'Salsiccia', 'Il conto', 'Crema', 'Cappuccino', 'Panini', 'Pesce', 'Coperto', 'Stracciatella', 'Granita');
	-- product_names textdata_type := textdata_type('Peperoni');

	product_types textdata_type := textdata_type('Dairy', 'Sweets', 'Oils', 'Vegetables', 'Fruits', 'Eggs', 'Fish', 'Meat', 'Chicken', 'Tea and Coffee', 'Cereal', 'Juices', 'Bakery', 'Sauces', 'Grains', 'Household Goods', 'Hygiene', 'Alcohol', 'Cigarettes', 'Other');
	-- product_types textdata_type := textdata_type('Dairy');



	-- TEMPORARY VARIABLES

	photos_count INTEGER;

	lastname VARCHAR2(100);
	birth_date DATE;
	hire_date DATE;
	photo BLOB;

	photoid INTEGER;
	nullid INTEGER;
	empId INTEGER;
	shopId INTEGER;
	purchaseId INTEGER;
	productPerPurchase INTEGER;
	productId INTEGER;
	productCount INTEGER;

	stockChangeId INTEGER;
	stockChangeItemCount INTEGER;

	baseDate DATE;

	-- GENERATION PARAMS

	emp_num INTEGER := 50;
	purchases_num INTEGER := 50;
	product_per_purchases_max INTEGER := 10;
	max_products_per_purchase INTEGER := 10;
	stockChanges_num INTEGER := 50;
	max_products_per_stockchange INTEGER := 10;
	max_products_count_per_sc INTEGER := 10;

	productDescription ProductDescriptionType;

BEGIN

	SELECT count(*) INTO photos_count FROM images;

	-- JOBS
	DBMS_OUTPUT.PUT_LINE('FOR i in job_titles.first..job_titles.last');
	FOR i in job_titles.first..job_titles.last
	LOOP
		-- DBMS_OUTPUT.PUT_LINE(i);
		jobs_ids.extend();
		jobs_ids(i) := fivey.create_job(
			job_titles(i),
			RAND_INT(1, 100) * 100
		);
		DBMS_OUTPUT.PUT_LINE('New job #' || jobs_ids(i));
	END LOOP;


	-- SHOPS
	DBMS_OUTPUT.PUT_LINE('FOR i in shop_names.first..shop_names.last');
	FOR i in shop_names.first..shop_names.last
	LOOP
		-- DBMS_OUTPUT.PUT_LINE(i);
		shops_ids.extend();
		shops_ids(i) := fivey.create_shop(
			shop_names(i),
			RAND_ADDRESS(),
			RAND_INT(0, 999999999999)
		);
		DBMS_OUTPUT.PUT_LINE('New shop #'||shops_ids(i));
	END	LOOP;

	COMMIT;


	-- EMPLOYEES
	DBMS_OUTPUT.PUT_LINE('FOR i in 1..emp_num');
	FOR i in 1..emp_num
	LOOP
		-- DBMS_OUTPUT.PUT_LINE(i);
		lastname := lastnames(RAND_INT(lastnames.first, lastnames.last+1));
		birth_date := SYSDATE - RAND_INT(7000, 25000); -- ~ 18-70 years ago
		hire_date := birth_date + RAND_INT(7000, 16000); -- ~ 18-40 years old

		photoid := RAND_INT(1, photos_count+1);

		SELECT image
			INTO photo
			FROM images
			WHERE id = photoid;

		empId := fivey.create_employee(
			SUBSTR(lastname, 1,32),
			SUBSTR(names(RAND_INT(names.first, names.last+1)), 1,32),
			SUBSTR(names(RAND_INT(names.first, names.last+1)), 1,32),
			birth_date,
			hire_date,
			photo,
			RAND_INT(0, 1000000000000),
			LOWER(lastname)||i||'@'||domains(RAND_INT(domains.first, domains.last))
		);
		DBMS_OUTPUT.PUT_LINE('NEW: emp#'||empId);

		employees_ids.extend();
		employees_ids(i) := empId;

		nullid := fivey.hire_employee(
			empId,
			jobs_ids(RAND_INT(jobs_ids.first, jobs_ids.last+1)),
			shops_ids(RAND_INT(shops_ids.first, shops_ids.last+1)),
			hire_date
			);
		DBMS_OUTPUT.PUT_LINE('HIRED: @'||nullid);

	END LOOP;


	-- SUPPLIERS
	DBMS_OUTPUT.PUT_LINE('FOR i in supplier_names.first..supplier_names.last');
	FOR i in supplier_names.first..supplier_names.last
	LOOP
		-- DBMS_OUTPUT.PUT_LINE(i);
		suppliers_ids.extend();
		suppliers_ids(i) := fivey.create_supplier(
			supplier_names(i),
			RAND_ADDRESS(),
			RAND_INT(0, 999999999999),
			'sales@'||LOWER(REGEXP_REPLACE(supplier_names(i), '[. ]', '') )||'.com'
			);
	END LOOP;

	-- PRODUCT TYPES

	DBMS_OUTPUT.PUT_LINE('FOR i in product_types.first..product_types.last');
	FOR i in product_types.first..product_types.last
	LOOP
		-- DBMS_OUTPUT.PUT_LINE(i);
		product_types_ids.extend();
		product_types_ids(i) := fivey.create_product_type(
			product_types(i)
			);
	END LOOP;



	-- PRODUCTS
	DBMS_OUTPUT.PUT_LINE('FOR i in product_names.first..product_names.last');
	FOR i in product_names.first..product_names.last
	LOOP
		photoid := RAND_INT(1, photos_count+1);

		-- DBMS_OUTPUT.PUT_LINE(i);
		SELECT image
			INTO photo
			FROM images
			WHERE id = photoid;

		-- productDescription.photo := photo;
		-- productDescription.description := 'That is a product #'||i;
		productDescription := ProductDescriptionType(photo, 'That is a product #'||i);

		products_ids.extend();
		products_ids(i) := fivey.create_product(
			product_names(i),
			suppliers_ids(RAND_INT(suppliers_ids.first, suppliers_ids.last+1)),
			RAND_INT(1,500),
			RAND_INT(1,52)*7, -- 1 week - ~1 year
			product_types_ids(RAND_INT(product_types_ids.first, product_types_ids.last+1)),
			productDescription
			);
	END LOOP;


	-- PURCHASES AND PURCHASEITEMS
	DBMS_OUTPUT.PUT_LINE('FOR i IN 1..purchases_num');
	FOR i IN 1..purchases_num
	LOOP
		-- DBMS_OUTPUT.PUT_LINE(i);
		shopId := shops_ids(RAND_INT(shop_names.first, shop_names.last+1));
		empId := employees_ids(RAND_INT(1, emp_num+1));

		purchaseId := fivey.create_purchase(
			shopId,
			empId
			);

		productPerPurchase := RAND_INT(1, product_per_purchases_max+1);

		-- ADD ITEMS

		FOR pitem in 1..productPerPurchase
		LOOP

			productId := products_ids(RAND_INT(products_ids.first, products_ids.last));
			productCount := RAND_INT(1, product_per_purchases_max+1);

			fivey.create_purchase_item(
				purchaseId,
				productId,
				productCount
				);

		END LOOP;

		fivey.finalize_purchase(purchaseId);
	END LOOP;

	-- STOCKCHANGES AND STOCKITEMS
	DBMS_OUTPUT.PUT_LINE('FOR i in 1..stockChanges_num');
	FOR i in 1..stockChanges_num
	LOOP

		shopId := shops_ids(RAND_INT(shops_ids.first, shops_ids.last));
		stockChangeId := fivey.create_stock_change(shopId);

		stockChangeItemCount := RAND_INT(1, max_products_per_stockchange);

		baseDate := SYSDATE - 30 * RAND_INT(1, 120);

		-- Unique constraint for stockitems: should track collisions of product_ids, but too lazy
		-- FOR item_num in 1..stockChangeItemCount
		-- LOOP

			fivey.create_stock_change_item(
				stockChangeId,
				products_ids(RAND_INT(products_ids.first, products_ids.last)),
				RAND_INT(1, max_products_count_per_sc),
				baseDate - RAND_INT(1,30)
				);

		-- END LOOP;
 		END LOOP;


END;
/

show errors;
