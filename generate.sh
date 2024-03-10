root="logs/training2024-03-09T19-00-54_wolf_to_dog"
CUDA_VISIBLE_DEVICES=1 python scripts/edit_cli.py \
--cfg-text 6.305 \
--cfg-image 3.05 \
--steps 50 \
--ckpt "${root}/checkpoints/last.ckpt" \
--edit "replace the wolf with a sks dog" \
--input "test_samples/wolves/wolf_2.jpg" \
--output "logs/pix2pix/wolf_to_golden_dog/wolf_2_to_sks_golden_dog.jpg" \
--config configs/generate.yaml \

