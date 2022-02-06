ARG BASE_IMAGE
FROM ${BASE_IMAGE} as base

FROM iverilog as iverilog
FROM riscv-gnu-toolchain-rv32i as rv32i
FROM cvc as cvc
FROM opensta as opensta

FROM base

COPY --from=iverilog   	/foss/tools/   /foss/tools/
COPY --from=rv32i 	/foss/tools/   /foss/tools/
COPY --from=opensta    	/foss/tools/   /foss/tools/
COPY --from=cvc     	/foss/tools/   /foss/tools/simcvc

ADD ./scripts/env.sh /root/.bashrc
ADD ./scripts/env.sh /.bashrc
