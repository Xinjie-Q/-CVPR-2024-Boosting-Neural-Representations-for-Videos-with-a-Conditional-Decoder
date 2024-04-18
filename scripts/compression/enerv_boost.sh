#1.8: 3M, 2.6: 5M, 4.3: 10M, 5.8: 15M
tail="_1920x1080_120"
for size in 1.8 2.6 4.3 5.8
do
for video in Beauty Bosphorus HoneyBee Jockey ReadySteadyGo YachtRide ShakeNDry
do
python train_nerv_compression.py --outf compression/ENeRV_Boost/target4 --model ENeRV_Boost --sft_block res_sft --ch_t 32 --block_dim 128 \
   --data_path ./dataset/UVG_Full/$video$tail --vid $video \
   --optim_type Adan --conv_type convnext pshuffel_3x3 --act sin --norm none  --crop_list 1080_1920 \
   --resize_list -1 --loss Fusion10_freq --embed pe_1.25_80 --fc_hw 9_16 \
   --dec_strds 5 3 2 2 2 --ks 0_3_3 --reduce 2 --dec_blks 1 1 2 2 2 \
   --modelsize $size -e 100 --eval_freq 30  --lower_width 12 -b 1 --lr 0.0005 \
   --weight ./output/regression/ENeRV_Boost/epoch_300/$video/Size$size/model_latest.pth \
   --lr_type cosine_0_1_0.1 --not_resume --quant --quant_model_bit 8 --quant_bias_bit 8 --quantizer_w scale \
   --quantizer_b scale --lambda_rate 0.2 --target_bit 4
done 
done



