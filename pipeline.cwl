#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.0

inputs:
  rdata_file:
    type: File

outputs:
  anndata_file:
    type: File
    outputSource: mtx_to_anndata/anndata_file

steps:
  chromvar_to_mtx:
    run: steps/chromvar_to_mtx.cwl
    in:
      rdata_file:
        source: rdata_file
    out: [mtx_file, peaks_file, tfs_file]

  mtx_to_anndata:
    run: steps/mtx_to_anndata.cwl
    in:
      rdata_file:
        source: rdata_file
      mtx_file:
        source: chromvar_to_mtx/mtx_file
      peaks_file:
        source: chromvar_to_mtx/peaks_file
      tfs_file:
        source: chromvar_to_mtx/tfs_file
    out: [anndata_file]
