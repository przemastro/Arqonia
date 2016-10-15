#!/usr/bin/env python

import numpy
import pyfits
import pylab
import numpy
import math
import os
import time
import ConfigParser
from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
from matplotlib.figure import Figure


env = ConfigParser.RawConfigParser()
env.read('../resources/env.properties')
backendInputFits = env.get('FilesCatalogs', 'catalog.backendInputFits');
backendOutputFits = env.get('FilesCatalogs', 'catalog.backendOutputFits');
frontendInputFits = env.get('FilesCatalogs', 'catalog.frontendInputFits');




def reduce(getDarkFrames, getBiasFrames, getFlatFields, getRawFrames):
    try:
        sig_fract = 5.0
        percent_fract = 0.01
        min_val = 0.0

        #Open Dark Frames data
        List = getDarkFrames
        dataList = []
        for file in List:
            dataList.append(openFile(file))
        reference_dark_image = medianImage(dataList)

        #Open Bias Frames data
        List = getBiasFrames
        dataList = []
        for file in List:
            dataList.append(openFile(backendInputFits+file))
        reference_bias_image = medianImage(dataList)

        #Open Flat Fields data
        List = getFlatFields
        dataList = []
        for file in List:
            dataList.append(openFileAndNormalize(backendInputFits+file))
        reference_flat_image = medianImage(dataList)


        #Open Raw Images Data and Reduce
        List = getRawFrames
        for file in List:
           dataImage = openFileAndNormalize(backendInputFits+file)
           dark_corrected_image = dataImage - reference_dark_image
           bias_corrected_image = dark_corrected_image - reference_bias_image
           final_image = bias_corrected_image / reference_flat_image

           pyfits.append(backendOutputFits+"Processed_"+file+".fits", final_image)

           sky, num_iter = sky_mean_sig_clip(final_image, sig_fract, percent_fract, max_iter=1)
           img_data = final_image - sky
           new_img = linear(img_data, scale_min = min_val)
           fig = Figure(figsize=(12.5, 13.35))
           fig.figimage(new_img, cmap='gray')
           canvas = FigureCanvas(fig)
           canvas.print_figure(frontendInputFits+"Processed_"+file+".png")

    except (RuntimeError, TypeError, NameError):
        print 'error'

def medianImage(images):
    stack = numpy.array(images)
    print stack
    median = numpy.median(stack, axis=0)
    return median

def openFile(fileName):
    hdulist = pyfits.open(fileName)
    img_data_raw = hdulist[0].data
    hdulist.close()
    img_data_raw = numpy.array(img_data_raw, dtype=float)
    return img_data_raw

def openFileAndNormalize(fileName):
    hdulist = pyfits.open(fileName)
    img_data_raw = hdulist[0].data
    hdulist.close()
    img_data_raw = numpy.array(img_data_raw, dtype=float)
    image_mean = numpy.mean(img_data_raw)
    normalized = img_data_raw / image_mean
    return normalized

def sky_mean_sig_clip(input_arr, sig_fract, percent_fract, max_iter=100, low_cut=True, high_cut=True):
    work_arr = numpy.ravel(input_arr)
    old_sky = numpy.mean(work_arr)
    sig = work_arr.std()
    upper_limit = old_sky + sig_fract * sig
    lower_limit = old_sky - sig_fract * sig
    if low_cut and high_cut:
        indices = numpy.where((work_arr < upper_limit) & (work_arr > lower_limit))
    else:
        if low_cut:
            indices = numpy.where((work_arr > lower_limit))
        else:
            indices = numpy.where((work_arr < upper_limit))
    work_arr = work_arr[indices]
    new_sky = numpy.mean(work_arr)
    iteration = 0
    while ((math.fabs(old_sky - new_sky)/new_sky) > percent_fract) and (iteration < max_iter) :
        iteration += 1
        old_sky = new_sky
        sig = work_arr.std()
        upper_limit = old_sky + sig_fract * sig
        lower_limit = old_sky - sig_fract * sig
        if low_cut and high_cut:
            indices = numpy.where((work_arr < upper_limit) & (work_arr > lower_limit))
        else:
            if low_cut:
                indices = numpy.where((work_arr > lower_limit))
            else:
                indices = numpy.where((work_arr < upper_limit))
        work_arr = work_arr[indices]
        new_sky = numpy.mean(work_arr)
    return (new_sky, iteration)


def linear(inputArray, scale_min=None, scale_max=None):
    #print "img_scale : linear"
    imageData=numpy.array(inputArray, copy=True)

    if scale_min == None:
        scale_min = imageData.min()
    if scale_max == None:
        scale_max = imageData.max()

    imageData.clip(min=scale_min, max=scale_max)
    imageData = (imageData -scale_min) / (scale_max - scale_min)
    indices = numpy.where(imageData < 0)
    imageData[indices] = 0.0

    return imageData


