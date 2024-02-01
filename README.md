# RDAI Mini Project (AIP) 

This project does an image detection using a pre-trained YOLOv7.


## Before running 
In the configs folder, download the weights\
```./get_weights.sh yolov7-e6```\
yolov7-e6_state.pt should be in the configs folder

## To run 
1) In the main folder, ```docker compose up```
2) Head to `http://0.0.0.0:5002` in your desired browser
3) Upload an image \
![image](https://github.com/kimb3rlyn/rdai_miniproj_aip/assets/32510185/173dd664-2684-4982-aaa4-ecfa1f2afc71) 
- There is a sample image in `test_images` folder
4) Click 'Submit' after uploading and the prediction result will be shown in on the right of the screen \
  ![image](https://github.com/kimb3rlyn/rdai_miniproj_aip/assets/32510185/cfb5b12f-efd3-4910-9b71-ae159efba1e5) 
  - 'Clear' button will reset and other images can be tested
  - 'Flag' button will sends the input and output data back to the machine where the gradio demo is running, and saves it to a CSV log file.

## After running 
1) ```Ctl+C``` to quit
2) ```docker compose down``` to stop and remove the container 
