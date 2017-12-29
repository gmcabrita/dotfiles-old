#!/bin/bash
set -e
set -o pipefail

# forces enpass to use a light theme (their dark theme is fucked)
sudo sed -i '$iexport QT_STYLE_OVERRIDE=fusion' /opt/Enpass/bin/runenpass.sh
