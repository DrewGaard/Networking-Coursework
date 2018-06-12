/* Primary Author: Alex Murray */
/* Secondary Author: Dr. Vivek Pallipuram */
/*Header Files */
#include <stdio.h>
#include <stdlib.h>
#include "image_template.h"
#include <math.h>
#include <sys/time.h>
#include "main.h"

int main (int argc, char **argv)
{
	/*Declare Variables*/
	float *org_img;
	float *Gx_mask, *Gy_mask;
	float *IGx, *IGy;	
	float *Gxy, *I_angle;
	float *suppressed, *threshold, *hyst;
	int i, j, m, n;
	int img_width, img_height;
	float sigma;
	int gauss_width;

	char nameIGy[20];
        char nameIGx[20];
        char gxName[20];
        char gyName[20];
        char fileGXY[20];
        char fileIAng[20];
	char fileHyst[100];
	
	if(argc != 4)
	{
		printf("\n Correct Usage: ./myexec <image name> <gaussian width> <sigma>");
		return 0;
	}
	
	//Read the image 

	printf("\n 1. Reading input image...");

    	read_image_template(argv[1], &org_img, &img_width, &img_height); 

	printf("\n Image reading complete...");
	
	//Read arguments from the command line 
	gauss_width = atoi(argv[2]);
	sigma = atof(argv[3]);
	
	
	//Allocate memory for masks
	Gx_mask = (float *)malloc(sizeof(float) * (gauss_width * gauss_width));
	Gy_mask = (float *)malloc(sizeof(float) * (gauss_width * gauss_width));

	//Allocate memory for intermediate images
	IGy = (float *)malloc(sizeof(float) * (img_width * img_height));
	IGx = (float *)malloc(sizeof(float) * (img_width * img_height));
	
	Gxy = (float *)malloc(sizeof(float) * (img_width * img_height));
	I_angle = (float *)malloc(sizeof(float) * (img_width * img_height));
	
	suppressed = (float *)malloc(sizeof(float) * (img_width * img_height));
	threshold = (float *)malloc(sizeof(float) * (img_width * img_height));
	
	hyst = (float *)malloc(sizeof(float) * (img_width * img_height));
	
/*1. Canny Edge Detector */
	//Give Gx_mask, Gy_mask values
	gaussianX_mask(Gx_mask, gauss_width, sigma);
	gaussianY_mask(Gy_mask, gauss_width, sigma);

	//Get IGy: convolve(org_img,Gx_mask)
	printf("\n 2. Performing convolution for IGy and IGx..");
	convolve(org_img, img_width, img_height, Gx_mask, gauss_width, IGy);

	//Get IGx: convolve(org_img, Gy_mask)
	convolve(org_img, img_width, img_height, Gy_mask, gauss_width, IGx);

	printf("\n Convolution complete...");

	//Get magnitude based on ONLY IGy and IGx
	printf("\n 3. Obtaining magnitude image...");
	magnitude(IGx, IGy, img_width, img_height, Gxy); 

	printf("\n Magnitude image is ready...");

	//Get directionality based on ONLY IGy and IGx
	printf("\n 4. Obtaining direction image..");
	angle(IGy, IGx, img_width, img_height, I_angle); 


	printf("\n Direction image is ready...");
	printf("\n 5. Performing non-maximal suppression...");
	

	//Suppress auxillary image
	memcpy(suppressed, Gxy, sizeof(float) * img_width * img_height);

	nonmaximal_suppression(suppressed, I_angle, 0, img_width, img_height);

	printf("\n Non-maximal suppression complete...");
	
	//Use thresholding to remove some noise from auxillary image
	printf("\n 6. Performing double thresholding...");

	memcpy(threshold,suppressed,sizeof(float)*img_width*img_height);

//	double_thresh(suppressed, threshold, img_width, img_height); //VKP: Need some changes here

	qsort(suppressed, img_width * img_height, sizeof(float), comp);

	int index=0.95*img_width*img_height;

	float thigh,tlow;

	thigh=suppressed[index];

	tlow=thigh/5;

	printf("\n high %f low %f",thigh,tlow);

	double_threshold(threshold,thigh,tlow,img_width,img_height);

	printf("\n Double thresholding complete...");

	printf("\n 7. Performing Edge Linking (last step of Canny edge detector..");

	edge_linking(threshold, hyst, img_width, img_height);	
	
	printf("\n Edge Linking complete...");
	
	//Put image name into string
	sprintf(fileHyst,"Edges.pgm");
	sprintf(nameIGy,"IGy.pgm");
        sprintf(nameIGx,"IGx.pgm");
        sprintf(fileGXY, "Gxy_img.pgm");
        sprintf(fileIAng, "I_Angle.pgm");

	//Write out the images

	printf("\n Writing output images. Edge image is Edges.pgm");

	write_image_template(fileHyst, hyst, img_width, img_height);
	write_image_template(nameIGy, IGy, img_width, img_height);
        write_image_template(nameIGx, IGx, img_width, img_height);
        write_image_template(fileGXY, Gxy, img_width, img_height);
        write_image_template(fileIAng, I_angle, img_width, img_height);

	printf("\n Edge Processing complete!");

	//free memory
	free(Gx_mask);
	free(Gy_mask);
	free(IGx);
	free(IGy);
	free(Gxy);
	free(I_angle);
	free(suppressed);
	free(hyst);
	free(threshold);
	
	return 0;

}
