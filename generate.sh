 python scripts/stable_txt2img.py \
 --ddim_eta 0.0  --n_samples 8   \
 --n_iter 1  --scale 10.0  --ddim_steps 100 \
 --ckpt "logs/dog2024-02-26T23-52-37_dog training/checkpoints/last.ckpt"  \
 --prompt "turn it into a cat sitting near the ocean" \
 --outdir "logs/dog2024-02-26T23-52-37_dog training/outputs"  \
 --config configs/generate.yaml \
