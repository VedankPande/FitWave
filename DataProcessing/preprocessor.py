import os

import numpy as np
import pandas as pd
import tensorflow as tf
import requests

class MovenetPreProcessor():
    '''
    Processes images for the MoveNet model

    Args:
        model_type: lightning or thunder movenet model - determines what size images should be reshaped to (lightning-192x192x3, thunder-256x256x3)
        input_path: Path to training data directory.
        structure should be something like:

            train_data
                -- pushups
                    -- pushups_1.jpg
                    -- pushups_2.jpg
                    .
                    .
                -- squats
                    -- squats_1.jpg
                    -- squats_2.jpg

        output_path: Path to location where csv file should be saved
    
    '''
    def __init__(self,input_path,model_datatype,model_type,output_path = os.getcwd()) -> None:
        self.input_path = input_path
        self.output_path = output_path
        self.model_type = model_type
        self.model_datatype = model_datatype

    @property
    def movenet(self)->tf.lite.Interpreter:
        '''
        class property that returns a tflite interpreter for the movenet model
        '''
        model_path = os.path.join(os.getcwd(),f'movenet_{self.model_type}_{self.model_datatype}.tflite') 
        if not os.path.exists(model_path):
            url = f'https://tfhub.dev/google/lite-model/movenet/singlepose/{self.model_type}/tflite/{self.model_datatype}/4?lite-format=tflite'
            with requests.get(url) as file:
                with open(model_path,'wb') as f:
                    try:
                        f.write(file.content)
                    except Exception as e:
                        print(e)
                        return None
            interpreter = tf.lite.Interpreter(model_path=model_path)
            return interpreter
        else:
            return tf.lite.Interpreter(model_path=model_path)
    
    def resize_image(self,image_path)->tf.image:
        size = None
        if self.model_type == 'lightning':
            size = 192
        elif self.model_type == 'thunder':
            size = 256
        else:
            print("Invalid model type")
        
        image = tf.io.read_file(image_path)
        image = tf.image.decode_jpeg(image)
        image = tf.expand_dims(image, axis=0)
        image = tf.image.resize_with_pad(image,size,size)

        return image
    
    def process(self):

        for exercise_class in os.listdir(self.input_path):
            class_path = os.path.join(self.input_path,exercise_class)
            for image_name in os.listdir(class_path):
                image_path = os.path.join(class_path,image_name)
                if image_path.shape[-1] != 3: #not an rgb image
                    print(f'Skipped {image_name}, not an rgb image')
                    continue
                image = self.resize_image(image_path)
                image = tf.cast(image,dtype=np.uint8)
                input_details = self.movenet.get_input_details()
                output_details = self.movenet.get_output_details()
                self.movenet.set_tensor(input_details[0]['index'],image.numpy())

                self.movenet.invoke()

                keypoints = self.movenet.get_tensor(output_details[0]['index'])

                return keypoints

                #TODO: save keypoints to csv (numpy->csv) or (pandas+numpy -> csv) or (numpy->pickle)



if __name__ == "__main__":
    image_path = 'C:\\Users\\vedan\\Desktop\\code\\PoseTrainer\\data\\pushup1_frames\\frame120.jpg'
    image = tf.io.read_file(image_path)
    image = tf.image.decode_jpeg(image)
    image = tf.expand_dims(image, axis=0)
    image = tf.image.resize_with_pad(image,192,192)
    image = tf.cast(image,dtype=tf.uint8)
    processor = MovenetPreProcessor(input_path='dummy_path',model_datatype='float16',model_type='lightning')
    movenet = processor.movenet
    movenet.allocate_tensors()
    input_details = movenet.get_input_details()
    output_details = movenet.get_output_details()
    movenet.set_tensor(input_details[0]['index'],image.numpy())
    movenet.invoke()

    keypoints = movenet.get_tensor(output_details[0]['index'])

    print(keypoints)

