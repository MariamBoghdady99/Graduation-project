# -*- coding: utf-8 -*-
"""Untitled1.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1fOHnFZEzLfIuCyccE_BycfiQsRnVd4Ol
"""

from fpdf import FPDF
from matplotlib.backends.backend_pdf import PdfPages
import matplotlib.pyplot as plt
from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
from matplotlib.figure import Figure
from PIL import Image

import numpy as np
from random import Random ##to get the random points

from flask import Flask, request

app = Flask(__name__)

@app.route('/recieve_integers', methods=['POST'])
def recieve_integers():
    data = request.get_json()
    integer_list = data['integers']

    return 'Integers received successfully'

def classifier_age (age_user):
    if (age_user < 13):
        min_HR = 55
        max_HR = 85
        min_temp = 36.4
        max_temp = 37.5
        min_spo2 = 97
        max_spo2 = 99
    if (age_user > 13 & age_user < 60 ):
        min_HR = 60
        max_HR = 100
        min_temp = 36.1
        max_temp = 37.2
        min_spo2 = 93
        max_spo2 = 99
    if (age_user > 60):
        min_HR = 55
        max_HR = 85
        min_temp = 35.8
        max_temp = 36.9
        min_spo2 = 97
        max_spo2 = 100
    return (min_HR , max_HR , min_temp , max_temp , min_spo2 , max_spo2)

def classifier (age_user  , HR_data , temp_data ,  SPO2_data ):
    min_HR , max_HR , min_Temp , max_Temp , min_SPO2 , max_SPO2 = classifier_age(age_user)
    if (HR_data<min_HR):
        ##alarm function
        return str(f' hypothyroidism .. myocarditis .. myocardial infarction .. electrolyte imbalance .. obstructive sleep apnea .. rheumatic fever or lupus .. Certain medications' )
    if (HR_data>max_HR):
        ##alarm function
        return str(f'anxiety .. exercise .. certain medicins ..  fever .. hyperthyrodism .. hypertension .. infection .. smoking .. congenital heart disease .. anemia .. electrolyte imbalance .. heart attack .. lung disease'  )
    if (temp_data<min_Temp):
        ### alarm function
        return str(f'.. Hypothermia .. hypothyrodism .. hypoglycemia .. dehydration .. drinking alcohol ' )
    if (temp_data>max_Temp):
        ##alarm function
        return str(f'.. hyperthermia .. fever .. septicima .. sepsis .. infective endocarditis ..hyperthyrodism .. upper and/or lower respiratory tract infection .. urenary tract infection .. git infection  '  )
    if (SPO2_data<min_SPO2):
        ### alarm function
        return str(f' and  high altitude .. airway obstruction .. asthma .. COVID-19 and other respiratory infections .. collapsed lung .. heart defects .. heart failure .. chronic obstructive pulmonary disease .. interstitial lung disease .. pneumonia .. pulmonary fibrosis .. sleep apnea deep sedation or coma ' )

