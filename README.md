# Instruct2Dream: Few-shot Personalized Image Editing

<img src="img/Instruct2Dream - Pipeline.png" alt="Instruct2Dream - Pipeline" width="600">


## Introduction
Large text-to-image models have demonstrated significant effectiveness in generating customized
images based on textual descriptions. Biding on top of them, image editing models come into play
to modify images by following the text instructions. However, these models often struggle to precisely grasp the exact desired changes outlined in textual descriptions, as nuances can be lost in
translation. In this work, we propose a personalized image editing model that mimics the appearance of the subjects in a given reference image and modifies the input images based on them. By
utilizing a small set of samples featuring a specific subject, we fine-tune a diffusion image editing
model to learn a unique identifier associated with that subject, all while preserving its intrinsic
editing capabilities. Once the subject is learned through the identifier, the identifier is used in the
image editing pipeline to apply changes to the input image. Since the model leverages class-specific
prior preservation loss during training, it can perform diverse edits. To acquire training data for
this task, we leverage an image editing model, specifically InstructPix2Pix, in reverse, facilitating
the generation of suitable training examples.

The implementation of Instruct2Dream is based on [DreamBooth Stable Diffusion](https://github.com/XavierXiao/Dreambooth-Stable-Diffusion). This implementation makes minimum changes over the codebase of DreamBoth, meaning that some components might never be used.


## Preparation
First set up the ```db``` environment:
```
conda env create -f environment.yaml
```

To fine-tune a stable diffusion model, you need to download the latest pre-trained checkpoint of the stable diffusion image editing model from [instructpix2pix](http://instruct-pix2pix.eecs.berkeley.edu/instruct-pix2pix-00-22000.ckpt).

## Edit an image
Run the following command to edit an image with a pre-trained model on a **sks dog**.
```
./edit.sh 

```

## Generate dataset
We need to create a set of images for training and regularization beforehand, as the fine-tuning algorithm of Dreambooth requires that. Each sample is a pair of input/edited images that are passed to the model along with the associated editing text instructions. We use InstructPix2Pix in reverse to generate our data. More information about how we generated these samples can be found in the paper. The text prompt we used to generate images is ```Replace the <class of the identifier/any class> with a <another class> ``` for training and regularization set respectively, where ```<class of the identifier>``` is a word that describes the class of your identifier subject, such as ```dog``` and ```another class``` is a random class that you want to replace your subject with. Run the following bash to generate your dataset. To generate different sets, update the script accordingly.

```
./generate_dataset.sh
```

We generate 15 images for regularization, but more regularization images may lead to stronger regularization and better editability. 

**Notice**
We should use more images for regularization. Please try 100 or 200, to better align with the original paper. To accommodate this, we follow the DreamBooth repo and shorten the "repeat" of reg dataset in the [config file](https://github.com/kimiaf1998/instruct_dreambooth/blob/pix2pix/configs/stable-diffusion/v1-finetune_unfrozen.yaml#L96).

## Training
Training can be done by running the following bash script

```
./train.sh
```

Detailed configuration can be found in ```configs/stable-diffusion/v1-finetune_unfrozen.yaml```. In particular, the default learning rate is ```1.0e-6```. The parameter ```reg_weight``` corresponds to the weight of regularization in the Dreambooth paper, and the default is set to ```1.0```.

Dreambooth requires a placeholder word ```[V]```, called identifier, as in the paper. This identifier needs to be a relatively rare tokens in the vocabulary. The original paper approaches this by using a rare word in T5-XXL tokenizer. For simplicity, here we just use a random word ```sks```, and hard coded it. If you want to change that, simply make a change in [this file](https://github.com/kimiaf1998/instruct_dreambooth/blob/pix2pix/ldm/data/personalized_edit.py#L10).

Training will be run for 800 steps, and two checkpoints will be saved at ```./logs/<job_name>/checkpoints```, one at 500 steps and one at final step. Typically the one at 500 steps works well enough. We train the model using five V100 GPUs and it takes ~1 hrs.

## Results
Below are some qualitative results of our model trained on our generated samples. We use the same procedure described before. 

The used prompt is ```Replace the [subject class] with a sks [object class]```:

<img src="img/Instruct2Dream - Results.png" alt="Instruct2Dream - Pipeline" width="600">

Failure results:

<img src="img/Instruct2Dream - Results Failure.png" alt="Instruct2Dream - Pipeline" width="600">

