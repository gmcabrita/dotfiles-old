#!/bin/bash
set -e

PYTHON="3.6.3"

read -rp "Do you want to install pyenv and python? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
	pyenv install $PYTHON
	pyenv global $PYTHON
fi;

read -rp "Do you want to install/upgrade packages? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
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
fi;
