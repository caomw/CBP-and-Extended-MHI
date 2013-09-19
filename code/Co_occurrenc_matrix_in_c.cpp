//You can include any C libraries that you normally use 
#include "math.h" 
#include "mex.h" //--This one is required

#define output plhs[0]

#define  clusterNo_p prhs[0] 
#define  deltaT_p    prhs[4]
#define  alf_p       prhs[5]
#define  centers_p   prhs[6]
#define  Sample_p    prhs[1]
#define  frameNumber_p prhs[2]
#define  frameNumberIndividual_p prhs[3]


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) 
{
    int  clusterNo,frame,frameNo,start,q,M,N,M_Sample,N_Sample,deltaT;
    double alf,temp;
    double *Sample,*frameNumber,*frameNumberIndividual;
    double *B,*S,*W,*C,*CO,*CO_t,*Out;
    mxArray *S_p,*W_p,*CO_p,*CO_t_p;
    
    clusterNo=(int)mxGetScalar(clusterNo_p);
    deltaT   =(int)mxGetScalar(deltaT_p);
    alf      =mxGetScalar(alf_p);   
    
    frame    =(int)mxGetN(frameNumber_p);
    
    frameNumber=mxGetPr(frameNumber_p);
    frameNumberIndividual=mxGetPr(frameNumberIndividual_p);
    C=mxGetPr(centers_p);
    
    output= mxCreateDoubleMatrix(frame, clusterNo*clusterNo, mxREAL);
    Out   = mxGetPr(output);
   // output  = mxCreateDoubleMatrix(frame,clusterNo*clusterNo, mxREAL);
    
    B = mxGetPr(plhs[0]);
        /* Check the number of arguments */
    if(nrhs < 1 || nrhs > 7) 
    mexErrMsgTxt("Wrong number of input arguments.");
    else if(nlhs > 1)
    mexErrMsgTxt("Too many output arguments.");
    

    N_Sample=(int)mxGetN(Sample_p);  
    M_Sample=(int)mxGetM(Sample_p);
    Sample = mxGetPr(Sample_p);

    start=0;     
    // mexPrintf("Frame is %d",frame);

for(int q=0;q<frame;q++)
{     
     frameNo=(int)frameNumberIndividual[q];   
     S_p=mxCreateDoubleMatrix(frameNo,N_Sample,mxREAL);
     S=mxGetPr(S_p);     
    // S=Sample(start+1:frameNumber(q),:);
    // M=(int)frameNumber[q];  
     for(int n=0;n<N_Sample;n++)
     {
        for(int m=0;m<frameNo;m++)
        {
            S[m+frameNo*n]=Sample[(start+m)+M_Sample*n];
        }
     } 
     
     start=(int)frameNumber[q];
     
     //W=zeros(clusterNo,frameNo);
     W_p=mxCreateDoubleMatrix(clusterNo,frameNo,mxREAL);
     W=mxGetPr(W_p);
     
     for(int n=0;n<frameNo;n++)
     {
         for(int m=0;m<clusterNo;m++)
         {
             temp=0;
            //W(j,i)=exp(-(sum((S(i,:)-C(j,:)).^2)./(2*alf^2)));
             for(int t=0;t<N_Sample;t++)
             {
                temp=temp+pow(S[n+t*frameNo]-C[m+t*clusterNo],2);
             }
             W[m+clusterNo*n]=exp(-temp/(2*pow(alf,2)));
         }
     }
     
     CO_p=mxCreateDoubleMatrix(clusterNo,clusterNo,mxREAL);
     CO=mxGetPr(CO_p);
    
     for(int n=0;n<clusterNo;n++)
     {
      for(int m=0;m<clusterNo;m++)
      {
        for(int k=0;k<(frameNo-deltaT);k++)
        {
            temp=W[m+clusterNo*k]*W[n+clusterNo*(k+deltaT)];
            CO[m+clusterNo*n]=CO[m+clusterNo*n]+temp;
        }
      }
     }
     
     CO_t_p=mxCreateDoubleMatrix(clusterNo,clusterNo,mxREAL);
     CO_t=mxGetPr(CO_t_p);
//Transpose
    for(int n=0;n<clusterNo;n++){
       for(int m=0;m<clusterNo;m++){
           CO_t[m+n*clusterNo]=CO[n+m*clusterNo];
        }
    }

//output(q,:)=T';
     for(int m=0;m<clusterNo*clusterNo;m++)
     {
        Out[q+m*frame]=CO_t[m];
     }
  
}
}

