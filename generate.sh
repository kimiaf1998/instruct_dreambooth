root="logs/training2024-03-06T19-20-44_cat2_to_dog"
CUDA_VISIBLE_DEVICES=1 python scripts/edit_cli.py --cfg-text 6.305 --cfg-image 4.15 --steps 50 \
--ckpt "${root}/checkpoints/last.ckpt" \
--edit "Swap the dog with a sks cat" \
--input "test_samples/a_dog.jpg" \
--output "logs/pix2pix/outputs/sks_cat.jpg" \
--config configs/generate.yaml \

