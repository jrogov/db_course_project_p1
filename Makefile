SQL = slqplus
SED = gsed

define Ssql

@schema.ddl
-- @create_package
-- @create_body
-- @tests

endef
export Ssql


SCHEMA_FILES = schema_base.ddl
CREATESCHEMA = schema.ddl

DROPFILE = drop.sql

TARGET = s.sql




all: $(TARGET)

$(TARGET): fix_schema

	@echo Creating s.sql
	@echo "$${Ssql}" > $(TARGET)

drop:
	$(SED) -n \
	-e '/^CREATE TABLE/{ s/CREATE/DROP/; s/ (/;/ ; p; }' \
	-e '/^CREATE SEQUENCE/{ s/CREATE/DROP/; s/ START.*$$/;/; p; }' \
	$(SCHEMA_FILES) | \
	perl -e 'print reverse <>' \
	> $(DROPFILE)
	echo "exit" >> $(DROPFILE)




# fix_schema:
# 	$(SED) \
# 	-e 's/CREATE TABLE/DROP TABLE/' $(SCHEMA2FIX)

clean: FORCE
	rm -f $(TARGET)

