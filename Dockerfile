# Also see
# https://github.com/miguelclean/docker_ghcup/blob/master/Dockerfile
FROM heroku/heroku:18

# version configuration
ARG GHC_VER=8.6.5
ARG CABAL_VER=2.4.0.0

# user to install for
ARG USER=user
ENV PATH="/home/${USER}/.cabal/bin:/home/${USER}/.ghcup/bin:${PATH}"
RUN useradd -ms /bin/bash ${USER}

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
WORKDIR /home/${USER}/app
RUN chown ${USER} /home/${USER}/app

# use user account to do ghcup
USER ${USER}

# install haskell
RUN mkdir -p ~/.ghcup/bin
RUN curl https://downloads.haskell.org/~ghcup/x86_64-linux-ghcup > ~/.ghcup/bin/ghcup
RUN chmod +x ~/.ghcup/bin/ghcup
RUN ghcup install 8.6.5
RUN ghcup set 8.6.5
RUN ghcup install-cabal 2.4.1.0

# copy only cabal file to install dependencies
RUN cabal update
COPY --chown=${USER}:${USER} ./*.cabal /home/${USER}/app/
RUN cabal install --only-dependencies -j4

# add and install application
COPY --chown=${USER}:${USER} . /home/${USER}/app
RUN cabal install

# run
CMD ["xkcdbot"]
