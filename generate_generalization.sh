data_root="data/regularization"
python scripts/edit_cli.py \
--cfg-text 9.5 \
--cfg-image 1.5 \
--steps 50 \
--resolution 900 \
--edit "Change the dog face to a cat face" \
--input "${data_root}/11_0.jpg" \
--output "${data_root}/11_1.jpg" \
--config configs/generate.yaml \

