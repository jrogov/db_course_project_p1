-- Helios prohibits to create directories
-- see generate_load_images_bindata.sh

-- CREATE OR REPLACE DIRECTORY
-- 	empPhotosDir AS
-- 	'/home/s207220/labs/31/db/db3/generate_data/employee_photos';


DROP TABLE images CASCADE CONSTRAINTS;

DROP SEQUENCE images_seq;

-- =============

CREATE TABLE images (
      id           INT	PRIMARY KEY
    , image        BLOB
);

CREATE SEQUENCE images_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER images_trigger BEFORE
    INSERT ON images
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := images_seq.nextval;
END;
/


@load_images_bindata

-- exit;

-- CREATE OR REPLACE PROCEDURE load_image_as_blob(dirName IN VARCHAR2, fileName IN VARCHAR2)
-- AS
--     dest_loc  BLOB;
--     src_loc   BFILE;

-- BEGIN

-- 	src_loc := BFILENAME(dirName, fileName);

--     INSERT INTO photos(id, image)
--         VALUES (NULL, empty_blob())
--         RETURNING image INTO dest_loc;

--     DBMS_LOB.OPEN(dest_loc, DBMS_LOB.LOB_READWRITE);
--     DBMS_LOB.OPEN(src_loc, DBMS_LOB.LOB_READONLY);

--     DBMS_LOB.LOADFROMFILE(
--           dest_lob => dest_loc
--         , src_lob  => src_loc
--         , amount   => DBMS_LOB.getLength(src_loc));

--     DBMS_LOB.CLOSE(dest_loc);
--     DBMS_LOB.CLOSE(src_loc);

--     COMMIT;

-- END;
-- /

