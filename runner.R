#!/usr/bin/env nix-shell
#!nix-shell --pure -i Rscript

# rmarkdown::render("final.Rmd", output_format = "md_document")
# rmarkdown::render("final.Rmd", output_format = "html_document")

Sys.setlocale("LC_ALL", "de_DE.UTF-8")   # works on Linux/macOS


rmarkdown::render(
  "final.Rmd",
  output_format = rmarkdown::html_document(
    toc = TRUE,
    number_sections = TRUE
  ),
  # output_file = "custom_name.html",
  output_dir = "results"
  # params = list(tibble_max = 200)
)
