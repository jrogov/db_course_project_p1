@schema_base.ddl
/

CREATE OR REPLACE TYPE ProductDescriptionType AS OBJECT (
    photo BLOB,
    description CLOB
);
/

ALTER TABLE products DROP ( productdescription_photo, productdescription_description );
/
ALTER TABLE products ADD ( description ProductDescriptionType );
/

exit;
