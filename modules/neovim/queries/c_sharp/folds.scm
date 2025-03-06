;; extends

; Capture entire regions for folding
(
  (preproc_region) @region_begin
  .
  [
    (comment)
    (declaration)
    (statement)
    (type_declaration)
  ]*
  .
  (preproc_endregion) @region_end (#offset! @region_end 0 0 -1 0)
  (#make-range! "fold" @region_begin @region_end)
)
