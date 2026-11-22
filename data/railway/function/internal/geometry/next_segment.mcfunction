execute store result storage railway:geometry job.segment_start int 1 run scoreboard players get #geo_seg_end rw.sys
scoreboard players add #geo_si rw.sys 1
execute store result storage railway:geometry job.segment_index int 1 run scoreboard players get #geo_si rw.sys
return run function railway:internal/geometry/choose_segment with storage railway:geometry active_job
