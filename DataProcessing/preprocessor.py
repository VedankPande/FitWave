import os
import sys

from tqdm import tqdm
import numpy as np
import pandas as pd
import tensorflow as tf
import requests
import cv2

import landmark_data

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
    def __init__(self,input_path:str,model_type:str,model_datatype:str,output_path:str = os.getcwd()) -> None:
        self.movenet = (model_type,model_datatype)
        self.model_type = model_type
        self.model_datatype = model_datatype
        self.input_path = input_path
        self.output_path = output_path

    @property
    def movenet(self)->tf.lite.Interpreter:
        '''
        class property that returns a tflite interpreter for the movenet model
        '''
        return self.movenet_model

    @movenet.setter
    def movenet(self,model_info)->None:
        model_type,model_datatype = model_info
        model_path = os.path.join(os.getcwd(),'models',f'movenet_{model_type}_{model_datatype}.tflite')

        #download model if it's not already on the local machine
        if not os.path.exists(model_path):
            url = f'https://tfhub.dev/google/lite-model/movenet/singlepose/{model_type}/tflite/{model_datatype}/4?lite-format=tflite'
            with requests.get(url) as file:
                with open(model_path,'wb') as f:
                    try:
                        f.write(file.content)
                    except Exception as e:
                        print(e)
                        return None
            interpreter = tf.lite.Interpreter(model_path=model_path)
            interpreter.allocate_tensors()
            self.movenet_model = interpreter
        #if model already has been downloaded
        else:
            interpreter = tf.lite.Interpreter(model_path=model_path)
            interpreter.allocate_tensors()
            self.movenet_model = interpreter


    def resize_image(self,image_path: str)->tf.image:

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
        image = tf.cast(image,dtype=np.uint8)

        return image
    
    def get_landmarks(self,image)->np.array:
        '''
        Returns keypoints for the given image using the class' assigned movenet variant
        Args:
            image: The input image on which inference is to be run
        '''
        pass

    def save_visualized_landmarks(self,image_path:str,keypoints:np.array)->None:
        '''
        Plots landmarks/keypoints and respective edges on images and saves them to the local filesystem
        Args:
            image: Path to the image on which landmarks are to be plotted
            keypoints: Keypoints from the movenet model of the shape (1,1,17,3)
        '''

        #remove single dimensional entries in shape, if any
        keypoints = np.squeeze(keypoints) #if input is of size (1,1,17,3), squeeze to (17,3) [y,x,confidence score]
        keypoints_x = keypoints[:,1]
        keypoints_y = keypoints[:,0]

        image = cv2.imread(image_path)

        height,width,_ = image.shape

        #scale landmark/keypoint coordinates to image size
        keypoints_x_scaled = keypoints_x*width
        keypoints_y_scaled = keypoints_y*height

        #plot circles on landmarks
        for x,y in zip(keypoints_x_scaled,keypoints_y_scaled):
            image = cv2.circle(image,(int(x),int(y)),radius=10,color=(0,0,255),thickness=2)
        
        #plot edges using edge dictionary
        for edge in landmark_data.EDGE_DICT.values():
            start_point = (int(keypoints_x_scaled[edge[0]]),int(keypoints_y_scaled[edge[0]]))
            end_point = (int(keypoints_x_scaled[edge[1]]),int(keypoints_y_scaled[edge[1]]))
            image = cv2.line(image,start_point,end_point,(0,255,0),7)

        #save image to output path
        image_name = image_path.replace('\\','/').split('/')[-1][:-4]
        root = os.path.join(self.output_path,'landmark_visualizations')
        if not os.path.exists(root):
            os.mkdir(root)
        out_path = os.path.join(root,f'{image_name}_visuals.jpg')
        cv2.imwrite(out_path,image)

        
    def process(self)->np.array:
        '''
        
        '''
        res = []
        for exercise_class in os.listdir(self.input_path):
            class_path = os.path.join(self.input_path,exercise_class)
            for image_name in tqdm(os.listdir(class_path)):
                image_path = os.path.join(class_path,image_name)
                # if image_path.shape[-1] != 3: #not an rgb image
                #     print(f'Skipped {image_name}, not an rgb image')
                #     continue
                image = self.resize_image(image_path)

                #prepare the model for inference
                input_details = self.movenet_model.get_input_details()
                output_details = self.movenet_model.get_output_details()
                self.movenet_model.set_tensor(input_details[0]['index'],image.numpy())
                
                #inference
                self.movenet_model.invoke()

                keypoints = self.movenet_model.get_tensor(output_details[0]['index'])
                self.save_visualized_landmarks(image_path,keypoints)
                res.append(np.squeeze(keypoints))

        return np.asarray(res)
        #TODO: save keypoints to csv (numpy->csv) or (pandas+numpy -> csv) or (numpy->pickle)



if __name__ == "__main__":
    #env setup
    root = 'C:\\Users\\vedan\\Desktop\\code\\PoseTrainer\\data\\frames'

    #driver code
    processor = MovenetPreProcessor(input_path=root,model_type='lightning',model_datatype='int8')
    print(processor.process())

