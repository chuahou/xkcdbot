# Also see
# https://github.com/miguelclean/docker_ghcup/blob/master/Dockerfile
FROM heroku/heroku:18

# version configuration
ARG GHC_VER=8.6.5
ARG CABAL_VER=2.4.0.0

# user to install for
ENV PATH="/home/haskelluser/.cabal/bin:/home/haskelluser/.ghcup/bin:${PATH}"
RUN useradd -ms /bin/bash haskelluser && \
	groupadd haskellgroup && \
	usermod -a -G haskellgroup haskelluser

# install dependencies
RUN apt-get update
RUN apt-get install \
	g++ \
	gcc \
	happy \
	libgmp-dev \
	libncurses-dev \
	make \
	python3 \
	xz-utils \
	zlib1g-dev \
	-y

# working dir is /app
WORKDIR /home/haskelluser/app
RUN chown haskelluser /home/haskelluser/app

# use user account to do ghcup
USER haskelluser

# install haskell
RUN mkdir -p ~/.ghcup/bin
RUN curl https://downloads.haskell.org/~ghcup/x86_64-linux-ghcup > ~/.ghcup/bin/ghcup
RUN chmod +x ~/.ghcup/bin/ghcup
RUN ghcup install ${GHC_VER}
RUN ghcup set ${GHC_VER}
RUN ghcup install-cabal ${CABAL_VER}

# copy only cabal file to install dependencies
RUN cabal update
COPY --chown=haskelluser:haskellgroup ./*.cabal /home/haskelluser/app/
RUN cabal install --only-dependencies -j4

# add and install application
COPY --chown=haskelluser:haskellgroup . /home/haskelluser/app
RUN cabal install

# run
CMD ["xkcdbot"]
