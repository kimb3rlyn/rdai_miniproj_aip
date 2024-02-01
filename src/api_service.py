
from importlib_resources import files

import cv2
import gradio as gr
import torch 

from fastapi import FastAPI
from yolov7.yolov7 import YOLOv7


app = FastAPI()

yolov7 = YOLOv7(
    weights='../configs/yolov7-e6_state.pt',
    cfg='../configs/yolov7-e6.yaml',
    bgr=True,
    device='cuda',
    model_image_size=640,
    max_batch_size=64,
    half=True,
    same_size=True,
    conf_thresh=0.25,
    trace=False,
    cudnn_benchmark=False,
)

def detect_image(image):
    torch.cuda.synchronize()
    dets = yolov7.detect_get_box_in(image, box_format='ltrb', classes=None, buffer_ratio=0.0)
    # print('detections: {}'.format(dets))
    torch.cuda.synchronize()

    draw_frame = image.copy()
    for det in dets:
        # print(det)
        bb, score, class_ = det
        l, t, r, b = bb
        cv2.rectangle(draw_frame, (l, t), (r, b), (255, 255, 0), 1)
        cv2.putText(draw_frame, class_, (l, t-8), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 0))
    
    return draw_frame 

demo = gr.Interface(
    fn = detect_image,
    inputs=[gr.Image()],
    outputs=[gr.Image()]
)

app = gr.mount_gradio_app(app, demo, path="/")