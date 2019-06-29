#include "PATH/multi-camera-motion/approx_relpose_generalized_fast.h"

#include "mex.h"

/* The gateway function */
void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
/* variable declarations here */
    double* inMatrix = mxGetPr(prhs[0]);
    plhs[0] = mxCreateDoubleMatrix(3,20,mxREAL);
    double* outMatrix = mxGetPr(plhs[0]);
    plhs[1] = mxCreateDoubleMatrix(1,1,mxREAL);
    double* solNum = mxGetPr(plhs[1]);
//    approx_relpose_generalized_fast
//            (
//    const Eigen::Matrix<double,6,6> &w1,
//    const Eigen::Matrix<double,6,6> &w2,
//    const Eigen::Matrix<double,6,6> &w3,
//    const Eigen::Matrix<double,6,6> &w4,
//    const Eigen::Matrix<double,6,6> &w5,
//    const Eigen::Matrix<double,6,6> &w6,
//            std::vector<Eigen::Vector3d> &rsolns
//    )

    std::vector<Eigen::Matrix<double,6,6>> wv;
    for (int i = 0; i < 6; i++)
    {
        int s = 36*i;
        Eigen::Matrix<double,6,6> w;
        int ind = 0;
        for (int cx = 0; cx < 6; cx++)
        {
            for (int cy = 0; cy < 6; cy++)
            {
                w(cx, cy) = inMatrix[s+ind];
                ind++;
            }
        }
        wv.push_back(w);
    }
    std::vector<Eigen::Vector3d> rsolns;
    approx_relpose_generalized_fast(wv[0], wv[1], wv[2], wv[3], wv[4], wv[5], rsolns);
    *solNum = rsolns.size();

    for (int i = 0; (i < rsolns.size()) && (i < 20); i++)
    {
        if (i < 20) {
            int s = 3 * i;
            for (int j = 0; j < 3; j++) {
                outMatrix[s + j] = rsolns[i](j);
            }
        }
    }
//    outMatrix[0] = 1.0;
//    *solNum = 25;
}