def power(inputArray, power_index=3.0, scale_min=None, scale_max=None):
    print "img_scale : power"
    imageData=numpy.array(inputArray, copy=True)

    if scale_min == None:
        scale_min = imageData.min()
    if scale_max == None:
        scale_max = imageData.max()
    factor = 1.0 / math.pow((scale_max - scale_min), power_index)
    indices0 = numpy.where(imageData < scale_min)
    indices1 = numpy.where((imageData >= scale_min) & (imageData <= scale_max))
    indices2 = numpy.where(imageData > scale_max)
    imageData[indices0] = 0.0
    imageData[indices2] = 1.0
    imageData[indices1] = numpy.power((imageData[indices1] - scale_min), power_index)*factor

    return imageData

def sky_mean_sig_clip(input_arr, sig_fract, percent_fract, max_iter=100, low_cut=True, high_cut=True):
    work_arr = numpy.ravel(input_arr)
    old_sky = numpy.mean(work_arr)
    sig = work_arr.std()
    upper_limit = old_sky + sig_fract * sig
    lower_limit = old_sky - sig_fract * sig
    if low_cut and high_cut:
        indices = numpy.where((work_arr < upper_limit) & (work_arr > lower_limit))
    else:
        if low_cut:
            indices = numpy.where((work_arr > lower_limit))
        else:
            indices = numpy.where((work_arr < upper_limit))
    work_arr = work_arr[indices]
    new_sky = numpy.mean(work_arr)
    iteration = 0
    while ((math.fabs(old_sky - new_sky)/new_sky) > percent_fract) and (iteration < max_iter) :
        iteration += 1
        old_sky = new_sky
        sig = work_arr.std()
        upper_limit = old_sky + sig_fract * sig
        lower_limit = old_sky - sig_fract * sig
        if low_cut and high_cut:
            indices = numpy.where((work_arr < upper_limit) & (work_arr > lower_limit))
        else:
            if low_cut:
                indices = numpy.where((work_arr > lower_limit))
            else:
                indices = numpy.where((work_arr < upper_limit))
        work_arr = work_arr[indices]
        new_sky = numpy.mean(work_arr)
    return (new_sky, iteration)


def linear(inputArray, scale_min=None, scale_max=None):
    #print "img_scale : linear"
    imageData=numpy.array(inputArray, copy=True)

    if scale_min == None:
        scale_min = imageData.min()
    if scale_max == None:
        scale_max = imageData.max()

    imageData.clip(min=scale_min, max=scale_max)
    imageData = (imageData -scale_min) / (scale_max - scale_min)
    indices = numpy.where(imageData < 0)
    imageData[indices] = 0.0

    return imageData


def histeq(inputArray, num_bins=1024):

    imageData=numpy.array(inputArray, copy=True)

    # histogram equalisation: we want an equal number of pixels in each intensity range
    sortedDataIntensities=numpy.sort(numpy.ravel(imageData))
    median=numpy.median(sortedDataIntensities)

    # Make cumulative histogram of data values, simple min-max used to set bin sizes and range
    dataCumHist=numpy.zeros(num_bins)
    minIntensity=sortedDataIntensities.min()
    maxIntensity=sortedDataIntensities.max()
    histRange=maxIntensity-minIntensity
    binWidth=histRange/float(num_bins-1)
    for i in range(len(sortedDataIntensities)):
        binNumber=int(math.ceil((sortedDataIntensities[i]-minIntensity)/binWidth))
        addArray=numpy.zeros(num_bins)
        onesArray=numpy.ones(num_bins-binNumber)
        onesRange=range(binNumber, num_bins)
        numpy.put(addArray, onesRange, onesArray)
        dataCumHist=dataCumHist+addArray

    # Make ideal cumulative histogram
    idealValue=dataCumHist.max()/float(num_bins)
    idealCumHist=numpy.arange(idealValue, dataCumHist.max()+idealValue, idealValue)

    # Map the data to the ideal
    for y in range(imageData.shape[0]):
        for x in range(imageData.shape[1]):
            # Get index corresponding to dataIntensity
            intensityBin=int(math.ceil((imageData[y][x]-minIntensity)/binWidth))

    # Guard against rounding errors (happens rarely I think)
    if intensityBin<0:
        intensityBin=0
    if intensityBin>len(dataCumHist)-1:
        intensityBin=len(dataCumHist)-1

    # Get the cumulative frequency corresponding intensity level in the data
    dataCumFreq=dataCumHist[intensityBin]

    # Get the index of the corresponding ideal cumulative frequency
    idealBin=numpy.searchsorted(idealCumHist, dataCumFreq)
    idealIntensity=(idealBin*binWidth)+minIntensity
    imageData[y][x]=idealIntensity

    scale_min = imageData.min()
    scale_max = imageData.max()
    imageData.clip(min=scale_min, max=scale_max)
    imageData = (imageData -scale_min) / (scale_max - scale_min)
    indices = numpy.where(imageData < 0)
    imageData[indices] = 0.0

    return imageData
