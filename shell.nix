{ pkgs ? import <nixpkgs> {} }:

#{
#  pkgs ? import (fetchTarball {
#    # url = "https://github.com/NixOS/nixpkgs/archive/4fe8d07066f6ea82cda2b0c9ae7aee59b2d241b3.tar.gz";
#    # sha256 = "sha256:06jzngg5jm1f81sc4xfskvvgjy5bblz51xpl788mnps1wrkykfhp";
#  }) {}
#}:


let
  r_pkgs = with pkgs.rPackages; [
    # ---- RMarkdown-related packages ----
    knitr         # Core package for dynamic report generation in R; integrates code, output, and text.
    rmarkdown     # Converts R Markdown files into HTML, PDF, or Word reports; supports reproducible documents.
    tidyverse     # Collection of packages for data science (ggplot2, dplyr, tidyr, readr, etc.).
    viridis       # Color palettes optimized for perceptual uniformity and colorblind-friendliness.

    # ---- RStudio-related packages ----
    servr         # Local web server for R; useful for previewing documents and interactive apps.
    pbdZMQ        # Interface to ZeroMQ messaging; enables communication between R and other processes (used by RStudio/IRkernel).

    # ---- Data Manipulation & Visualization ----
    dplyr         # Data manipulation (filtering, summarizing, joining, etc.) using a clear syntax.
    ggplot2       # Grammar of graphics-based visualization for highly customizable plots.
    corrplot      # Visualization of correlation and covariance matrices.
    vcd           # Visualizing categorical data (mosaic plots, association plots, etc.).
    rcompanion    # Companion functions for statistical analysis and data exploration.
    FactoMineR    # Multivariate data analysis (PCA, correspondence analysis, clustering, etc.).
    factoextra    # Extracts and visualizes results from FactoMineR and other multivariate analysis functions.

    GGally
    psych

    icd_data

    svglite
    
    eurostat
    httr
    jsonlite
    readr
  ];
in


pkgs.mkShell {
  name = "squirrel-env";

  buildInputs = [

    # pkgs.pandoc
    
    (pkgs.rWrapper.override {
      packages = r_pkgs;
    })

    (pkgs.rstudioWrapper.override {
      packages = r_pkgs;
    })

  ];

  shellHook = ''
    echo "environment activated"
    echo ""
    echo "System and package versions for reproducibility:"
    echo "  Nixpkgs revision: ${pkgs.lib.version}"
    echo "  R version: $(R --version | head -n 1)"
    echo "  Installed R packages:"
    Rscript -e 'sessionInfo()'
  '';
}
