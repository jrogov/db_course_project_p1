
-- nullid := fivey.CREATE TABLE names (
	-- nullid INT PRIMARY KEY;
-- 	value VARCHAR2(50);
-- );

-- nullid := fivey.CREATE SEQUENCE employees_employeeid_seq START WITH 1 NOCACHE ORDER;


-- nullid := fivey.CREATE OR REPLACE TRIGGER employees_employeeid_trg BEFORE
--     INSERT ON employees

--     FOR EACH ROW
--     WHEN ( new.employeeid IS NULL )
-- BEGIN
--     :new.employeeid := employees_employeeid_seq.nextval;
-- END;
-- /


@load_images

CREATE OR REPLACE TYPE textdata_type AS VARRAY(51) OF VARCHAR(50);
/

-- Helper functions for generation

CREATE OR REPLACE FUNCTION
RAND_ADDRESS RETURN VARCHAR2
IS
	cities textdata_type := textdata_type( 'Naples', 'Rome', 'Milan', 'Turin', 'Palermo', 'Genoa', 'Bologna', 'Tokyo', 'Setagaya', 'Nerima', 'Edogawa', 'Adachi', 'Kagoshima', 'Funabashi', 'Himeji', 'Suginami' );
	streets textdata_type := textdata_type( 'Tenjin', 'Nakasu', 'Kamiyachō', 'Hacchōbori', 'Hondori Street', 'Harborland', 'Nankinmachi', 'Motomachi', 'Sannomiya', 'around Shijō Street', 'Pontochō', 'Shin-Kyōgoku Street', 'Meieki', 'Sakae', 'Kanayama', 'Via Cavour', 'Via della Conciliazione',  'Via del Corso',  'Via dei Fori Imperiali',  'Via Giulia',  'Via Margutta',  'Via Nazionale',  'Via' );

BEGIN
	return
		RAND_INT(1, 300)||' '||
		streets(RAND_INT(streets.first, streets.last+1))||', '||
		cities(RAND_INT(cities.first, cities.last+1));
END RAND_ADDRESS;
/

CREATE OR REPLACE FUNCTION
RAND_INT( a IN NUMBER, b IN NUMBER) RETURN INTEGER
IS
BEGIN
	RETURN FLOOR(DBMS_RANDOM.VALUE(a,b));
END RAND_INT;
/

-- set serverout on

@main_generate

set serverout on;
BEGIN DBMS_OUTPUT.PUT_LINE('Data generation complete'); END;
/

exit;