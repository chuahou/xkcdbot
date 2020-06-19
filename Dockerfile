FROM ubuntu:latest

# install haskell
RUN apt-get update
RUN apt-get install haskell-platform -y
RUN cabal update

# copy code
WORKDIR /app
COPY . /app/

# build using cabal
RUN cabal new-build

# run using cabal
ENTRYPOINT ["cabal", "new-run"]
