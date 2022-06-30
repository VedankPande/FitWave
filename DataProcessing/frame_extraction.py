#imports
import os
import cv2
import math

#env variables and setup
root = 'C:\\Users\\vedan\\Desktop\\sample'
video1 = 'C:\\Users\\vedan\\Desktop\\code\\PoseTrainer\\data\\pushups\\pushup1.mp4'


#functions
def get_frame(video_path,class_name,frames_per_second=1,directory=os.getcwd()):
    '''
    returns frames from given video and saves them to a specified location (defaulted to current directory)
    Args:
        video_path: path to video
        frames_per_second: how many frames you want to extract per second
        directoy: output directory path
    '''
    video_path = video_path.replace('\\','/')
    video_name = video_path.split('/')[-1]

    cap = cv2.VideoCapture(video_path)
    frame_rate = cap.get(cv2.CAP_PROP_FPS)
    while(cap.isOpened()):
        frame_id = cap.get(cv2.CAP_PROP_POS_FRAMES)
        ret,frame = cap.read()
        if not ret:
            break
        folder_path = os.path.join(directory,f'{class_name}_frames')
        if frame_id%(48)==0:
            if not os.path.exists(folder_path):
                os.mkdir(folder_path)
            file_path = os.path.join(folder_path,f'{video_name[:-4]}_frame{int(frame_id)}.jpg')
            print(file_path)
            try:
                cv2.imwrite(file_path,frame)
            except Exception as e:
                print(e)

def get_frames_all(path):
    '''
    extracts frames from train data directory
    ensure that the directory looks like:
        root/
            pushups/
                vid1.mp4
                vid2.mp4
            squats/
                vid1.mp4
                vide2.mp4
    Args:
        path: path to train data folder
    '''

    for exercise in os.listdir(path):
        data_folder_path = os.path.join(root,exercise)
        for video in os.listdir(data_folder_path):
            get_frame(os.path.join(data_folder_path,video),exercise,directory=root,frames_per_second=2)
    
#main
if __name__ == "__main__":
    get_frames_all(root)
