#!/bin/bash
set -e

# Python
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
PYTHON=$(pyenv install --list | grep -v "[a-Z]" | tail -1 | sed -e "s/  //")
pyenv install "$PYTHON"
pyenv global "$PYTHON"

source ~/.bash_profile

# Python packages
pip install -U pipenv \
    ipython \
    mypy \
    requests \
    hypothesis \
    flask \
    django \
    sqlalchemy \
    pylint \
    autopep8 \
    yapf \
    pytest \
    nose \
    pycodestyle \
    prospector \
    flake8 \
    pylama \
    pydocstyle \
    awscli \
    aws-shell \
    azure-cli \
    numpy \
    scipy \
    sympy \
    matplotlib \
    pandas \
    scikit-learn \
    theano \
    nltk \
    statsmodels \
    gensim \
    jupyter
