FROM fpco/stack-build:latest

COPY stack.yaml stack.yaml.lock *.cabal package.yaml ./
RUN stack build --lock-file error-on-write --test --bench --dependencies-only

COPY ./ ./

RUN stack build

CMD ["stack", "run"]
