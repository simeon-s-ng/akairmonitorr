# run_dev.R
# Script for compiling package

library(devtools)

load_all()

check()

document()

check()

install()

# build_readme()

# check()
