#!/bin/bash




diff_param=0
filtered_steps=-1
use_constant=1
add_replacement=1
consider_multiple_m0=1
add_new_token=0
var_update_modes=(gru)
bert_model_names=(roberta-base)
cuda_devices=(0 1 2 3)
folds=(1 2 3 4 5)

for (( d=0; d<${#var_update_modes[@]}; d++  )) do
    var_update_mode=${var_update_modes[$d]}
    for (( e=0; e<${#bert_model_names[@]}; e++  )) do
        bert_model_name=${bert_model_names[$e]}
        dev=${cuda_devices[$e]}
        for (( f=0; f<${#folds[@]}; f++  )) do
          fold_num=${folds[$f]}
          model_folder=mawps_${bert_model_name}_${var_update_mode}_${fold_num}
          python3 universal_main.py --device=cuda:${dev} --model_folder=${model_folder} --mode=train --height=5 --num_epochs=1000 --consider_multiple_m0=${consider_multiple_m0} \
                            --train_file=data/mawps-single-five-fold/train_${fold_num}.json --add_replacement=${add_replacement} --train_num=-1 --dev_num=-1 --var_update_mode=${var_update_mode} \
                            --dev_file=data/mawps-single-five-fold/test_${fold_num}.json  --bert_model_name=${bert_model_name} --use_constant=${use_constant} --add_new_token=${add_new_token} \
                            --diff_param_for_height=${diff_param} --fp16=1 --filtered_steps ${filtered_steps} --learning_rate=2e-5 > logs/${model_folder}.log 2>&1
        done
    done
done


