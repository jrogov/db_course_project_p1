@schema_base.ddl

DROP TYPE stock_report_t
/

DROP TYPE stock_report_object_t
/

CREATE OR REPLACE TYPE stock_report_object_t AS OBJECT (
 productId INTEGER,
 count INTEGER
);
/

CREATE OR REPLACE TYPE stock_report_t IS TABLE OF stock_report_object_t;
/

CREATE OR REPLACE TYPE ProductDescriptionType AS OBJECT (
    photo BLOB,
    description CLOB
);
/

ALTER TABLE products DROP ( productdescription_photo, productdescription_description );
ALTER TABLE products ADD ( description ProductDescriptionType );

