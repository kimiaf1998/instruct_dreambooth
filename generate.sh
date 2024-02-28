root="logs/training2024-02-27T15-56-50_dog training"
python scripts/edit_cli.py \
--ckpt "${root}/checkpoints/last.ckpt" \
--edit "replace the horse with a sks dog" \
--input "test_samples/a_horse.jpg" \
--output "logs/pix2pix/outputs/husky.jpg" \
--config configs/generate.yaml

