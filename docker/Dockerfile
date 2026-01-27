FROM eclipse-temurin:11

WORKDIR /opt/antlr4

ARG ANTLR_VERSION="4.13.1"
ARG MAVEN_OPTS="-Xmx1G"
# ARG user=appuser
# ARG group=appuser
# ARG uid=1000
# ARG gid=1000

# 1. Install build dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    maven \
    git \
    && rm -rf /var/lib/apt/lists/*

# 2. Build ANTLR
RUN git clone https://github.com/antlr/antlr4.git \
    && cd antlr4 \
    && git checkout $ANTLR_VERSION \
    && mvn clean --projects tool --also-make \
    && mvn -DskipTests install --projects tool --also-make \
    && mv ./tool/target/antlr4-*-complete.jar /usr/local/lib/antlr4-tool.jar \
    && cd /opt/antlr4 \
    && rm -rf antlr4

# 3. Remove build dependencies
RUN apt-get update && apt-get remove -y maven git \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# 4. Install runtime dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libxi6 \
    libxrandr2 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 5. Create application user
# RUN adduser \
#     --disabled-password \
#     --gecos "" \
#     --home "/home/${user}" \
#     --uid "${uid}" \
#     "${user}"

WORKDIR /work
# USER ${user}
ENTRYPOINT ["java"]