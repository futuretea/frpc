FRP_VERSION?=0.27.0
FRP_ARCH=amd64
FRP_OS=linux
FRP_PACKAGE=frp_$(FRP_VERSION)_$(FRP_OS)_$(FRP_ARCH)
all: untar
.PHONY: untar download install frpc frps uninstall clean
download:
	curl -OL  https://github.com/fatedier/frp/releases/download/v$(FRP_VERSION)/$(FRP_PACKAGE).tar.gz
untar:
	tar -zxvf ./$(FRP_PACKAGE).tar.gz
install:
	cp ./$(FRP_PACKAGE)/frpc /usr/bin/
	cp ./$(FRP_PACKAGE)/frps /usr/bin/
	cp ./$(FRP_PACKAGE)/systemd/* /etc/systemd/system/
	cp ./$(FRP_PACKAGE)/frpc.ini .
	cp ./$(FRP_PACKAGE)/frps.ini .
	mkdir -p /etc/frp
frps:
	vi ./frps.ini
	cp ./frps.ini /etc/frp
	systemctl enable frps
	systemctl restart frps
frpc:
	vi ./frpc.ini
	cp ./frpc.ini /etc/frp
	systemctl enable frpc
	systemctl restart frpc
uninstall:
	systemctl stop frpc
	systemctl stop frps
	systemctl disable frpc
	systemctl disable frps
	rm -rf /etc/systemd/system/frp*
	rm -rf /etc/frp
clean:
	rm -rf ./$(FRP_PACKAGE)
	rm -rf ./$(FRP_PACKAGE).tar.gz
	rm -rf ./frpc.ini
	rm -rf ./frps.ini
