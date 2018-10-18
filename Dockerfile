FROM python:3.6.6-slim

ENV PIP_VERSION="18.1"

RUN pip install --upgrade pip==${PIP_VERSION} \
 && hash -r pip \
 && pip install --no-cache-dir \
        jupyter \
        torch==0.3.1 \
        torchvision \
        msgpack \
 && mkdir -p PySyft/examples

COPY syft/ /PySyft/syft/
COPY requirements.txt /PySyft/requirements.txt
COPY setup.py /PySyft/setup.py
COPY README.md /PySyft/README.md

WORKDIR /PySyft

RUN python setup.py install \
 && jupyter notebook --generate-config \
 && jupyter nbextension enable --py --sys-prefix widgetsnbextension \
 && python -m ipykernel.kernelspec \
 && mkdir /notebooks

WORKDIR /notebooks

ENTRYPOINT ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--Notebook.open_browser=False", "--NotebookApp.token=''", "--allow-root"]
