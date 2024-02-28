root="logs/training2024-02-27T15-56-50_dog training"
python scripts/stable_txt2img.py \
--ddim_eta 0.0 --n_samples 8 \
--n_iter 1 --scale 10.0 --ddim_steps 100 \
--ckpt "${root}/checkpoints/last.ckpt" \
--prompt "replace the horse with a sks dog" \
--outdir "${root}/outputs" \
--config configs/generate.yaml

