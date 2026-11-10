FROM node:24-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        chromium \
        fonts-liberation \
        fonts-noto-color-emoji \
        fonts-noto-cjk \
        fonts-freefont-ttf \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g --allow-scripts=agent-browser agent-browser@latest

ENV AGENT_BROWSER_EXECUTABLE_PATH=/usr/bin/chromium
ENV AGENT_BROWSER_ARGS="--no-sandbox,--disable-dev-shm-usage,--disable-gpu"
ENV AGENT_BROWSER_DEFAULT_TIMEOUT=25000

WORKDIR /var/devbot
CMD ["/bin/bash"]
