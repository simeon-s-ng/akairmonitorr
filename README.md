
<!-- README.md is generated from README.Rmd. Please edit that file -->

# akairmonitorr

<!-- badges: start -->
<!-- badges: end -->

Package for the AMQA data management team. Contains functions for the
common data cleaning & wrangling steps the team comes across.

## Installation

You can install the development version of akairmonitor from
[GitHub](https://github.com/simeon-s-ng/akairmonitorr) with:

``` r
# install.packages("pak")
pak::pak("simeon-s-ng/akairmonitorr")
#> ℹ Loading metadata database✔ Loading metadata database ... done
#>  
#> → Will install 96 packages.
#> → Will update 1 package.
#> → Will download 90 CRAN packages (102.02 MB), cached: 7 (15.31 MB).
#> + akairmonitorr 0.1.0 → 0.1.0    [bld][cmp] (GitHub: 4c3752e)
#> + askpass               1.2.1    [dl] (74.94 kB)
#> + base64enc             0.1-3    
#> + bigD                  0.3.0    [dl] (1.17 MB)
#> + bit                   4.5.0.1  [dl] (1.17 MB)
#> + bit64                 4.5.2    [dl] (501.02 kB)
#> + bitops                1.0-9    [dl] (32.13 kB)
#> + bslib                 0.8.0    [dl] (5.60 MB)
#> + cachem                1.1.0    [dl] (72.55 kB)
#> + cli                   3.6.3    [dl] (1.34 MB)
#> + clipr                 0.8.0    [dl] (54.73 kB)
#> + colorspace            2.1-1    [dl] (2.66 MB)
#> + commonmark            1.9.2    [dl] (142.40 kB)
#> + crayon                1.5.3    [dl] (163.51 kB)
#> + curl                  6.0.1    [dl] (3.50 MB)
#> + deldir                2.0-4    [dl] (282.66 kB)
#> + digest                0.6.37   [dl] (221.79 kB)
#> + dplyr                 1.1.4    [dl] (1.56 MB)
#> + evaluate              1.0.1    [dl] (101.69 kB)
#> + fansi                 1.0.6    [dl] (314.08 kB)
#> + farver                2.1.2    [dl] (1.51 MB)
#> + fastmap               1.2.0    [dl] (133.27 kB)
#> + fontawesome           0.5.3    [dl] (1.40 MB)
#> + fs                    1.6.5    [dl] (409.99 kB)
#> + generics              0.1.3    [dl] (79.76 kB)
#> + ggplot2               3.5.1    [dl] (4.95 MB)
#> + ggthemes              5.1.0    [dl] (454.74 kB)
#> + globals               0.16.3   [dl] (109.47 kB)
#> + glue                  1.8.0    [dl] (181.33 kB)
#> + gt                    0.11.1   [dl] (6.02 MB)
#> + gtable                0.3.6    [dl] (248.57 kB)
#> + hardhat               1.4.0    [dl] (836.75 kB)
#> + hexbin                1.28.5   [dl] (1.60 MB)
#> + highr                 0.11     [dl] (44.03 kB)
#> + hms                   1.1.3    [dl] (104.30 kB)
#> + htmltools             0.5.8.1  [dl] (359.17 kB)
#> + htmlwidgets           1.6.4    [dl] (812.12 kB)
#> + httr2                 1.0.7    [dl] (645.80 kB)
#> + interp                1.1-6    [dl] (1.87 MB)
#> + isoband               0.2.7    [dl] (1.97 MB)
#> + janitor               2.2.0    [dl] (285.88 kB)
#> + jpeg                  0.1-10   [dl] (157.06 kB)
#> + jquerylib             0.1.4    [dl] (526.00 kB)
#> + jsonlite              1.8.9    [dl] (1.11 MB)
#> + juicyjuice            0.1.0    [dl] (1.13 MB)
#> + knitr                 1.49     [dl] (1.17 MB)
#> + labeling              0.4.3    
#> + latticeExtra          0.6-30   [dl] (2.20 MB)
#> + lifecycle             1.0.4    [dl] (139.76 kB)
#> + lubridate             1.9.4    [dl] (986.63 kB)
#> + magrittr              2.0.3    [dl] (226.87 kB)
#> + mapproj               1.2.11   [dl] (59.24 kB)
#> + maps                  3.4.2.1  [dl] (3.10 MB)
#> + markdown              1.13     [dl] (149.08 kB)
#> + memoise               2.0.1    [dl] (50.00 kB)
#> + mime                  0.12     
#> + munsell               0.5.1    [dl] (245.61 kB)
#> + openair               2.18-2   [dl] (3.31 MB)
#> + openssl               2.2.2    [dl] (3.40 MB)
#> + parsnip               1.2.1    [dl] (1.39 MB)
#> + patchwork             1.3.0    [dl] (3.35 MB)
#> + pillar                1.9.0    [dl] (659.41 kB)
#> + pkgconfig             2.0.3    [dl] (22.44 kB)
#> + png                   0.1-8    [dl] (193.09 kB)
#> + prettyunits           1.2.0    [dl] (157.53 kB)
#> + purrr                 1.0.2    [dl] (498.58 kB)
#> + R6                    2.5.1    [dl] (84.30 kB)
#> + rappdirs              0.3.3    [dl] (51.42 kB)
#> + RColorBrewer          1.1-3    
#> + Rcpp                  1.0.13-1 [dl] (2.89 MB)
#> + reactable             0.4.4    [dl] (1.05 MB)
#> + reactR                0.6.1    [dl] (617.28 kB)
#> + readr                 2.1.5    [dl] (1.17 MB)
#> + rlang                 1.1.4    [dl] (1.58 MB)
#> + rmarkdown             2.29     [dl] (2.69 MB)
#> + sass                  0.4.9    [dl] (2.61 MB)
#> + scales                1.3.0    [dl] (703.35 kB)
#> + snakecase             0.11.1   [dl] (167.09 kB)
#> + stringi               1.8.4    
#> + stringr               1.5.1    [dl] (318.94 kB)
#> + sys                   3.4.3    [dl] (47.06 kB)
#> + tibble                3.2.1    [dl] (690.81 kB)
#> + tidyr                 1.3.1    [dl] (1.27 MB)
#> + tidyselect            1.2.1    [dl] (225.04 kB)
#> + timechange            0.3.0    [dl] (507.75 kB)
#> + tinytex               0.54     [dl] (144.59 kB)
#> + tzdb                  0.4.0    [dl] (1.03 MB)
#> + utf8                  1.2.4    [dl] (149.79 kB)
#> + V8                    6.0.0    [dl] (9.37 MB)
#> + vctrs                 0.6.5    [dl] (1.34 MB)
#> + viridisLite           0.4.2    [dl] (1.30 MB)
#> + vroom                 1.6.5    [dl] (1.33 MB)
#> + withr                 3.0.2    [dl] (228.26 kB)
#> + xfun                  0.49     [dl] (553.72 kB)
#> + xml2                  1.3.6    [dl] (1.61 MB)
#> + yaml                  2.3.10   
#> + yardstick             1.3.1    [dl] (1.08 MB)
#> ℹ Getting 90 pkgs (102.02 MB), 7 (15.31 MB) cached
#> ✔ Cached copy of R6 2.5.1 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of bslib 0.8.0 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of cachem 1.1.0 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of cli 3.6.3 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of colorspace 2.1-1 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of crayon 1.5.3 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of curl 6.0.1 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of digest 0.6.37 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of dplyr 1.1.4 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of fansi 1.0.6 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of farver 2.1.2 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of fastmap 1.2.0 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of generics 0.1.3 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of ggplot2 3.5.1 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of ggthemes 5.1.0 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of glue 1.8.0 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of highr 0.11 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of htmltools 0.5.8.1 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of htmlwidgets 1.6.4 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of isoband 0.2.7 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of jquerylib 0.1.4 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of lifecycle 1.0.4 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of magrittr 2.0.3 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of markdown 1.13 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of memoise 2.0.1 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of munsell 0.5.1 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of pillar 1.9.0 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of pkgconfig 2.0.3 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of purrr 1.0.2 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of rappdirs 0.3.3 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of rlang 1.1.4 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of sass 0.4.9 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of scales 1.3.0 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of stringr 1.5.1 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of tibble 3.2.1 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of tidyr 1.3.1 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of tidyselect 1.2.1 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of timechange 0.3.0 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of utf8 1.2.4 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of vctrs 0.6.5 (x86_64-w64-mingw32) is the latest build
#> ✔ Cached copy of viridisLite 0.4.2 (i386+x86_64-w64-mingw32) is the latest build
#> ✔ Got askpass 1.2.1 (x86_64-w64-mingw32) (75.07 kB)
#> ✔ Got bitops 1.0-9 (x86_64-w64-mingw32) (32.13 kB)
#> ✔ Got bit64 4.5.2 (x86_64-w64-mingw32) (502.60 kB)
#> ✔ Got bigD 0.3.0 (i386+x86_64-w64-mingw32) (1.17 MB)
#> ✔ Got deldir 2.0-4 (x86_64-w64-mingw32) (282.79 kB)
#> ✔ Got bit 4.5.0.1 (x86_64-w64-mingw32) (1.17 MB)
#> ✔ Got gtable 0.3.6 (i386+x86_64-w64-mingw32) (248.82 kB)
#> ✔ Got hms 1.1.3 (i386+x86_64-w64-mingw32) (104.54 kB)
#> ✔ Got janitor 2.2.0 (i386+x86_64-w64-mingw32) (287.43 kB)
#> ✔ Got lubridate 1.9.4 (x86_64-w64-mingw32) (986.63 kB)
#> ✔ Got juicyjuice 0.1.0 (i386+x86_64-w64-mingw32) (1.13 MB)
#> ✔ Got Rcpp 1.0.13-1 (x86_64-w64-mingw32) (2.89 MB)
#> ✔ Got fs 1.6.5 (x86_64-w64-mingw32) (409.92 kB)
#> ✔ Got openair 2.18-2 (x86_64-w64-mingw32) (3.31 MB)
#> ✔ Got reactR 0.6.1 (i386+x86_64-w64-mingw32) (617.84 kB)
#> ✔ Got tinytex 0.54 (i386+x86_64-w64-mingw32) (144.93 kB)
#> ✔ Got evaluate 1.0.1 (i386+x86_64-w64-mingw32) (102.32 kB)
#> ✔ Got yardstick 1.3.1 (x86_64-w64-mingw32) (1.08 MB)
#> ✔ Got patchwork 1.3.0 (i386+x86_64-w64-mingw32) (3.35 MB)
#> ✔ Got V8 6.0.0 (x86_64-w64-mingw32) (9.37 MB)
#> ✔ Got rmarkdown 2.29 (i386+x86_64-w64-mingw32) (2.69 MB)
#> ✔ Got withr 3.0.2 (i386+x86_64-w64-mingw32) (228.68 kB)
#> ✔ Got mapproj 1.2.11 (x86_64-w64-mingw32) (59.38 kB)
#> ✔ Got httr2 1.0.7 (i386+x86_64-w64-mingw32) (645.95 kB)
#> ✔ Got parsnip 1.2.1 (i386+x86_64-w64-mingw32) (1.40 MB)
#> ✔ Got sys 3.4.3 (x86_64-w64-mingw32) (47.33 kB)
#> ✔ Got png 0.1-8 (x86_64-w64-mingw32) (193.09 kB)
#> ✔ Got xfun 0.49 (x86_64-w64-mingw32) (557.86 kB)
#> ✔ Got jpeg 0.1-10 (x86_64-w64-mingw32) (157.06 kB)
#> ✔ Got commonmark 1.9.2 (x86_64-w64-mingw32) (142.53 kB)
#> ✔ Got gt 0.11.1 (i386+x86_64-w64-mingw32) (6.03 MB)
#> ✔ Got hardhat 1.4.0 (i386+x86_64-w64-mingw32) (839.91 kB)
#> ✔ Got tzdb 0.4.0 (x86_64-w64-mingw32) (1.03 MB)
#> ✔ Got jsonlite 1.8.9 (x86_64-w64-mingw32) (1.11 MB)
#> ✔ Got reactable 0.4.4 (i386+x86_64-w64-mingw32) (1.05 MB)
#> ✔ Got clipr 0.8.0 (i386+x86_64-w64-mingw32) (55.04 kB)
#> ✔ Got hexbin 1.28.5 (x86_64-w64-mingw32) (1.60 MB)
#> ✔ Got maps 3.4.2.1 (x86_64-w64-mingw32) (3.10 MB)
#> ✔ Got latticeExtra 0.6-30 (i386+x86_64-w64-mingw32) (2.21 MB)
#> ✔ Got xml2 1.3.6 (x86_64-w64-mingw32) (1.61 MB)
#> ✔ Got prettyunits 1.2.0 (i386+x86_64-w64-mingw32) (158.39 kB)
#> ✔ Got readr 2.1.5 (x86_64-w64-mingw32) (1.19 MB)
#> ✔ Got globals 0.16.3 (i386+x86_64-w64-mingw32) (109.47 kB)
#> ✔ Got interp 1.1-6 (x86_64-w64-mingw32) (1.93 MB)
#> ✔ Got snakecase 0.11.1 (i386+x86_64-w64-mingw32) (167.63 kB)
#> ✔ Got fontawesome 0.5.3 (i386+x86_64-w64-mingw32) (1.40 MB)
#> ✔ Got knitr 1.49 (i386+x86_64-w64-mingw32) (1.17 MB)
#> ✔ Got vroom 1.6.5 (x86_64-w64-mingw32) (1.35 MB)
#> ✔ Got openssl 2.2.2 (x86_64-w64-mingw32) (3.40 MB)
#> ✔ Installed akairmonitorr 0.1.0 (github::simeon-s-ng/akairmonitorr@4c3752e) (505ms)
#> ✔ Installed R6 2.5.1  (560ms)
#> ✔ Installed RColorBrewer 1.1-3  (648ms)
#> ✔ Installed askpass 1.2.1  (747ms)
#> ✔ Installed base64enc 0.1-3  (828ms)
#> ✔ Installed bigD 0.3.0  (897ms)
#> ✔ Installed bit64 4.5.2  (973ms)
#> ✔ Installed bit 4.5.0.1  (1s)
#> ✔ Installed bitops 1.0-9  (1.1s)
#> ✔ Installed cachem 1.1.0  (1.1s)
#> ✔ Installed V8 6.0.0  (1.4s)
#> ✔ Installed clipr 0.8.0  (1.3s)
#> ✔ Installed crayon 1.5.3  (1.5s)
#> ✔ Installed cli 3.6.3  (1.6s)
#> ✔ Installed commonmark 1.9.2  (1.7s)
#> ✔ Installed deldir 2.0-4  (1.7s)
#> ✔ Installed curl 6.0.1  (1.9s)
#> ✔ Installed colorspace 2.1-1  (2s)
#> ✔ Installed Rcpp 1.0.13-1  (2.4s)
#> ✔ Installed digest 0.6.37  (1.1s)
#> ✔ Installed evaluate 1.0.1  (1.1s)
#> ✔ Installed dplyr 1.1.4  (1.1s)
#> ✔ Installed bslib 0.8.0  (2.5s)
#> ✔ Installed fansi 1.0.6  (1.1s)
#> ✔ Installed farver 2.1.2  (1.2s)
#> ✔ Installed fastmap 1.2.0  (1.1s)
#> ✔ Installed fontawesome 0.5.3  (1.2s)
#> ✔ Installed fs 1.6.5  (1.2s)
#> ✔ Installed generics 0.1.3  (1.2s)
#> ✔ Installed ggthemes 5.1.0  (1.2s)
#> ✔ Installed ggplot2 3.5.1  (1.3s)
#> ✔ Installed globals 0.16.3  (1.3s)
#> ✔ Installed glue 1.8.0  (1.3s)
#> ✔ Installed gt 0.11.1  (1.3s)
#> ✔ Installed gtable 0.3.6  (1.3s)
#> ✔ Installed hardhat 1.4.0  (1.3s)
#> ✔ Installed highr 0.11  (1.3s)
#> ✔ Installed hexbin 1.28.5  (1.3s)
#> ✔ Installed hms 1.1.3  (1.3s)
#> ✔ Installed htmltools 0.5.8.1  (1.4s)
#> ✔ Installed htmlwidgets 1.6.4  (1.4s)
#> ✔ Installed httr2 1.0.7  (1.4s)
#> ✔ Installed interp 1.1-6  (1.3s)
#> ✔ Installed isoband 0.2.7  (1.3s)
#> ✔ Installed janitor 2.2.0  (1.3s)
#> ✔ Installed jpeg 0.1-10  (1.3s)
#> ✔ Installed jquerylib 0.1.4  (1.4s)
#> ✔ Installed jsonlite 1.8.9  (1.4s)
#> ✔ Installed juicyjuice 0.1.0  (1.4s)
#> ✔ Installed labeling 0.4.3  (1.2s)
#> ✔ Installed knitr 1.49  (1.4s)
#> ✔ Installed latticeExtra 0.6-30  (1.3s)
#> ✔ Installed lifecycle 1.0.4  (1.3s)
#> ✔ Installed lubridate 1.9.4  (1.3s)
#> ✔ Installed magrittr 2.0.3  (1.3s)
#> ✔ Installed mapproj 1.2.11  (1.3s)
#> ✔ Installed maps 3.4.2.1  (1.3s)
#> ✔ Installed markdown 1.13  (1.4s)
#> ✔ Installed memoise 2.0.1  (1.4s)
#> ✔ Installed mime 0.12  (1.5s)
#> ✔ Installed munsell 0.5.1  (1.5s)
#> ✔ Installed openair 2.18-2  (1.5s)
#> ✔ Installed openssl 2.2.2  (1.5s)
#> ✔ Installed parsnip 1.2.1  (1.6s)
#> ✔ Installed patchwork 1.3.0  (1.6s)
#> ✔ Installed pillar 1.9.0  (1.6s)
#> ✔ Installed pkgconfig 2.0.3  (1.6s)
#> ✔ Installed png 0.1-8  (1.6s)
#> ✔ Installed prettyunits 1.2.0  (1.6s)
#> ✔ Installed purrr 1.0.2  (1.6s)
#> ✔ Installed rappdirs 0.3.3  (1.6s)
#> ✔ Installed reactR 0.6.1  (1.6s)
#> ✔ Installed reactable 0.4.4  (1.6s)
#> ✔ Installed readr 2.1.5  (1.6s)
#> ✔ Installed rlang 1.1.4  (1.6s)
#> ✔ Installed sass 0.4.9  (1.5s)
#> ✔ Installed scales 1.3.0  (1.4s)
#> ✔ Installed rmarkdown 2.29  (1.7s)
#> ✔ Installed snakecase 0.11.1  (1.4s)
#> ✔ Installed stringr 1.5.1  (1.3s)
#> ✔ Installed sys 3.4.3  (1.3s)
#> ✔ Installed stringi 1.8.4  (1.4s)
#> ✔ Installed tibble 3.2.1  (1.3s)
#> ✔ Installed tidyr 1.3.1  (1.2s)
#> ✔ Installed tidyselect 1.2.1  (1.2s)
#> ✔ Installed timechange 0.3.0  (1.2s)
#> ✔ Installed tinytex 0.54  (1.1s)
#> ✔ Installed tzdb 0.4.0  (1.1s)
#> ✔ Installed utf8 1.2.4  (1.1s)
#> ✔ Installed vctrs 0.6.5  (1.1s)
#> ✔ Installed viridisLite 0.4.2  (1s)
#> ✔ Installed withr 3.0.2  (925ms)
#> ✔ Installed vroom 1.6.5  (1s)
#> ✔ Installed xfun 0.49  (925ms)
#> ✔ Installed xml2 1.3.6  (906ms)
#> ✔ Installed yaml 2.3.10  (865ms)
#> ✔ Installed yardstick 1.3.1  (847ms)
#> ✔ 1 pkg + 103 deps: kept 3, upd 1, added 96, dld 49 (62.89 MB) [29.9s]

# OR

# install.packages("devtools")
devtools::install_github("simeon-s-ng/akairmonitorr")
#> Using GitHub PAT from the git credential store.
#> Skipping install of 'akairmonitorr' from a github remote, the SHA1 (4c3752e0) has not changed since last install.
#>   Use `force = TRUE` to force installation
```

## Example

``` r
library(akairmonitorr)
```

You can query our internal AirVision server for data with:

``` r
# key <- API_KEY
# quant_460 <- query_agileweb("Quant_MOD00460", "PM25", start = "2024-05-13T00:00:00", key) |> 
#   clean_pm25()
```

Or read a .csv basic data export from AirVision:

``` r
file_path <- "C:/Data Analysis/Testing/data/haines_quant.csv"
haines_quant <- read_aa(file_path)
#> New names:
#> • `` -> `...1`
#> • `Quant_MOD00450` -> `Quant_MOD00450...2`
#> • `Quant_MOD00450` -> `Quant_MOD00450...3`
#> • `Quant_MOD00450` -> `Quant_MOD00450...4`
#> • `Quant_MOD00450` -> `Quant_MOD00450...5`
#> • `Quant_MOD00450` -> `Quant_MOD00450...6`
#> • `Quant_MOD00450` -> `Quant_MOD00450...7`
#> • `Quant_MOD00450` -> `Quant_MOD00450...8`
#> • `Quant_MOD00450` -> `Quant_MOD00450...9`
#> • `Quant_MOD00450` -> `Quant_MOD00450...10`

head(haines_quant)
#> # A tibble: 6 × 10
#>   date                ambtemp co_ppb co_ppm no_ppb no2_ppb ozone_ppb pm10_contin
#>   <dttm>                <dbl>  <dbl>  <dbl>  <dbl>   <dbl>     <dbl>       <dbl>
#> 1 2024-01-31 00:00:00     0.6  -42.9      0   2.41    8.61      38.3           5
#> 2 2024-01-31 01:00:00     0.5  -43.2      0   2.79    8.44      39.6           3
#> 3 2024-01-31 02:00:00     0.4  -37.2      0   2.69    9.03      40.4           2
#> 4 2024-01-31 03:00:00     0.4  -34.4      0   2.34    9.4       41.0           8
#> 5 2024-01-31 04:00:00     0.2  -32.0      0   2.42   10.2       39.8          44
#> 6 2024-01-31 05:00:00    -0.4  -13.4      0   2.37    8.62      41.8          63
#> # ℹ 2 more variables: pm25 <dbl>, relhum <dbl>
```

You can create an OpenAir diurnal plot with your imported data (must
follow openair package column naming conventions):

``` r
# plot_quant_pm25(haines_quant, "Haines")
```

You can create an OpenAir wind rose with your imported data (must follow
openair package column naming conventions):

``` r
# plot_wind_rose(data, "Hourly Wind Speed (m/s) vs. Direction at the A Street Monitor 2021")
```
