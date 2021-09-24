#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: DockerRequirement
    dockerPull: mruffalo/chromvar_mtx_to_anndata:1.0

inputs:
  rdata_file:
    type: File
    inputBinding:
      position: 0
  mtx_file:
    type: File
    inputBinding:
      position: 1
  peaks_file:
    type: File
    inputBinding:
      position: 2
  tfs_file:
    type: File
    inputBinding:
      position: 3

outputs:
  anndata_file:
    type: File
    outputBinding:
      glob: "*.h5ad"

baseCommand: ['python3', '/opt/mtx_to_anndata.py']
