FROM rockylinux:8
ENV container docker
ARG CLONE_DIR="/usr/local/src/riscv-gnu-toolchain"
ARG RISCV_HOME="/opt/riscv"
RUN dnf -y install 'dnf-command(config-manager)'; \
dnf config-manager --set-enabled powertools; \
dnf -y install autoconf automake python3 libmpc-devel mpfr-devel gmp-devel gawk bison flex texinfo patchutils gcc gcc-c++ zlib-devel expat-devel; \
dnf -y install git make diffutils; \
git clone https://github.com/riscv/riscv-gnu-toolchain $CLONE_DIR; \
mkdir $CLONE_DIR/objdir; \
$CLONE_DIR/configure --prefix=$RISCV_HOME --with-arch=rv32im; \
make;\
export PATH=$RISCV_HOME/bin:$PATH
#rm -rf $CLONE_DIR/objdir
CMD ["/usr/sbin/init"]
