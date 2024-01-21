FROM fpco/stack-build:latest

COPY ./ ./

RUN stack test
