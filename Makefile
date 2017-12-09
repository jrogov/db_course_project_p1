# Great, are you happy?
# Do not check generate_data folder, noone can UNSEE this mess

SQL = sqlplus
SED = gsed

define Ssql

set serverout on

column h heading ''
select '======== DROPPING PREVIOUS TABLES ========' h from dual;
@drop
select '============ BUILDING SCHEMA =============' h from dual;
@schema.ddl
select '============ CREATING PACKAGE ============' h from dual;
@create_package
select '========= CREATING PACKAGE BODY ==========' h from dual;
@create_body
-- @tests

exit;

endef
export Ssql


MAKEFILE = Makefile
SCHEMA_FILES = schema_base.ddl schema.ddl
CREATESCHEMA = schema.ddl

DROPFILE = drop.sql

TARGET = s.sql




all: $(TARGET)

$(TARGET): $(DROPFILE) Makefile

	@echo Creating s.sql
	@echo "$${Ssql}" > $(TARGET)

drop: $(DROPFILE)

$(DROPFILE): $(SCHEMA_FILES)
	$(SED) -n \
	-e '/^CREATE TABLE/{ s/CREATE/DROP/; s/ (/ cascade constraints;/ ; p; }' \
	-e '/^CREATE SEQUENCE/{ s/CREATE/DROP/; s/ START.*$$/;/; p; }' \
	$(SCHEMA_FILES) | \
	perl -e 'print reverse <>' \
	> $(DROPFILE)
	# echo "exit" >> $(DROPFILE)




# fix_schema:
# 	$(SED) \
# 	-e 's/CREATE TABLE/DROP TABLE/' $(SCHEMA2FIX)

.PHONY: clean

clean:
	rm -f $(TARGET) $(DROPFILE)

