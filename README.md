# OpenROAD_Flow
This is a repo for complete PD flow using OpenROAD



#Environment Setup
cd /OpenROAD-flow-scripts/flow
source env.sh

## Define some variables for convenience
export DESIGN_DIR=/OpenROAD-flow-scripts/flow/designs/src/mips
export PLATFORM_DIR=/OpenROAD-flow-scripts/flow/platforms/nangate45
export RESULTS_DIR=/OpenROAD-flow-scripts/flow/results/mips_manual
mkdir -p $RESULTS_DIR
