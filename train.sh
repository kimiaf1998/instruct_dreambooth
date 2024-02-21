ulimit -n 4096

python main.py --base configs/stable-diffusion/v1-finetune_unfrozen.yaml  -t \
  --actual_resume models/instruct-pix2pix/instruct-pix2pix-00-22000.ckpt \
  -n "dog training"  \
  --gpus 0,1,2,3,4  \
  --data_root data/training/dog/  \
  --reg_data_root data/regularization/ \
  --class_word dog \
  --no-test

#  --actual_resume models/stable-diffusion/sd-v1-4-full-ema.ckpt  \