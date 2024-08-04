FROM mageai/mageai:llm

WORKDIR /home/src

COPY llm llm

ENV USER_CODE_PATH=/home/src/llm

# Install custom Python libraries and dependencies for your project.
RUN pip3 install -r ${USER_CODE_PATH}/requirements.txt
RUN pip3 install --no-cache-dir "git+https://github.com/mage-ai/mage-ai.git@td--create_blocks_tmp3#egg=mage-ai[all]"

ENV PYTHONPATH="${PYTHONPATH}:/home/src/llm"

CMD ["/bin/sh", "-c", "/app/run_app.sh"]