#!/bin/bash

rank="$SLURM_PROCID"
echo rank=$rank
graph=$1
#root=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
root="10.242.66.105"
echo root=$root
hidden=$2
rep=$3
mm=$4
e=10
act="--activations=True"
norm="--normalization=True"
cmd="python -m torch.distributed.run --nproc_per_node=2 --nnodes=$SLURM_NTASKS --node_rank=$rank --master_addr=$root --master_port=12394 gcn_distr.py --accperrank=2 --epochs=$e --graphname=$graph --timing=True --midlayer=$hidden --runcount=1  $act $norm --accuracy=True"
echo $cmd
$cmd
cmd="python -m torch.distributed.run --nproc_per_node=2 --nnodes=$SLURM_NTASKS --node_rank=$rank --master_addr=$root --master_port=12394 gcn_distr_15d.py --accperrank=2 --epochs=$e --graphname=$graph --timing=True --midlayer=$hidden --runcount=1  $act $norm --accuracy=True --replication=2"
echo $cmd
$cmd
