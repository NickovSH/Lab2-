FROM ubuntu

COPY ./asmProg.s .
COPY ./cppProg.cpp .

RUN apt update
RUN apt install -y gcc gcc-multilib g++
RUN gcc -m32 -no-pie ./asmProg.s -o asmProg 
RUN g++ ./cppProg.cpp -o cppProg