def generate_pdf(user_name , user_age, N, Temp , HR ,Spo2):
    pdf = FPDF()

    # Add a page
    pdf.add_page()
    # Add a logo
    pdf.image('Cura.jpg', x = 150, y = 15 , w = 50 , h = 0 )

    pdf.image('woman.jpg', x = 10, y = 40 , w = 40 , h = 0 )

    pdf.set_font("Arial", 'B',size = 40)
    pdf.cell(180, 50, txt = "Survey",ln = 1,align = 'C')

    pdf.set_font("Times",size = 25)
    pdf.set_text_color(r= 0, g= 0, b = 200)
    pdf.cell(160, txt = f'{user_name} ',ln = 1 , align = 'C')

    time_list = np.arange(0 , 24 , N)



    fig1, ax1 = plt.subplots(figsize=(10,5))
    la, = ax1.plot(time_list, Temp )
    ax1.set_xlim(0,24)
    ax1.set_ylim(35,42)
    ax1.set_title("Temperature at the all day" )
    ax1.set_xlabel("Time ")
    ax1.set_ylabel("Temperature")
    plt.savefig('./Temperature.png')
    pdf.image('Temperature.png' , x = 5, y = 80 , w = 200 , h = 0)
    pdf.set_font("Times",size = 15)
    pdf.set_text_color(r= 255, g= 0, b = 0)
    pdf.set_xy(30,95)
    pdf.cell(0,10,txt = f'Max Temperature = {round(max(Temp),2)}')

    fig2, ax2 = plt.subplots(figsize=(10,5))
    la, = ax2.plot(time_list, HR)
    ax2.set_xlim(0,24)
    ax2.set_ylim(50,100)
    ax2.set_title("Heart Rate  at the all day" )
    ax2.set_xlabel("Time ")
    ax2.set_ylabel("Heart Rate ")
    plt.savefig('./HR.png')
    pdf.image('HR.png' , x = 5, y = 180 , w = 200 , h = 0)
    pdf.set_text_color(r= 255, g= 0, b = 0)
    pdf.set_xy(30,195)
    pdf.cell(0,10,txt = f'Max Heart Rate = {round(max(HR),2)}')

    pdf.add_page()
    pdf.image('Cura.jpg', x = 150, y = 15 , w = 50 , h = 0 )

    fig3, ax3 = plt.subplots(figsize=(10,5))
    la, = ax3.plot(time_list, Spo2)
    ax3.set_xlim(0,24)
    ax3.set_ylim(90,100)
    ax3.set_title("Spo2  at the all day" )
    ax3.set_xlabel("Time ")
    ax3.set_ylabel("Oxygen Saturation  ")
    plt.savefig('./spo2.png')
    pdf.image('spo2.png' , x = 5, y = 30 , w = 200 , h = 0)
    pdf.set_text_color(r= 255, g= 0, b = 0)
    pdf.set_xy(30,105)
    pdf.cell(0,10,txt = f'Max SPO2 = {round(max(Spo2),2)}')


    Data = classifier(user_age , max(HR) , max(Temp) , max(Spo2))
    pdf.set_text_color(r= 0, g= 0, b = 0)
    pdf.set_font("Arial", 'B',size = 25)
    pdf.set_xy(80,130)
    pdf.cell(0, 25, txt = "Our Vision ")

    pdf.set_font("Times",size = 15)
    pdf.set_text_color(r= 0, g= 0, b = 255)
    pdf.set_xy(20,150)
    pdf.multi_cell( 0,10 ,txt = f'According to the Data on the all day, we suspected that {user_name} suffer from some of this diseases {Data} .' , align= 'L')

    # save the pdf with name .pdf
    pdf.output("trial_servey.pdf")

SEED =5 ##to get the same points in every run
random_generator =Random(x=SEED)
def generator_data(N=144):  ## N defult value for max points should be in space
    temp_list,HR_list,spo2_list=[],[] , [] ##   X&y coordinates
    for _ in range(N):
        temp_list.append(random_generator.uniform(a=37,b=39))
    for _ in range(N): ## to make sure that will be different
        HR_list.append(random_generator.uniform(a=55,b=90))
    for _ in range(N): ## to make sure that will be different
        spo2_list.append(random_generator.uniform(a=95,b=100))
    return temp_list,HR_list,spo2_list

app = Flask(__name__)

@app.route('/recieve_integers', methods=['POST'])
def recieve_integers():
    data = request.get_json()
    integer_list = data['integers']

    print('List is detected')
    return 'Integers received successfully'
    return integer_list
    print(integer_list)


Temp ,HR,Spo2 =generator_data()
received_list = recieve_integers()
Sample_ratio =1/6    ## HOURS
generate_pdf( "Nada Abd Elrhman " , 22 , Sample_ratio,   Temp , HR, Spo2)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)