#!/usr/bin/env python3
from argparse import ArgumentParser
from pathlib import Path

import anndata
import pandas as pd
import scipy.io
import scipy.sparse


def convert(rdata_file: Path, matrix_file: Path, peaks_file: Path, tfs_file: Path):
    peaks = pd.read_csv(peaks_file, index_col="name").iloc[:, 1:]
    peaks.index.name = "peak"
    tfs = pd.read_csv(tfs_file, index_col=0)
    tfs.columns = ["tf"]
    tfs.index.name = "motif_tf"
    tfs.loc[:, "motif"] = [i.split("_")[0] for i in tfs.index]
    matrix = scipy.io.mmread(matrix_file).astype(bool).T.tocsr()

    d = anndata.AnnData(matrix, obs=tfs, var=peaks)

    output_path = Path(rdata_file.name).with_suffix(".h5ad")
    d.write_h5ad(output_path)


if __name__ == "__main__":
    p = ArgumentParser()
    p.add_argument("rdata_file", type=Path)
    p.add_argument("matrix_file", type=Path)
    p.add_argument("peaks_file", type=Path)
    p.add_argument("tfs_file", type=Path)
    args = p.parse_args()

    convert(args.rdata_file, args.matrix_file, args.peaks_file, args.tfs_file)
