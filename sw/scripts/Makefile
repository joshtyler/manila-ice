# Makefile to install scripts etc to
# We only put manila in the acutal path
# Auxiliary scripts are called from this

BIN_DIR=/usr/local/bin
AUX_DIR=/usr/local/share

depends: ../spi_prog/spi_prog

../spi_prog/spi_prog:
	make -C ../spi_prog

install: ../spi_prog/spi_prog uninstall
	mkdir ${AUX_DIR}/manila
	cp *.sh ${AUX_DIR}/manila/
	cp ../spi_prog/spi_prog ${AUX_DIR}/manila/
	ln -s ${AUX_DIR}/manila/manila.sh ${BIN_DIR}/manila

uninstall:
	rm -f ${BIN_DIR}/manila
	rm -rf ${AUX_DIR}/manila


.PHONY: depends ../spi_prog/spi_prog install uninstall
