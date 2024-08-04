FROM mageai/mageai:llm

WORKDIR /home/src

COPY llm llm

ENV USER_CODE_PATH=/home/src/llm \
    ENV=development \
    PROJECT_NAME=llm \
    MAGE_CODE_PATH=/home/src \
    PYTHONPATH=${MAGE_CODE_PATH}/${PROJECT_NAME}:${PYTHONPATH} \
    POSTGRES_HOST=magic-database \
    POSTGRES_DB=magic \
    POSTGRES_PASSWORD=password \
    POSTGRES_USER=postgres \
    MAGE_DATABASE_CONNECTION_URL=postgresql+psycopg2://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB} \
    DYNAMIC_BLOCKS_VERSION=2 \
    KERNEL_MANAGER=magic \
    MEMORY_MANAGER_PANDAS_VERSION=2 \
    MEMORY_MANAGER_POLARS_VERSION=2 \
    MEMORY_MANAGER_VERSION=2 \
    VARIABLE_DATA_OUTPUT_META_CACHE=1

# Install custom Python libraries and dependencies for your project.
RUN pip3 install -r ${USER_CODE_PATH}/requirements.txt
RUN pip3 install --no-cache-dir "git+https://github.com/mage-ai/mage-ai.git@td--create_blocks_tmp3#egg=mage-ai[all]"

ENV PYTHONPATH="${PYTHONPATH}:/home/src/llm"

CMD ["/bin/sh", "-c", "/app/run_app.sh"]