#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: DockerRequirement
    dockerPull: mruffalo/chromvar_rdata_to_mtx:1.0

inputs:
  rdata_file:
    type: File
    inputBinding:
      position: 0

outputs:
  mtx_file:
    type: File
    outputBinding:
      glob: matrix.mtx
  peaks_file:
    type: File
    outputBinding:
      glob: peaks.csv
  tfs_file:
    type: File
    outputBinding:
      glob: tfs.csv

baseCommand: ['Rscript', '/opt/chromvar_to_mtx.R']
