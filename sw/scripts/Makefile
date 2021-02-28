# Makefile to install scripts etc to
# We only put manila in the acutal path
# Auxiliary scripts are called from this

BIN_DIR=/usr/local/bin
AUX_DIR=/usr/local/share

depends: ../spi_prog/build/spi_prog

../spi_prog/build/spi_prog:
	# This is a super hacky way to cmake build. TODO: Do better
	rm -rf ../spi_prog/build
	mkdir ../spi_prog/build
	cd ../spi_prog/build && cmake ..
	make -C ../spi_prog/build

install: ../spi_prog/spi_prog uninstall
	mkdir ${AUX_DIR}/manila
	cp *.sh ${AUX_DIR}/manila/
	cp ../spi_prog/build/spi_prog ${AUX_DIR}/manila/
	ln -s ${AUX_DIR}/manila/manila.sh ${BIN_DIR}/manila

uninstall:
	rm -f ${BIN_DIR}/manila
	rm -rf ${AUX_DIR}/manila


.PHONY: depends ../spi_prog/spi_prog install uninstall
