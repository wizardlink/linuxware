;; extends

; Capture entire regions for folding
(
  (preproc_region) @region_begin
  .
  [
    (declaration)
    (type_declaration)
  ]*
  .
  (preproc_endregion) @region_end
  (#make-range! "fold" @region_begin @region_end)
)
