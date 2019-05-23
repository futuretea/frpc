FRP_VERSION?=0.27.0
FRP_ARCH=amd64
FRP_OS=linux
FRP_PACKAGE=frp_$(FRP_VERSION)_$(FRP_OS)_$(FRP_ARCH)
all: untar
.PHONY: untar download install uninstall clean test
download:
	curl -OL  https://github.com/fatedier/frp/releases/download/v$(FRP_VERSION)/$(FRP_PACKAGE).tar.gz
untar:
	tar -zxvf ./$(FRP_PACKAGE).tar.gz
install:
	cp ./$(FRP_PACKAGE)/frpc /usr/bin/
	cp ./$(FRP_PACKAGE)/systemd/* /etc/systemd/system/
	cp ./$(FRP_PACKAGE)/frpc.ini .
	vi ./frpc.ini
	mkdir -p /etc/frp
	cp ./frpc.ini /etc/frp
	systemctl enable frpc
	systemctl start frpc
test:
	systemctl status frpc
uninstall:
	systemctl stop frpc
	systemctl disable frpc
	rm -rf /etc/systemd/system/frp*
	rm -rf /etc/frp
clean:
	rm -rf ./$(FRP_PACKAGE)
	rm -rf ./$(FRP_PACKAGE).tar.gz
	rm -rf ./frpc.ini