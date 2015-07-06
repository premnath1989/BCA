//
//  EverLifeViewController.m
//  iMobile Planner
//
//  Created by infoconnect on 8/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "EverLifeViewController.h"
#import "DBController.h"
#import "DataTable.h"

@interface EverLifeViewController ()

@end

const double PolicyFee = 5, IncreasePrem =0, CYFactor = 1, ExcessAllo = 0.95, RegularAllo =0.95, OADLimit = 1000000.00;
const double Bump_Annual = 1.00, Bump_SemiAnnual = 0.5, Bump_Quarter = 0.25, Bump_Month = 0.0833333;
int YearDiff2023, YearDiff2025, YearDiff2028, YearDiff2030, YearDiff2035, CommMonth;
int MonthDiff2023, MonthDiff2025, MonthDiff2028, MonthDiff2030, MonthDiff2035;
int FundTermPrev2023, FundTerm2023, FundTermPrev2025, FundTerm2025,FundTermPrev2028, FundTerm2028;
int FundTermPrev2030, FundTerm2030, FundTermPrev2035, FundTerm2035;
int VU2023Factor,VU2025Factor,VU2028Factor,VU2030Factor,VU2035Factor,VUCashFactor,VURetFactor,VURetOptFactor,VUCashOptFactor,VUDanaFactor,VUDanaOptFactor;
int RegWithdrawalStartYear, RegWithdrawalEndYear, RegWithdrawalIntYear;
double PremReq;
//double VU2023Fac,VU2025Fac,VU2028Fac,VU2030Fac,VU2035Fac,VUCashFac,VURetFac,VURetOptFac,VUCashOptFac;
double VUCash_FundAllo_Percen,VURet_FundAllo_Percen,VUDana_FundAllo_Percen,VU2023_FundAllo_Percen,VU2025_FundAllo_Percen;
double VU2028_FundAllo_Percen,VU2030_FundAllo_Percen, VU2035_FundAllo_Percen, RegWithdrawalAmount;
double VU2023InstHigh, VU2023InstMedian, VU2023InstLow,VU2025InstHigh, VU2025InstMedian, VU2025InstLow;
double VU2028InstHigh, VU2028InstMedian, VU2028InstLow,VU2030InstHigh, VU2030InstMedian, VU2030InstLow;
double VU2035InstHigh, VU2035InstMedian, VU2035InstLow, NegativeValueOfMaxCashFundHigh,NegativeValueOfMaxCashFundMedian,NegativeValueOfMaxCashFundLow ;
double HSurrenderValue,MSurrenderValue,LSurrenderValue,HRiderSurrenderValue,MRiderSurrenderValue,LRiderSurrenderValue;
double VUCashValueHigh, VU2023ValueHigh,VU2025ValueHigh,VU2028ValueHigh,VU2030ValueHigh,VU2035ValueHigh,VURetValueHigh,VUDanaValueHigh;
double VU2023PrevValuehigh, VU2025PrevValuehigh,VU2028PrevValuehigh, VU2030PrevValuehigh, VU2035PrevValuehigh,VUCashPrevValueHigh,VURetPrevValueHigh,VUDanaPrevValueHigh;
double MonthVU2023PrevValuehigh, MonthVU2025PrevValuehigh,MonthVU2028PrevValuehigh, MonthVU2030PrevValuehigh, MonthVU2035PrevValuehigh,MonthVUCashPrevValueHigh, MonthVURetPrevValueHigh,MonthVUDanaPrevValueHigh;
double VUCashValueMedian, VU2023ValueMedian,VU2025ValueMedian,VU2028ValueMedian,VU2030ValueMedian,VU2035ValueMedian,VURetValueMedian,VUDanaValueMedian;
double VUCashValueLow, VU2023ValueLow,VU2025ValueLow,VU2028ValueLow,VU2030ValueLow,VU2035ValueLow,VURetValueLow,VUDanaValueLow;
double VU2023PrevValueMedian, VU2025PrevValueMedian,VU2028PrevValueMedian, VU2030PrevValueMedian, VU2035PrevValueMedian,VUCashPrevValueMedian,VURetPrevValueMedian,VUDanaPrevValueMedian;
double VU2023PrevValueLow, VU2025PrevValueLow,VU2028PrevValueLow, VU2030PrevValueLow, VU2035PrevValueLow,VUCashPrevValueLow,VURetPrevValueLow,VUDanaPrevValueLow;
double MonthVU2023PrevValueMedian, MonthVU2025PrevValueMedian,MonthVU2028PrevValueMedian, MonthVU2030PrevValueMedian;
double  MonthVU2035PrevValueMedian,MonthVUCashPrevValueMedian,MonthVURetPrevValueMedian,MonthVUDanaPrevValueMedian;
double MonthVU2023PrevValueLow, MonthVU2025PrevValueLow,MonthVU2028PrevValueLow, MonthVU2030PrevValueLow;
double  MonthVU2035PrevValueLow,MonthVUCashPrevValueLow,MonthVURetPrevValueLow,MonthVUDanaPrevValueLow;
double Allo2023, Allo2025,Allo2028,Allo2030,Allo2035;
double Fund2023PartialReinvest, Fund2025PartialReinvest,Fund2028PartialReinvest,Fund2030PartialReinvest,Fund2035PartialReinvest;
double MonthFundMaturityValue2023_Bull, MonthFundMaturityValue2023_Flat,MonthFundMaturityValue2023_Bear;
double MonthFundMaturityValue2025_Bull, MonthFundMaturityValue2025_Flat,MonthFundMaturityValue2025_Bear;
double MonthFundMaturityValue2028_Bull, MonthFundMaturityValue2028_Flat,MonthFundMaturityValue2028_Bear;
double MonthFundMaturityValue2030_Bull, MonthFundMaturityValue2030_Flat,MonthFundMaturityValue2030_Bear;
double MonthFundMaturityValue2035_Bull, MonthFundMaturityValue2035_Flat,MonthFundMaturityValue2035_Bear;
double Fund2023ReinvestTo2025Fac,Fund2023ReinvestTo2028Fac,Fund2023ReinvestTo2030Fac,Fund2023ReinvestTo2035Fac,Fund2023ReinvestToCashFac,Fund2023ReinvestToRetFac,Fund2023ReinvestToDanaFac ;
double Fund2025ReinvestTo2028Fac,Fund2025ReinvestTo2030Fac,Fund2025ReinvestTo2035Fac,Fund2025ReinvestToCashFac,Fund2025ReinvestToRetFac,Fund2025ReinvestToDanaFac ;
double Fund2028ReinvestTo2030Fac,Fund2028ReinvestTo2035Fac,Fund2028ReinvestToCashFac,Fund2028ReinvestToRetFac,Fund2028ReinvestToDanaFac;
double Fund2030ReinvestTo2035Fac,Fund2030ReinvestToCashFac,Fund2030ReinvestToRetFac,Fund2030ReinvestToDanaFac;
double Fund2035ReinvestToCashFac,Fund2035ReinvestToRetFac,Fund2035ReinvestToDanaFac;
double temp2023High, temp2023Median,temp2023Low,temp2025High, temp2025Median,temp2025Low,temp2028High, temp2028Median,temp2028Low;
double temp2030High, temp2030Median,temp2030Low, temp2035High, temp2035Median,temp2035Low;
double Withdrawtemp2023High, Withdrawtemp2023Median,Withdrawtemp2023Low,Withdrawtemp2025High, Withdrawtemp2025Median,Withdrawtemp2025Low,Withdrawtemp2028High, Withdrawtemp2028Median,Withdrawtemp2028Low;
double Withdrawtemp2030High, Withdrawtemp2030Median,Withdrawtemp2030Low, Withdrawtemp2035High, Withdrawtemp2035Median,Withdrawtemp2035Low;
double FundValueOfTheYearValueTotalHigh,FundValueOfTheYearValueTotalMedian, FundValueOfTheYearValueTotalLow;
double MonthFundValueOfTheYearValueTotalHigh,MonthFundValueOfTheYearValueTotalMedian, MonthFundValueOfTheYearValueTotalLow;
double MonthVU2023ValueHigh,MonthVU2023ValueMedian,MonthVU2023ValueLow,MonthVU2025ValueHigh,MonthVU2025ValueMedian,MonthVU2025ValueLow;
double MonthVU2028ValueHigh,MonthVU2028ValueMedian,MonthVU2028ValueLow,MonthVU2030ValueHigh,MonthVU2030ValueMedian,MonthVU2030ValueLow;
double MonthVU2035ValueHigh,MonthVU2035ValueMedian,MonthVU2035ValueLow,MonthVURetValueHigh,MonthVURetValueMedian,MonthVURetValueLow;
double MonthVUDanaValueHigh,MonthVUDanaValueMedian,MonthVUDanaValueLow;
BOOL VUCashValueNegative,RiderVUCashValueNegative, CIRDExist;

double RiderVUCashValueHigh, RiderVU2023ValueHigh,RiderVU2025ValueHigh,RiderVU2028ValueHigh,RiderVU2030ValueHigh,RiderVU2035ValueHigh,RiderVURetValueHigh,RiderVUDanaValueHigh;
double RiderVU2023PrevValuehigh, RiderVU2025PrevValuehigh,RiderVU2028PrevValuehigh, RiderVU2030PrevValuehigh, RiderVU2035PrevValuehigh,RiderVUCashPrevValueHigh,RiderVURetPrevValueHigh,RiderVUDanaPrevValueHigh;
double RiderMonthVU2023PrevValuehigh, RiderMonthVU2025PrevValuehigh,RiderMonthVU2028PrevValuehigh, RiderMonthVU2030PrevValuehigh, RiderMonthVU2035PrevValuehigh,RiderMonthVUCashPrevValueHigh, RiderMonthVURetPrevValueHigh, RiderMonthVUDanaPrevValueHigh;
double RiderVUCashValueMedian, RiderVU2023ValueMedian,RiderVU2025ValueMedian,RiderVU2028ValueMedian,RiderVU2030ValueMedian,RiderVU2035ValueMedian,RiderVURetValueMedian,RiderVUDanaValueMedian;
double RiderVUCashValueLow, RiderVU2023ValueLow,RiderVU2025ValueLow,RiderVU2028ValueLow,RiderVU2030ValueLow,RiderVU2035ValueLow,RiderVURetValueLow,RiderVUDanaValueLow;
double RiderVU2023PrevValueMedian, RiderVU2025PrevValueMedian,RiderVU2028PrevValueMedian, RiderVU2030PrevValueMedian, RiderVU2035PrevValueMedian,RiderVUCashPrevValueMedian,RiderVURetPrevValueMedian,RiderVUDanaPrevValueMedian;
double RiderVU2023PrevValueLow, RiderVU2025PrevValueLow,RiderVU2028PrevValueLow, RiderVU2030PrevValueLow, RiderVU2035PrevValueLow,RiderVUCashPrevValueLow,RiderVURetPrevValueLow,RiderVUDanaPrevValueLow;
double RiderMonthVU2023PrevValueMedian, RiderMonthVU2025PrevValueMedian,RiderMonthVU2028PrevValueMedian, RiderMonthVU2030PrevValueMedian;
double  RiderMonthVU2035PrevValueMedian,RiderMonthVUCashPrevValueMedian,RiderMonthVURetPrevValueMedian,RiderMonthVUDanaPrevValueMedian;
double RiderMonthVU2023PrevValueLow, RiderMonthVU2025PrevValueLow,RiderMonthVU2028PrevValueLow, RiderMonthVU2030PrevValueLow;
double  RiderMonthVU2035PrevValueLow,RiderMonthVUCashPrevValueLow,RiderMonthVURetPrevValueLow,RiderMonthVUDanaPrevValueLow;
double RiderFundValueOfTheYearValueTotalHigh,RiderFundValueOfTheYearValueTotalMedian, RiderFundValueOfTheYearValueTotalLow;
double RiderMonthFundValueOfTheYearValueTotalHigh,RiderMonthFundValueOfTheYearValueTotalMedian, RiderMonthFundValueOfTheYearValueTotalLow;
double RiderMonthVU2023ValueHigh,RiderMonthVU2023ValueMedian,RiderMonthVU2023ValueLow,RiderMonthVU2025ValueHigh,RiderMonthVU2025ValueMedian,RiderMonthVU2025ValueLow;
double RiderMonthVU2028ValueHigh,RiderMonthVU2028ValueMedian,RiderMonthVU2028ValueLow,RiderMonthVU2030ValueHigh,RiderMonthVU2030ValueMedian,RiderMonthVU2030ValueLow;
double RiderMonthVU2035ValueHigh,RiderMonthVU2035ValueMedian,RiderMonthVU2035ValueLow,RiderMonthVURetValueHigh,RiderMonthVURetValueMedian,RiderMonthVURetValueLow;
double RiderMonthVUDanaValueHigh,RiderMonthVUDanaValueMedian,RiderMonthVUDanaValueLow;
double RiderNegativeValueOfMaxCashFundHigh,RiderNegativeValueOfMaxCashFundMedian,RiderNegativeValueOfMaxCashFundLow ;
double Ridertemp2023High, Ridertemp2023Median,Ridertemp2023Low,Ridertemp2025High, Ridertemp2025Median,Ridertemp2025Low,Ridertemp2028High, Ridertemp2028Median,Ridertemp2028Low;
double Ridertemp2030High, Ridertemp2030Median,Ridertemp2030Low, Ridertemp2035High, Ridertemp2035Median,Ridertemp2035Low;;
double RiderWithdrawtemp2023High, RiderWithdrawtemp2023Median,RiderWithdrawtemp2023Low,RiderWithdrawtemp2025High, RiderWithdrawtemp2025Median;
double RiderWithdrawtemp2025Low,RiderWithdrawtemp2028High, RiderWithdrawtemp2028Median,RiderWithdrawtemp2028Low;
double RiderWithdrawtemp2030High, RiderWithdrawtemp2030Median,RiderWithdrawtemp2030Low, RiderWithdrawtemp2035High, RiderWithdrawtemp2035Median,RiderWithdrawtemp2035Low;;

double FundValueOfTheYearVURetValueHigh_Basic,FundValueOfTheYearVURetValueMedian_Basic,FundValueOfTheYearVURetValueLow_Basic;
double FundValueOfTheYearVUDanaValueHigh_Basic,FundValueOfTheYearVUDanaValueMedian_Basic,FundValueOfTheYearVUDanaValueLow_Basic;
double FundValueOfTheYearVU2023ValueHigh_Basic,FundValueOfTheYearVU2023ValueMedian_Basic,FundValueOfTheYearVU2023ValueLow_Basic;
double FundValueOfTheYearVU2025ValueHigh_Basic,FundValueOfTheYearVU2025ValueMedian_Basic,FundValueOfTheYearVU2025ValueLow_Basic;
double FundValueOfTheYearVU2028ValueHigh_Basic,FundValueOfTheYearVU2028ValueMedian_Basic,FundValueOfTheYearVU2028ValueLow_Basic;
double FundValueOfTheYearVU2030ValueHigh_Basic,FundValueOfTheYearVU2030ValueMedian_Basic,FundValueOfTheYearVU2030ValueLow_Basic;
double FundValueOfTheYearVU2035ValueHigh_Basic,FundValueOfTheYearVU2035ValueMedian_Basic,FundValueOfTheYearVU2035ValueLow_Basic;



double MonthFundValueOfTheYearVURetValueHigh_Basic,MonthFundValueOfTheYearVURetValueMedian_Basic,MonthFundValueOfTheYearVURetValueLow_Basic;
double MonthFundValueOfTheYearVUDanaValueHigh_Basic,MonthFundValueOfTheYearVUDanaValueMedian_Basic,MonthFundValueOfTheYearVUDanaValueLow_Basic;
double MonthFundValueOfTheYearVU2023ValueHigh_Basic,MonthFundValueOfTheYearVU2023ValueMedian_Basic,MonthFundValueOfTheYearVU2023ValueLow_Basic;
double MonthFundValueOfTheYearVU2025ValueHigh_Basic,MonthFundValueOfTheYearVU2025ValueMedian_Basic,MonthFundValueOfTheYearVU2025ValueLow_Basic;
double MonthFundValueOfTheYearVU2028ValueHigh_Basic,MonthFundValueOfTheYearVU2028ValueMedian_Basic,MonthFundValueOfTheYearVU2028ValueLow_Basic;
double MonthFundValueOfTheYearVU2030ValueHigh_Basic,MonthFundValueOfTheYearVU2030ValueMedian_Basic,MonthFundValueOfTheYearVU2030ValueLow_Basic;
double MonthFundValueOfTheYearVU2035ValueHigh_Basic,MonthFundValueOfTheYearVU2035ValueMedian_Basic,MonthFundValueOfTheYearVU2035ValueLow_Basic;

double VU2023Value_EverCash1, VU2025Value_EverCash1, VU2028Value_EverCash1, VU2030Value_EverCash1, VU2035Value_EverCash1, VURetValue_EverCash1, VUDanaValue_EverCash1, VUCashValue_EverCash1;
double VU2023Value_EverCash6, VU2025Value_EverCash6, VU2028Value_EverCash6, VU2030Value_EverCash6, VU2035Value_EverCash6, VURetValue_EverCash6, VUDanaValue_EverCash6, VUCashValue_EverCash6;
double VU2023Value_EverCash55, VU2025Value_EverCash55, VU2028Value_EverCash55, VU2030Value_EverCash55, VU2035Value_EverCash55, VURetValue_EverCash55, VUDanaValue_EverCash55, VUCashValue_EverCash55;
double PrevVU2023Value_EverCash55, PrevVU2025Value_EverCash55, PrevVU2028Value_EverCash55, PrevVU2030Value_EverCash55, PrevVU2035Value_EverCash55, PrevVURetValue_EverCash55, PrevVUDanaValue_EverCash55, PrevVUCashValue_EverCash55;
double CashFactor;

NSString *getHL, *getHLPct,*getHLTerm, *getHLPctTerm, *getOccLoading, *strBumpMode, *strBasicPremium, *strBasicPremium_Bump, *strBasicSA, *strRTUPFrom, *strRTUPFor,*strRTUPAmount,*strGrayRTUPAmount, *strCovPeriod;
NSString *strRRTUOPrem,*strRRTUOFrom,*strRRTUOFor, *PYSex, *SecSex;
NSString *ECAR1RiderTerm, *ECAR1RiderDesc, *ECAR1SumAssured, *ECAR1HLoading, *ECAR1HLoadingPct, *ECAR1Premium;
NSString *ECAR1PaymentTerm, *ECAR1ReinvestGYI, *ECAR1HLoadingTerm, *ECAR1HLoadingPctTerm;

NSString *ECAR6RiderTerm, *ECAR6RiderDesc, *ECAR6SumAssured, *ECAR6HLoading, *ECAR6HLoadingPct, *ECAR6Premium;
NSString *ECAR6PaymentTerm, *ECAR6ReinvestGYI, *ECAR6HLoadingTerm, *ECAR6HLoadingPctTerm;

NSString *ECAR55RiderTerm = @"", *ECAR55RiderDesc, *ECAR55SumAssured, *ECAR55HLoading, *ECAR55HLoadingPct, *ECAR55Premium;
NSString *ECAR55PaymentTerm, *ECAR55ReinvestGYI, *ECAR55HLoadingTerm, *ECAR55HLoadingPctTerm;

int PYAge, SecAge;
double CurrentBump, minSA;
BOOL ECAR1Exist = FALSE;
BOOL ECAR6Exist = FALSE;
BOOL ECAR55Exist = FALSE;
BOOL RPUOExist = FALSE;
BOOL NegativeBump = FALSE;
//BOOL StopExec = FALSE; //flag for sustainability purpose

NSString *RPUOYear,*RPUOSA;
double OneTimePayOut,OneTimePayOutRate,OneTimePayOutWithMinSA, PaidOpChargeCash_H, PaidOpCharge2023_H,PaidOpCharge2025_H,PaidOpCharge2028_H,PaidOpCharge2030_H,PaidOpCharge2035_H,PaidOpChargeRet_H,PaidOpChargeDana_H;
double PaidOpChargeCash_M,PaidOpCharge2023_M,PaidOpCharge2025_M,PaidOpCharge2028_M,PaidOpCharge2030_M,PaidOpCharge2035_M,PaidOpChargeRet_M,PaidOpChargeDana_M;
double PaidOpChargeCash_L,PaidOpCharge2023_L,PaidOpCharge2025_L,PaidOpCharge2028_L,PaidOpCharge2030_L,PaidOpCharge2035_L,PaidOpChargeRet_L,PaidOpChargeDana_L;
double PaidOpChargeSum_H,PaidOpChargeSum_M,PaidOpChargeSum_L, ProjDeduction2023_H;
double ProjDeduction2023_H,ProjDeduction2025_H,ProjDeduction2028_H,ProjDeduction2030_H,ProjDeduction2035_H,ProjDeductionRet_H,ProjDeductionDana_H,ProjDeductionCash_H,ProjDeductionSum_H;
double ProjDeduction2023_M,ProjDeduction2025_M,ProjDeduction2028_M,ProjDeduction2030_M,ProjDeduction2035_M,ProjDeductionRet_M,ProjDeductionDana_M,ProjDeductionCash_M,ProjDeductionSum_M;
double ProjDeduction2023_L,ProjDeduction2025_L,ProjDeduction2028_L,ProjDeduction2030_L,ProjDeduction2035_L,ProjDeductionRet_L,ProjDeductionDana_L,ProjDeductionCash_L,ProjDeductionSum_L;
double ReinvestCashFund2023_H,ReinvestCashFund2025_H,ReinvestCashFund2028_H,ReinvestCashFund2030_H,ReinvestCashFund2035_H,ReinvestCashFundRet_H,ReinvestCashFundDana_H,ReinvestCashFundSum_H;
double ReinvestCashFund2023_M,ReinvestCashFund2025_M,ReinvestCashFund2028_M,ReinvestCashFund2030_M,ReinvestCashFund2035_M,ReinvestCashFundRet_M,ReinvestCashFundDana_M,ReinvestCashFundSum_M;
double ReinvestCashFund2023_L,ReinvestCashFund2025_L,ReinvestCashFund2028_L,ReinvestCashFund2030_L,ReinvestCashFund2035_L,ReinvestCashFundRet_L,ReinvestCashFundDana_L,ReinvestCashFundSum_L;
double ReinvestCashFundCase_H,ReinvestCashFundCase_M,ReinvestCashFundCase_L, ProjValAfterReinvestCash_H,ProjValAfterReinvestCash_M,ProjValAfterReinvestCash_L;
double ProjValAfterReinvestSum_H,ProjValAfterReinvestSum_M,ProjValAfterReinvestSum_L;
double ProjValAfterReinvest2023_H,ProjValAfterReinvest2025_H,ProjValAfterReinvest2028_H,ProjValAfterReinvest2030_H,ProjValAfterReinvest2035_H,ProjValAfterReinvestRet_H,ProjValAfterReinvestDana_H,ProjValAfterReinvestCash_H,ProjValAfterReinvestSum_H;
double ProjValAfterReinvest2023_M,ProjValAfterReinvest2025_M,ProjValAfterReinvest2028_M,ProjValAfterReinvest2030_M,ProjValAfterReinvest2035_M,ProjValAfterReinvestRet_M,ProjValAfterReinvestDana_M,ProjValAfterReinvestCash_M,ProjValAfterReinvestSum_M;
double ProjValAfterReinvest2023_L,ProjValAfterReinvest2025_L,ProjValAfterReinvest2028_L,ProjValAfterReinvest2030_L,ProjValAfterReinvest2035_L,ProjValAfterReinvestRet_L,ProjValAfterReinvestDana_L,ProjValAfterReinvestCash_L,ProjValAfterReinvestSum_L;
double PrevPaidUpOptionTable_2023_High,PrevPaidUpOptionTable_2025_High,PrevPaidUpOptionTable_2028_High,PrevPaidUpOptionTable_2030_High,PrevPaidUpOptionTable_2035_High,PrevPaidUpOptionTable_Cash_High,PrevPaidUpOptionTable_Ret_High,PrevPaidUpOptionTable_Dana_High;
double PrevPaidUpOptionTable_2023_Median,PrevPaidUpOptionTable_2025_Median,PrevPaidUpOptionTable_2028_Median,PrevPaidUpOptionTable_2030_Median,PrevPaidUpOptionTable_2035_Median,PrevPaidUpOptionTable_Cash_Median,PrevPaidUpOptionTable_Ret_Median,PrevPaidUpOptionTable_Dana_Median;
double PrevPaidUpOptionTable_2023_Low,PrevPaidUpOptionTable_2025_Low,PrevPaidUpOptionTable_2028_Low,PrevPaidUpOptionTable_2030_Low,PrevPaidUpOptionTable_2035_Low,PrevPaidUpOptionTable_Cash_Low,PrevPaidUpOptionTable_Ret_Low,PrevPaidUpOptionTable_Dana_Low;
double ProjValueMaturity2023_H,ProjValueMaturity2023_M,ProjValueMaturity2023_L,ProjValueMaturity2025_H,ProjValueMaturity2025_M,ProjValueMaturity2025_L;
double ProjValueMaturity2028_H,ProjValueMaturity2028_M,ProjValueMaturity2028_L,ProjValueMaturity2030_H,ProjValueMaturity2030_M,ProjValueMaturity2030_L;
double ProjValueMaturity2035_H,ProjValueMaturity2035_M,ProjValueMaturity2035_L,ProjValueMaturityRet_H,ProjValueMaturityRet_M,ProjValueMaturityRet_L;
double ProjValueMaturityCash_H,ProjValueMaturityCash_M,ProjValueMaturityCash_L,ProjValueMaturityDana_H,ProjValueMaturityDana_M,ProjValueMaturityDana_L;
double ProjWithdraw2023_H,ProjWithdraw2023_M,ProjWithdraw2023_L,ProjWithdraw2025_H,ProjWithdraw2025_M,ProjWithdraw2025_L;
double ProjWithdraw2028_H,ProjWithdraw2028_M,ProjWithdraw2028_L,ProjWithdraw2030_H,ProjWithdraw2030_M,ProjWithdraw2030_L;
double ProjWithdraw2035_H,ProjWithdraw2035_M,ProjWithdraw2035_L,ProjWithdrawRet_H,ProjWithdrawRet_M,ProjWithdrawRet_L;
double ProjWithdrawCash_H,ProjWithdrawCash_M,ProjWithdrawCash_L,ProjWithdrawDana_H,ProjWithdrawDana_M,ProjWithdrawDana_L;
double ProjReinvest2023_H,ProjReinvest2023_M,ProjReinvest2023_L,ProjReinvest2025_H,ProjReinvest2025_M,ProjReinvest2025_L;
double ProjReinvest2028_H,ProjReinvest2028_M,ProjReinvest2028_L,ProjReinvest2030_H,ProjReinvest2030_M,ProjReinvest2030_L;
double ProjReinvest2035_H,ProjReinvest2035_M,ProjReinvest2035_L,ProjReinvestRet_H,ProjReinvestRet_M,ProjReinvestRet_L;
double ProjReinvestCash_H,ProjReinvestCash_M,ProjReinvestCash_L,ProjReinvestDana_H,ProjReinvestDana_M,ProjReinvestDana_L;
double ReinvestAmount2023to2025_H, ReinvestAmount2023to2028_H,ReinvestAmount2023to2030_H,ReinvestAmount2023to2035_H,ReinvestAmount2023toRet_H,ReinvestAmount2023toCash_H,ReinvestAmount2023toDana_H;
double ReinvestAmount2025to2028_H,ReinvestAmount2025to2030_H,ReinvestAmount2025to2035_H,ReinvestAmount2025toRet_H,ReinvestAmount2025toCash_H,ReinvestAmount2025toDana_H;
double ReinvestAmount2028to2030_H,ReinvestAmount2028to2035_H,ReinvestAmount2028toRet_H,ReinvestAmount2028toCash_H,ReinvestAmount2028toDana_H;
double ReinvestAmount2030to2035_H,ReinvestAmount2030toRet_H,ReinvestAmount2030toCash_H,ReinvestAmount2030toDana_H;
double ReinvestAmount2035toRet_H,ReinvestAmount2035toCash_H,ReinvestAmount2035toDana_H;
double ReinvestAmount2023to2025_M, ReinvestAmount2023to2028_M,ReinvestAmount2023to2030_M,ReinvestAmount2023to2035_M,ReinvestAmount2023toRet_M,ReinvestAmount2023toCash_M,ReinvestAmount2023toDana_M;
double ReinvestAmount2025to2028_M,ReinvestAmount2025to2030_M,ReinvestAmount2025to2035_M,ReinvestAmount2025toRet_M,ReinvestAmount2025toCash_M,ReinvestAmount2025toDana_M;
double ReinvestAmount2028to2030_M,ReinvestAmount2028to2035_M,ReinvestAmount2028toRet_M,ReinvestAmount2028toCash_M,ReinvestAmount2028toDana_M;
double ReinvestAmount2030to2035_M,ReinvestAmount2030toRet_M,ReinvestAmount2030toCash_M,ReinvestAmount2030toDana_M;
double ReinvestAmount2035toRet_M,ReinvestAmount2035toCash_M,ReinvestAmount2035toDana_M;
double ReinvestAmount2023to2025_L, ReinvestAmount2023to2028_L,ReinvestAmount2023to2030_L,ReinvestAmount2023to2035_L,ReinvestAmount2023toRet_L,ReinvestAmount2023toCash_L,ReinvestAmount2023toDana_L;
double ReinvestAmount2025to2028_L,ReinvestAmount2025to2030_L,ReinvestAmount2025to2035_L,ReinvestAmount2025toRet_L,ReinvestAmount2025toCash_L,ReinvestAmount2025toDana_L;
double ReinvestAmount2028to2030_L,ReinvestAmount2028to2035_L,ReinvestAmount2028toRet_L,ReinvestAmount2028toCash_L,ReinvestAmount2028toDana_L;
double ReinvestAmount2030to2035_L,ReinvestAmount2030toRet_L,ReinvestAmount2030toCash_L,ReinvestAmount2030toDana_L;
double ReinvestAmount2035toRet_L,ReinvestAmount2035toCash_L,ReinvestAmount2035toDana_L;

@implementation EverLifeViewController
@synthesize CustCode,SINo,Age,sex,Name, BasicSA, requestOccLoading, getPlanCommDate, requestPlanCommDate, requestDOB, getDOB;
@synthesize getSexLA,requestSexLA, getSmokerLA, requestSmokerLA, SimpleOrDetail, getOccpClass, requestOccpClass;
@synthesize OtherRiderCode,OtherRiderDeductible,OtherRiderDesc,OtherRiderHL,OtherRiderHLP,OtherRiderHLPTerm,OtherRiderHLTerm;
@synthesize OtherRiderPlanOption,OtherRiderSA,OtherRiderTerm,OtherRiderPaymentTerm, OtherRiderPremium;
@synthesize UnitizeRiderCode,UnitizeRiderDeductible,UnitizeRiderHL,UnitizeRiderHLPct, CheckSustainLevel;
@synthesize UnitizeRiderPlanChoice,UnitizeRiderSA,UnitizeRiderTerm, UnitizeRiderPremium,UniTotalRiderPremAtPolYear;
@synthesize UniTotalRiderPremWithAlloc, OverallAddTPDBegin, OverallAddTPDEOY,OverallEOYTotalOADBear,OverallEOYTotalOADBull,OverallEOYTotalOADFlat;
@synthesize OverallEOYTotalTPDBear,OverallEOYTotalTPDBull,OverallEOYTotalTPDFlat,OverallFullSurrenderValue,OverallMonthlyIncome,OverallOADBegin;
@synthesize OverallOADEOY,OverallTotalFundSurrenderValueBear,OverallTotalFundSurrenderValueBull,OverallTotalFundSurrenderValueFlat,OverallTotalPremiumPaid;
@synthesize OverallTPDBegin,OverallTPDEOY,OverallYearlyIncome, StopExec, StopMessage1,StopMessage2,StopMessage3,StopMessage4, HeaderMsg, PolicySustainYear;
@synthesize Solution1,Solution2, EngOrBm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    UL_RatesDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"UL_Rates.sqlite"]];
	     
	
	if ([SimpleOrDetail isEqualToString:@"Detail"]) {
		
		getSmokerLA = [self.requestSmokerLA description];
		getOccLoading = [self.requestOccLoading description];
		getPlanCommDate = [self.requestPlanCommDate description];
		getDOB = [self.requestDOB description];
		getSexLA = [self.requestSexLA description];
		getOccpClass = self.requestOccpClass;
		
		
		
		OtherRiderCode = [[NSMutableArray alloc] init];
		OtherRiderDeductible= [[NSMutableArray alloc] init];
		OtherRiderDesc= [[NSMutableArray alloc] init];
		OtherRiderHL= [[NSMutableArray alloc] init];
		OtherRiderHLP= [[NSMutableArray alloc] init];
		OtherRiderHLPTerm= [[NSMutableArray alloc] init];
		OtherRiderHLTerm= [[NSMutableArray alloc] init];
		OtherRiderPlanOption= [[NSMutableArray alloc] init];
		OtherRiderSA = [[NSMutableArray alloc] init];
		OtherRiderTerm= [[NSMutableArray alloc] init];
		OtherRiderPremium = [[NSMutableArray alloc] init];
		OtherRiderPaymentTerm= [[NSMutableArray alloc] init];
		
		UnitizeRiderCode = [[NSMutableArray alloc] init ];
		UnitizeRiderSA = [[NSMutableArray alloc] init ];
		UnitizeRiderHL= [[NSMutableArray alloc] init ];
		UnitizeRiderHLPct = [[NSMutableArray alloc] init ];
		UnitizeRiderTerm = [[NSMutableArray alloc] init ];
		//UnitizeRiderMort = [[NSMutableArray alloc] init ];
		UnitizeRiderPlanChoice = [[NSMutableArray alloc] init ];
		UnitizeRiderDeductible = [[NSMutableArray alloc] init ];
		//UnitizeRiderAlloc = [[NSMutableArray alloc] init ];
		UnitizeRiderPremium = [[NSMutableArray alloc] init ];
		UniTotalRiderPremAtPolYear = [[NSMutableArray alloc] init ];
		UniTotalRiderPremWithAlloc = [[NSMutableArray alloc] init ];
		
			
		OverallAddTPDBegin= [[NSMutableArray alloc] init];
		OverallAddTPDEOY= [[NSMutableArray alloc] init];
		OverallEOYTotalOADBear= [[NSMutableArray alloc] init];
		OverallEOYTotalOADBull= [[NSMutableArray alloc] init];
		OverallEOYTotalOADFlat= [[NSMutableArray alloc] init];
		OverallEOYTotalTPDBear= [[NSMutableArray alloc] init];
		OverallEOYTotalTPDBull= [[NSMutableArray alloc] init];
		OverallEOYTotalTPDFlat= [[NSMutableArray alloc] init];
		OverallFullSurrenderValue= [[NSMutableArray alloc] init];
		OverallMonthlyIncome= [[NSMutableArray alloc] init];
		OverallOADBegin= [[NSMutableArray alloc] init];
		OverallOADEOY= [[NSMutableArray alloc] init];
		OverallTotalFundSurrenderValueBear= [[NSMutableArray alloc] init ];
		OverallTotalFundSurrenderValueBull= [[NSMutableArray alloc] init ];
		OverallTotalFundSurrenderValueFlat= [[NSMutableArray alloc] init ];
		OverallTotalPremiumPaid= [[NSMutableArray alloc] init ];
		OverallTPDBegin= [[NSMutableArray alloc] init ];
		OverallTPDEOY = [[NSMutableArray alloc] init ];
		OverallYearlyIncome = [[NSMutableArray alloc] init ];
		
		[self deleteTemp];
		[self PopulateData];
		[self GetRTUPData];
		[self getAllPreDetails];
		[self InsertToUL_Temp_Trad_LA];
		
		double SAFac = 0;
		
		if (Age < 17) {
			SAFac = 60;
		}
		else if (Age > 16 && Age < 26){ //17 - 25
			SAFac = 55;
		}
		else if (Age > 25 && Age < 36){ //26 - 35
			SAFac = 50;
		}
		else if (Age > 35 && Age < 46){ // 36 - 45
			SAFac = 35;
		}
		else if (Age > 45 && Age < 56){ //46 - 55
			SAFac = 25;
		}
		else if (Age > 55){
			SAFac = 15;
		}
		
		minSA =  SAFac * [strBasicPremium_Bump doubleValue ];
		
		CurrentBump = [self CalculateBUMP];
		if (CurrentBump < 0) {
			if (BasicSA > minSA) {
				
				NSString *PremRequired;
				int pct = 10;
				double tempOriPrem = [strBasicPremium_Bump doubleValue];
				
				//tempOriPrem = [strBasicPremium doubleValue] * tempOriginal;
				
				
				for (int i = 0; i < 20; i++) {
					PremRequired =  [NSString stringWithFormat:@"%.2f", (tempOriPrem + (tempOriPrem * pct/100.00)) ];
					strBasicPremium_Bump = PremRequired;
					
					if ([self CalculateBUMP] > 0) {
						if ([PremRequired  doubleValue] < 2 * tempOriPrem) {
							HeaderMsg = @"";
							StopMessage1 = [self ErrorMsg:@"T1" andInput1:PremRequired andInput2:@"" andInput3:@""];
							StopMessage2 = @"";
							StopMessage3 = @"";
							StopMessage4 = @"";
							StopExec = TRUE;
							
						}
						else
						{
							HeaderMsg = @"";
							StopMessage1 = [self ErrorMsg:@"D0" andInput1:@"" andInput2:@"" andInput3:@""];
							StopMessage2 = @"";
							StopMessage3 = @"";
							StopMessage4 = @"";
							StopExec = TRUE;
							
						}
						break;
					}
						
					pct = pct + 10;
				}
				 
				NegativeBump = FALSE;
				return;
			}
			else{
				[self CheckSustainForNegativeBump:CurrentBump];
				NegativeBump = TRUE;
			}
			
		}
		else{
			NegativeBump = FALSE;
		}
		
		[self getECAR1];
		[self getECAR6];
		[self getECAR55];
		[self getRPUO];
		[self InsertToUL_Temp_Trad_Basic];
		if (StopExec == TRUE) {
			return;
		}
		
		[self InsertToUL_Temp_Trad_Rider];
		[self InsertToUL_Temp_ECAR55];
		[self InsertToUL_Temp_ECAR1];
		[self InsertToUL_Temp_ECAR6];
		

		
		if ([OtherRiderCode count] != 0 || [UnitizeRiderCode count] != 0 || ECAR1Exist == TRUE ||
			ECAR55Exist == TRUE || ECAR6Exist == TRUE ) {
			[self InsertToUL_Temp_Summary];
		}

		NSString *databaseName = @"hladb.sqlite";
		self.db = [DBController sharedDatabaseController:databaseName];
		NSString *sqlStmt;
		int DBID;
		int pageNum = 0;
		int riderCount = 0;
		NSString *desc = @"Page";
		
		sqlStmt = @"Delete from UL_Temp_Pages";
		DBID = [_db ExecuteINSERT:sqlStmt];
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page1.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page2.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		sqlStmt = [NSString stringWithFormat:@"SELECT * FROM UL_Temp_ECAR55 Where SINo = '%@' ",SINo];
		_dataTable = [_db  ExecuteQuery:sqlStmt];
		
		if(	_dataTable.rows.count > 0){
			pageNum++;
			sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page13.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
			DBID = [_db ExecuteINSERT:sqlStmt];
			if (DBID <= 0){
				NSLog(@"Error inserting data into database.");
			}
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page3.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page4.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		sqlStmt = [NSString stringWithFormat:@"SELECT * FROM UL_Fund_Maturity_Option Where SINo = '%@' ",SINo];
		_dataTable = [_db  ExecuteQuery:sqlStmt];
		if (_dataTable.rows.count > 0) {
			pageNum++;
			sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page14.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
			DBID = [_db ExecuteINSERT:sqlStmt];
			if (DBID <= 0){
				NSLog(@"Error inserting data into database.");
			}
		}
		
		
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page6.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		
		
		riderCount = 0; //reset rider count
		int descRiderCountStart;
		if ([EngOrBm isEqualToString:@"Bm"]) {
			descRiderCountStart = 36;
		}
		else{
			descRiderCountStart = 35;
		}
		 //start of rider description page
		int riderInPageCount = 0; //number of rider in a page, maximum 3
		NSString *riderInPage = @""; //rider in a page, write to db
		//NSString *riderInPage1 = @"";
		NSString *curRider; //current rider
		NSString *prevRider; //previous rider
		NSString *headerTitle = @"tblHeader;";
		
		
		
		
		
		NSArray* row;
		
		sqlStmt = [NSString stringWithFormat:@"SELECT RiderCode FROM UL_Rider_Details Where SINo = '%@' ORDER BY RiderCode ASC ", SINo];
		//NSLog(@"%@",sqlStmt);
		_dataTable = [_db  ExecuteQuery:sqlStmt];
		
		for (row in _dataTable.rows)
		{
			riderCount++;
			curRider = [row objectAtIndex:0];
			
			//NSLog(@"%@",curRider);
			
			if ([curRider isEqualToString:@"CIRD"] || [curRider isEqualToString:@"DHI"] || [curRider isEqualToString:@"RRTUO"] ||
				[curRider isEqualToString:@"DCA"] || [curRider isEqualToString:@"ECAR"] || [curRider isEqualToString:@"ECAR6"] ||
				[curRider isEqualToString:@"ECAR55"] || [curRider isEqualToString:@"HMM"] || [curRider isEqualToString:@"LSR"] ||
				[curRider isEqualToString:@"MG_IV"] || [curRider isEqualToString:@"MR"] || [curRider isEqualToString:@"PA"] ||
				[curRider isEqualToString:@"WI"] || [curRider isEqualToString:@"PR"] || [curRider isEqualToString:@"TPDMLA"] ||
				[curRider isEqualToString:@"TPDWP"]   ){
				riderInPageCount++;
				prevRider = curRider;
				
				if(riderCount == 1){
					riderInPage = [headerTitle stringByAppendingString:riderInPage];
				}
				
				riderInPage = [riderInPage stringByAppendingString:curRider];
				riderInPage = [riderInPage stringByAppendingString:@";"];
				if (riderInPageCount == 3){
					//NSLog(@"%@",riderInPage);
					pageNum++;
					//if(riderCount == 1)
					//  riderInPage = [headerTitle stringByAppendingString:riderInPage];
					//descRiderCountStart++;
					sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
					DBID = [_db ExecuteINSERT:sqlStmt];
					if (DBID <= 0){
						NSLog(@"Error inserting data into database.");
					}
					//NSLog(@"%@",sqlStmt);
					riderInPageCount = 0;
					riderInPage = @"";
					prevRider = @"";
				}
				
				if (riderInPageCount == 1 && riderCount == _dataTable.rows.count){
					//NSLog(@"%@",riderInPage);
					pageNum++;
					//descRiderCountStart++;
					sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
					DBID = [_db ExecuteINSERT:sqlStmt];
					if (DBID <= 0){
						NSLog(@"Error inserting data into database.");
					}
					//NSLog(@"%@",sqlStmt);
					riderInPageCount = 0;
					riderInPage = @"";
				}
				
				if (riderInPageCount == 2 && riderCount == _dataTable.rows.count) {
					pageNum++;
					//descRiderCountStart++;
					sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
					DBID = [_db ExecuteINSERT:sqlStmt];
					if (DBID <= 0){
						NSLog(@"Error inserting data into database.");
					}
					//NSLog(@"%@",sqlStmt);
					riderInPageCount = 0;
					riderInPage = @"";
				}
			}
			else{
				if (riderInPageCount == 2){
					//NSLog(@"%@",riderInPage);
					pageNum++;
					if(riderCount == 1)
						riderInPage = [headerTitle stringByAppendingString:riderInPage];
					//descRiderCountStart++;
					sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
					DBID = [_db ExecuteINSERT:sqlStmt];
					if (DBID <= 0){
						NSLog(@"Error inserting data into database.");
					}
					//NSLog(@"%@",sqlStmt);
					prevRider= @"";
					riderInPageCount = 0;
					riderInPage = @"";
				}
				if ([curRider isEqualToString:@"CIRD"] || [curRider isEqualToString:@"DHI"] || [curRider isEqualToString:@"RRTUO"] ||
					[curRider isEqualToString:@"DCA"] || [curRider isEqualToString:@"ECAR"] || [curRider isEqualToString:@"ECAR55"] ||
					[curRider isEqualToString:@"ECAR6"] || [curRider isEqualToString:@"HMM"] || [curRider isEqualToString:@"LSR"] ||
					[curRider isEqualToString:@"MG_IV"] || [curRider isEqualToString:@"MR"] || [curRider isEqualToString:@"PA"] ||
					[curRider isEqualToString:@"WI"] || [curRider isEqualToString:@"PR"] || [curRider isEqualToString:@"TPDMLA"] ||
					[curRider isEqualToString:@"TPDWP"]  ){
					if (![curRider isEqualToString:@"CIWP"] && ![curRider isEqualToString:@"ACIR"] && ![curRider isEqualToString:@"LCWP"]
						&& ![prevRider isEqualToString:@""]) {
						prevRider = [prevRider stringByAppendingString:@";"];
						curRider = [prevRider stringByAppendingString:curRider];
						riderInPageCount = 0;
						riderInPage = @"";
						
					}
					else{
						pageNum++;
						
						if(riderCount == 1){
							riderInPage = [headerTitle stringByAppendingString:riderInPage];
						}
						
						sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES "
								   "('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
						DBID = [_db ExecuteINSERT:sqlStmt];
						if (DBID <= 0){
							NSLog(@"Error inserting data into database.");
						}
						prevRider = @"";
						riderInPage = @"";
						riderInPageCount = 0;
					}
					
				}
				//NSLog(@"%@",curRider);
				pageNum++;
				if(riderCount == 1)
					curRider = [headerTitle stringByAppendingString:curRider];
				//descRiderCountStart++;
				sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",curRider,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
				DBID = [_db ExecuteINSERT:sqlStmt];
				if (DBID <= 0){
					NSLog(@"Error inserting data into database.");
				}
				//NSLog(@"%@",sqlStmt);
			}
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page7.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}

		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page8.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page9.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page10.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		
		//sqlStmt = [NSString stringWithFormat:@"SELECT * FROM UL_Temp_ECAR55 Where SINo = '%@' ", SINo];
		//_dataTable = [_db  ExecuteQuery:sqlStmt];
		
		if (ECAR55Exist == TRUE) {

			pageNum++;
			//EverCash 55
			sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page11.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
			DBID = [_db ExecuteINSERT:sqlStmt];
			if (DBID <= 0){
				NSLog(@"Error inserting data into database.");
			}
		}
		
		//sqlStmt = [NSString stringWithFormat:@"SELECT * FROM UL_Temp_ECAR6 Where SINo = '%@' ", SINo];
		//_dataTable = [_db  ExecuteQuery:sqlStmt];
		if (ECAR6Exist == TRUE) {
			
			pageNum++;
			//EverCash 6
			sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page15.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
			DBID = [_db ExecuteINSERT:sqlStmt];
			if (DBID <= 0){
				NSLog(@"Error inserting data into database.");
			}
		}
		
		//sqlStmt = [NSString stringWithFormat:@"SELECT * FROM UL_Temp_ECAR Where SINo = '%@' ", SINo];
		//_dataTable = [_db  ExecuteQuery:sqlStmt];
		if (ECAR1Exist == TRUE) {
			
			pageNum++;
			//EverCash 1
			sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page12.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
			DBID = [_db ExecuteINSERT:sqlStmt];
			if (DBID <= 0){
				NSLog(@"Error inserting data into database.");
			}
		}
		
		if ([OtherRiderCode count] > 0) {
			
			pageNum++;
			sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page20.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
			DBID = [_db ExecuteINSERT:sqlStmt];
			if (DBID <= 0){
				NSLog(@"Error inserting data into database.");
			}
			
			if ([OtherRiderCode count] > 3) {
				pageNum++;
				sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page21.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
				DBID = [_db ExecuteINSERT:sqlStmt];
				if (DBID <= 0){
					NSLog(@"Error inserting data into database.");
				}
			}
		}
		
		if ([OtherRiderCode count] != 0 || [UnitizeRiderCode count] != 0 || ECAR1Exist == TRUE ||
			ECAR55Exist == TRUE || ECAR6Exist == TRUE ) {
			pageNum++;
			//Summary Page 1
			sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page30.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
			DBID = [_db ExecuteINSERT:sqlStmt];
			if (DBID <= 0){
				NSLog(@"Error inserting data into database.");
			}
			
			pageNum++;
			//Summary Page 2
			sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page31.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
			DBID = [_db ExecuteINSERT:sqlStmt];
			if (DBID <= 0){
				NSLog(@"Error inserting data into database.");
			}
		}
		
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page40.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page41.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		if (UnitizeRiderCode.count > 0) {
			pageNum++;
			sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page42.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
			DBID = [_db ExecuteINSERT:sqlStmt];
			if (DBID <= 0){
				NSLog(@"Error inserting data into database.");
			}
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page43.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		sqlStmt = [NSString stringWithFormat:@"SELECT ReducedYear FROM UL_ReducedPaidUp Where SINo = '%@' ", SINo];
		_dataTable = [_db  ExecuteQuery:sqlStmt];
		
		if (_dataTable.rows.count > 0) {
			pageNum++;
			sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page50.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
			DBID = [_db ExecuteINSERT:sqlStmt];
			if (DBID <= 0){
				NSLog(@"Error inserting data into database.");
			}
			
			if ([[[_dataTable.rows objectAtIndex:0] objectAtIndex:0 ] intValue ] < 25) {
				pageNum++;
				sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page51.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
				DBID = [_db ExecuteINSERT:sqlStmt];
				if (DBID <= 0){
					NSLog(@"Error inserting data into database.");
				}
			}
			
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page44.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page45.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page46.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page47.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO UL_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page48.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
	}
	
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)deleteTemp{
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
		QuerySQL = @"Delete from UL_temp_RPUO";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
		
        QuerySQL = @"Delete from UL_temp_ECAR55";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
		
		QuerySQL = @"Delete from UL_temp_ECAR";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }

        QuerySQL = @"Delete from UL_temp_ECAR6";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }

		
		QuerySQL = @"Delete from UL_temp_Fund";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
		
		QuerySQL = @"Delete from UL_temp_Summary";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
		
        QuerySQL = @"Delete from UL_temp_Rider";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from UL_temp_Trad";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from UL_temp_Trad_Basic";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from UL_temp_Trad_details";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete  from UL_temp_Trad_Overall";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from UL_temp_Trad_Rider";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from UL_temp_Trad_Riderillus";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from UL_temp_Trad_Summary";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from UL_temp_trad_LA";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    
    statement = Nil;
    QuerySQL = Nil;
    
}

-(void)InsertToUL_Temp_Trad_LA{
    sqlite3_stmt *statement;
    sqlite3_stmt *statement2;
    sqlite3_stmt *statement3;
    NSString *getCustomerCodeSQL;
    NSString *getFromCltProfileSQL;
    NSString *smoker;
    NSString *QuerySQL;
    
    NSLog(@"insert to UL Temp Trad LA --- start");
    
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		getCustomerCodeSQL = [ NSString stringWithFormat:@"select CustCode from UL_LaPayor where sino = \"%@\" AND seq = %d ", SINo, 1];
		
		if(sqlite3_prepare_v2(contactDB, [getCustomerCodeSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW) {
				CustCode  = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				
				getFromCltProfileSQL  = [NSString stringWithFormat:@"Select Name, Smoker, sex, ALB from clt_profile where custcode  = \"%@\"",  CustCode];
				
				if(sqlite3_prepare_v2(contactDB, [getFromCltProfileSQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
					
					if (sqlite3_step(statement2) == SQLITE_ROW) {
						Name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
						smoker = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)];
						sex = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)];
						Age = sqlite3_column_int(statement2, 3);
						
						QuerySQL  = [ NSString stringWithFormat:@"Insert INTO UL_Temp_Trad_LA (\"SINo\", \"LADesc\", "
									 "\"PtypeCode\", \"Seq\", \"Name\", \"Age\", \"Sex\", \"Smoker\", \"LADescM\") "
									 " VALUES (\"%@\",\"Life Assured\",\"LA\",\"%d\",\"%@\",\"%d\", \"%@\", \"%@\", "
									 " \"Hayat yang Diinsuranskan\")", SINo, 1, Name, Age, sex, smoker ];
						
						if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement3, NULL) == SQLITE_OK) {
							if (sqlite3_step(statement3) == SQLITE_DONE) {
								//NSLog(@"done insert to temp_trad_LA");
							}
							sqlite3_finalize(statement3);
						}
						
						smoker = Nil;
					}
					sqlite3_finalize(statement2);
				}
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
    
    // check for 2nd life assured
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        getCustomerCodeSQL = [ NSString stringWithFormat:@"select CustCode from UL_LaPayor where sino = \"%@\" AND seq = %d ", SINo, 2];
        
        if(sqlite3_prepare_v2(contactDB, [getCustomerCodeSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                CustCode  = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                getFromCltProfileSQL  = [NSString stringWithFormat:@"Select Name, Smoker, sex, ALB from clt_profile where custcode  = \"%@\"",  CustCode];
                
                if(sqlite3_prepare_v2(contactDB, [getFromCltProfileSQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
                    
                    if (sqlite3_step(statement2) == SQLITE_ROW) {
                        NSString *SecName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
                        NSString *Secsmoker = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)];
						SecSex = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)];
						SecAge = sqlite3_column_int(statement2, 3);
                        
                        QuerySQL  = [ NSString stringWithFormat:@"Insert INTO UL_Temp_Trad_LA (\"SINo\", \"LADesc\", "
                                     "\"PtypeCode\", \"Seq\", \"Name\", \"Age\", \"Sex\", \"Smoker\", \"LADescM\") "
                                     " VALUES (\"%@\",\"2nd Life Assured\",\"LA\",\"%d\",\"%@\",\"%d\", \"%@\", \"%@\", "
                                     " \"Hayat yang Diinsuranskan ke-2\")", SINo, 2, SecName, SecAge, SecSex, Secsmoker ];
                        
                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement3, NULL) == SQLITE_OK) {
                            if (sqlite3_step(statement3) == SQLITE_DONE) {
                                //NSLog(@"done insert to temp_trad_LA");
                            }
                            sqlite3_finalize(statement3);
                        }
                        
                        SecName = Nil;
                        Secsmoker = Nil;
                        SecSex = Nil;
                    }
                    sqlite3_finalize(statement2);
                }
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    //check for payor
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        getCustomerCodeSQL = [ NSString stringWithFormat:@"select CustCode from UL_LaPayor where sino = \"%@\" AND PtypeCode = 'PY' ", SINo];
        
        if(sqlite3_prepare_v2(contactDB, [getCustomerCodeSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                CustCode  = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                getFromCltProfileSQL  = [NSString stringWithFormat:@"Select Name, Smoker, sex, ALB from clt_profile where custcode  = \"%@\"",  CustCode];
                
                if(sqlite3_prepare_v2(contactDB, [getFromCltProfileSQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
                    
                    if (sqlite3_step(statement2) == SQLITE_ROW) {
                        NSString *PYName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
                        NSString *PYsmoker = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)];
						PYSex = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)];
						PYAge = sqlite3_column_int(statement2, 3);
                        
                        QuerySQL  = [ NSString stringWithFormat:@"Insert INTO UL_Temp_Trad_LA (\"SINo\", \"LADesc\", "
                                     "\"PtypeCode\", \"Seq\", \"Name\", \"Age\", \"Sex\", \"Smoker\", \"LADescM\") "
                                     " VALUES (\"%@\",\"Policy Owner\",\"PY\",\"%d\",\"%@\",\"%d\", \"%@\", \"%@\", "
                                     " \"Pemunya Polisi\")", SINo, 1, PYName, PYAge, PYSex, PYsmoker ];
                        
                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement3, NULL) == SQLITE_OK) {
                            if (sqlite3_step(statement3) == SQLITE_DONE) {
                                
                            }
                            sqlite3_finalize(statement3);
                        }
                        
                        PYName = Nil;
                        PYsmoker = Nil;
                        PYSex = Nil;
                    }
                    sqlite3_finalize(statement2);
                }
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    NSLog(@"insert to UL_Temp_Trad_LA --- End");
    statement = Nil;
    statement2 = Nil;
    statement3 = Nil;
    getCustomerCodeSQL = Nil;
    getFromCltProfileSQL = Nil;
    smoker = Nil;
    QuerySQL = Nil;
    
}

-(void)InsertToUL_Temp_Trad_Basic{
    sqlite3_stmt *statement;
    NSString *QuerySQL;
	int inputAge;
	NSMutableArray *AnnualPremium = [[NSMutableArray alloc] init ];
    NSMutableArray *BasicSumAssured = [[NSMutableArray alloc] init ];
	NSMutableArray *CumulativePremium = [[NSMutableArray alloc] init ];
	NSMutableArray *AllocatedBasicPrem = [[NSMutableArray alloc] init ];
	NSMutableArray *AllocatedRiderPrem = [[NSMutableArray alloc] init ];
	NSMutableArray *UnAllocatedAllPrem = [[NSMutableArray alloc] init ];
	NSMutableArray *CumAlloBasicPrem = [[NSMutableArray alloc] init ];
	NSMutableArray *CumAlloRiderPrem = [[NSMutableArray alloc] init ];
	NSMutableArray *TotalCumPrem = [[NSMutableArray alloc] init ];
	NSMutableArray *BasicInsCharge = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderInsCharge = [[NSMutableArray alloc] init ];
	NSMutableArray *OtherCharge = [[NSMutableArray alloc] init ];
	NSMutableArray *DirectDistributionCost = [[NSMutableArray alloc] init ];
	NSMutableArray *BullSurrender = [[NSMutableArray alloc] init ];
	NSMutableArray *FlatSurrender = [[NSMutableArray alloc] init ];
	NSMutableArray *BearSurrender = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderBullSurrender = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderFlatSurrender = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderBearSurrender = [[NSMutableArray alloc] init ];
	NSMutableArray *TotalBullSurrender = [[NSMutableArray alloc] init ];
	NSMutableArray *TotalFlatSurrender = [[NSMutableArray alloc] init ];
	NSMutableArray *TotalBearSurrender = [[NSMutableArray alloc] init ];
	NSMutableArray *EOFTPDBull = [[NSMutableArray alloc] init ];
	NSMutableArray *EOFTPDFlat = [[NSMutableArray alloc] init ];
	NSMutableArray *EOFTPDBear = [[NSMutableArray alloc] init ];
	NSMutableArray *EOFOADBull = [[NSMutableArray alloc] init ];
	NSMutableArray *EOFOADFlat = [[NSMutableArray alloc] init ];
	NSMutableArray *EOFOADBear = [[NSMutableArray alloc] init ];
	NSMutableArray *FundChargeBull = [[NSMutableArray alloc] init ];
	NSMutableArray *FundChargeFlat = [[NSMutableArray alloc] init ];
	NSMutableArray *FundChargeBear = [[NSMutableArray alloc] init ];


	
	NSLog(@"------------basic start --------");
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		/*
		QuerySQL = [NSString stringWithFormat: @"Select BasicSA, ATPrem, replace(A.Hloading, '(null)', '0') as Hloading, replace(A.HLoadingPct, '(null)', '0') as HLoadingPct "
					", BumpMode, sum(b.premium) as TotalRiderPrem from UL_Details A, ul_rider_details B Where  "
					"A.sino = B.sino AND A.sino = '%@' AND ridercode in ('CIRD', 'DCA', 'ACIR', 'HMM', 'MG_IV', "
					"'WI', 'MR', 'TPDMLA', 'PA', 'DHI')", SINo];
		*/
		/*
		QuerySQL = [NSString stringWithFormat: @"Select BasicSA, ATPrem, replace(Hloading, '(null)', '0') as Hloading, replace(HLoadingPct, '(null)', '0') as HLoadingPct "
					", BumpMode from UL_Details Where  "
					" sino = '%@' ", SINo];
		
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {

				BasicSA = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] doubleValue ];

				strBasicSA = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] ;

				strBasicPremium = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] ;

				const char *temp = (const char*)sqlite3_column_text(statement, 2);
                getHL = temp == NULL ? nil : [[NSString alloc] initWithUTF8String:temp];

				const char *temp2 = (const char*)sqlite3_column_text(statement, 3);
				getHLPct = temp2 == NULL ? nil : [[NSString alloc] initWithUTF8String:temp2];

				strBumpMode	= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] ;
			
             }
            sqlite3_finalize(statement);
        }
		*/
		/*
		QuerySQL = [NSString stringWithFormat: @"Select sum(premium) as TotalRiderPrem from  ul_rider_details Where  "
					" sino = '%@' AND ridercode in ('CIRD', 'DCA', 'ACIR', 'HMM', 'MG_IV', "
					"'WI', 'MR', 'TPDMLA', 'PA', 'DHI')", SINo];
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
				
				const char *temp3 = (const char*)sqlite3_column_text(statement, 0);
				strUnitizeRiderPrem = temp3 == NULL ? nil : [[NSString alloc] initWithUTF8String:temp3];
				
			}
			else{
				strUnitizeRiderPrem = @"0.00";
			}
            sqlite3_finalize(statement);
        }
		 */
		
		
		sqlite3_close(contactDB);
	}
	
	if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
		if (UnitizeRiderCode.count > 0) {
			for (int i = 1; i <= 30; i++) {
				double tempUniRiderPrem = 0.00;
				double tempValue = 0.00;
				double tempUniRiderAlloc = 0.00;
				
				for (int j = 0; j < [UnitizeRiderCode count]; j++) {
					if ([[UnitizeRiderTerm objectAtIndex:j ] integerValue ] >= i ) {
						tempUniRiderPrem = tempUniRiderPrem + [[UnitizeRiderPremium objectAtIndex:j] doubleValue ];
						
						QuerySQL = [NSString stringWithFormat: @"select Rate from ES_Sys_Rider_Allocation where Term = '%@' AND PolYear = '%d'",
									[UnitizeRiderTerm objectAtIndex:j], i];
						
						//NSLog(@"%@", QuerySQL);
						if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
							if (sqlite3_step(statement) == SQLITE_ROW) {
								tempValue = sqlite3_column_double(statement, 0);
								
							}
							else{
								tempValue = 0.00;
							}
							sqlite3_finalize(statement);
						}
						else{
							tempValue = 0.00;
						}
						
						tempUniRiderAlloc = tempUniRiderAlloc + ([[UnitizeRiderPremium objectAtIndex:j] doubleValue ] * tempValue/100.00 );
						
					}
				}
				
				[UniTotalRiderPremAtPolYear addObject:[NSString stringWithFormat:@"%f", tempUniRiderPrem]];
				[UniTotalRiderPremWithAlloc addObject:[NSString stringWithFormat:@"%f", tempUniRiderAlloc]];
			}
		}
		else{
			for (int i = 1; i <= 30; i++) {
				[UniTotalRiderPremAtPolYear addObject:[NSString stringWithFormat:@"0.00"]];
				[UniTotalRiderPremWithAlloc addObject:[NSString stringWithFormat:@"0.00"]];
			}
			
		}

	}
	
	if (UniTotalRiderPremAtPolYear.count < 30) {
		NSLog(@" UniTotalRiderPremAtPolYear is less than 30");
		return;
	}

	if (UniTotalRiderPremWithAlloc.count < 30) {
		NSLog(@" UniTotalRiderAlloc is less than 30");
		return;
	}
	
	
	if ([strBasicPremium isEqualToString:@""]) {
		NSLog(@"no basic premium");
		return;
	}
	
	[self ResetData];
	//int tempSustainYear = PolicySustainYear == 0 ? 100 : PolicySustainYear;
	
    for (int i =1; i <=30 ; i++) {
		//if (Age + i <= tempSustainYear) {
			[BasicSumAssured addObject: [NSString stringWithFormat:@"%.0f", [strBasicSA doubleValue] * [self JuvenilienFactor:Age + i]]];
			[OverallTPDBegin addObject:[BasicSumAssured objectAtIndex:i - 1 ]];
			[OverallTPDEOY addObject:[BasicSumAssured objectAtIndex:i - 1 ]];
			[OverallFullSurrenderValue addObject:@"0.00"];
			
			double TotalPolicyPrem = [strBasicPremium doubleValue] + [[UniTotalRiderPremAtPolYear objectAtIndex:i -1] doubleValue];
			[AnnualPremium addObject: [NSString stringWithFormat:@"%.3f", TotalPolicyPrem]];
			//NSLog(@"premium ok");
			[OverallTotalPremiumPaid addObject:[AnnualPremium objectAtIndex:i - 1 ]];
			
			if (i == 1) {
				[CumulativePremium addObject: [AnnualPremium objectAtIndex: i -1]];
			}
			else{
				NSString *Prev = [NSString stringWithFormat:@"%.3f", [[CumulativePremium objectAtIndex:i - 2] doubleValue ] + [[AnnualPremium objectAtIndex: i -1] doubleValue ]];
				[CumulativePremium addObject: Prev];
			}
			//NSLog(@"cumPremium ok");
			
			double sss = [self ReturnPremAllocation:i];
			[AllocatedBasicPrem addObject:[NSString stringWithFormat:@"%f", [strBasicPremium doubleValue ] * sss]];
			
			[AllocatedRiderPrem addObject:[NSString stringWithFormat:@"%f", [[UniTotalRiderPremWithAlloc objectAtIndex:i -1] doubleValue ]]];
			
			[UnAllocatedAllPrem addObject:[NSString stringWithFormat:@"%f",
										   TotalPolicyPrem - [[AllocatedBasicPrem objectAtIndex:i - 1] doubleValue] - [[AllocatedRiderPrem objectAtIndex:i - 1] doubleValue]]];
			
			if (i == 1) {
				[CumAlloBasicPrem addObject: [AllocatedBasicPrem objectAtIndex: i -1]];
			}
			else{
				NSString *Prev = [NSString stringWithFormat:@"%f", [[CumAlloBasicPrem objectAtIndex:i - 2] doubleValue ] + [[AllocatedBasicPrem objectAtIndex: i -1] doubleValue ]];
				[CumAlloBasicPrem addObject: Prev];
			}
			
			if (i == 1) {
				[CumAlloRiderPrem addObject: [AllocatedRiderPrem objectAtIndex: i -1]];
			}
			else{
				NSString *Prev = [NSString stringWithFormat:@"%f", [[CumAlloRiderPrem objectAtIndex:i - 2] doubleValue ] + [[AllocatedRiderPrem objectAtIndex: i -1] doubleValue ]];
				[CumAlloRiderPrem addObject: Prev];
			}
			
			[TotalCumPrem addObject:[NSString stringWithFormat:@"%f", [[CumAlloBasicPrem objectAtIndex:i - 1] doubleValue] + [[CumAlloRiderPrem objectAtIndex:i-1] doubleValue ]]];
			
			[BasicInsCharge addObject:[NSString stringWithFormat:@"%f",[self ReturnTotalBasicMortLow:i] * 12]];
			
			[RiderInsCharge addObject:[NSString stringWithFormat:@"%f", [self ReturnTotalRiderMort:i] * 12.00]];
			
			[OtherCharge addObject:[NSString stringWithFormat:@"%f", (PolicyFee + [self ReturnRiderPolicyFee:i]) * 12]];
			
			[DirectDistributionCost addObject:[NSString stringWithFormat:@"%f", ([strBasicPremium doubleValue ] * [self ReturnBasicCommisionFee:i]/100.00) +
											   ([self ReturnRegTopUpPrem] * 0.0375) + ([self ReturnExcessPrem:1] * 0.0375) + [self ReturnRiderCommisionFee:i]  ]];
			
			
			
			
			//-----------
			if (i == 1) {
				[self CalcInst:@""];
				[self GetRegWithdrawal];
				[self ReturnFundFactor]; // get factor for each fund
				[self CalcYearDiff]; //get the yearDiff
				
			}
			
			if (i == YearDiff2023 || i == YearDiff2025 || i == YearDiff2028 || i == YearDiff2030 || i == YearDiff2035) {
				[self ReturnMonthEverCash1:i andMonth:12];
				[self ReturnMonthEverCash6:i andMonth:12];
				[self ReturnMonthEverCash55:i andMonth:12];
			}
			else
			{
				[self ReturnEverCash1:i];
				[self ReturnEverCash6:i];
				[self ReturnEverCash55:i];
			}
			
			
			//---------
			
			double t2023High = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] * (i > FundTermPrev2023 ? 0 : [self ReturnVU2023Fac]) * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2023PrevValuehigh * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double t2025High = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2025Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2025PrevValuehigh * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double t2028High = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2028Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2028PrevValuehigh * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double t2030High = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2030Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2030PrevValuehigh * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double t2035High = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2035Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2035PrevValuehigh * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tCashHigh = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVUCashFac:i] * [self ReturnFundChargeRate:@"Cash" andMOP:strBumpMode]) + VUCashPrevValueHigh * [self ReturnFundChargeRate:@"Cash" andMOP:@"A"];
			double tRetHigh = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVURetFac:i] * [self ReturnFundChargeRate:@"Secure" andMOP:strBumpMode]) + VURetPrevValueHigh * [self ReturnFundChargeRate:@"Secure" andMOP:@"A"];
			double tDanaHigh = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVUDanaFac:i] * [self ReturnFundChargeRate:@"Dana" andMOP:strBumpMode]) + VUDanaPrevValueHigh * [self ReturnFundChargeRate:@"Dana" andMOP:@"A"];
		
			double FundManagementChargeHigh = t2023High + t2025High + t2028High + t2030High + t2035High + tCashHigh + tRetHigh + tDanaHigh;
			FundManagementChargeHigh = FundManagementChargeHigh <= 0 ? 0 : FundManagementChargeHigh;
			
			double tRider2023High = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] * (i > FundTermPrev2023 ? 0 : [self ReturnVU2023Fac]) * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2023PrevValuehigh * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRider2025High = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2025Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2025PrevValuehigh * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRider2028High = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2028Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2028PrevValuehigh * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRider2030High = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2030Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2030PrevValuehigh * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRider2035High = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2035Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2035PrevValuehigh * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRiderCashHigh = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVUCashFac:i] * [self ReturnFundChargeRate:@"Cash" andMOP:strBumpMode]) + RiderVUCashPrevValueHigh * [self ReturnFundChargeRate:@"Cash" andMOP:@"A"];
			double tRiderRetHigh = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVURetFac:i] * [self ReturnFundChargeRate:@"Secure" andMOP:strBumpMode]) + RiderVURetPrevValueHigh * [self ReturnFundChargeRate:@"Secure" andMOP:@"A"];
			double tRiderDanaHigh = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVUDanaFac:i] * [self ReturnFundChargeRate:@"Dana" andMOP:strBumpMode]) + RiderVUDanaPrevValueHigh * [self ReturnFundChargeRate:@"Dana" andMOP:@"A"];
		
			double RiderFundManagementChargeHigh = tRider2023High + tRider2025High + tRider2028High + tRider2030High + tRider2035High + tRiderCashHigh + tRiderRetHigh + tRiderDanaHigh;
			RiderFundManagementChargeHigh = RiderFundManagementChargeHigh <= 0 ? 0 : RiderFundManagementChargeHigh;
			
			double t2023Med = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] * (i > FundTermPrev2023 ? 0 : [self ReturnVU2023Fac]) * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2023PrevValueMedian * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double t2025Med = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2025Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2025PrevValueMedian * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double t2028Med = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2028Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2028PrevValueMedian * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double t2030Med = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2030Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2030PrevValueMedian * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double t2035Med = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2035Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2035PrevValueMedian * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tCashMed = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVUCashFac:i] * [self ReturnFundChargeRate:@"Cash" andMOP:strBumpMode]) + VUCashPrevValueMedian * [self ReturnFundChargeRate:@"Cash" andMOP:@"A"];
			double tRetMed = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVURetFac:i] * [self ReturnFundChargeRate:@"Secure" andMOP:strBumpMode]) + VURetPrevValueMedian * [self ReturnFundChargeRate:@"Secure" andMOP:@"A"];
			double tDanaMed = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVUDanaFac:i] * [self ReturnFundChargeRate:@"Dana" andMOP:strBumpMode]) + VUDanaPrevValueMedian * [self ReturnFundChargeRate:@"Dana" andMOP:@"A"];
		
			double FundManagementChargeMed = t2023Med + t2025Med + t2028Med + t2030Med + t2035Med + tCashMed + tRetMed + tDanaMed;
			FundManagementChargeMed = FundManagementChargeMed <= 0 ? 0 : FundManagementChargeMed;
			
			double tRider2023Med = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] * (i > FundTermPrev2023 ? 0 : [self ReturnVU2023Fac]) * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2023PrevValueMedian * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRider2025Med = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2025Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2025PrevValueMedian * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRider2028Med = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2028Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2028PrevValueMedian * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRider2030Med = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2030Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2030PrevValueMedian * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRider2035Med = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2035Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2035PrevValueMedian * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRiderCashMed = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVUCashFac:i] * [self ReturnFundChargeRate:@"Cash" andMOP:strBumpMode]) + RiderVUCashPrevValueMedian * [self ReturnFundChargeRate:@"Cash" andMOP:@"A"];
			double tRiderRetMed = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVURetFac:i] * [self ReturnFundChargeRate:@"Secure" andMOP:strBumpMode]) + RiderVURetPrevValueMedian * [self ReturnFundChargeRate:@"Secure" andMOP:@"A"];
			double tRiderDanaMed = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVUDanaFac:i] * [self ReturnFundChargeRate:@"Dana" andMOP:strBumpMode]) + RiderVUDanaPrevValueMedian * [self ReturnFundChargeRate:@"Dana" andMOP:@"A"];
		
			double RiderFundManagementChargeMed = tRider2023Med + tRider2025Med + tRider2028Med + tRider2030Med + tRider2035Med + tRiderCashMed + tRiderRetMed + tRiderDanaMed;
			RiderFundManagementChargeMed = RiderFundManagementChargeMed <= 0 ? 0 : RiderFundManagementChargeMed;
			
			double t2023Low = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] * (i > FundTermPrev2023 ? 0 : [self ReturnVU2023Fac]) * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2023PrevValueLow * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double t2025Low = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2025Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2025PrevValueLow * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double t2028Low = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2028Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2028PrevValueLow * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double t2030Low = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2030Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2030PrevValueLow * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double t2035Low = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2035Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + VU2035PrevValueLow * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tCashLow = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVUCashFac:i] * [self ReturnFundChargeRate:@"Cash" andMOP:strBumpMode]) + VUCashPrevValueLow * [self ReturnFundChargeRate:@"Cash" andMOP:@"A"];
			double tRetLow = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVURetFac:i] * [self ReturnFundChargeRate:@"Secure" andMOP:strBumpMode]) + VURetPrevValueLow * [self ReturnFundChargeRate:@"Secure" andMOP:@"A"];
			double tDanaLow = ([[AllocatedBasicPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVUDanaFac:i] * [self ReturnFundChargeRate:@"Dana" andMOP:strBumpMode]) + VUDanaPrevValueLow * [self ReturnFundChargeRate:@"Dana" andMOP:@"A"];
		
			double FundManagementChargeLow = t2023Low + t2025Low + t2028Low + t2030Low + t2035Low + tCashLow + tRetLow + tDanaLow;
			FundManagementChargeLow = FundManagementChargeLow <= 0 ? 0 : FundManagementChargeLow;
			
			double tRider2023Low = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] * (i > FundTermPrev2023 ? 0 : [self ReturnVU2023Fac]) * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2023PrevValueLow * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRider2025Low = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2025Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2025PrevValueLow * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRider2028Low = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2028Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2028PrevValueLow * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRider2030Low = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2030Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2030PrevValueLow * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRider2035Low = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVU2035Fac:i] * [self ReturnFundChargeRate:@"Ever" andMOP:strBumpMode]) + RiderVU2035PrevValueLow * [self ReturnFundChargeRate:@"Ever" andMOP:@"A"];
			double tRiderCashLow = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVUCashFac:i] * [self ReturnFundChargeRate:@"Cash" andMOP:strBumpMode]) + RiderVUCashPrevValueLow * [self ReturnFundChargeRate:@"Cash" andMOP:@"A"];
			double tRiderRetLow = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVURetFac:i] * [self ReturnFundChargeRate:@"Secure" andMOP:strBumpMode]) + RiderVURetPrevValueLow * [self ReturnFundChargeRate:@"Secure" andMOP:@"A"];
			double tRiderDanaLow = ([[AllocatedRiderPrem objectAtIndex:i - 1]doubleValue ] *[self ReturnVUDanaFac:i] * [self ReturnFundChargeRate:@"Dana" andMOP:strBumpMode]) + RiderVUDanaPrevValueLow * [self ReturnFundChargeRate:@"Dana" andMOP:@"A"];
		
			double RiderFundManagementChargeLow = tRider2023Low + tRider2025Low + tRider2028Low + tRider2030Low + tRider2035Low + tRiderCashLow + tRiderRetLow + tRiderDanaLow;
			RiderFundManagementChargeLow = RiderFundManagementChargeLow <= 0 ? 0 : RiderFundManagementChargeLow;
			
			VUCashValueNegative = false;
			RiderVUCashValueNegative = false;
			if (i == YearDiff2023 || i == YearDiff2025 || i == YearDiff2028 || i == YearDiff2030 || i == YearDiff2035) {
				
				for (int m = 1; m <= 12; m++) {
					MonthFundValueOfTheYearValueTotalHigh = [self ReturnMonthFundValueOfTheYearValueTotalHigh:i andMonth:m];
					RiderMonthFundValueOfTheYearValueTotalHigh = [self ReturnRiderMonthFundValueOfTheYearValueTotalHigh:i andMonth:m];
					//NSLog(@"%d %f %f %f", m, MonthVURetValueHigh, MonthVU2035ValueHigh, MonthFundValueOfTheYearValueTotalHigh );
					[self SurrenderValue:i andMonth:m andLevel:1];
					
					MonthFundValueOfTheYearValueTotalMedian = [self ReturnMonthFundValueOfTheYearValueTotalMedian:i andMonth:m];
					RiderMonthFundValueOfTheYearValueTotalMedian = [self ReturnRiderMonthFundValueOfTheYearValueTotalMedian:i andMonth:m];
					[self SurrenderValue:i andMonth:m andLevel:2];
					
					
					MonthFundValueOfTheYearValueTotalLow = [self ReturnMonthFundValueOfTheYearValueTotalLow:i andMonth:m];
					RiderMonthFundValueOfTheYearValueTotalLow = [self ReturnRiderMonthFundValueOfTheYearValueTotalLow:i andMonth:m];
					//NSLog(@"%d %f %f %f", m, MonthVURetValueLow, MonthVU2035ValueLow, MonthFundValueOfTheYearValueTotalLow );
					[self SurrenderValue:i andMonth:m andLevel:3];
					
				}
				
				// for page14.html ul_temp_fund
				if (i == YearDiff2023) {
					[self InsertToUL_Temp_Fund:@"HLA EverGreen 2023" andValue1:Withdrawtemp2023High + RiderWithdrawtemp2023High
									 andValue2:Withdrawtemp2023Median + RiderWithdrawtemp2023Median
									 andValue3:Withdrawtemp2023Low + RiderWithdrawtemp2023Low
									 andValue4:temp2023High + Ridertemp2023High
									 andValue5:temp2023Median + Ridertemp2023Median
									 andValue6:temp2023Low + Ridertemp2023Low];
					//NSLog(@"%f, %f, %f", temp2035High, temp2035Median, temp2035Low);
				}
				else if (i == YearDiff2025) {
					[self InsertToUL_Temp_Fund:@"HLA EverGreen 2025" andValue1:Withdrawtemp2025High + RiderWithdrawtemp2025High
									 andValue2:Withdrawtemp2025Median + RiderWithdrawtemp2025Median
									 andValue3:Withdrawtemp2025Low + RiderWithdrawtemp2025Low
									 andValue4:temp2025High + Ridertemp2025High
									 andValue5:temp2025Median + Ridertemp2025Median
									 andValue6:temp2025Low + Ridertemp2025Low];
					//NSLog(@"%f, %f, %f", temp2035High, temp2035Median, temp2035Low);
				}
				else if (i == YearDiff2028) {
					[self InsertToUL_Temp_Fund:@"HLA EverGreen 2028" andValue1:Withdrawtemp2028High + RiderWithdrawtemp2028High
									 andValue2:Withdrawtemp2028Median + RiderWithdrawtemp2028Median
									 andValue3:Withdrawtemp2025Low + RiderWithdrawtemp2025Low
									 andValue4:temp2028High + Ridertemp2028High
									 andValue5:temp2028Median + Ridertemp2028Median
									 andValue6:temp2028Low + Ridertemp2028Low];
					//NSLog(@"%f, %f, %f", temp2035High, temp2035Median, temp2035Low);
				}
				else if (i == YearDiff2030) {
					[self InsertToUL_Temp_Fund:@"HLA EverGreen 2030" andValue1:Withdrawtemp2030High + RiderWithdrawtemp2030High
									 andValue2:Withdrawtemp2030Median + RiderWithdrawtemp2030Median
									 andValue3:Withdrawtemp2030Low + RiderWithdrawtemp2030Low
									 andValue4:temp2030High + Ridertemp2030High
									 andValue5:temp2030Median + Ridertemp2030Median andValue6:temp2030Low + Ridertemp2030Low];
					//NSLog(@"%f, %f, %f", temp2035High, temp2035Median, temp2035Low);
				}
				else if (i == YearDiff2035) {
					[self InsertToUL_Temp_Fund:@"HLA EverGreen 2035" andValue1:Withdrawtemp2035High + RiderWithdrawtemp2035High
									 andValue2:Withdrawtemp2035Median + RiderWithdrawtemp2035Median
									 andValue3:Withdrawtemp2035Low + RiderWithdrawtemp2035Low
									 andValue4:temp2035High + Ridertemp2035High
									 andValue5:temp2035Median + Ridertemp2035Median andValue6:temp2035Low + Ridertemp2035Low];
					//NSLog(@"%f, %f, %f", temp2035High, temp2035Median, temp2035Low);
				}
			}
			else{
				VUCashValueNegative = false;
				RiderVUCashValueNegative = false;
				FundValueOfTheYearValueTotalHigh = [self ReturnFundValueOfTheYearValueTotalHigh:i];
				FundValueOfTheYearValueTotalMedian = [self ReturnFundValueOfTheYearValueTotalMedian:i];
				FundValueOfTheYearValueTotalLow = [self ReturnFundValueOfTheYearValueTotalLow:i];
				RiderFundValueOfTheYearValueTotalHigh = [self ReturnRiderFundValueOfTheYearValueTotalHigh:i];
				RiderFundValueOfTheYearValueTotalMedian = [self ReturnRiderFundValueOfTheYearValueTotalMedian:i];
				RiderFundValueOfTheYearValueTotalLow = [self ReturnRiderFundValueOfTheYearValueTotalLow:i];
				
				[self SurrenderValue:i andMonth:0 andLevel:0];
				
			}
			
			
			NSString *tempMsg = [NSString stringWithFormat:@"%d",i - 1 ];
			int tempSustainPolicyYear = PolicySustainYear > 0 ? PolicySustainYear - Age : 20;
			
			//NSLog(@"%d %f",i, HSurrenderValue);
				
		if (NegativeBump == TRUE) {
			
			if (BasicSA == minSA) {
				if([self ReturnRegWithdrawal:i] == 0){
					if(HSurrenderValue < 0 ){
						if (PolicySustainYear > 0) { //negative bump, no withdrawal, sustain year inserted
							if (i <= tempSustainPolicyYear) {
								[self CheckSustainForNegativeBump:CurrentBump];
								NegativeBump = TRUE;
								[self InsertToUL_Temp_Trad_Basic];
							}
							else{
								HeaderMsg = [self ErrorMsg:@"R0" andInput1:strGrayRTUPAmount andInput2:tempMsg andInput3:@"0"];
								StopMessage1 = [self ErrorMsg:@"01" andInput1:@"" andInput2:@"" andInput3:@""];
								StopMessage2 = @"";
								StopMessage3 = @"";
								StopMessage4 = @"";
								
								StopExec = TRUE;
								return;
							}
						}
						else{ //negative bump, no withdrawal, no sustain year inserted
							if (i <= tempSustainPolicyYear) {
								[self CheckSustainForNegativeBump:CurrentBump];
								NegativeBump = TRUE;
								[self InsertToUL_Temp_Trad_Basic];
							}
							else{
								HeaderMsg = [self ErrorMsg:@"Z2" andInput1:strGrayRTUPAmount andInput2:tempMsg andInput3:@"0"];
								StopMessage1 = [self ErrorMsg:@"01" andInput1:@"" andInput2:@"" andInput3:@""];
								StopMessage2 = @"";
								StopMessage3 = @"";
								StopMessage4 = @"";
								
								StopExec = TRUE;
								return;
							}
						}
					}
					else{
						if (i == 30) { //negative bump, no withdrawal, no sustain year inserted, no lapse before 30 years
							HeaderMsg = [self ErrorMsg:@"R0" andInput1:strGrayRTUPAmount andInput2:@"" andInput3:@""];
							StopMessage1 = [self ErrorMsg:@"01" andInput1:@"" andInput2:@"" andInput3:@""];
							StopMessage2 = @"";
							StopMessage3 = @"";
							StopMessage4 = @"";
							
							StopExec = TRUE;
							return;
						}
					}
				}
				else{ //negative bump, withdrawal
					if (i < RegWithdrawalStartYear) {
						[self CheckSustainForNegativeBump:CurrentBump];
						NegativeBump = TRUE;
						[self InsertToUL_Temp_Trad_Basic];
					}
					else{
						if (HSurrenderValue < 0 || HRiderSurrenderValue < 0 ) {
							if (i < 10) {
								HeaderMsg = [self ErrorMsg:@"Z1" andInput1:strGrayRTUPAmount andInput2:tempMsg andInput3:tempMsg];
								StopMessage1 = [self ErrorMsg:@"00" andInput1:@"" andInput2:@"" andInput3:@""];
								StopMessage2 = @"";
								StopMessage3 = @"";
								StopMessage4 = @"";
								
								StopExec = TRUE;
								return;
							}
							else{
								HeaderMsg = [self ErrorMsg:@"Z2" andInput1:strGrayRTUPAmount andInput2:tempMsg andInput3:tempMsg];
								StopMessage1 = [self ErrorMsg:@"01" andInput1:@"" andInput2:@"" andInput3:@""];
								StopMessage2 = @"";
								StopMessage3 = @"";
								StopMessage4 = @"";
								
								StopExec = TRUE;
								return;
							}
						}
						else{
							if (i == 30) { //negative bump, withdrawal, no lapse before 30 years
								HeaderMsg = [self ErrorMsg:@"R0" andInput1:strGrayRTUPAmount andInput2:@"" andInput3:@""];
								StopMessage1 = [self ErrorMsg:@"01" andInput1:@"" andInput2:@"" andInput3:@""];
								StopMessage2 = @"";
								StopMessage3 = @"";
								StopMessage4 = @"";
								
								StopExec = TRUE;
								return;
							}
							
						}
						
					}
				}
			}
			else{ //not min SA inserted
				
			}
			
			
		}
		else{
			if ([CheckSustainLevel isEqualToString:@"1"]) {
				if(HSurrenderValue < 0 ){
					if (i <= tempSustainPolicyYear) {
						if (HRiderSurrenderValue < 0) {
							
							if([self ReturnRegWithdrawal:i] == 0){ //BUA lapse, RUA lapse, no withdraw, level 1
								if (i < 10) {
									
									HeaderMsg = [self ErrorMsg:@"X3" andInput1:tempMsg andInput2:tempMsg andInput3:@""];
									StopMessage1 = [self ErrorMsg:@"C3" andInput1:@"" andInput2:@"" andInput3:@""];
									if (BasicSA > minSA) {
										StopMessage2 = [self ErrorMsg:@"D0" andInput1:@"" andInput2:@"" andInput3:@""];
									}
									else{
										StopMessage2 = @"";
									}
									StopMessage3 = @"";
									StopMessage4 = @"";
									
									StopExec = TRUE;
									return;
								}
								else if (i >= 10 && i <= 20){
									
									
									HeaderMsg = [self ErrorMsg:@"X3" andInput1:tempMsg andInput2:tempMsg andInput3:@""];
									StopMessage1 = [self ErrorMsg:@"B0" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage2 = [self ErrorMsg:@"C3" andInput1:@"" andInput2:@"" andInput3:@""];
									if (BasicSA > minSA) {
										StopMessage3 = [self ErrorMsg:@"D0" andInput1:@"" andInput2:@"" andInput3:@""];
									}
									else{
										StopMessage3 = @"";
									}
									
									StopMessage4 = @"";
									StopExec = TRUE;
									return;
									
								}
								else{
									
								}
							}
							else{ //BUA lapse, RUA lapse, withdraw, level 1
								if (i < 10) {
									HeaderMsg = [self ErrorMsg:@"X3" andInput1:tempMsg andInput2:tempMsg andInput3:@""];
									StopMessage1 = [self ErrorMsg:@"A3" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage2 = [self ErrorMsg:@"C3" andInput1:@"" andInput2:@"" andInput3:@""];
									if (BasicSA > minSA) {
										StopMessage3 = [self ErrorMsg:@"D0" andInput1:@"" andInput2:@"" andInput3:@""];
									}
									else{
										StopMessage3 = @"";
									}
									StopMessage4 = @"";
									StopExec = TRUE;
									return;
								}
								else if (i >= 10 && i <= 20){
									HeaderMsg = [self ErrorMsg:@"X3" andInput1:tempMsg andInput2:tempMsg andInput3:@""];
									StopMessage1 = [self ErrorMsg:@"A3" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage2 = [self ErrorMsg:@"B0" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage3 = [self ErrorMsg:@"C3" andInput1:@"" andInput2:@"" andInput3:@""];
									if (BasicSA > minSA) {
										StopMessage4 = [self ErrorMsg:@"D0" andInput1:@"" andInput2:@"" andInput3:@""];
									}
									else{
										StopMessage4 = @"";
									}
									StopExec = TRUE;
									return;
								}
								else{
									
								}
							}
						}
						else
						{
							if([self ReturnRegWithdrawal:i] == 0){ //BUA lapse, RUA no lapse, no withdraw, level 1
								if (i < 10) {
									HeaderMsg = [self ErrorMsg:@"X2" andInput1:tempMsg andInput2:@"" andInput3:@""];
									StopMessage1 = [self ErrorMsg:@"C2" andInput1:@"" andInput2:@"" andInput3:@""];
									if (BasicSA > minSA) {
										StopMessage2 = [self ErrorMsg:@"D0" andInput1:@"" andInput2:@"" andInput3:@""];
									}
									else{
										StopMessage2 = @"";
									}
									StopMessage3 = @"";
									StopMessage4 = @"";
									StopExec = TRUE;
									return;
								}
								else if (i >= 10 && i <= 20){
									HeaderMsg = [self ErrorMsg:@"X2" andInput1:tempMsg andInput2:@"" andInput3:@""];
									StopMessage1 = [self ErrorMsg:@"B0" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage2 = [self ErrorMsg:@"C2" andInput1:@"" andInput2:@"" andInput3:@""];
									if (BasicSA > minSA) {
										StopMessage3 = [self ErrorMsg:@"D0" andInput1:@"" andInput2:@"" andInput3:@""];
									}
									else{
										StopMessage3 = @"";
									}
									StopMessage4 = @"";
									StopExec = TRUE;
									return;
								}
								else{
									
								}
							}
							else{ //BUA lapse, RUA no lapse, withdraw, level 1
								if (i < 10) {
									HeaderMsg = [self ErrorMsg:@"X2" andInput1:tempMsg andInput2:@"" andInput3:@""];
									StopMessage1 = [self ErrorMsg:@"A2" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage2 = [self ErrorMsg:@"C2" andInput1:@"" andInput2:@"" andInput3:@""];
									if (BasicSA > minSA) {
										StopMessage3 = [self ErrorMsg:@"D0" andInput1:@"" andInput2:@"" andInput3:@""];
									}
									else{
										StopMessage3 = @"";
									}
									StopMessage4 = @"";
									StopExec = TRUE;
									return;
								}
								else if (i >= 10 && i <= 20){
									HeaderMsg = [self ErrorMsg:@"X2" andInput1:tempMsg andInput2:@"" andInput3:@""];
									StopMessage1 = [self ErrorMsg:@"A2" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage2 = [self ErrorMsg:@"B0" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage3 = [self ErrorMsg:@"C2" andInput1:@"" andInput2:@"" andInput3:@""];
									if (BasicSA > minSA) {
										StopMessage4 = [self ErrorMsg:@"D0" andInput1:@"" andInput2:@"" andInput3:@""];
									}
									else{
										StopMessage4 = @"";
									}
									StopExec = TRUE;
									return;
								}
								else{
									
								}
							}
						}
						
					}
					
					
				}
				else{
					if (HRiderSurrenderValue < 0) {
						if (i <= tempSustainPolicyYear) {
							if([self ReturnRegWithdrawal:i] == 0){ //BUA no lapse, RUA lapse, no withdraw, level 1
								if (i < 10) {
									HeaderMsg = [self ErrorMsg:@"X1" andInput1:tempMsg andInput2:@"" andInput3:@""];
									StopMessage1 = [self ErrorMsg:@"C1" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage2 = @"";
									StopMessage3 = @"";
									StopMessage4 = @"";
									StopExec = TRUE;
									return;
								}
								else if (i >= 10 && i <= 20){
									HeaderMsg = [self ErrorMsg:@"X1" andInput1:tempMsg andInput2:@"" andInput3:@""];
									StopMessage1 = [self ErrorMsg:@"B0" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage2 = [self ErrorMsg:@"C1" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage3 = @"";
									StopMessage4 = @"";
									StopExec = TRUE;
									return;
								}
								else{
									
								}
							}
							else{ //BUA no lapse, RUA lapse, withdraw, level 1
								if (i < 10) {
									HeaderMsg = [self ErrorMsg:@"X1" andInput1:tempMsg andInput2:@"" andInput3:@""];
									StopMessage1 = [self ErrorMsg:@"A1" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage2 = [self ErrorMsg:@"C1" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage3 = @"";
									StopMessage4 = @"";
									StopExec = TRUE;
									return;
								}
								else if (i >= 10 && i <= 20){
									HeaderMsg = [self ErrorMsg:@"X1" andInput1:tempMsg andInput2:@"" andInput3:@""];
									StopMessage1 = [self ErrorMsg:@"A1" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage2 = [self ErrorMsg:@"B0" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage3 = [self ErrorMsg:@"C1" andInput1:@"" andInput2:@"" andInput3:@""];
									StopMessage4 = @"";
									StopExec = TRUE;
									return;
								}
								else{
									
								}
							}
							
						}
						
					}
				}
				
			}
			else{ //second level checking
				if(HSurrenderValue < 0 ){
					if (i <= tempSustainPolicyYear) {
						if (HRiderSurrenderValue < 0) { // second level checking, BUA lapse, RUA lapse, level 2
							if (i < 10) {
								HeaderMsg = [self ErrorMsg:@"Y3" andInput1:tempMsg andInput2:tempMsg andInput3:@""];
								StopMessage1 = [self ErrorMsg:@"00" andInput1:@"" andInput2:@"" andInput3:@""];
								StopMessage2 = @"";
								StopMessage3 = @"";
								StopMessage4 = @"";
								StopExec = TRUE;
								return;
							}
							else if (i >= 10 && i <= 20){
								[self InsertSustainYear:[tempMsg intValue]];
								HeaderMsg = [self ErrorMsg:@"X3" andInput1:tempMsg andInput2:tempMsg andInput3:@""];
								StopMessage1 = [self ErrorMsg:@"01" andInput1:@"" andInput2:@"" andInput3:@""];
								StopMessage2 = @"";
								StopMessage3 = @"";
								StopMessage4 = @"";
								Solution1 = tempMsg;
								Solution2 = tempMsg;
								StopExec = TRUE;
								return;
								
							}
							else{
								
							}
						}
						else
						{
							//second level checking, BUA lapse, RUA no lapse, level 2
							if (i < 10) {
								HeaderMsg = [self ErrorMsg:@"Y2" andInput1:tempMsg andInput2:@"" andInput3:@""];
								StopMessage1 = [self ErrorMsg:@"00" andInput1:@"" andInput2:@"" andInput3:@""];
								StopMessage2 = @"";
								StopMessage3 = @"";
								StopMessage4 = @"";
								StopExec = TRUE;
								return;
							}
							else if (i >= 10 && i <= 20){
								[self InsertSustainYear:[tempMsg intValue]];
								HeaderMsg = [self ErrorMsg:@"X2" andInput1:tempMsg andInput2:@"" andInput3:@""];
								StopMessage1 = [self ErrorMsg:@"01" andInput1:@"" andInput2:@"" andInput3:@""];
								StopMessage2 = @"";
								StopMessage3 = @"";
								StopMessage4 = @"";
								Solution1 = tempMsg;
								Solution2 = @"";
								StopExec = TRUE;
								return;
							}
							else{
								
							}
							
						}
						
					}
					
					
				}
				else{
					if (HRiderSurrenderValue < 0) {
						if (i <= tempSustainPolicyYear) {
							//second level checking, BUA no lapse, RUA lapse, level 2
							if (i < 10) {
								HeaderMsg = [self ErrorMsg:@"Y1" andInput1:tempMsg andInput2:@"" andInput3:@""];
								StopMessage1 = [self ErrorMsg:@"00" andInput1:@"" andInput2:@"" andInput3:@""];
								StopMessage2 = @"";
								StopMessage3 = @"";
								StopMessage4 = @"";
								StopExec = TRUE;
								return;
							}
							else if (i >= 10 && i <= 20){
								[self InsertSustainYear:[tempMsg intValue]];
								HeaderMsg = [self ErrorMsg:@"X1" andInput1:tempMsg andInput2:@"" andInput3:@""];
								StopMessage1 = [self ErrorMsg:@"01" andInput1:@"" andInput2:@"" andInput3:@""];
								StopMessage2 = @"";
								StopMessage3 = @"";
								StopMessage4 = @"";
								Solution1 = tempMsg;
								Solution2 = @"";
								StopExec = TRUE;
								return;
							}
							else{
								
							}
							
							
						}
						
					}
				}
			}
		}
		
			
			
			
			[BullSurrender addObject:[NSString stringWithFormat:@"%f", HSurrenderValue]];
			[FlatSurrender addObject:[NSString stringWithFormat:@"%f", MSurrenderValue]];
			[BearSurrender addObject:[NSString stringWithFormat:@"%f", LSurrenderValue]];
			//NSLog(@"%d) %f, %f, %f",i, HRiderSurrenderValue, MRiderSurrenderValue, LRiderSurrenderValue );
			//NSLog(@"%d) %f,%f,%f,%f,%f,%f,%f", i, RiderVUCashValueHigh,RiderVURetValueHigh,RiderVU2023ValueHigh, RiderVU2025ValueHigh,RiderVU2028ValueHigh, RiderVU2030ValueHigh, RiderVU2035ValueHigh);
			NSLog(@"%d) %f,%f, %f, %f,%f,%f,%f,%f", i, VUCashValueHigh,VURetValueHigh, VUDanaValueHigh, VU2023ValueHigh, VU2025ValueHigh,VU2028ValueHigh, VU2030ValueHigh, VU2035ValueHigh);
			//NSLog(@"%d) %f,%f, %f, %f,%f,%f,%f,%f", i, VUCashValueLow,VURetValueLow, VUDanaValueLow, VU2023ValueLow, VU2025ValueLow,VU2028ValueLow, VU2030ValueLow, VU2035ValueLow);
			// --------------------
			
			[RiderBullSurrender addObject:[NSString stringWithFormat:@"%f", HRiderSurrenderValue]];
			[RiderFlatSurrender addObject:[NSString stringWithFormat:@"%f", MRiderSurrenderValue]];
			[RiderBearSurrender addObject:[NSString stringWithFormat:@"%f", LRiderSurrenderValue]];
			
			[TotalBullSurrender addObject:[NSString stringWithFormat:@"%f", HSurrenderValue + HRiderSurrenderValue] ];
			[TotalFlatSurrender addObject:[NSString stringWithFormat:@"%f", MSurrenderValue + MRiderSurrenderValue]];
			[TotalBearSurrender addObject:[NSString stringWithFormat:@"%f", LSurrenderValue + LRiderSurrenderValue]];
			
			[OverallTotalFundSurrenderValueBull addObject:[TotalBullSurrender objectAtIndex: i -1]];
			[OverallTotalFundSurrenderValueFlat addObject:[TotalFlatSurrender objectAtIndex: i -1]];
			[OverallTotalFundSurrenderValueBear addObject:[TotalBearSurrender objectAtIndex: i -1]];
			
			[EOFTPDBull addObject:[NSString stringWithFormat:@"%f", [[BasicSumAssured objectAtIndex:i -1] doubleValue] + HSurrenderValue + HRiderSurrenderValue]];
			[EOFTPDFlat addObject:[NSString stringWithFormat:@"%f", [[BasicSumAssured objectAtIndex:i -1] doubleValue] + MSurrenderValue + MRiderSurrenderValue]];
			[EOFTPDBear addObject:[NSString stringWithFormat:@"%f", [[BasicSumAssured objectAtIndex:i -1] doubleValue] + LSurrenderValue + LRiderSurrenderValue]];
			
			[OverallEOYTotalTPDBull addObject:[TotalBullSurrender objectAtIndex:i -1 ]];
			[OverallEOYTotalTPDFlat addObject:[TotalFlatSurrender objectAtIndex:i -1 ]];
			[OverallEOYTotalTPDBear addObject:[TotalBearSurrender objectAtIndex:i -1 ]];
			
			if (Age + i >= 65 ) {
				[EOFOADBull addObject:[NSString stringWithFormat:@"%f", [strBasicSA doubleValue] > OADLimit ? OADLimit : [strBasicSA doubleValue ] + HSurrenderValue + HRiderSurrenderValue]];
				[EOFOADFlat addObject:[NSString stringWithFormat:@"%f", [strBasicSA doubleValue] > OADLimit ? OADLimit : [strBasicSA doubleValue ] + MSurrenderValue + MRiderSurrenderValue]];
				[EOFOADBear addObject:[NSString stringWithFormat:@"%f", [strBasicSA doubleValue] > OADLimit ? OADLimit : [strBasicSA doubleValue ] + LSurrenderValue + LRiderSurrenderValue]];
				
				[OverallEOYTotalOADBull addObject:[NSString stringWithFormat:@"%f",[[EOFOADBull objectAtIndex: i -1] doubleValue ] ]];
				[OverallEOYTotalOADFlat addObject:[NSString stringWithFormat:@"%f",[[EOFOADFlat objectAtIndex: i -1] doubleValue ] ]];
				[OverallEOYTotalOADBear addObject:[NSString stringWithFormat:@"%f",[[EOFOADBear objectAtIndex: i -1] doubleValue ] ]];
			}
			else{
				[EOFOADBull addObject:[NSString stringWithFormat:@"0"]];
				[EOFOADFlat addObject:[NSString stringWithFormat:@"0"]];
				[EOFOADBear addObject:[NSString stringWithFormat:@"0"]];
				
				[OverallEOYTotalOADBull addObject:[NSString stringWithFormat:@"%f", 0.00]];
				[OverallEOYTotalOADFlat addObject:[NSString stringWithFormat:@"%f", 0.00]];
				[OverallEOYTotalOADBear addObject:[NSString stringWithFormat:@"%f", 0.00]];
			}
			
			
			
			double HFundManagementCharge = HSurrenderValue > 0 ? FundManagementChargeHigh + RiderFundManagementChargeHigh : 0;
			double MFundManagementCharge = MSurrenderValue > 0 ? FundManagementChargeMed + RiderFundManagementChargeMed : 0;
			double LFundManagementCharge = LSurrenderValue > 0 ? FundManagementChargeLow + RiderFundManagementChargeLow : 0;
			
			[FundChargeBull addObject:[NSString stringWithFormat:@"%f",  HFundManagementCharge]];
			[FundChargeFlat addObject:[NSString stringWithFormat:@"%f", MFundManagementCharge]];
			[FundChargeBear addObject:[NSString stringWithFormat:@"%f",  LFundManagementCharge]];
			
			if (RPUOExist == TRUE) {
				if (i == [RPUOYear intValue ]) {
					[self CalculateRPUO];
					
				}
			}
		
		}
	/*
		else{
			[AnnualPremium addObject:@"0"];
			[BasicSumAssured addObject:@"0"];
			[CumulativePremium addObject:@"0"];
			[AllocatedBasicPrem addObject:@"0"];
			[AllocatedRiderPrem addObject:@"0"];
			[UnAllocatedAllPrem addObject:@"0"];
			[CumAlloBasicPrem addObject:@"0"];
			[CumAlloRiderPrem addObject:@"0"];
			[TotalCumPrem addObject:@"0"];
			[BasicInsCharge addObject:@"0"];
			[RiderInsCharge addObject:@"0"];
			[OtherCharge addObject:@"0"];
			[DirectDistributionCost addObject:@"0"];
			[BullSurrender addObject:@"0"];
			[FlatSurrender addObject:@"0"];
			[BearSurrender addObject:@"0"];
			[RiderBullSurrender addObject:@"0"];
			[RiderFlatSurrender addObject:@"0"];
			[RiderBearSurrender addObject:@"0"];
			[TotalBullSurrender addObject:@"0"];
			[TotalFlatSurrender addObject:@"0"];
			[TotalBearSurrender addObject:@"0"];
			[EOFTPDBull addObject:@"0"];
			[EOFTPDFlat addObject:@"0"];
			[EOFTPDBear addObject:@"0"];
			[EOFOADBull addObject:@"0"];
			[EOFOADFlat addObject:@"0"];
			[EOFOADBear addObject:@"0"];
			[FundChargeBull addObject:@"0"];
			[FundChargeFlat addObject:@"0"];
			[FundChargeBear addObject:@"0"];
		}
				
	}
    */
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		for (int a= 1; a<=30; a++) {
			if (Age >= 0){
				inputAge = Age + a;
				
				//if (inputAge <= tempSustainYear) {
					QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_Trad_Basic (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
								"'col3','col4','col5','col6','col7','col8','col9','col10','col11','col12','col13','col14','col15','col16','col17','col18','col19','col20','col21','col22', "
								" 'col23','col24','col25','col26','col27','col28','col29','col30','col31') VALUES ( "
								" \"%@\",\"%d\",\"%@\",\"%d\",\"%d\",\"%@\", '%@', '%.0f','%.0f', '%.0f', %.0f, '%.0f', '%.0f','%.0f', '%.0f','%.0f', '%.0f','%.0f','%.0f', '%.0f','%.0f','%.0f', '%.0f','%.0f', "
								"'%.0f', '%.0f','%.0f','%.0f', '%.0f','%.0f','%.0f', '%.0f','%.0f','%.0f', '%.0f','%.0f' )",
								SINo, a, @"DATA", a, inputAge, [BasicSumAssured objectAtIndex:a-1], [AnnualPremium objectAtIndex:a -1], round([[CumulativePremium objectAtIndex: a -1] doubleValue]),
								round([[UnAllocatedAllPrem objectAtIndex:a-1] doubleValue]), round([[AllocatedBasicPrem objectAtIndex:a-1] doubleValue ]), round([[AllocatedRiderPrem objectAtIndex:a-1] doubleValue ]),
								round([[CumAlloBasicPrem objectAtIndex:a-1] doubleValue ]), round([[CumAlloRiderPrem objectAtIndex:a-1]doubleValue ]), round([[TotalCumPrem objectAtIndex:a-1] doubleValue ]),
								round([[BasicInsCharge objectAtIndex:a-1]doubleValue ]), round([[RiderInsCharge objectAtIndex:a-1]doubleValue ]), round([[OtherCharge objectAtIndex:a-1]doubleValue ]),
								round([[DirectDistributionCost objectAtIndex:a-1]doubleValue ]),
								round([[BullSurrender objectAtIndex:a-1]doubleValue ]), round([[FlatSurrender objectAtIndex:a-1]doubleValue ]), round([[BearSurrender objectAtIndex:a-1]doubleValue ]),
								round([[RiderBullSurrender objectAtIndex:a-1]doubleValue ]), round([[RiderFlatSurrender objectAtIndex:a-1] doubleValue ]), round([[RiderBearSurrender objectAtIndex:a-1] doubleValue ]),
								round([[TotalBullSurrender objectAtIndex:a-1]doubleValue ]), round([[TotalFlatSurrender objectAtIndex:a-1] doubleValue ]), round([[TotalBearSurrender objectAtIndex:a-1] doubleValue ]),
								round([[EOFTPDBull objectAtIndex:a-1]doubleValue ]), round([[EOFTPDFlat objectAtIndex:a-1] doubleValue ]), round([[EOFTPDBear objectAtIndex:a-1] doubleValue ]),
								round([[EOFOADBull objectAtIndex:a-1]doubleValue ]), round([[EOFOADFlat objectAtIndex:a-1] doubleValue ]), round([[EOFOADBear objectAtIndex:a-1] doubleValue ]),
								round([[FundChargeBull objectAtIndex:a-1]doubleValue ]), round([[FundChargeFlat objectAtIndex:a-1] doubleValue ]), round([[FundChargeBear objectAtIndex:a-1] doubleValue ])];
				/*
				}
				else{
					QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_Trad_Basic (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
								"'col3','col4','col5','col6','col7','col8','col9','col10','col11','col12','col13','col14','col15','col16','col17','col18','col19','col20','col21','col22', "
								" 'col23','col24','col25','col26','col27','col28','col29','col30','col31') VALUES ( "
								" \"%@\",\"%d\",\"%@\",\"%d\",\"%d\",\"-\", '-', '-','-', '-', '-', '-', '-','-', '-','-', '-','-','-', '-','-','-', '-','-', "
								"'-', '-','-','-', '-','-','-', '-','-','-', '-','-')",
								SINo, a, @"DATA", a, inputAge];
				}
				*/
				
				
				//NSLog(@"%@", QuerySQL);
				if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
					if (sqlite3_step(statement) == SQLITE_DONE) {
						
					}
					else{
						NSLog(@"error in inserting data to UL_Temp_Trad_Basic");
					}
					sqlite3_finalize(statement);
				}
				
			}
		}
		
		
		sqlite3_close(contactDB);
	}
	/*
	AnnualPremium = Nil;
	BasicSumAssured = Nil;
	CumulativePremium = Nil;
	AllocatedBasicPrem = Nil;
	AllocatedRiderPrem = Nil;
	UnAllocatedAllPrem = Nil;
	CumAlloBasicPrem = Nil;
	CumAlloRiderPrem = Nil;
	TotalCumPrem = Nil;
	BasicInsCharge = Nil;
	RiderInsCharge = Nil;
	OtherCharge = Nil;
	DirectDistributionCost = Nil;
	BullSurrender = Nil;
	FlatSurrender = Nil;
	BearSurrender = Nil;
	RiderBullSurrender = Nil;
	RiderFlatSurrender = Nil;
	RiderBearSurrender = Nil;
	TotalBullSurrender = Nil;
	TotalFlatSurrender = Nil;
	TotalBearSurrender = Nil;
	EOFTPDBull = Nil;
	EOFTPDFlat = Nil;
	EOFTPDBear = Nil;
	EOFOADBull = Nil;
	EOFOADFlat = Nil;
	EOFOADBear = Nil;
	FundChargeBull = Nil;
	FundChargeFlat = Nil;
	FundChargeBear = Nil;
	*/
	NSLog(@"---------basic end--------");
}

-(double)JuvenilienFactor :(int)aaAge{
	if (aaAge <= 1) {
		return 0.2;
	}
	else if(aaAge == 2){
		return 0.4;
	}
	else if(aaAge == 3){
		return 0.6;
	}
	else if(aaAge == 4){
		return 0.8;
	}
	else {
		return 1.0;
	}
}

-(void)CalculateRPUO{
	NSString *tempPol;
	NSString *QuerySQL;
	sqlite3_stmt *statement;
	
	if ([[RPUOYear substringFromIndex:RPUOYear.length - 1] isEqualToString:@"1" ]) {
		tempPol = [RPUOYear stringByAppendingFormat:@"st" ];
	}
	else if ([[RPUOYear substringFromIndex:RPUOYear.length - 1] isEqualToString:@"2" ]){
		tempPol = [RPUOYear stringByAppendingFormat:@"nd" ];
	}
	else if ([[RPUOYear substringFromIndex:RPUOYear.length - 1] isEqualToString:@"3" ]){
		tempPol = [RPUOYear stringByAppendingFormat:@"rd" ];
	}
	else{
		tempPol = [RPUOYear stringByAppendingFormat:@"th" ];
	}
	
	PaidOpCharge2023_H = [self Calc_PaidUpOptionCharges:VU2023ValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	PaidOpCharge2025_H = [self Calc_PaidUpOptionCharges:VU2025ValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	PaidOpCharge2028_H = [self Calc_PaidUpOptionCharges:VU2028ValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	PaidOpCharge2030_H = [self Calc_PaidUpOptionCharges:VU2030ValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	PaidOpCharge2035_H = [self Calc_PaidUpOptionCharges:VU2035ValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	PaidOpChargeRet_H = [self Calc_PaidUpOptionCharges:VURetValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	PaidOpChargeDana_H = [self Calc_PaidUpOptionCharges:VUDanaValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	
	PaidOpCharge2023_M = [self Calc_PaidUpOptionCharges:VU2023ValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	PaidOpCharge2025_M = [self Calc_PaidUpOptionCharges:VU2025ValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	PaidOpCharge2028_M = [self Calc_PaidUpOptionCharges:VU2028ValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	PaidOpCharge2030_M = [self Calc_PaidUpOptionCharges:VU2030ValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	PaidOpCharge2035_M = [self Calc_PaidUpOptionCharges:VU2035ValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	PaidOpChargeRet_M = [self Calc_PaidUpOptionCharges:VURetValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	PaidOpChargeDana_M = [self Calc_PaidUpOptionCharges:VUDanaValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	
	PaidOpCharge2023_L = [self Calc_PaidUpOptionCharges:VU2023ValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	PaidOpCharge2025_L = [self Calc_PaidUpOptionCharges:VU2025ValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	PaidOpCharge2028_L = [self Calc_PaidUpOptionCharges:VU2028ValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	PaidOpCharge2030_L = [self Calc_PaidUpOptionCharges:VU2030ValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	PaidOpCharge2035_L = [self Calc_PaidUpOptionCharges:VU2035ValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	PaidOpChargeRet_L = [self Calc_PaidUpOptionCharges:VURetValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	PaidOpChargeDana_L = [self Calc_PaidUpOptionCharges:VUDanaValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	
	PaidOpChargeCash_H = VUCashValueHigh >= OneTimePayOut ? OneTimePayOut:VUCashValueHigh;
	PaidOpChargeCash_M = VUCashValueMedian >= OneTimePayOut ? OneTimePayOut:VUCashValueMedian;
	PaidOpChargeCash_L = VUCashValueLow >= OneTimePayOut ? OneTimePayOut:VUCashValueLow;
	
	PaidOpChargeSum_H = PaidOpCharge2023_H + PaidOpCharge2025_H + PaidOpCharge2028_H + PaidOpCharge2030_H + PaidOpCharge2035_H + PaidOpChargeRet_H + PaidOpChargeDana_H + PaidOpChargeCash_H;
	PaidOpChargeSum_M = PaidOpCharge2023_M + PaidOpCharge2025_M + PaidOpCharge2028_M + PaidOpCharge2030_M + PaidOpCharge2035_M + PaidOpChargeRet_M + PaidOpChargeDana_M + PaidOpChargeCash_M;
	PaidOpChargeSum_L = PaidOpCharge2023_L + PaidOpCharge2025_L + PaidOpCharge2028_L + PaidOpCharge2030_L + PaidOpCharge2035_L + PaidOpChargeRet_L + PaidOpChargeDana_L + PaidOpChargeCash_L;
	
	ProjDeduction2023_H = VU2023ValueHigh - PaidOpCharge2023_H;
	ProjDeduction2025_H = VU2025ValueHigh - PaidOpCharge2025_H;
	ProjDeduction2028_H = VU2028ValueHigh - PaidOpCharge2028_H;
	ProjDeduction2030_H = VU2030ValueHigh - PaidOpCharge2030_H;
	ProjDeduction2035_H = VU2035ValueHigh - PaidOpCharge2035_H;
	ProjDeductionRet_H = VURetValueHigh - PaidOpChargeRet_H;
	ProjDeductionDana_H = VUDanaValueHigh - PaidOpChargeDana_H;
	ProjDeductionCash_H = VUCashValueHigh - PaidOpChargeCash_H;
	ProjDeductionSum_H = ProjDeduction2023_H + ProjDeduction2025_H + ProjDeduction2028_H + ProjDeduction2030_H + ProjDeduction2035_H + ProjDeductionCash_H + ProjDeductionRet_H + ProjDeductionDana_H;
	
	ProjDeduction2023_M = VU2023ValueMedian - PaidOpCharge2023_M;
	ProjDeduction2025_M = VU2025ValueMedian - PaidOpCharge2025_M;
	ProjDeduction2028_M = VU2028ValueMedian - PaidOpCharge2028_M;
	ProjDeduction2030_M = VU2030ValueMedian - PaidOpCharge2030_M;
	ProjDeduction2035_M = VU2035ValueMedian - PaidOpCharge2035_M;
	ProjDeductionRet_M = VURetValueMedian - PaidOpChargeRet_M;
	ProjDeductionDana_M = VUDanaValueMedian - PaidOpChargeDana_M;
	ProjDeductionCash_M = VUCashValueMedian - PaidOpChargeCash_M;
	ProjDeductionSum_M = ProjDeduction2023_M + ProjDeduction2025_M + ProjDeduction2028_M + ProjDeduction2030_M + ProjDeduction2035_M + ProjDeductionCash_M + ProjDeductionRet_M + ProjDeductionDana_M;
	
	ProjDeduction2023_L = VU2023ValueLow - PaidOpCharge2023_L;
	ProjDeduction2025_L = VU2025ValueLow - PaidOpCharge2025_L;
	ProjDeduction2028_L = VU2028ValueLow - PaidOpCharge2028_L;
	ProjDeduction2030_L = VU2030ValueLow - PaidOpCharge2030_L;
	ProjDeduction2035_L = VU2035ValueLow - PaidOpCharge2035_L;
	ProjDeductionRet_L = VURetValueLow - PaidOpChargeRet_L;
	ProjDeductionDana_L = VUDanaValueLow - PaidOpChargeDana_L;
	ProjDeductionCash_L = VUCashValueLow - PaidOpChargeCash_L;
	ProjDeductionSum_L = ProjDeduction2023_L + ProjDeduction2025_L + ProjDeduction2028_L + ProjDeduction2030_L + ProjDeduction2035_L + ProjDeductionCash_L + ProjDeductionRet_L + ProjDeductionDana_L;
	
	if(ProjDeductionSum_H < 0 || ProjDeductionSum_M < 0 || ProjDeductionSum_L < 0 ){
		//NSLog(@"%f %f %f", ProjDeductionSum_H, ProjDeductionSum_M, ProjDeductionSum_L);
		OneTimePayOut = OneTimePayOutWithMinSA;
		BOOL bMinSA = [self CalculateRPUO_WithMinSA];
		if (bMinSA == TRUE) {
			NSString *tempMin = [NSString stringWithFormat:@"%.0f",BasicSA * (0.05 * ([RPUOYear intValue ] -3)  + 0.15) ];
			StopMessage1 = [self ErrorMsg:@"R1" andInput1:tempMin andInput2:@"" andInput3:@""];
			StopMessage2 = [self ErrorMsg:@"R2" andInput1:@"" andInput2:@"" andInput3:@""];
			StopMessage3 = @"";
			StopMessage4 = @"";
		}
		else{
			StopMessage1 = [self ErrorMsg:@"R4" andInput1:RPUOYear andInput2:[NSString stringWithFormat:@"%d", 100 - Age] andInput3:@""];
			StopMessage2 = @"";
			StopMessage3 = @"";
			StopMessage4 = @"";
		}
		
		StopExec = TRUE;
		return;
	}
	//-----------------------------
	ReinvestCashFund2023_H = [self Calc_CashFundReinvest:VU2023ValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	ReinvestCashFund2025_H = [self Calc_CashFundReinvest:VU2025ValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	ReinvestCashFund2028_H = [self Calc_CashFundReinvest:VU2028ValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	ReinvestCashFund2030_H = [self Calc_CashFundReinvest:VU2030ValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	ReinvestCashFund2035_H = [self Calc_CashFundReinvest:VU2035ValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	ReinvestCashFundRet_H = [self Calc_CashFundReinvest:VURetValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	ReinvestCashFundDana_H = [self Calc_CashFundReinvest:VUDanaValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	
	ReinvestCashFund2023_M = [self Calc_CashFundReinvest:VU2023ValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	ReinvestCashFund2025_M = [self Calc_CashFundReinvest:VU2025ValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	ReinvestCashFund2028_M = [self Calc_CashFundReinvest:VU2028ValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	ReinvestCashFund2030_M = [self Calc_CashFundReinvest:VU2030ValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	ReinvestCashFund2035_M = [self Calc_CashFundReinvest:VU2035ValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	ReinvestCashFundRet_M = [self Calc_CashFundReinvest:VURetValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	ReinvestCashFundDana_M = [self Calc_CashFundReinvest:VUDanaValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	
	ReinvestCashFund2023_L = [self Calc_CashFundReinvest:VU2023ValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	ReinvestCashFund2025_L = [self Calc_CashFundReinvest:VU2025ValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	ReinvestCashFund2028_L = [self Calc_CashFundReinvest:VU2028ValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	ReinvestCashFund2030_L = [self Calc_CashFundReinvest:VU2030ValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	ReinvestCashFund2035_L = [self Calc_CashFundReinvest:VU2035ValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	ReinvestCashFundRet_L = [self Calc_CashFundReinvest:VURetValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	ReinvestCashFundDana_L = [self Calc_CashFundReinvest:VUDanaValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	
	if (ReinvestCashFund2023_H + ReinvestCashFund2025_H + ReinvestCashFund2028_H + ReinvestCashFund2030_H + ReinvestCashFund2035_H + ReinvestCashFundRet_H + ReinvestCashFundDana_H == 0 ) {
		ReinvestCashFundCase_H = ProjDeductionCash_H;
	}
	else{
		if (ProjDeductionCash_H > 0) {
			ReinvestCashFundCase_H = -ProjDeductionCash_H;
		}
		else{
			ReinvestCashFundCase_H = 0;
		}
	}
	
	if (ReinvestCashFund2023_M + ReinvestCashFund2025_M + ReinvestCashFund2028_M + ReinvestCashFund2030_M + ReinvestCashFund2035_M + ReinvestCashFundRet_M + ReinvestCashFundDana_M == 0 ) {
		ReinvestCashFundCase_M = ProjDeductionCash_M;
	}
	else{
		if (ProjDeductionCash_M > 0) {
			ReinvestCashFundCase_M = -ProjDeductionCash_M;
		}
		else{
			ReinvestCashFundCase_M = 0;
		}
	}
	
	if (ReinvestCashFund2023_L + ReinvestCashFund2025_L + ReinvestCashFund2028_L + ReinvestCashFund2030_L + ReinvestCashFund2035_L + ReinvestCashFundRet_L + ReinvestCashFundDana_L == 0 ) {
		ReinvestCashFundCase_L = ProjDeductionCash_L;
	}
	else{
		if (ProjDeductionCash_L > 0) {
			ReinvestCashFundCase_L = -ProjDeductionCash_L;
		}
		else{
			ReinvestCashFundCase_L = 0;
		}
	}
	
	ReinvestCashFundSum_H = ReinvestCashFund2023_H + ReinvestCashFund2025_H + ReinvestCashFund2028_H + ReinvestCashFund2030_H + ReinvestCashFund2035_H + ReinvestCashFundRet_H + ReinvestCashFundDana_H + ReinvestCashFundCase_H;
	ReinvestCashFundSum_M = ReinvestCashFund2023_M + ReinvestCashFund2025_M + ReinvestCashFund2028_M + ReinvestCashFund2030_M + ReinvestCashFund2035_M + ReinvestCashFundRet_M + ReinvestCashFundDana_M + ReinvestCashFundCase_M;
	ReinvestCashFundSum_L = ReinvestCashFund2023_L + ReinvestCashFund2025_L + ReinvestCashFund2028_L + ReinvestCashFund2030_L + ReinvestCashFund2035_L + ReinvestCashFundRet_L + ReinvestCashFundDana_L + ReinvestCashFundCase_L;
	
	if (VUCash_FundAllo_Percen == 100) {
		ProjValAfterReinvestCash_H = ProjDeductionCash_H;
		ProjValAfterReinvestCash_M = ProjDeductionCash_M;
		ProjValAfterReinvestCash_L = ProjDeductionCash_L;
		
		ProjValAfterReinvestSum_H = ProjDeductionCash_H;
		ProjValAfterReinvestSum_M = ProjDeductionCash_M;
		ProjValAfterReinvestSum_L = ProjDeductionCash_L;
	}
	else{
		ProjValAfterReinvest2023_H = ProjDeduction2023_H + ReinvestCashFund2023_H;
		ProjValAfterReinvest2025_H = ProjDeduction2025_H + ReinvestCashFund2025_H;
		ProjValAfterReinvest2028_H = ProjDeduction2028_H + ReinvestCashFund2028_H;
		ProjValAfterReinvest2030_H = ProjDeduction2030_H + ReinvestCashFund2030_H;
		ProjValAfterReinvest2035_H = ProjDeduction2035_H + ReinvestCashFund2035_H;
		ProjValAfterReinvestRet_H = ProjDeductionRet_H + ReinvestCashFundRet_H;
		ProjValAfterReinvestDana_H = ProjDeductionDana_H + ReinvestCashFundDana_H;
		ProjValAfterReinvestCash_H = ReinvestCashFundSum_H;
		ProjValAfterReinvestSum_H = ProjValAfterReinvest2023_H + ProjValAfterReinvest2025_H + ProjValAfterReinvest2028_H + ProjValAfterReinvest2030_H + ProjValAfterReinvest2035_H + ProjValAfterReinvestRet_H +
		ProjValAfterReinvestDana_H  ;
		
		ProjValAfterReinvest2023_M = ProjDeduction2023_M + ReinvestCashFund2023_M;
		ProjValAfterReinvest2025_M = ProjDeduction2025_M + ReinvestCashFund2025_M;
		ProjValAfterReinvest2028_M = ProjDeduction2028_M + ReinvestCashFund2028_M;
		ProjValAfterReinvest2030_M = ProjDeduction2030_M + ReinvestCashFund2030_M;
		ProjValAfterReinvest2035_M = ProjDeduction2035_M + ReinvestCashFund2035_M;
		ProjValAfterReinvestRet_M = ProjDeductionRet_M + ReinvestCashFundRet_M;
		ProjValAfterReinvestDana_M = ProjDeductionDana_M + ReinvestCashFundDana_M;
		ProjValAfterReinvestCash_M = ReinvestCashFundSum_M;
		ProjValAfterReinvestSum_M = ProjValAfterReinvest2023_M + ProjValAfterReinvest2025_M + ProjValAfterReinvest2028_M + ProjValAfterReinvest2030_M + ProjValAfterReinvest2035_M + ProjValAfterReinvestRet_M +
		ProjValAfterReinvestDana_M  ;
		
		ProjValAfterReinvest2023_L = ProjDeduction2023_L + ReinvestCashFund2023_L;
		ProjValAfterReinvest2025_L = ProjDeduction2025_L + ReinvestCashFund2025_L;
		ProjValAfterReinvest2028_L = ProjDeduction2028_L + ReinvestCashFund2028_L;
		ProjValAfterReinvest2030_L = ProjDeduction2030_L + ReinvestCashFund2030_L;
		ProjValAfterReinvest2035_L = ProjDeduction2035_L + ReinvestCashFund2035_L;
		ProjValAfterReinvestRet_L = ProjDeductionRet_L + ReinvestCashFundRet_L;
		ProjValAfterReinvestDana_L = ProjDeductionDana_L + ReinvestCashFundDana_L;
		ProjValAfterReinvestCash_L = ReinvestCashFundSum_L;
		ProjValAfterReinvestSum_L = ProjValAfterReinvest2023_L + ProjValAfterReinvest2025_L + ProjValAfterReinvest2028_L + ProjValAfterReinvest2030_L + ProjValAfterReinvest2035_L + ProjValAfterReinvestRet_L +
		ProjValAfterReinvestDana_L  ;
	}
	//-------------------
	
	PrevPaidUpOptionTable_2023_High = ProjValAfterReinvest2023_H;
	PrevPaidUpOptionTable_2025_High = ProjValAfterReinvest2025_H;
	PrevPaidUpOptionTable_2028_High = ProjValAfterReinvest2028_H;
	PrevPaidUpOptionTable_2030_High = ProjValAfterReinvest2030_H;
	PrevPaidUpOptionTable_2035_High = ProjValAfterReinvest2035_H;
	PrevPaidUpOptionTable_Cash_High = ProjValAfterReinvestCash_H;
	PrevPaidUpOptionTable_Ret_High = ProjValAfterReinvestRet_H;
	PrevPaidUpOptionTable_Dana_High = ProjValAfterReinvestDana_H;
	
	PrevPaidUpOptionTable_2023_Median = ProjValAfterReinvest2023_M;
	PrevPaidUpOptionTable_2025_Median = ProjValAfterReinvest2025_M;
	PrevPaidUpOptionTable_2028_Median = ProjValAfterReinvest2028_M;
	PrevPaidUpOptionTable_2030_Median = ProjValAfterReinvest2030_M;
	PrevPaidUpOptionTable_2035_Median = ProjValAfterReinvest2035_M;
	PrevPaidUpOptionTable_Cash_Median = ProjValAfterReinvestCash_M;
	PrevPaidUpOptionTable_Ret_Median = ProjValAfterReinvestRet_M;
	PrevPaidUpOptionTable_Dana_Median = ProjValAfterReinvestDana_M;
	
	PrevPaidUpOptionTable_2023_Low = ProjValAfterReinvest2023_L;
	PrevPaidUpOptionTable_2025_Low = ProjValAfterReinvest2025_L;
	PrevPaidUpOptionTable_2028_Low = ProjValAfterReinvest2028_L;
	PrevPaidUpOptionTable_2030_Low = ProjValAfterReinvest2030_L;
	PrevPaidUpOptionTable_2035_Low = ProjValAfterReinvest2035_L;
	PrevPaidUpOptionTable_Cash_Low = ProjValAfterReinvestCash_L;
	PrevPaidUpOptionTable_Ret_Low = ProjValAfterReinvestRet_L;
	PrevPaidUpOptionTable_Dana_Low = ProjValAfterReinvestDana_L;
	
	
	int FromYear = [RPUOYear intValue] + 1;
	int ToYear;
	if (Age > 50) {
		ToYear = 75 - Age;
	}
	else{
		ToYear = 25;
	}
	
	double ReinvestRate2023 = 0.00;
	double ReinvestRate2025 = 0.00;
	double ReinvestRate2028 = 0.00;
	double ReinvestRate2030 = 0.00;
	double ReinvestRate2035 = 0.00;
	int ReinvestRate2023to2025, ReinvestRate2023to2028,ReinvestRate2023to2030,ReinvestRate2023to2035,ReinvestRate2023toCash,ReinvestRate2023toRet,ReinvestRate2023toDana;
	int ReinvestRate2025to2028, ReinvestRate2025to2030,ReinvestRate2025to2035,ReinvestRate2025toCash,ReinvestRate2025toRet,ReinvestRate2025toDana;
	int ReinvestRate2028to2030, ReinvestRate2028to2035,ReinvestRate2028toCash,ReinvestRate2028toRet,ReinvestRate2028toDana;
	int ReinvestRate2030to2035, ReinvestRate2030toCash,ReinvestRate2030toRet,ReinvestRate2030toDana;
	int ReinvestRate2035toCash, ReinvestRate2035toRet,ReinvestRate2035toDana;
	
	for (int polYear = FromYear; polYear <= ToYear; polYear++) {
		if (polYear == FundTerm2023) {
			if (Fund2023PartialReinvest == 0) {
				ReinvestRate2023 = 100; //meaning fully reinvest
			}
			else{
				ReinvestRate2023 = 100 - Fund2023PartialReinvest;
			}
			
			if (Fund2023PartialReinvest != 100) { //meaning not withdraw
				ReinvestRate2023to2025 = Fund2023ReinvestTo2025Fac;
				ReinvestRate2023to2028 = Fund2023ReinvestTo2028Fac;
				ReinvestRate2023to2030 = Fund2023ReinvestTo2030Fac;
				ReinvestRate2023to2035 = Fund2023ReinvestTo2035Fac;
				ReinvestRate2023toCash = Fund2023ReinvestToCashFac;
				ReinvestRate2023toDana = Fund2023ReinvestToDanaFac;
				ReinvestRate2023toRet = Fund2023ReinvestToRetFac;
			}
			else{
				ReinvestRate2023to2025 = 0.00;
				ReinvestRate2023to2028 = 0.00;
				ReinvestRate2023to2030 = 0.00;
				ReinvestRate2023to2035 = 0.00;
				ReinvestRate2023toCash = 0.00;
				ReinvestRate2023toDana = 0.00;
				ReinvestRate2023toRet = 0.00;
			}
			
			
			//---- for 2023
			ProjValueMaturity2023_H = [self PaidUpOptionTable_2023_H_Balance:PrevPaidUpOptionTable_2023_High andPolicyYear:polYear];
			ProjWithdraw2023_H = ProjValueMaturity2023_H * ((100 - ReinvestRate2023)/100.00);
			ProjReinvest2023_H = ProjValueMaturity2023_H - ProjWithdraw2023_H;
			
			ProjValueMaturity2023_M = [self PaidUpOptionTable_2023_M_Balance:PrevPaidUpOptionTable_2023_Median andPolicyYear:polYear];
			ProjWithdraw2023_M = ProjValueMaturity2023_M * ((100 - ReinvestRate2023)/100.00);
			ProjReinvest2023_M = ProjValueMaturity2023_M - ProjWithdraw2023_M;
			
			ProjValueMaturity2023_L = [self PaidUpOptionTable_2023_L_Balance:PrevPaidUpOptionTable_2023_Low andPolicyYear:polYear];
			ProjWithdraw2023_L = ProjValueMaturity2023_L * ((100 - ReinvestRate2023)/100.00);
			ProjReinvest2023_L = ProjValueMaturity2023_L - ProjWithdraw2023_L;
			//-------
			
			//-- for 2025---
			ReinvestAmount2023to2025_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023to2025/100.00);
			ProjValueMaturity2025_H = [self PaidUpOptionTable_2025_High:PrevPaidUpOptionTable_2025_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2025_High = ProjValueMaturity2025_H;
			
			ReinvestAmount2023to2025_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023to2025/100.00);
			ProjValueMaturity2025_M = [self PaidUpOptionTable_2025_Median:PrevPaidUpOptionTable_2025_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2025_Median = ProjValueMaturity2025_M;
			
			ReinvestAmount2023to2025_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023to2025/100.00);
			ProjValueMaturity2025_L = [self PaidUpOptionTable_2025_Low:PrevPaidUpOptionTable_2025_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2025_Low = ProjValueMaturity2025_L;
			//------------
			
			//-- for 2028---
			ReinvestAmount2023to2028_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023to2028/100.00);
			ProjValueMaturity2028_H = [self PaidUpOptionTable_2028_High:PrevPaidUpOptionTable_2028_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2028_High = ProjValueMaturity2028_H;
			
			ReinvestAmount2023to2028_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023to2028/100.00);
			ProjValueMaturity2028_M = [self PaidUpOptionTable_2028_Median:PrevPaidUpOptionTable_2028_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2028_Median = ProjValueMaturity2028_M;
			
			ReinvestAmount2023to2028_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023to2028/100.00);
			ProjValueMaturity2028_L = [self PaidUpOptionTable_2028_Low:PrevPaidUpOptionTable_2028_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2028_Low = ProjValueMaturity2028_L;
			//------------
			
			//-- for 2030---
			ReinvestAmount2023to2030_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023to2030/100.00);
			ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
			
			ReinvestAmount2023to2030_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023to2030/100.00);
			ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
			
			ReinvestAmount2023to2030_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023to2030/100.00);
			ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
			//------------
			
			//-- for 2035---
			ReinvestAmount2023to2035_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023to2035/100.00);
			ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
			
			ReinvestAmount2023to2035_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023to2035/100.00);
			ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
			
			ReinvestAmount2023to2035_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023to2035/100.00);
			ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			//------------
			
			//-- for Secure Fund---
			ReinvestAmount2023toRet_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023toRet/100.00);
			ProjValueMaturityRet_H = [self PaidUpOptionTable_Ret_High:PrevPaidUpOptionTable_Ret_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_High = ProjValueMaturityRet_H;
			
			ReinvestAmount2023toRet_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023toRet/100.00);
			ProjValueMaturityRet_M = [self PaidUpOptionTable_Ret_Median:PrevPaidUpOptionTable_Ret_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Median = ProjValueMaturityRet_M;
			
			ReinvestAmount2023toRet_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023toRet/100.00);
			ProjValueMaturityRet_L = [self PaidUpOptionTable_Ret_Low:PrevPaidUpOptionTable_Ret_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Low = ProjValueMaturityRet_L;
			//------------
			
			//-- for Dana Fund---
			ReinvestAmount2023toDana_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023toDana/100.00);
			ProjValueMaturityDana_H = [self PaidUpOptionTable_Dana_High:PrevPaidUpOptionTable_Dana_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_High = ProjValueMaturityDana_H;
			
			ReinvestAmount2023toDana_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023toDana/100.00);
			ProjValueMaturityDana_M = [self PaidUpOptionTable_Dana_Median:PrevPaidUpOptionTable_Dana_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Median = ProjValueMaturityDana_M;
			
			ReinvestAmount2023toDana_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023toDana/100.00);
			ProjValueMaturityDana_L = [self PaidUpOptionTable_Dana_Low:PrevPaidUpOptionTable_Dana_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Low = ProjValueMaturityDana_L;
			//------------
			
			//-- for Cash Fund---
			ReinvestAmount2023toCash_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023toCash/100.00);
			ProjValueMaturityCash_H = [self PaidUpOptionTable_Cash_High:PrevPaidUpOptionTable_Cash_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_High = ProjValueMaturityCash_H;
			
			ReinvestAmount2023toCash_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023toCash/100.00);
			ProjValueMaturityCash_M = [self PaidUpOptionTable_Cash_Median:PrevPaidUpOptionTable_Cash_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Median = ProjValueMaturityCash_M;
			
			ReinvestAmount2023toCash_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023toCash/100.00);
			ProjValueMaturityCash_L = [self PaidUpOptionTable_Cash_Low:PrevPaidUpOptionTable_Cash_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Low = ProjValueMaturityCash_L;
			//------------
			
		}
		
		else if (polYear == FundTerm2025) {
			
			if (Fund2025PartialReinvest == 0) {
				ReinvestRate2025 = 100; //meaning 2025 is fully reinvest
			}
			else{
				ReinvestRate2025 = 100 - Fund2025PartialReinvest;
			}
			
			if (Fund2025PartialReinvest != 100) { //meaning 2025 is not withdraw
				ReinvestRate2025to2028 = Fund2025ReinvestTo2028Fac;
				ReinvestRate2025to2030 = Fund2025ReinvestTo2030Fac;
				ReinvestRate2025to2035 = Fund2025ReinvestTo2035Fac;
				ReinvestRate2025toCash = Fund2025ReinvestToCashFac;
				ReinvestRate2025toDana = Fund2025ReinvestToDanaFac;
				ReinvestRate2025toRet = Fund2025ReinvestToRetFac;
			}
			else{
				ReinvestRate2025to2028 = 0.00;
				ReinvestRate2025to2030 = 0.00;
				ReinvestRate2025to2035 = 0.00;
				ReinvestRate2025toCash = 0.00;
				ReinvestRate2025toDana = 0.00;
				ReinvestRate2025toRet = 0.00;
			}
			
			//---- for 2025
			ProjValueMaturity2025_H = [self PaidUpOptionTable_2025_H_Balance:PrevPaidUpOptionTable_2025_High andPolicyYear:polYear];
			ProjWithdraw2025_H = ProjValueMaturity2025_H * ((100 - ReinvestRate2025)/100.00);
			ProjReinvest2025_H = ProjValueMaturity2025_H - ProjWithdraw2025_H;
			
			ProjValueMaturity2025_M = [self PaidUpOptionTable_2025_M_Balance:PrevPaidUpOptionTable_2025_Median andPolicyYear:polYear];
			ProjWithdraw2025_M = ProjValueMaturity2025_M * ((100 - ReinvestRate2025)/100.00);
			ProjReinvest2025_M = ProjValueMaturity2025_M - ProjWithdraw2025_M;
			
			ProjValueMaturity2025_L = [self PaidUpOptionTable_2025_L_Balance:PrevPaidUpOptionTable_2025_Low andPolicyYear:polYear];
			ProjWithdraw2025_L = ProjValueMaturity2025_L * ((100 - ReinvestRate2025)/100.00);
			ProjReinvest2025_L = ProjValueMaturity2025_L - ProjWithdraw2025_L;
			//-------
			
			// ---- for 2028
			ReinvestAmount2025to2028_H = ProjValueMaturity2025_H * (ReinvestRate2025/100.00) * (ReinvestRate2025to2028/100.00);
			ProjValueMaturity2028_H = [self PaidUpOptionTable_2028_High:PrevPaidUpOptionTable_2028_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2028_High = ProjValueMaturity2028_H;
			
			ReinvestAmount2025to2028_M = ProjValueMaturity2025_M * (ReinvestRate2025/100.00) * (ReinvestRate2025to2028/100.00);
			ProjValueMaturity2028_M = [self PaidUpOptionTable_2028_Median:PrevPaidUpOptionTable_2028_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2028_Median = ProjValueMaturity2028_M;
			
			ReinvestAmount2025to2028_L = ProjValueMaturity2025_L * (ReinvestRate2025/100.00) * (ReinvestRate2025to2028/100.00);
			ProjValueMaturity2028_L = [self PaidUpOptionTable_2028_Low:PrevPaidUpOptionTable_2028_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2028_Low = ProjValueMaturity2028_L;
			// -----
			
			// ---- for 2030
			ReinvestAmount2025to2030_H = ProjValueMaturity2025_H * (ReinvestRate2025/100.00) * (ReinvestRate2025to2030/100.00);
			ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
			
			ReinvestAmount2025to2030_M = ProjValueMaturity2025_M * (ReinvestRate2025/100.00) * (ReinvestRate2025to2030/100.00);
			ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
			
			ReinvestAmount2025to2030_L = ProjValueMaturity2025_L * (ReinvestRate2025/100.00) * (ReinvestRate2025to2030/100.00);
			ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
			// -----
			
			// ---- for 2035
			ReinvestAmount2025to2035_H = ProjValueMaturity2025_H * (ReinvestRate2025/100.00) * (ReinvestRate2025to2035/100.00);
			ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
			
			ReinvestAmount2025to2035_M = ProjValueMaturity2025_M * (ReinvestRate2025/100.00) * (ReinvestRate2025to2035/100.00);
			ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
			
			ReinvestAmount2025to2035_L = ProjValueMaturity2025_L * (ReinvestRate2025/100.00) * (ReinvestRate2025to2035/100.00);
			ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			// -----
			
			//-- for Secure Fund---
			ReinvestAmount2025toRet_H = ProjValueMaturity2025_H * (ReinvestRate2025/100.00) * (ReinvestRate2025toRet/100.00);
			ProjValueMaturityRet_H = [self PaidUpOptionTable_Ret_High:PrevPaidUpOptionTable_Ret_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_High = ProjValueMaturityRet_H;
			
			ReinvestAmount2025toRet_M = ProjValueMaturity2025_M * (ReinvestRate2025/100.00) * (ReinvestRate2025toRet/100.00);
			ProjValueMaturityRet_M = [self PaidUpOptionTable_Ret_Median:PrevPaidUpOptionTable_Ret_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Median = ProjValueMaturityRet_M;
			
			ReinvestAmount2025toRet_L = ProjValueMaturity2025_L * (ReinvestRate2025/100.00) * (ReinvestRate2025toRet/100.00);
			ProjValueMaturityRet_L = [self PaidUpOptionTable_Ret_Low:PrevPaidUpOptionTable_Ret_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Low = ProjValueMaturityRet_L;
			//------------
			
			//-- for Dana Fund---
			ReinvestAmount2025toDana_H = ProjValueMaturity2025_H * (ReinvestRate2025/100.00) * (ReinvestRate2025toDana/100.00);
			ProjValueMaturityDana_H = [self PaidUpOptionTable_Dana_High:PrevPaidUpOptionTable_Dana_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_High = ProjValueMaturityDana_H;
			
			ReinvestAmount2025toDana_M = ProjValueMaturity2025_M * (ReinvestRate2025/100.00) * (ReinvestRate2025toDana/100.00);
			ProjValueMaturityDana_M = [self PaidUpOptionTable_Dana_Median:PrevPaidUpOptionTable_Dana_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Median = ProjValueMaturityDana_M;
			
			ReinvestAmount2025toDana_L = ProjValueMaturity2025_L * (ReinvestRate2025/100.00) * (ReinvestRate2025toDana/100.00);
			ProjValueMaturityDana_L = [self PaidUpOptionTable_Dana_Low:PrevPaidUpOptionTable_Dana_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Low = ProjValueMaturityDana_L;
			//------------
			
			//-- for Cash Fund---
			ReinvestAmount2025toCash_H = ProjValueMaturity2025_H * (ReinvestRate2025/100.00) * (ReinvestRate2025toCash/100.00);
			ProjValueMaturityCash_H = [self PaidUpOptionTable_Cash_High:PrevPaidUpOptionTable_Cash_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_High = ProjValueMaturityCash_H;
			
			ReinvestAmount2025toCash_M = ProjValueMaturity2025_M * (ReinvestRate2025/100.00) * (ReinvestRate2025toCash/100.00);
			ProjValueMaturityCash_M = [self PaidUpOptionTable_Cash_Median:PrevPaidUpOptionTable_Cash_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Median = ProjValueMaturityCash_M;
			
			ReinvestAmount2025toCash_L = ProjValueMaturity2025_L * (ReinvestRate2025/100.00) * (ReinvestRate2025toCash/100.00);
			ProjValueMaturityCash_L = [self PaidUpOptionTable_Cash_Low:PrevPaidUpOptionTable_Cash_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Low = ProjValueMaturityCash_L;
			//------------
			
		}
		else if (polYear == FundTerm2028) {
			
			if (Fund2028PartialReinvest == 0) {
				ReinvestRate2028 = 100; //meaning 2028 is fully reinvest
			}
			else{
				ReinvestRate2028 = 100 - Fund2028PartialReinvest;
			}
			
			if (Fund2028PartialReinvest != 100) { //meaning 2028 is not withdraw
				ReinvestRate2028to2030 = Fund2028ReinvestTo2030Fac;
				ReinvestRate2028to2035 = Fund2028ReinvestTo2035Fac;
				ReinvestRate2028toCash = Fund2028ReinvestToCashFac;
				ReinvestRate2028toDana = Fund2028ReinvestToDanaFac;
				ReinvestRate2028toRet = Fund2028ReinvestToRetFac;
			}
			else{
				ReinvestRate2028to2030 = 0.00;
				ReinvestRate2028to2035 = 0.00;
				ReinvestRate2028toCash = 0.00;
				ReinvestRate2028toDana = 0.00;
				ReinvestRate2028toRet = 0.00;
			}
			
			//---- for 2028
			ProjValueMaturity2028_H = [self PaidUpOptionTable_2028_H_Balance:PrevPaidUpOptionTable_2028_High andPolicyYear:polYear];
			ProjWithdraw2028_H = ProjValueMaturity2028_H * ((100 - ReinvestRate2028)/100.00);
			ProjReinvest2028_H = ProjValueMaturity2028_H - ProjWithdraw2028_H;
			
			ProjValueMaturity2028_M = [self PaidUpOptionTable_2028_M_Balance:PrevPaidUpOptionTable_2028_Median andPolicyYear:polYear];
			ProjWithdraw2028_M = ProjValueMaturity2028_M * ((100 - ReinvestRate2028)/100.00);
			ProjReinvest2028_M = ProjValueMaturity2028_M - ProjWithdraw2028_M;
			
			ProjValueMaturity2028_L = [self PaidUpOptionTable_2028_L_Balance:PrevPaidUpOptionTable_2028_Low andPolicyYear:polYear];
			ProjWithdraw2028_L = ProjValueMaturity2028_L * ((100 - ReinvestRate2028)/100.00);
			ProjReinvest2028_L = ProjValueMaturity2028_L - ProjWithdraw2028_L;
			//-------
			
			// ---- for 2030
			ReinvestAmount2028to2030_H = ProjValueMaturity2028_H * (ReinvestRate2028/100.00) * (ReinvestRate2028to2030/100.00);
			ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
			
			ReinvestAmount2028to2030_M = ProjValueMaturity2028_M * (ReinvestRate2028/100.00) * (ReinvestRate2028to2030/100.00);
			ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
			
			ReinvestAmount2028to2030_L = ProjValueMaturity2028_L * (ReinvestRate2028/100.00) * (ReinvestRate2028to2030/100.00);
			ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
			// -----
			
			// ---- for 2035
			ReinvestAmount2028to2035_H = ProjValueMaturity2028_H * (ReinvestRate2028/100.00) * (ReinvestRate2028to2035/100.00);
			ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
			
			ReinvestAmount2028to2035_M = ProjValueMaturity2028_M * (ReinvestRate2028/100.00) * (ReinvestRate2028to2035/100.00);
			ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
			
			ReinvestAmount2028to2035_L = ProjValueMaturity2028_L * (ReinvestRate2028/100.00) * (ReinvestRate2028to2035/100.00);
			ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			// -----
			
			//-- for Secure Fund---
			ReinvestAmount2028toRet_H = ProjValueMaturity2028_H * (ReinvestRate2028/100.00) * (ReinvestRate2028toRet/100.00);
			ProjValueMaturityRet_H = [self PaidUpOptionTable_Ret_High:PrevPaidUpOptionTable_Ret_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_High = ProjValueMaturityRet_H;
			
			ReinvestAmount2028toRet_M = ProjValueMaturity2028_M * (ReinvestRate2028/100.00) * (ReinvestRate2028toRet/100.00);
			ProjValueMaturityRet_M = [self PaidUpOptionTable_Ret_Median:PrevPaidUpOptionTable_Ret_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Median = ProjValueMaturityRet_M;
			
			ReinvestAmount2028toRet_L = ProjValueMaturity2028_L * (ReinvestRate2028/100.00) * (ReinvestRate2028toRet/100.00);
			ProjValueMaturityRet_L = [self PaidUpOptionTable_Ret_Low:PrevPaidUpOptionTable_Ret_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Low = ProjValueMaturityRet_L;
			//------------
			
			//-- for Dana Fund---
			ReinvestAmount2028toDana_H = ProjValueMaturity2028_H * (ReinvestRate2028/100.00) * (ReinvestRate2028toDana/100.00);
			ProjValueMaturityDana_H = [self PaidUpOptionTable_Dana_High:PrevPaidUpOptionTable_Dana_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_High = ProjValueMaturityDana_H;
			
			ReinvestAmount2028toDana_M = ProjValueMaturity2028_M * (ReinvestRate2028/100.00) * (ReinvestRate2028toDana/100.00);
			ProjValueMaturityDana_M = [self PaidUpOptionTable_Dana_Median:PrevPaidUpOptionTable_Dana_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Median = ProjValueMaturityDana_M;
			
			ReinvestAmount2028toDana_L = ProjValueMaturity2028_L * (ReinvestRate2028/100.00) * (ReinvestRate2028toDana/100.00);
			ProjValueMaturityDana_L = [self PaidUpOptionTable_Dana_Low:PrevPaidUpOptionTable_Dana_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Low = ProjValueMaturityDana_L;
			//------------
			
			//-- for Cash Fund---
			ReinvestAmount2028toCash_H = ProjValueMaturity2028_H * (ReinvestRate2028/100.00) * (ReinvestRate2028toCash/100.00);
			ProjValueMaturityCash_H = [self PaidUpOptionTable_Cash_High:PrevPaidUpOptionTable_Cash_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_High = ProjValueMaturityCash_H;
			
			ReinvestAmount2028toCash_M = ProjValueMaturity2028_M * (ReinvestRate2028/100.00) * (ReinvestRate2028toCash/100.00);
			ProjValueMaturityCash_M = [self PaidUpOptionTable_Cash_Median:PrevPaidUpOptionTable_Cash_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Median = ProjValueMaturityCash_M;
			
			ReinvestAmount2028toCash_L = ProjValueMaturity2028_L * (ReinvestRate2028/100.00) * (ReinvestRate2028toCash/100.00);
			ProjValueMaturityCash_L = [self PaidUpOptionTable_Cash_Low:PrevPaidUpOptionTable_Cash_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Low = ProjValueMaturityCash_L;
			//------------
			
		}
		else if (polYear == FundTerm2030) {
			
			if (Fund2030PartialReinvest == 0) {
				ReinvestRate2030 = 100; //meaning 2030 is fully reinvest
			}
			else{
				ReinvestRate2030 = 100 - Fund2030PartialReinvest;
			}
			
			if (Fund2030PartialReinvest != 100) { //meaning 2030 is not withdraw
				ReinvestRate2030to2035 = Fund2030ReinvestTo2035Fac;
				ReinvestRate2030toCash = Fund2030ReinvestToCashFac;
				ReinvestRate2030toDana = Fund2030ReinvestToDanaFac;
				ReinvestRate2030toRet = Fund2030ReinvestToRetFac;
			}
			else{
				ReinvestRate2030to2035 = 0.00;
				ReinvestRate2030toCash = 0.00;
				ReinvestRate2030toDana = 0.00;
				ReinvestRate2030toRet = 0.00;
			}
			
			//---- for 2030
			ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_H_Balance:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
			ProjWithdraw2030_H = ProjValueMaturity2030_H * ((100 - ReinvestRate2030)/100.00);
			ProjReinvest2030_H = ProjValueMaturity2030_H - ProjWithdraw2030_H;
			
			ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_M_Balance:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
			ProjWithdraw2030_M = ProjValueMaturity2030_M * ((100 - ReinvestRate2030)/100.00);
			ProjReinvest2030_M = ProjValueMaturity2030_M - ProjWithdraw2030_M;
			
			ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_L_Balance:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
			ProjWithdraw2030_L = ProjValueMaturity2030_L * ((100 - ReinvestRate2030)/100.00);
			ProjReinvest2030_L = ProjValueMaturity2030_L - ProjWithdraw2030_L;
			//-------
			
			// ---- for 2035
			ReinvestAmount2030to2035_H = ProjValueMaturity2030_H * (ReinvestRate2030/100.00) * (ReinvestRate2030to2035/100.00);
			ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
			
			ReinvestAmount2030to2035_M = ProjValueMaturity2030_M * (ReinvestRate2030/100.00) * (ReinvestRate2030to2035/100.00);
			ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
			
			ReinvestAmount2030to2035_L = ProjValueMaturity2030_L * (ReinvestRate2030/100.00) * (ReinvestRate2030to2035/100.00);
			ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			// -----
			
			//-- for Secure Fund---
			ReinvestAmount2030toRet_H = ProjValueMaturity2030_H * (ReinvestRate2030/100.00) * (ReinvestRate2030toRet/100.00);
			ProjValueMaturityRet_H = [self PaidUpOptionTable_Ret_High:PrevPaidUpOptionTable_Ret_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_High = ProjValueMaturityRet_H;
			
			ReinvestAmount2030toRet_M = ProjValueMaturity2030_M * (ReinvestRate2030/100.00) * (ReinvestRate2030toRet/100.00);
			ProjValueMaturityRet_M = [self PaidUpOptionTable_Ret_Median:PrevPaidUpOptionTable_Ret_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Median = ProjValueMaturityRet_M;
			
			ReinvestAmount2030toRet_L = ProjValueMaturity2030_L * (ReinvestRate2030/100.00) * (ReinvestRate2030toRet/100.00);
			ProjValueMaturityRet_L = [self PaidUpOptionTable_Ret_Low:PrevPaidUpOptionTable_Ret_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Low = ProjValueMaturityRet_L;
			//------------
			
			//-- for Dana Fund---
			ReinvestAmount2030toDana_H = ProjValueMaturity2030_H * (ReinvestRate2030/100.00) * (ReinvestRate2030toDana/100.00);
			ProjValueMaturityDana_H = [self PaidUpOptionTable_Dana_High:PrevPaidUpOptionTable_Dana_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_High = ProjValueMaturityDana_H;
			
			ReinvestAmount2030toDana_M = ProjValueMaturity2030_M * (ReinvestRate2030/100.00) * (ReinvestRate2030toDana/100.00);
			ProjValueMaturityDana_M = [self PaidUpOptionTable_Dana_Median:PrevPaidUpOptionTable_Dana_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Median = ProjValueMaturityDana_M;
			
			ReinvestAmount2030toDana_L = ProjValueMaturity2030_L * (ReinvestRate2030/100.00) * (ReinvestRate2030toDana/100.00);
			ProjValueMaturityDana_L = [self PaidUpOptionTable_Dana_Low:PrevPaidUpOptionTable_Dana_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Low = ProjValueMaturityDana_L;
			//------------
			
			//-- for Cash Fund---
			ReinvestAmount2030toCash_H = ProjValueMaturity2030_H * (ReinvestRate2030/100.00) * (ReinvestRate2030toCash/100.00);
			ProjValueMaturityCash_H = [self PaidUpOptionTable_Cash_High:PrevPaidUpOptionTable_Cash_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_High = ProjValueMaturityCash_H;
			
			ReinvestAmount2030toCash_M = ProjValueMaturity2030_M * (ReinvestRate2030/100.00) * (ReinvestRate2030toCash/100.00);
			ProjValueMaturityCash_M = [self PaidUpOptionTable_Cash_Median:PrevPaidUpOptionTable_Cash_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Median = ProjValueMaturityCash_M;
			
			ReinvestAmount2030toCash_L = ProjValueMaturity2030_L * (ReinvestRate2030/100.00) * (ReinvestRate2030toCash/100.00);
			ProjValueMaturityCash_L = [self PaidUpOptionTable_Cash_Low:PrevPaidUpOptionTable_Cash_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Low = ProjValueMaturityCash_L;
			//------------
			
		}
		else if (polYear == FundTerm2035) {
			
			if (Fund2035PartialReinvest == 0) {
				ReinvestRate2035 = 100; //meaning 2035 is fully reinvest
			}
			else{
				ReinvestRate2035 = 100 - Fund2035PartialReinvest;
			}
			
			if (Fund2035PartialReinvest != 100) { //meaning 2035 is not withdraw
				ReinvestRate2035toCash = Fund2035ReinvestToCashFac;
				ReinvestRate2035toDana = Fund2035ReinvestToDanaFac;
				ReinvestRate2035toRet = Fund2035ReinvestToRetFac;
			}
			else{
				ReinvestRate2035toCash = 0.00;
				ReinvestRate2035toDana = 0.00;
				ReinvestRate2035toRet = 0.00;
			}
			
			//---- for 2035
			ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_H_Balance:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
			ProjWithdraw2035_H = ProjValueMaturity2035_H * ((100 - ReinvestRate2035)/100.00);
			ProjReinvest2035_H = ProjValueMaturity2035_H - ProjWithdraw2035_H;
			
			ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_M_Balance:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
			ProjWithdraw2035_M = ProjValueMaturity2035_M * ((100 - ReinvestRate2035)/100.00);
			ProjReinvest2035_M = ProjValueMaturity2035_M - ProjWithdraw2035_M;
			
			ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_L_Balance:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
			ProjWithdraw2035_L = ProjValueMaturity2035_L * ((100 - ReinvestRate2035)/100.00);
			ProjReinvest2035_L = ProjValueMaturity2035_L - ProjWithdraw2035_L;
			//-------
			
			//-- for Secure Fund---
			ReinvestAmount2035toRet_H = ProjValueMaturity2035_H * (ReinvestRate2035/100.00) * (ReinvestRate2035toRet/100.00);
			ProjValueMaturityRet_H = [self PaidUpOptionTable_Ret_High:PrevPaidUpOptionTable_Ret_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_High = ProjValueMaturityRet_H;
			
			ReinvestAmount2035toRet_M = ProjValueMaturity2035_M * (ReinvestRate2035/100.00) * (ReinvestRate2035toRet/100.00);
			ProjValueMaturityRet_M = [self PaidUpOptionTable_Ret_Median:PrevPaidUpOptionTable_Ret_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Median = ProjValueMaturityRet_M;
			
			ReinvestAmount2035toRet_L = ProjValueMaturity2035_L * (ReinvestRate2035/100.00) * (ReinvestRate2035toRet/100.00);
			ProjValueMaturityRet_L = [self PaidUpOptionTable_Ret_Low:PrevPaidUpOptionTable_Ret_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Low = ProjValueMaturityRet_L;
			//------------
			
			//-- for Dana Fund---
			ReinvestAmount2035toDana_H = ProjValueMaturity2035_H * (ReinvestRate2035/100.00) * (ReinvestRate2035toDana/100.00);
			ProjValueMaturityDana_H = [self PaidUpOptionTable_Dana_High:PrevPaidUpOptionTable_Dana_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_High = ProjValueMaturityDana_H;
			
			ReinvestAmount2035toDana_M = ProjValueMaturity2035_M * (ReinvestRate2035/100.00) * (ReinvestRate2035toDana/100.00);
			ProjValueMaturityDana_M = [self PaidUpOptionTable_Dana_Median:PrevPaidUpOptionTable_Dana_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Median = ProjValueMaturityDana_M;
			
			ReinvestAmount2035toDana_L = ProjValueMaturity2035_L * (ReinvestRate2035/100.00) * (ReinvestRate2035toDana/100.00);
			ProjValueMaturityDana_L = [self PaidUpOptionTable_Dana_Low:PrevPaidUpOptionTable_Dana_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Low = ProjValueMaturityDana_L;
			//------------
			
			//-- for Cash Fund---
			ReinvestAmount2035toCash_H = ProjValueMaturity2035_H * (ReinvestRate2035/100.00) * (ReinvestRate2035toCash/100.00);
			ProjValueMaturityCash_H = [self PaidUpOptionTable_Cash_High:PrevPaidUpOptionTable_Cash_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_High = ProjValueMaturityCash_H;
			
			ReinvestAmount2035toCash_M = ProjValueMaturity2035_M * (ReinvestRate2035/100.00) * (ReinvestRate2035toCash/100.00);
			ProjValueMaturityCash_M = [self PaidUpOptionTable_Cash_Median:PrevPaidUpOptionTable_Cash_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Median = ProjValueMaturityCash_M;
			
			ReinvestAmount2035toCash_L = ProjValueMaturity2035_L * (ReinvestRate2035/100.00) * (ReinvestRate2035toCash/100.00);
			ProjValueMaturityCash_L = [self PaidUpOptionTable_Cash_Low:PrevPaidUpOptionTable_Cash_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Low = ProjValueMaturityCash_L;
			//------------
			
			
		}
		else{
			ProjValueMaturityRet_H = [self PaidUpOptionTable_Ret_High:PrevPaidUpOptionTable_Ret_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_High = ProjValueMaturityRet_H;
			ProjValueMaturityRet_M = [self PaidUpOptionTable_Ret_Median:PrevPaidUpOptionTable_Ret_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Median = ProjValueMaturityRet_M;
			ProjValueMaturityRet_L = [self PaidUpOptionTable_Ret_Low:PrevPaidUpOptionTable_Ret_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Low = ProjValueMaturityRet_L;
			
			ProjValueMaturityCash_H = [self PaidUpOptionTable_Cash_High:PrevPaidUpOptionTable_Cash_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_High = ProjValueMaturityCash_H;
			ProjValueMaturityCash_M = [self PaidUpOptionTable_Cash_Median:PrevPaidUpOptionTable_Cash_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Median = ProjValueMaturityCash_M;
			ProjValueMaturityCash_L = [self PaidUpOptionTable_Cash_Low:PrevPaidUpOptionTable_Cash_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Low = ProjValueMaturityCash_L;
			
			ProjValueMaturityDana_H = [self PaidUpOptionTable_Dana_High:PrevPaidUpOptionTable_Dana_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_High = ProjValueMaturityDana_H;
			ProjValueMaturityDana_M = [self PaidUpOptionTable_Dana_Median:PrevPaidUpOptionTable_Dana_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Median = ProjValueMaturityDana_M;
			ProjValueMaturityDana_L = [self PaidUpOptionTable_Dana_Low:PrevPaidUpOptionTable_Dana_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Low = ProjValueMaturityDana_L;
			
			
			if(polYear < FundTerm2023){
				ProjValueMaturity2023_H = [self PaidUpOptionTable_2023_High:PrevPaidUpOptionTable_2023_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2023_High = ProjValueMaturity2023_H;
				ProjValueMaturity2023_M = [self PaidUpOptionTable_2023_Median:PrevPaidUpOptionTable_2023_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2023_Median = ProjValueMaturity2023_M;
				ProjValueMaturity2023_L = [self PaidUpOptionTable_2023_Low:PrevPaidUpOptionTable_2023_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2023_Low = ProjValueMaturity2023_L;
				
				ProjValueMaturity2025_H = [self PaidUpOptionTable_2025_High:PrevPaidUpOptionTable_2025_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2025_High = ProjValueMaturity2025_H;
				ProjValueMaturity2025_M = [self PaidUpOptionTable_2025_Median:PrevPaidUpOptionTable_2025_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2025_Median = ProjValueMaturity2025_M;
				ProjValueMaturity2025_L = [self PaidUpOptionTable_2025_Low:PrevPaidUpOptionTable_2025_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2025_Low = ProjValueMaturity2025_L;
				
				ProjValueMaturity2028_H = [self PaidUpOptionTable_2028_High:PrevPaidUpOptionTable_2028_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_High = ProjValueMaturity2028_H;
				ProjValueMaturity2028_M = [self PaidUpOptionTable_2028_Median:PrevPaidUpOptionTable_2028_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_Median = ProjValueMaturity2028_M;
				ProjValueMaturity2028_L = [self PaidUpOptionTable_2028_Low:PrevPaidUpOptionTable_2028_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_Low = ProjValueMaturity2028_L;
				
				ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
				ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
				ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
				
				ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
				ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
				ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			}
			else if(polYear < FundTerm2025){
				ProjValueMaturity2025_H = [self PaidUpOptionTable_2025_High:PrevPaidUpOptionTable_2025_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2025_High = ProjValueMaturity2025_H;
				ProjValueMaturity2025_M = [self PaidUpOptionTable_2025_Median:PrevPaidUpOptionTable_2025_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2025_Median = ProjValueMaturity2025_M;
				ProjValueMaturity2025_L = [self PaidUpOptionTable_2025_Low:PrevPaidUpOptionTable_2025_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2025_Low = ProjValueMaturity2025_L;
				
				ProjValueMaturity2028_H = [self PaidUpOptionTable_2028_High:PrevPaidUpOptionTable_2028_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_High = ProjValueMaturity2028_H;
				ProjValueMaturity2028_M = [self PaidUpOptionTable_2028_Median:PrevPaidUpOptionTable_2028_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_Median = ProjValueMaturity2028_M;
				ProjValueMaturity2028_L = [self PaidUpOptionTable_2028_Low:PrevPaidUpOptionTable_2028_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_Low = ProjValueMaturity2028_L;
				
				ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
				ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
				ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
				
				ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
				ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
				ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			}
			else if(polYear < FundTerm2028){
				
				ProjValueMaturity2028_H = [self PaidUpOptionTable_2028_High:PrevPaidUpOptionTable_2028_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_High = ProjValueMaturity2028_H;
				ProjValueMaturity2028_M = [self PaidUpOptionTable_2028_Median:PrevPaidUpOptionTable_2028_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_Median = ProjValueMaturity2028_M;
				ProjValueMaturity2028_L = [self PaidUpOptionTable_2028_Low:PrevPaidUpOptionTable_2028_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_Low = ProjValueMaturity2028_L;
				
				ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
				ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
				ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
				
				ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
				ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
				ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			}
			else if(polYear < FundTerm2030){
				
				ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
				ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
				ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
				
				ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
				ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
				ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			}
			else if(polYear < FundTerm2035){
				
				ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
				ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
				ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			}
		}
		
		//NSLog(@"%d %f %f %f", polYear, ProjValueMaturityCash_H,ProjValueMaturityCash_M,ProjValueMaturityCash_L);
	}
	
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2') "
					"VALUES ('%@','%d','%@','%.0f')", SINo, 0, @"Charge", round(PaidOpChargeSum_H) ];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		double tempSum = 0.00;
		tempSum = VU2023ValueHigh + VU2025ValueHigh + VU2028ValueHigh + VU2030ValueHigh + VU2035ValueHigh + VUDanaValueHigh + VUCashValueHigh + VURetValueHigh;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Fund Value at %@ policy anniversary date','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f', '%.0F')",
					SINo, 1, @"BULL", tempPol, round(VU2023ValueHigh),round(VU2025ValueHigh),round(VU2028ValueHigh), round(VU2030ValueHigh),
					round(VU2035ValueHigh), round(VUDanaValueHigh),round(VURetValueHigh),round(VUCashValueHigh), round(tempSum)];
		
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		tempSum = VU2023ValueMedian + VU2025ValueMedian + VU2028ValueMedian + VU2030ValueMedian + VU2035ValueMedian + VUDanaValueMedian + VUCashValueMedian + VURetValueMedian;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Fund Value at %@ policy anniversary date','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f', '%.0F')",
					SINo, 1, @"FLAT", tempPol, round(VU2023ValueMedian),round(VU2025ValueMedian),round(VU2028ValueMedian), round(VU2030ValueMedian),
					round(VU2035ValueMedian), round(VUDanaValueMedian),round(VURetValueMedian),round(VUCashValueMedian), round(tempSum) ];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		tempSum = VU2023ValueLow + VU2025ValueLow + VU2028ValueLow + VU2030ValueLow + VU2035ValueLow + VUDanaValueLow + VUCashValueLow + VURetValueLow;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Fund Value at %@ policy anniversary date','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f', '%.0F')",
					SINo, 1, @"BEAR", tempPol, round(VU2023ValueLow),round(VU2025ValueLow),round(VU2028ValueLow), round(VU2030ValueLow),
					round(VU2035ValueLow), round(VUDanaValueLow),round(VURetValueLow),round(VUCashValueLow), round(tempSum) ];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		// -------------
		
		tempSum = ProjDeduction2023_H + ProjDeduction2025_H + ProjDeduction2028_H + ProjDeduction2030_H + ProjDeduction2035_H + ProjDeductionDana_H + ProjDeductionRet_H + ProjDeductionCash_H;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Fund Value immediately after Reduced Paid Up Charges','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f')",
					SINo, 2, @"BULL", round(ProjDeduction2023_H),round(ProjDeduction2025_H),round(ProjDeduction2028_H), round(ProjDeduction2030_H),
					round(ProjDeduction2035_H), round(ProjDeductionDana_H),round(ProjDeductionRet_H),round(ProjDeductionCash_H),round(tempSum) ];
		
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		tempSum = ProjDeduction2023_M + ProjDeduction2025_M + ProjDeduction2028_M + ProjDeduction2030_M + ProjDeduction2035_M + ProjDeductionDana_M + ProjDeductionRet_M + ProjDeductionCash_M;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Fund Value immediately after Reduced Paid Up Charges','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f')",
					SINo, 2, @"FLAT", round(ProjDeduction2023_M),round(ProjDeduction2025_M),round(ProjDeduction2028_M), round(ProjDeduction2030_M),
					round(ProjDeduction2035_M), round(ProjDeductionDana_M),round(ProjDeductionRet_M),round(ProjDeductionCash_M),round(tempSum) ];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		tempSum = ProjDeduction2023_L + ProjDeduction2025_L + ProjDeduction2028_L + ProjDeduction2030_L + ProjDeduction2035_L + ProjDeductionDana_L + ProjDeductionRet_L + ProjDeductionCash_L;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Fund Value immediately after Reduced Paid Up Charges','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f')",
					SINo, 2, @"BEAR", round(ProjDeduction2023_L),round(ProjDeduction2025_L),round(ProjDeduction2028_L), round(ProjDeduction2030_L),
					round(ProjDeduction2035_L), round(ProjDeductionDana_L),round(ProjDeductionRet_L),round(ProjDeductionCash_L),round(tempSum) ];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		//-------------
		
		tempSum = ProjValAfterReinvest2023_H + ProjValAfterReinvest2025_H + ProjValAfterReinvest2028_H + ProjValAfterReinvest2030_H + ProjValAfterReinvest2035_H + ProjValAfterReinvestDana_H + ProjValAfterReinvestRet_H + ProjValAfterReinvestCash_H;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Fund Value immediately after Reinvestment of remaining HLA Cash Fund','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f')",
					SINo, 3, @"BULL", round(ProjValAfterReinvest2023_H),round(ProjValAfterReinvest2025_H),round(ProjValAfterReinvest2028_H), round(ProjValAfterReinvest2030_H),
					round(ProjValAfterReinvest2035_H), round(ProjValAfterReinvestDana_H),round(ProjValAfterReinvestRet_H),round(ProjValAfterReinvestCash_H),round(tempSum) ];
		
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		tempSum = ProjValAfterReinvest2023_M + ProjValAfterReinvest2025_M + ProjValAfterReinvest2028_M + ProjValAfterReinvest2030_M + ProjValAfterReinvest2035_M + ProjValAfterReinvestDana_M + ProjValAfterReinvestRet_M + ProjValAfterReinvestCash_M;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Fund Value immediately after Reinvestment of remaining HLA Cash Fund','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f')",
					SINo, 3, @"FLAT", round(ProjValAfterReinvest2023_M),round(ProjValAfterReinvest2025_M),round(ProjValAfterReinvest2028_M), round(ProjValAfterReinvest2030_M),
					round(ProjValAfterReinvest2035_M), round(ProjValAfterReinvestDana_M),round(ProjValAfterReinvestRet_M),round(ProjValAfterReinvestCash_M),round(tempSum) ];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		tempSum = ProjValAfterReinvest2023_L + ProjValAfterReinvest2025_L + ProjValAfterReinvest2028_L + ProjValAfterReinvest2030_L + ProjValAfterReinvest2035_L + ProjValAfterReinvestDana_L + ProjValAfterReinvestRet_L + ProjValAfterReinvestCash_L;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Fund Value immediately after Reinvestment of remaining HLA Cash Fund','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f')",
					SINo, 3, @"BEAR", round(ProjValAfterReinvest2023_L),round(ProjValAfterReinvest2025_L),round(ProjValAfterReinvest2028_L), round(ProjValAfterReinvest2030_L),
					round(ProjValAfterReinvest2035_L), round(ProjValAfterReinvestDana_L),round(ProjValAfterReinvestRet_L),round(ProjValAfterReinvestCash_L),round(tempSum) ];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		//-------- withdrawal------------------
		
		tempSum = ProjWithdraw2023_H + ProjWithdraw2025_H + ProjWithdraw2028_H + ProjWithdraw2030_H + ProjWithdraw2035_H + ProjWithdrawDana_H + ProjWithdrawRet_H + ProjWithdrawCash_H;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Amount Withdrawn at fund maturity','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f')",
					SINo, 4, @"BULL", round(ProjWithdraw2023_H),round(ProjWithdraw2025_H),round(ProjWithdraw2028_H), round(ProjWithdraw2030_H),
					round(ProjWithdraw2035_H), round(ProjWithdrawDana_H),round(ProjWithdrawRet_H),round(ProjWithdrawCash_H),round(tempSum) ];
		
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		tempSum = ProjWithdraw2023_M + ProjWithdraw2025_M + ProjWithdraw2028_M + ProjWithdraw2030_M + ProjWithdraw2035_M + ProjWithdrawDana_M + ProjWithdrawRet_M + ProjWithdrawCash_M;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Amount Withdrawn at fund maturity','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f')",
					SINo, 4, @"FLAT", round(ProjWithdraw2023_M),round(ProjWithdraw2025_M),round(ProjWithdraw2028_M), round(ProjWithdraw2030_M),
					round(ProjWithdraw2035_M), round(ProjWithdrawDana_M),round(ProjWithdrawRet_M),round(ProjWithdrawCash_M),round(tempSum) ];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		tempSum = ProjWithdraw2023_L + ProjWithdraw2025_L + ProjWithdraw2028_L + ProjWithdraw2030_L + ProjWithdraw2035_L + ProjWithdrawDana_L + ProjWithdrawRet_L + ProjWithdrawCash_L;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Amount Withdrawn at fund maturity','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f')",
					SINo, 4, @"BEAR", round(ProjWithdraw2023_L),round(ProjWithdraw2025_L),round(ProjWithdraw2028_L), round(ProjWithdraw2030_L),
					round(ProjWithdraw2035_L), round(ProjWithdrawDana_L),round(ProjWithdrawRet_L),round(ProjWithdrawCash_L),round(tempSum) ];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		//-------- projected fund value at xxth year------------------
		
		NSString *tempAdd;
		NSString *str = [NSString stringWithFormat:@"%d", ToYear];
		
		if ([[str substringFromIndex: str.length  - 1 ] isEqualToString:@"1"]) {
			tempAdd = [str stringByAppendingFormat:@"st" ];
		}
		if ([[str substringFromIndex: str.length  - 1 ] isEqualToString:@"2"]) {
			tempAdd = [str stringByAppendingFormat:@"nd" ];
		}
		if ([[str substringFromIndex: str.length  - 1 ] isEqualToString:@"3"]) {
			tempAdd = [str stringByAppendingFormat:@"rd" ];
		}
		else {
			tempAdd = [str stringByAppendingFormat:@"th" ];
		}
		
		/*
		 QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10') "
		 "VALUES ('%@','%d','%@','Projected Fund Value at end of %@ policy year ','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f')",
		 SINo, 5, @"BULL", tempAdd, round(ProjValueMaturity2023_H),round(ProjValueMaturity2025_H),round(ProjValueMaturity2028_H), round(ProjValueMaturity2030_H),
		 round(ProjValueMaturity2035_H), round(ProjValueMaturityDana_H),round(ProjValueMaturityRet_H),round(ProjValueMaturityCash_H) ];
		 */
		
		tempSum = ProjValueMaturity2023_H + ProjValueMaturity2025_H + ProjValueMaturity2028_H + ProjValueMaturity2030_H + ProjValueMaturity2035_H + ProjValueMaturityDana_H + ProjValueMaturityRet_H + ProjValueMaturityCash_H;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Fund Value at end of %@ policy year ','%@','%@','%@','%@','%@','%.0f','%.0f','%.0f','%.0f')",
					SINo, 5, @"BULL", tempAdd, @"N/A", @"N/A",@"N/A", @"N/A",@"N/A",
					round(ProjValueMaturityDana_H),round(ProjValueMaturityRet_H),round(ProjValueMaturityCash_H),round(tempSum) ];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		/*
		 QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10') "
		 "VALUES ('%@','%d','%@','Projected Fund Value at end of %@ policy year','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f','%.0f')",
		 SINo, 5, @"FLAT", tempAdd,round(ProjValueMaturity2023_M),round(ProjValueMaturity2025_M),round(ProjValueMaturity2028_M), round(ProjValueMaturity2030_M),
		 round(ProjValueMaturity2025_M), round(ProjValueMaturityDana_M),round(ProjValueMaturityRet_M),round(ProjValueMaturityCash_M) ];
		 */
		
		tempSum = ProjValueMaturity2023_M + ProjValueMaturity2025_M + ProjValueMaturity2028_M + ProjValueMaturity2030_M + ProjValueMaturity2035_M + ProjValueMaturityDana_M + ProjValueMaturityRet_M + ProjValueMaturityCash_M;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Fund Value at end of %@ policy year','%@','%@','%@','%@','%@','%.0f','%.0f','%.0f','%.0f')",
					SINo, 5, @"FLAT", tempAdd, @"N/A",@"N/A", @"N/A", @"N/A",@"N/A",
					round(ProjValueMaturityDana_M),round(ProjValueMaturityRet_M),round(ProjValueMaturityCash_M),round(tempSum) ];
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		tempSum = ProjValueMaturity2023_L + ProjValueMaturity2025_L + ProjValueMaturity2028_L + ProjValueMaturity2030_L + ProjValueMaturity2035_L + ProjValueMaturityDana_L + ProjValueMaturityRet_L + ProjValueMaturityCash_L;
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_RPUO ('SINO', 'SeqNo','col1','col2','col3','col4','col5','col6','col7','col8','col9','col10','col11') "
					"VALUES ('%@','%d','%@','Projected Fund Value at end of %@ policy year','%@','%@','%@','%@','%@','%.0f','%.0f','%.0f','%.0f')",
					SINo, 5, @"BEAR", tempAdd, @"N/A", @"N/A", @"N/A", @"N/A", @"N/A",
					round(ProjValueMaturityDana_L),round(ProjValueMaturityRet_L),round(ProjValueMaturityCash_L),round(tempSum) ];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
			}
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
}

-(double)Calc_PaidUpOptionCharges:(double) aaFundValue andVUCash :(double) aaVUCash andHighMedLow :(NSString *) aaHighMedLow{
	if (aaVUCash >= OneTimePayOut) {
		return 0.00;
	}
	else{
		double totalWithoutVUCash = 0.00;
		if ([aaHighMedLow isEqualToString:@"High"]) {
			totalWithoutVUCash = VU2023ValueHigh + VU2025ValueHigh + VU2028ValueHigh + VU2030ValueHigh + VU2035ValueHigh + VUDanaValueHigh + VURetValueHigh;
		}
		else if ([aaHighMedLow isEqualToString:@"Med"]) {
			totalWithoutVUCash = VU2023ValueMedian + VU2025ValueMedian + VU2028ValueMedian + VU2030ValueMedian + VU2035ValueMedian + VUDanaValueMedian + VURetValueMedian;
		}
		else if ([aaHighMedLow isEqualToString:@"Low"]) {
			totalWithoutVUCash = VU2023ValueLow + VU2025ValueLow + VU2028ValueLow + VU2030ValueLow + VU2035ValueLow + VUDanaValueLow + VURetValueLow;
		}
			
		if (aaFundValue == 0 && totalWithoutVUCash == 0.00) {
			return 0.00;
		}
		else{
			return aaFundValue/(totalWithoutVUCash) * (OneTimePayOut - aaVUCash);
		}
	}
}

-(double)Calc_CashFundReinvest:(double) aaFundValue andVUCash :(double) aaVUCash andHighMedLow :(NSString *) aaHighMedLow{

		double totalWithoutVUCash = 0.00;
		if ([aaHighMedLow isEqualToString:@"High"]) {
			totalWithoutVUCash = VU2023ValueHigh + VU2025ValueHigh + VU2028ValueHigh + VU2030ValueHigh + VU2035ValueHigh + VUDanaValueHigh + VURetValueHigh;
		}
		else if ([aaHighMedLow isEqualToString:@"Med"]) {
			totalWithoutVUCash = VU2023ValueMedian + VU2025ValueMedian + VU2028ValueMedian + VU2030ValueMedian + VU2035ValueMedian + VUDanaValueMedian + VURetValueMedian;
		}
		else if ([aaHighMedLow isEqualToString:@"Low"]) {
			totalWithoutVUCash = VU2023ValueLow + VU2025ValueLow + VU2028ValueLow + VU2030ValueLow + VU2035ValueLow + VUDanaValueLow + VURetValueLow;
		}
		
		if (aaFundValue == 0 && totalWithoutVUCash == 0.00) {
			return 0.00;
		}
		else{
			return aaFundValue/(totalWithoutVUCash) * aaVUCash;
		}

}

-(double)ReturnFundChargeRate:(NSString *)aaFund andMOP:(NSString *)aaMOP{
	if ([aaFund isEqualToString:@"Ever"]) {
		if ([aaMOP isEqualToString:@"A"]) {
			return 0.013;
		}
		else if ([aaMOP isEqualToString:@"S"]) {
			return 0.0097395;
		}
		else if ([aaMOP isEqualToString:@"Q"]) {
			return 0.0081119;
		}
		else {
			return 0.0070278;
		}
	}
	else if ([aaFund isEqualToString:@"Secure"]) {
		if ([aaMOP isEqualToString:@"A"]) {
			return 0.01;
		}
		else if ([aaMOP isEqualToString:@"S"]) {
			return 0.0074938;
		}
		else if ([aaMOP isEqualToString:@"Q"]) {
			return 0.0062422;
		}
		else  {
			return 0.0054084;
		}
	}
	else if ([aaFund isEqualToString:@"Dana"]) {
		if ([aaMOP isEqualToString:@"A"]) {
			return 0.013;
		}
		else if ([aaMOP isEqualToString:@"S"]) {
			return 0.0097395;
		}
		else if ([aaMOP isEqualToString:@"Q"]) {
			return 0.0081119;
		}
		else  {
			return 0.0070278;
		}
	}
	else {
		if ([aaMOP isEqualToString:@"A"]) {
			return 0.0025;
		}
		else if ([aaMOP isEqualToString:@"S"]) {
			return 0.0018746;
		}
		else if ([aaMOP isEqualToString:@"Q"]) {
			return 0.001562;
		}
		else {
			return 0.0013537;
		}
	}
}

-(BOOL)InsertToUL_Temp_Fund:(NSString *)aaFund andValue1:(double)aaValue1 andValue2:(double)aaValue2 andValue3:(double)aaValue3
								andValue4:(double)aaValue4 andValue5:(double)aaValue5 andValue6:(double)aaValue6{
	sqlite3_stmt *statement;
    NSString *QuerySQL;
	
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		QuerySQL = [ NSString stringWithFormat:@"Insert Into UL_temp_Fund (col1,col2,col3,col4,col5,col6,col7,sino) "
					"VALUES ('%@', '%.0f', '%.0f', '%.0f', '%.0f', '%.0f', '%.0f', '%@')", aaFund, round(aaValue1), round(aaValue2), round(aaValue3),
					round(aaValue4), round(aaValue5), round(aaValue6), SINo];
		
		//NSLog(@"%@",QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if(sqlite3_step(statement) == SQLITE_DONE) {
					

			}
			
			sqlite3_finalize(statement);
			sqlite3_close(contactDB);
			return  TRUE;
			
		}
		else
		{	sqlite3_close(contactDB);
			return FALSE;
		}
		

	}
	else{
		return FALSE;
	}
}

-(void)getAllPreDetails{
	sqlite3_stmt *statement;
    NSString *QuerySQL;
	double tempOtherRiderPrem = 0.00;
	NSString *tempUniRiderPrem;
	
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		QuerySQL = [NSString stringWithFormat: @"Select BasicSA, ATPrem, replace(Hloading, '(null)', '0') as Hloading, "
					"replace(HLoadingPct, '(null)', '0') as HLoadingPct "
					", BumpMode, HLoadingTerm, HLoadingPctTerm, PolicySustainYear, ATU, covperiod from UL_Details Where  "
					" sino = '%@' ", SINo];
		
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
				
				BasicSA = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] doubleValue ];
				strBasicSA = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] ;
				strBasicPremium = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] ;
				const char *temp = (const char*)sqlite3_column_text(statement, 2);
                getHL = temp == NULL ? nil : [[NSString alloc] initWithUTF8String:temp];
				const char *temp2 = (const char*)sqlite3_column_text(statement, 3);
				getHLPct = temp2 == NULL ? nil : [[NSString alloc] initWithUTF8String:temp2];
				strBumpMode	= [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] ;
				const char *temp3 = (const char*)sqlite3_column_text(statement, 5);
				getHLTerm = temp3 == NULL ? nil : [[NSString alloc] initWithUTF8String:temp3];
				const char *temp4 = (const char*)sqlite3_column_text(statement, 6);
				getHLPctTerm = temp4 == NULL ? nil : [[NSString alloc] initWithUTF8String:temp4];
				PolicySustainYear = sqlite3_column_double(statement, 7);
				strGrayRTUPAmount = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] ;
				strCovPeriod = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] ;
			}
            sqlite3_finalize(statement);
        }
		
		strBasicPremium_Bump = strBasicPremium; 
		if ([strBumpMode isEqualToString:@"S"]) {
			strBasicPremium = [NSString stringWithFormat:@"%.0f", round([strBasicPremium doubleValue]/0.5)];
		}
		else if([strBumpMode isEqualToString:@"Q"]){
			strBasicPremium = [NSString stringWithFormat:@"%.0f", round([strBasicPremium doubleValue]/0.25)];
		}
		else if([strBumpMode isEqualToString:@"M"]){
			strBasicPremium = [NSString stringWithFormat:@"%.0f", round([strBasicPremium doubleValue]/0.0833333)];
		}
		else
		{

		}
		
		QuerySQL = [ NSString stringWithFormat:@"Select RiderCode, RiderTerm,RiderDesc, SumAssured, PlanOption, "
					"Deductible, replace(Hloading, '(null)', '0') as Hloading, HloadingTerm, "
					" replace(HloadingPct, '(null)', '0') as HloadingPct, HloadingPctTerm, Premium, paymentTerm, "
					" ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear from UL_rider_details "
                    "  where \"sino\" = \"%@\" AND ridercode not in ('CIRD', 'DCA', 'ACIR', 'HMM', 'MG_IV', "
					"'WI', 'MR', 'TPDMLA', 'PA', 'DHI', 'ECAR', 'ECAR6', 'ECAR55', 'RRTUO') ORDER BY RiderCode ASC ", SINo];
		
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			while(sqlite3_step(statement) == SQLITE_ROW) {
				[OtherRiderCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
				[OtherRiderTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
				[OtherRiderDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]];
				
				[OtherRiderSA addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)]];
				if ([[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] isEqualToString:@"(null)" ]   ) {
					[OtherRiderPlanOption addObject:@""];
				}
				else {
					[OtherRiderPlanOption addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)]];
				}
				
				[OtherRiderDeductible addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)]];
				[OtherRiderHL addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)]];
				[OtherRiderHLTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)]];
				[OtherRiderHLP addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)]];
				[OtherRiderHLPTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)]];
				tempOtherRiderPrem = sqlite3_column_double(statement, 10);
				
				if ([strBumpMode isEqualToString:@"S"]) {
					[OtherRiderPremium addObject:[NSString stringWithFormat:@"%f", tempOtherRiderPrem/0.5]];
				}
				else if([strBumpMode isEqualToString:@"Q"]){
					[OtherRiderPremium addObject:[NSString stringWithFormat:@"%f", tempOtherRiderPrem/0.25]];
				}
				else if([strBumpMode isEqualToString:@"M"]){
					[OtherRiderPremium addObject:[NSString stringWithFormat:@"%f", tempOtherRiderPrem/0.0833333]];
				}
				else
				{
					[OtherRiderPremium addObject:[NSString stringWithFormat:@"%f", tempOtherRiderPrem]];
				}
				
				//[OtherRiderPremium addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)]];
				[OtherRiderPaymentTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 11)]];
			}
			
			sqlite3_finalize(statement);
		}
		
		QuerySQL = [NSString stringWithFormat: @"Select ridercode, SumAssured, ifnull(Hloading, '0') as Hloading, ifnull(HLoadingPct, '0') as HLoadingPct, "
					"RiderTerm, planOption, Deductible, premium from ul_rider_details Where  "
					"  sino = '%@' AND ridercode in ('CIRD', 'DCA', 'ACIR', 'HMM', 'MG_IV', "
					"'WI', 'MR', 'TPDMLA', 'PA', 'DHI')", SINo];
		
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
				[UnitizeRiderCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
				[UnitizeRiderSA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
				[UnitizeRiderHL addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]];
				[UnitizeRiderHLPct addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)]];
				[UnitizeRiderTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)]];
				[UnitizeRiderPlanChoice addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)]];
				[UnitizeRiderDeductible addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)]];
				//[UnitizeRiderPremium addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)]];
				tempUniRiderPrem = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
				
				if ([strBumpMode isEqualToString:@"S"]) {
					[UnitizeRiderPremium addObject:[NSString stringWithFormat:@"%f", [tempUniRiderPrem doubleValue]/0.5]];
				}
				else if([strBumpMode isEqualToString:@"Q"]){
					[UnitizeRiderPremium addObject:[NSString stringWithFormat:@"%f", [tempUniRiderPrem doubleValue ]/0.25]];
				}
				else if([strBumpMode isEqualToString:@"M"]){
					[UnitizeRiderPremium addObject:[NSString stringWithFormat:@"%f", [tempUniRiderPrem doubleValue ]/0.0833333]];
				}
				else
				{
					[UnitizeRiderPremium addObject:[NSString stringWithFormat:@"%f", [tempUniRiderPrem doubleValue]]];
				}
			}
            sqlite3_finalize(statement);
        }
		
		
		QuerySQL = [NSString stringWithFormat: @"Select premium, RRTUOFromYear, RRTUOYear from ul_rider_details Where  "
					"  sino = '%@' AND ridercode in ('RRTUO')", SINo];
		
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
				strRRTUOPrem = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				strRRTUOFrom = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				strRRTUOFor = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
			}
            sqlite3_finalize(statement);
        }
		
		
		
		
		sqlite3_close(contactDB);
	}
	
}

-(void)InsertSustainYear :(int)aaSustainYear{
	sqlite3_stmt *statement;
    NSString *QuerySQL;
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		QuerySQL = [ NSString stringWithFormat:@"Update UL_Details SET PolicySustainYear = '%d' where sino = '%@'", aaSustainYear + Age, SINo];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {

			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
}

-(void)getRPUO{
	sqlite3_stmt *statement;
    NSString *QuerySQL;
	OneTimePayOutRate = 0.00;
			
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		QuerySQL = [ NSString stringWithFormat:@"Select ReducedYear, Amount From UL_ReducedPaidUp where sino = '%@'", SINo];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW) {
			 	RPUOExist = TRUE;
				RPUOYear = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				RPUOSA = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
			}
			else
			{
				RPUOExist = NO;
				RPUOYear = @"0";
				RPUOSA = @"0";
			}
			
			sqlite3_finalize(statement);
		}

		sqlite3_close(contactDB);
	}
	
	if (RPUOExist == TRUE) {
		if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
			QuerySQL = [ NSString stringWithFormat:@"Select Rate From ES_Sys_Paid_Up_Rate where Sex = '%@' "
						"AND Smoker = '%@' AND PolTerm = '%d' AND Paid_Up_Year = '%@' ",
						getSexLA, getSmokerLA, 100 - Age, RPUOYear];
			//NSLog(@"%@",QuerySQL);
			if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
				if (sqlite3_step(statement) == SQLITE_ROW) {
					OneTimePayOutRate = sqlite3_column_double(statement, 0);
				}
				
				sqlite3_finalize(statement);
			}
			
			
			
			sqlite3_close(contactDB);
		}
		
		OneTimePayOut = (OneTimePayOutRate * (1 + (([getHLPct doubleValue ]/100.00) * (MAX(0, [getHLPctTerm intValue] - [RPUOYear intValue ])/(75 - Age - [RPUOYear intValue])))) +
						 ([getHL doubleValue] * MAX(0, [getHLTerm intValue] - [RPUOYear intValue])) + ([getOccLoading doubleValue] * MAX(0, 75 - Age - [RPUOYear intValue]))) * [RPUOSA doubleValue]/1000.00;
		
		double tempMin = BasicSA * (0.05 * ([RPUOYear intValue ] -3)  + 0.15);
		OneTimePayOutWithMinSA = (OneTimePayOutRate * (1 + (([getHLPct doubleValue ]/100.00) * (MAX(0, [getHLPctTerm intValue] - [RPUOYear intValue ])/(75 - Age - [RPUOYear intValue])))) +
								  ([getHL doubleValue] * MAX(0, [getHLTerm intValue] - [RPUOYear intValue])) + ([getOccLoading doubleValue] * MAX(0, 75 - Age - [RPUOYear intValue]))) * tempMin/1000.00;
		
	}
	
	//NSLog(@"%f dasdas", OneTimePayOut);
}

-(void)getECAR55{
	sqlite3_stmt *statement;
    NSString *QuerySQL;
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		QuerySQL = [ NSString stringWithFormat:@"Select  RiderTerm,RiderDesc, SumAssured, "
					" coalesce(nullif(hloading, ''), '0' ) as Hloading, HloadingTerm, "
					" replace(HloadingPct, '(null)', '0') as HloadingPct, HloadingPctTerm, Premium, paymentTerm, "
					" ReinvestGYI from UL_rider_details where \"sino\" = \"%@\" AND ridercode = 'ECAR55' ", SINo];
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW) {
				ECAR55Exist = TRUE;
				ECAR55RiderTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				ECAR55RiderDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
				ECAR55SumAssured = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
				const char *temp = (const char*)sqlite3_column_text(statement, 3);
				ECAR55HLoading = temp == NULL ? Nil : [[NSString alloc] initWithUTF8String:(const char *)temp];
				//ECAR55HLoading = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
				ECAR55HLoadingTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
				ECAR55HLoadingPct = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
				ECAR55HLoadingPctTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
				ECAR55Premium = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
				ECAR55PaymentTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
				ECAR55ReinvestGYI = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)];
				
			}
			else{
				ECAR55Exist = FALSE;
			}
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
	
	
}

-(void)InsertToUL_Temp_ECAR55{
	sqlite3_stmt *statement;
    NSString *QuerySQL;

	double ECAR55AnnuityRate = 0.00;
	double ECAR55TPDRate = 0.00;
	NSMutableArray *CSVRate = [[NSMutableArray alloc] init ];
	NSMutableArray *ECAR55AnnualPremium = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderMonthlyIncome = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderSurrenderValueMRA = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderSurrenderValue = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderTPDBegin = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderTPDEnd = [[NSMutableArray alloc] init ];
	NSMutableArray *CommissionRate = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderDistributionCost = [[NSMutableArray alloc] init ];
	
	if (ECAR55Exist == TRUE) {
		NSLog(@"--------- ECAR55 begin --------");
		
		if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
			for (int i =1; i <= 30; i++) {
				QuerySQL = [ NSString stringWithFormat:@"Select CSV from ES_sys_Rider_csv where PlanCode = 'ECAR55' "
							"AND PremPayOpt = '%@' AND PolTerm = '%@' AND FromAge = '%d' AND PolYear = '%d' ", ECAR55PaymentTerm, ECAR55RiderTerm, Age, i];
				
				//NSLog(@"%@", QuerySQL);
				if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
					if (sqlite3_step(statement) == SQLITE_ROW) {
							[CSVRate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
					}
					
					sqlite3_finalize(statement);
				}

				QuerySQL = [ NSString stringWithFormat:@"Select Rate from ES_sys_Rider_ECAR55_Comm where  "
							" Year = '%d' AND Premium_Term = '%d' ", i > 7 ? 7 : i, 55 - Age];
				
				if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
					if (sqlite3_step(statement) == SQLITE_ROW) {
						[CommissionRate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
					}
					
					
					sqlite3_finalize(statement);
				}
				
			}
			
			QuerySQL = [ NSString stringWithFormat:@"Select Rate from ES_sys_Rider_AnnuityPrem where PlanCode = 'ECAR55' "
						"AND PremPayOpt = '%@' AND PolTerm = '%@' AND FromAge = '%d' ", ECAR55PaymentTerm, ECAR55RiderTerm, Age];
			
			if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
									if (sqlite3_step(statement) == SQLITE_ROW) {
										ECAR55AnnuityRate = sqlite3_column_double(statement, 0);
									}
				
				sqlite3_finalize(statement);
			}
			
			QuerySQL = [ NSString stringWithFormat:@"Select Rate from ES_sys_Rider_Prem where PlanCode = 'ECAR55' "
						"AND PremPayOpt = '%@' AND Term = '%@' AND FromAge = '%d' ", ECAR55PaymentTerm, ECAR55RiderTerm, Age];
			
			if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
				if (sqlite3_step(statement) == SQLITE_ROW) {
						ECAR55TPDRate = sqlite3_column_double(statement, 0);
				}
				
				sqlite3_finalize(statement);
			}
			
			
			sqlite3_close(contactDB);
		}
		
		if (CommissionRate.count == 0) {
			NSLog(@"no commission rate");
			return;
		}
		
		if (CSVRate.count == 0) {
			NSLog(@"no csv rate");
			return;
		}
		
		for (int i = 1; i <= 30; i++) {
			if (Age + i <= 55) {
				[ECAR55AnnualPremium addObject: ECAR55Premium ];
			}
			else{
				[ECAR55AnnualPremium addObject:@"0.00" ];
			}
			
			double NewOverallTotalPremiumPaid = [[OverallTotalPremiumPaid objectAtIndex: i -1 ] doubleValue ] +
												[[ECAR55AnnualPremium objectAtIndex:i-1] doubleValue ];
			[OverallTotalPremiumPaid replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallTotalPremiumPaid]];
			
			if (Age + i ==  55) {
				[RiderMonthlyIncome addObject: ECAR55SumAssured ];
			}
			else if (Age + i > 55) {
				[RiderMonthlyIncome addObject: [NSString stringWithFormat:@"%f", [ECAR55SumAssured doubleValue ] * 12 ]];
			}
			else{
				[RiderMonthlyIncome addObject:@"0.00" ];
			}
			
			[OverallMonthlyIncome addObject:[RiderMonthlyIncome objectAtIndex:i - 1]];
			
			double tempS = [[CSVRate objectAtIndex:i -1] doubleValue ] * [ECAR55SumAssured doubleValue ]/100.00;
			double tempRetPrem = ECAR55AnnuityRate * [ECAR55Premium doubleValue]/100.00;
			double minRetention = 0.00;
			
			if (tempRetPrem > 3000) {
				tempRetPrem = 3000;
			}
			
			if (Age + i <= 55) {
				minRetention = tempRetPrem * i;
			}
			else{
				minRetention = 0.00;
			}
				
			//-----------------
			[RiderSurrenderValueMRA addObject:[NSString stringWithFormat:@"%f", tempS - minRetention < 0.00 ? 0 : tempS - minRetention]];
			[RiderSurrenderValue addObject:[NSString stringWithFormat:@"%f", tempS]];
			
			double NewOverallFullSurrenderValue = [[OverallFullSurrenderValue objectAtIndex: i -1 ] doubleValue ] +
													[[RiderSurrenderValue objectAtIndex:i-1] doubleValue ];
			[OverallFullSurrenderValue replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallFullSurrenderValue]];
			
			//------------
			double RiderTPD;
			if (Age + i <= 55) {
				RiderTPD = (ECAR55TPDRate * [ECAR55SumAssured doubleValue]/100.00) * ((pow(1.035, i ) - 1)/0.035) ;
				
			}
			else{
				RiderTPD = [ECAR55SumAssured doubleValue ] * 6 * (101 - (Age + i));
			}
			
			
			[RiderTPDBegin addObject:[NSString stringWithFormat:@"%f", RiderTPD]];
			double NewOverallTPDBegin = [[OverallTPDBegin objectAtIndex: i -1 ] doubleValue ] + [[RiderTPDBegin objectAtIndex:i-1] doubleValue ];
			[OverallTPDBegin replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallTPDBegin]];
			
			double RiderTPDEOF;
			if (Age + i <= 55) {
				RiderTPDEOF = (ECAR55TPDRate * [ECAR55SumAssured doubleValue]/100.00) * 1.035 * (pow(1.035, i) - 1)/0.035 ;
			}
			else{
				RiderTPDEOF = [ECAR55SumAssured doubleValue ] * 6 * (100 - (Age + i));
			}
			
			[RiderTPDEnd addObject:[NSString stringWithFormat:@"%f", RiderTPDEOF]];
			double NewOverallTPDEOY = [[OverallTPDEOY objectAtIndex: i -1 ] doubleValue ] + [[RiderTPDEnd objectAtIndex:i-1] doubleValue ];
			[OverallTPDEOY replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallTPDEOY]];
			
			[RiderDistributionCost addObject:[NSString stringWithFormat:@"%f", [[ECAR55AnnualPremium objectAtIndex:i - 1] doubleValue ] * [[CommissionRate objectAtIndex:i - 1] doubleValue ]/100.00]];
			
			
		}
		
		int inputAge;
		if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){

			for (int a= 1; a<=30; a++) {
				if (Age >= 0){
					inputAge = Age + a;
					
					if (a == 1) {
						QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_ECAR55 (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
									"'col3','col4','col5','col6','col7', 'col8', 'col9') VALUES ( "
									" \"%@\",\"%d\",\"%@\",\"%d\",\"%d\",\"%@\", '%.0f', '%.0f','%.0f', '%.0f', %.0f, '%.0f', '%f', '%@')",
									SINo, a, @"DATA", a, inputAge, [ECAR55AnnualPremium objectAtIndex:a - 1], round([[RiderMonthlyIncome objectAtIndex:a -1] doubleValue ]),
									round([[RiderSurrenderValueMRA objectAtIndex:a-1] doubleValue ]), round([[RiderSurrenderValue objectAtIndex:a-1] doubleValue]),
									round([[RiderTPDBegin objectAtIndex:a-1] doubleValue ]),
									round([[RiderTPDEnd objectAtIndex:a-1] doubleValue ]), round([[RiderDistributionCost objectAtIndex:a-1]doubleValue ]), ECAR55AnnuityRate, ECAR55Premium];
					}
					else{
						QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_ECAR55 (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
									"'col3','col4','col5','col6','col7') VALUES ( "
									" \"%@\",\"%d\",\"%@\",\"%d\",\"%d\",\"%@\", '%.0f', '%.0f','%.0f', '%.0f', %.0f, '%.0f')",
									SINo, a, @"DATA", a, inputAge, [ECAR55AnnualPremium objectAtIndex:a - 1], round([[RiderMonthlyIncome objectAtIndex:a -1] doubleValue ]),
									round([[RiderSurrenderValueMRA objectAtIndex:a-1] doubleValue ]), round([[RiderSurrenderValue objectAtIndex:a-1] doubleValue ]),
									round([[RiderTPDBegin objectAtIndex:a-1] doubleValue ]),
									round([[RiderTPDEnd objectAtIndex:a-1] doubleValue ]), round([[RiderDistributionCost objectAtIndex:a-1]doubleValue ])] ;
					}
			
					
					//NSLog(@"%@", QuerySQL);
					if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
						if (sqlite3_step(statement) == SQLITE_DONE) {
							
						}
						sqlite3_finalize(statement);
					}
					
				}
			}
			sqlite3_close(contactDB);
		}
			NSLog(@"--------- ECAR55 end --------");
	}
	
	int tempToAdd = 0;
	
	if (OverallMonthlyIncome.count < 30) {
		tempToAdd = 30 - OverallMonthlyIncome.count;
		
		for (int i = 0; i < tempToAdd; i ++) {
			[OverallMonthlyIncome addObject:@"0.00"];
			//[OverallFullSurrenderValue addObject:@"0.00"];
		}
	}

}



-(void)getECAR6{
	sqlite3_stmt *statement;
    NSString *QuerySQL;
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		QuerySQL = [ NSString stringWithFormat:@"Select  RiderTerm,RiderDesc, SumAssured, "
					" coalesce(nullif(hloading, ''), '0' ) as Hloading, HloadingTerm, "
					" replace(HloadingPct, '(null)', '0') as HloadingPct, HloadingPctTerm, Premium, paymentTerm, "
					" ReinvestGYI from UL_rider_details where \"sino\" = \"%@\" AND ridercode = 'ECAR6' ", SINo];
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW) {
				ECAR6Exist = TRUE;
				ECAR6RiderTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				ECAR6RiderDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
				ECAR6SumAssured = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
				const char *temp = (const char*)sqlite3_column_text(statement, 3);
				ECAR6HLoading = temp == NULL ? Nil : [[NSString alloc] initWithUTF8String:(const char *)temp];
				//ECAR55HLoading = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
				ECAR6HLoadingTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
				ECAR6HLoadingPct = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
				ECAR6HLoadingPctTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
				ECAR6Premium = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
				ECAR6PaymentTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
				ECAR6ReinvestGYI = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)];
				
			}
			else
			{
				ECAR6Exist = FALSE;
			}
			
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
}


-(void)InsertToUL_Temp_ECAR6{
	sqlite3_stmt *statement;
    NSString *QuerySQL;
	
	
	NSMutableArray *ECAR6TPDRate = [[NSMutableArray alloc] init ];
	NSMutableArray *ECAR6TPDRateEOY = [[NSMutableArray alloc] init ];
	NSMutableArray *ECAR6AccTPD = [[NSMutableArray alloc] init ];
	NSMutableArray *ECAR6AccTPDEOY = [[NSMutableArray alloc] init ];
	NSMutableArray *CSVRate = [[NSMutableArray alloc] init ];
	NSMutableArray *ECAR6AnnualPremium = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderYearlyIncome = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderSurrenderValue = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderTPDBegin = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderTPDEnd = [[NSMutableArray alloc] init ];
	NSMutableArray *CommissionRate = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderDistributionCost = [[NSMutableArray alloc] init ];
	
	
	
	if (ECAR6Exist == TRUE) {
		NSLog(@"--------- ECAR6 begin --------");
		
		if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
			for (int i =1; i <= [ECAR6RiderTerm intValue]; i++) {
				QuerySQL = [ NSString stringWithFormat:@"Select CSV from ES_sys_Rider_csv where PlanCode = 'ECAR' "
							"AND GYI_GMI_Year = '6' AND PolTerm = '%@' AND FromAge = '%d' AND PolYear = '%d' ", ECAR6RiderTerm, Age, i];
				
				//NSLog(@"%@", QuerySQL);
				if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
					if (sqlite3_step(statement) == SQLITE_ROW) {
						[CSVRate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
					}
					
					
					sqlite3_finalize(statement);
				}
				
				int max;
				if (i > 7) {
					max = 7;
				}
				else{
					max = i;
				}
				
				QuerySQL = [ NSString stringWithFormat:@"Select Rate from ES_sys_Rider_commission where  "
							" PolYear = '%d' AND RiderTerm = '%d' ", max, 6];
				
				if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
					if (sqlite3_step(statement) == SQLITE_ROW) {
						[CommissionRate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
					}
					
					
					sqlite3_finalize(statement);
				}
				
				QuerySQL = [ NSString stringWithFormat:@"Select Rate from ES_sys_Rider_DeathTPD where CP_Start_Year = '6' AND  "
							" Policy_Year = '%d' AND Policy_Term = '%@' ", i, ECAR6RiderTerm];
				
				//NSLog(@"%@", QuerySQL);
				
				if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
					if (sqlite3_step(statement) == SQLITE_ROW) {
						[ECAR6TPDRate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
					}
					
					
					sqlite3_finalize(statement);
				}
				
				QuerySQL = [ NSString stringWithFormat:@"Select Rate from ES_sys_Rider_DeathTPD_EOY where CP_Start_Year = '6' AND  "
							" Policy_Year = '%d' AND Policy_Term = '%@' ", i, ECAR6RiderTerm];
				
				if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
					if (sqlite3_step(statement) == SQLITE_ROW) {
						[ECAR6TPDRateEOY addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
					}
					
					
					sqlite3_finalize(statement);
				}
				
			}
			
			sqlite3_close(contactDB);
		}
		
		
		if (CommissionRate.count == 0) {
			NSLog(@"no commission rate");
			return;
		}
		
		if (ECAR6TPDRate.count == 0) {
			NSLog(@"no tpd rate");
			return;
		}
		
		if (ECAR6TPDRateEOY.count == 0) {
			NSLog(@"no tpd eoy rate");
			return;
		}
		
		if (CSVRate.count == 0) {
			NSLog(@"no tpd eoy rate");
			return;
		}
		
		NSString *tempECAR6AnnualPrem;
		if ([strBumpMode isEqualToString:@"A"]) {
			tempECAR6AnnualPrem = ECAR6Premium;
		}
		else if ([strBumpMode isEqualToString:@"S"]) {
			tempECAR6AnnualPrem = [NSString stringWithFormat:@"%f", [ECAR6Premium doubleValue]/0.5 ];
		}
		else if ([strBumpMode isEqualToString:@"Q"]) {
			tempECAR6AnnualPrem = [NSString stringWithFormat:@"%f", [ECAR6Premium doubleValue]/0.25];
		}
		else {
			tempECAR6AnnualPrem = [NSString stringWithFormat:@"%f", [ECAR6Premium doubleValue]/0.0833333];
		}
		
		for (int i = 1; i <= [ECAR6RiderTerm intValue]; i++) {
			if (i <= [ECAR6PaymentTerm intValue ]) {
				[ECAR6AnnualPremium addObject: tempECAR6AnnualPrem ];
			}
			else{
				[ECAR6AnnualPremium addObject:@"0.00" ];
			}
			
			double NewOverallTotalPremiumPaid = [[OverallTotalPremiumPaid objectAtIndex: i -1 ] doubleValue ] + [[ECAR6AnnualPremium objectAtIndex:i-1] doubleValue ];
			[OverallTotalPremiumPaid replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallTotalPremiumPaid]];
			
			
			if (i >=  6) {
				[RiderYearlyIncome addObject: ECAR6SumAssured ];
			}
			else{
				[RiderYearlyIncome addObject:@"0.00" ];
			}
			
			double NewOverallTotalYearlyIncome = [[OverallYearlyIncome objectAtIndex: i -1 ] doubleValue ] + [[RiderYearlyIncome objectAtIndex:i-1] doubleValue ];
			[OverallYearlyIncome replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallTotalYearlyIncome]];
			//[OverallYearlyIncome addObject:[RiderYearlyIncome objectAtIndex: i - 1]];
			
			// ---------------
			double tempS = [[CSVRate objectAtIndex:i -1] doubleValue ] * [ECAR6SumAssured doubleValue ]/1000.00;
			[RiderSurrenderValue addObject:[NSString stringWithFormat:@"%f", tempS]];
			
			double NewOverallFullSurrenderValue = [[OverallFullSurrenderValue objectAtIndex: i -1 ] doubleValue ] +
			[[RiderSurrenderValue objectAtIndex:i-1] doubleValue ];
			[OverallFullSurrenderValue replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallFullSurrenderValue]];
			
			//-----------------
			double RiderTPD;
			
			RiderTPD = [ECAR6SumAssured doubleValue ]  * [[ECAR6TPDRate objectAtIndex:i-1] doubleValue];
			
			[RiderTPDBegin addObject:[NSString stringWithFormat:@"%f", RiderTPD]];
			double NewOverallTPDBegin = [[OverallTPDBegin objectAtIndex: i -1 ] doubleValue ] + [[RiderTPDBegin objectAtIndex:i-1] doubleValue ];
			[OverallTPDBegin replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallTPDBegin]];
			//-------------
			double RiderTPDEOY;
			
			RiderTPDEOY = [ECAR6SumAssured doubleValue ] * [[ECAR6TPDRateEOY objectAtIndex:i-1] doubleValue]; ;
			
			
			[RiderTPDEnd addObject:[NSString stringWithFormat:@"%f", RiderTPDEOY]];
			double NewOverallTPDEOY = [[OverallTPDEOY objectAtIndex: i -1 ] doubleValue ] + [[RiderTPDEnd objectAtIndex:i-1] doubleValue ];
			[OverallTPDEOY replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallTPDEOY]];
			
			// --------
			double RiderAccTPD = 0.00;
			if (Age + i <= 65) {
				double eee = 0.00;
				
				eee = RiderTPD * 3;
				
				if (eee + RiderTPD <= [self TPDLimit:Age + i - 1] ) {
					RiderAccTPD = RiderTPD * 3;
				}
				else{
					RiderAccTPD = [self TPDLimit:Age + i - 1] - RiderTPD;
					if (RiderAccTPD < 0) {
						RiderAccTPD = 0.00;
					}
				}
			}
			else{
				RiderAccTPD = 0.00;
			}
			
			[ECAR6AccTPD addObject:[NSString stringWithFormat:@"%f", RiderAccTPD]];
			

			
			if (ECAR1Exist == TRUE) {
				double ReportAddTPDBegin = 0.00;
				if (Age + i <= 65) { // for summary page only ----- ~~
					double eee = 0.00;
					double ECAR1RiderAddTPD = [[OverallAddTPDBegin objectAtIndex:i - 1] doubleValue]/3.00;
					double tempECAR1AndBasic = [[OverallTPDBegin objectAtIndex:i - 1]  doubleValue] - RiderTPD;
					
					if (ECAR1Exist == TRUE) {
						eee = RiderTPD * 3 + ECAR1RiderAddTPD * 3;
					}
					else{
						eee = RiderTPD * 3;
					}
					
					if (eee + RiderTPD + tempECAR1AndBasic <= [self TPDLimit:Age + i - 1] ) {
						ReportAddTPDBegin = eee;
					}
					else{
						ReportAddTPDBegin = [self TPDLimit:Age + i - 1] - (RiderTPD + tempECAR1AndBasic)  ;
						if (ReportAddTPDBegin < 0) {
							ReportAddTPDBegin = 0.00;
						}
					}
				}
				else{
					ReportAddTPDBegin = 0.00;
				}
				// ------------------ ~~
				
				[OverallAddTPDBegin replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", ReportAddTPDBegin]];
			}
			else{
				double NewOverallAddTPDBegin = [[OverallAddTPDBegin objectAtIndex: i -1 ] doubleValue ] + [[ECAR6AccTPD objectAtIndex:i-1] doubleValue ];
				[OverallAddTPDBegin replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallAddTPDBegin]];
				//[OverallAddTPDBegin addObject:[ECAR6AccTPD objectAtIndex: i -1]];
			}
			
			
			
			//------
			double RiderAccTPD_EOY = 0.00;
			if (Age + i <= 64) {
				double fff = RiderTPDEOY * 3;
				if (fff + RiderTPDEOY <= [self TPDLimit:Age + i] ) {
					RiderAccTPD_EOY = RiderTPDEOY * 3; ;
				}
				else{
					RiderAccTPD_EOY = [self TPDLimit:Age + i] - RiderTPDEOY ;
					if (RiderAccTPD_EOY <= 0) {
						RiderAccTPD_EOY = 0.00;
					}
				}
			}
			else{
				RiderAccTPD_EOY = 0.00;
			}
			
			[ECAR6AccTPDEOY addObject:[NSString stringWithFormat:@"%f", RiderAccTPD_EOY]];
			
			if (ECAR1Exist == TRUE) {
				double ReportAddTPDEOY = 0.00;
				if (Age + i <= 65) { // for summary page only ----- ~~
					double RiderAccTPD_EOY = 0.00;
					double ECAR1RiderAddTPDEOY = [[OverallAddTPDEOY objectAtIndex:i - 1] doubleValue]/3.00;
					double tempECAR1AndBasicEOY = [[OverallTPDEOY objectAtIndex:i - 1]  doubleValue] - RiderTPDEOY;
					
					if (ECAR1Exist == TRUE) {
						RiderAccTPD_EOY = RiderTPDEOY * 3 + ECAR1RiderAddTPDEOY * 3;
					}
					else{
						RiderAccTPD_EOY = RiderTPDEOY * 3;
					}
					
					if (RiderAccTPD_EOY + RiderTPDEOY + tempECAR1AndBasicEOY <= [self TPDLimit:Age + i] ) {
						ReportAddTPDEOY = RiderAccTPD_EOY;
					}
					else{
						ReportAddTPDEOY = [self TPDLimit:Age + i - 1] - (RiderTPDEOY + tempECAR1AndBasicEOY)  ;
						if (ReportAddTPDEOY < 0) {
							ReportAddTPDEOY = 0.00;
						}
					}
				}
				else{
					ReportAddTPDEOY = 0.00;
				}
				// ------------------ ~~
				
				[OverallAddTPDEOY replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", ReportAddTPDEOY]];
			}
			else{
				double NewOverallAccTPDEOY = [[OverallAddTPDEOY objectAtIndex: i -1 ] doubleValue ] + [[ECAR6AccTPDEOY objectAtIndex:i-1] doubleValue ];
				[OverallAddTPDEOY replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallAccTPDEOY]];
				//[OverallAddTPDEOY addObject:[ECAR6AccTPDEOY objectAtIndex: i - 1]];
			}

			
			
			
			//----------
			
			[RiderDistributionCost addObject:[NSString stringWithFormat:@"%f", [tempECAR6AnnualPrem doubleValue ] * [[CommissionRate objectAtIndex:i - 1] doubleValue ]/100.00]];
			
			
		}
		
		int inputAge;
		if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
			for (int a= 1; a<=[ECAR6RiderTerm intValue]; a++) {
				if (Age >= 0){
					inputAge = Age + a;
					
					QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_ECAR6 (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
								"'col3','col4','col5','col6','col7','col8') VALUES ( "
								" \"%@\",\"%d\",\"%@\",\"%d\",\"%d\",\"%@\", '%.0f', '%.0f','%.0f', '%.0f', '%.0f', '%.0f', '%.0f')",
								SINo, a, @"DATA", a, inputAge, [ECAR6AnnualPremium objectAtIndex:a - 1], round([[RiderYearlyIncome objectAtIndex:a -1] doubleValue]),
								round([[RiderSurrenderValue objectAtIndex:a-1] doubleValue]), round([[RiderTPDBegin objectAtIndex:a-1] doubleValue]),
								round([[RiderTPDEnd objectAtIndex:a-1] doubleValue]), round([[ECAR6AccTPD objectAtIndex:a-1] doubleValue]),
								round([[ECAR6AccTPDEOY objectAtIndex:a-1] doubleValue]), round([[RiderDistributionCost objectAtIndex:a-1] doubleValue])];
					
					//NSLog(@"%@", QuerySQL);
					if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
						if (sqlite3_step(statement) == SQLITE_DONE) {
							
						}
						sqlite3_finalize(statement);
					}
					
				}
			}
			sqlite3_close(contactDB);
		}
		NSLog(@"--------- ECAR6 end --------");
	}
	
	int tempToAdd = 0;
	
	if (OverallAddTPDBegin.count < 30) {
		tempToAdd = 30 - OverallAddTPDBegin.count;
		
		for (int i = 0; i < tempToAdd; i ++) {
			[OverallAddTPDBegin addObject:@"0.00"];
			[OverallAddTPDEOY addObject:@"0.00"];
			[OverallYearlyIncome addObject:@"0.00"];
		}
	}
	
	
}

-(void)getECAR1{
	sqlite3_stmt *statement;
    NSString *QuerySQL;
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		QuerySQL = [ NSString stringWithFormat:@"Select  RiderTerm,RiderDesc, SumAssured, "
					" coalesce(nullif(hloading, ''), '0' ) as Hloading, HloadingTerm, "
					" replace(HloadingPct, '(null)', '0') as HloadingPct, HloadingPctTerm, Premium, paymentTerm, "
					" ReinvestGYI from UL_rider_details where \"sino\" = \"%@\" AND ridercode = 'ECAR' ", SINo];
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW) {
				ECAR1Exist = TRUE;
				ECAR1RiderTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				ECAR1RiderDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
				ECAR1SumAssured = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
				const char *temp = (const char*)sqlite3_column_text(statement, 3);
				ECAR1HLoading = temp == NULL ? Nil : [[NSString alloc] initWithUTF8String:(const char *)temp];
				//ECAR55HLoading = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
				ECAR1HLoadingTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
				ECAR1HLoadingPct = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
				ECAR1HLoadingPctTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
				ECAR1Premium = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
				ECAR1PaymentTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
				ECAR1ReinvestGYI = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)];
				
			}
			else{
				ECAR1Exist = FALSE;
			}
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
}

-(void)InsertToUL_Temp_ECAR1{
	sqlite3_stmt *statement;
    NSString *QuerySQL;
	

	NSMutableArray *ECAR1TPDRate = [[NSMutableArray alloc] init ];
	NSMutableArray *ECAR1TPDRateEOY = [[NSMutableArray alloc] init ];
	NSMutableArray *ECAR1AccTPD = [[NSMutableArray alloc] init ];
	NSMutableArray *ECAR1AccTPDEOY = [[NSMutableArray alloc] init ];
	NSMutableArray *CSVRate = [[NSMutableArray alloc] init ];
	NSMutableArray *ECAR1AnnualPremium = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderYearlyIncome = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderSurrenderValue = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderTPDBegin = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderTPDEnd = [[NSMutableArray alloc] init ];
	NSMutableArray *CommissionRate = [[NSMutableArray alloc] init ];
	NSMutableArray *RiderDistributionCost = [[NSMutableArray alloc] init ];
	
	
	if (ECAR1Exist == TRUE) {
		NSLog(@"--------- ECAR1 begin --------");
		
		if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
			for (int i =1; i <= [ECAR1RiderTerm intValue]; i++) {
				QuerySQL = [ NSString stringWithFormat:@"Select CSV from ES_sys_Rider_csv where PlanCode = 'ECAR' "
							"AND GYI_GMI_Year = '1' AND PolTerm = '%@' AND FromAge = '%d' AND PolYear = '%d' ", ECAR1RiderTerm, Age, i];
				
				//NSLog(@"%@", QuerySQL);
				if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
					if (sqlite3_step(statement) == SQLITE_ROW) {
						[CSVRate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
					}
					
					
					sqlite3_finalize(statement);
				}
				
				int max;
				if (i > 7) {
					max = 7;
				}
				else{
					max = i;
				}
				
				QuerySQL = [ NSString stringWithFormat:@"Select Rate from ES_sys_Rider_commission where  "
							" PolYear = '%d' AND RiderTerm = '%d' ", max, 6];
				
				if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
					if (sqlite3_step(statement) == SQLITE_ROW) {
						[CommissionRate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
					}
					
					
					sqlite3_finalize(statement);
				}
				
				QuerySQL = [ NSString stringWithFormat:@"Select Rate from ES_sys_Rider_DeathTPD where CP_Start_Year = '1' AND  "
							" Policy_Year = '%d' AND Policy_Term = '%@' ", i, ECAR1RiderTerm];
				
				//NSLog(@"%@", QuerySQL);
				
				if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
					if (sqlite3_step(statement) == SQLITE_ROW) {
						[ECAR1TPDRate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
					}
					
					
					sqlite3_finalize(statement);
				}
				
				QuerySQL = [ NSString stringWithFormat:@"Select Rate from ES_sys_Rider_DeathTPD_EOY where CP_Start_Year = '1' AND  "
							" Policy_Year = '%d' AND Policy_Term = '%@' ", i, ECAR1RiderTerm];
				
				if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
					if (sqlite3_step(statement) == SQLITE_ROW) {
						[ECAR1TPDRateEOY addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
					}
					
					
					sqlite3_finalize(statement);
				}
				
			}
			
			sqlite3_close(contactDB);
		}
		
		
		if (CommissionRate.count == 0) {
			NSLog(@"no commission rate");
			return;
		}
		
		if (ECAR1TPDRate.count == 0) {
			NSLog(@"no tpd rate");
			return;
		}
		
		if (ECAR1TPDRateEOY.count == 0) {
			NSLog(@"no tpd eoy rate");
			return;
		}
		
		if (CSVRate.count == 0) {
			NSLog(@"no tpd eoy rate");
			return;
		}
		
		NSString *tempECAR1AnnualPrem;
		if ([strBumpMode isEqualToString:@"A"]) {
			tempECAR1AnnualPrem = ECAR1Premium;
		}
		else if ([strBumpMode isEqualToString:@"S"]) {
			tempECAR1AnnualPrem = [NSString stringWithFormat:@"%f", [ECAR1Premium doubleValue]/0.5 ];
		}
		else if ([strBumpMode isEqualToString:@"Q"]) {
			tempECAR1AnnualPrem = [NSString stringWithFormat:@"%f", [ECAR1Premium doubleValue]/0.25];
		}
		else {
			tempECAR1AnnualPrem = [NSString stringWithFormat:@"%f", [ECAR1Premium doubleValue]/0.0833333];
		}
		
		for (int i = 1; i <= [ECAR1RiderTerm intValue]; i++) {
			if (i <= [ECAR1PaymentTerm intValue ]) {
				[ECAR1AnnualPremium addObject: tempECAR1AnnualPrem ];
			}
			else{
				[ECAR1AnnualPremium addObject:@"0.00" ];
			}
			
			double NewOverallTotalPremiumPaid = [[OverallTotalPremiumPaid objectAtIndex: i -1 ] doubleValue ] + [[ECAR1AnnualPremium objectAtIndex:i-1] doubleValue ];
			[OverallTotalPremiumPaid replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallTotalPremiumPaid]];
			
			
			if (Age + i >=  1) {
				[RiderYearlyIncome addObject: ECAR1SumAssured ];
			}
			else{
				[RiderYearlyIncome addObject:@"0.00" ];
			}
			
			[OverallYearlyIncome addObject:[RiderYearlyIncome objectAtIndex: i - 1]];
			
			// ---------------
			double tempS = [[CSVRate objectAtIndex:i -1] doubleValue ] * [ECAR1SumAssured doubleValue ]/1000.00;
			[RiderSurrenderValue addObject:[NSString stringWithFormat:@"%f", tempS]];
			
			double NewOverallFullSurrenderValue = [[OverallFullSurrenderValue objectAtIndex: i -1 ] doubleValue ] +
													[[RiderSurrenderValue objectAtIndex:i-1] doubleValue ];
			[OverallFullSurrenderValue replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallFullSurrenderValue]];

			//-----------------
			double RiderTPD;

			RiderTPD = [ECAR1SumAssured doubleValue ]  * [[ECAR1TPDRate objectAtIndex:i-1] doubleValue];
			
			[RiderTPDBegin addObject:[NSString stringWithFormat:@"%f", RiderTPD]];
			double NewOverallTPDBegin = [[OverallTPDBegin objectAtIndex: i -1 ] doubleValue ] + [[RiderTPDBegin objectAtIndex:i-1] doubleValue ];
			[OverallTPDBegin replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallTPDBegin]];
			//-------------
			double RiderTPDEOY;

			RiderTPDEOY = [ECAR1SumAssured doubleValue ] * [[ECAR1TPDRateEOY objectAtIndex:i-1] doubleValue]; ;

			
			[RiderTPDEnd addObject:[NSString stringWithFormat:@"%f", RiderTPDEOY]];
			double NewOverallTPDEOY = [[OverallTPDEOY objectAtIndex: i -1 ] doubleValue ] + [[RiderTPDEnd objectAtIndex:i-1] doubleValue ];
			[OverallTPDEOY replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallTPDEOY]];
			
			// --------
			double RiderAccTPD = 0.00;
			if (Age + i <= 65) {
				double eee = RiderTPD * 3;
				if (eee + RiderTPD <= [self TPDLimit:Age + i - 1] ) {
					RiderAccTPD = RiderTPD * 3; ;
				}
				else{
					RiderAccTPD = [self TPDLimit:Age + i - 1] - RiderTPD ;
					if (RiderAccTPD <= 0) {
						RiderAccTPD = 0.00;
					}
				}
			}
			else{
				RiderAccTPD = 0.00;
			}
			
			[ECAR1AccTPD addObject:[NSString stringWithFormat:@"%f", RiderAccTPD]];
			[OverallAddTPDBegin addObject:[ECAR1AccTPD objectAtIndex: i -1]];

			
			//------
			double RiderAccTPD_EOY = 0.00;
			if (Age + i <= 64) {
				double fff = RiderTPDEOY * 3;
				if (fff + RiderTPDEOY <= [self TPDLimit:Age + i] ) {
					RiderAccTPD_EOY = RiderTPDEOY * 3; ;
				}
				else{
					RiderAccTPD_EOY = [self TPDLimit:Age + i] - RiderTPDEOY ;
					if (RiderAccTPD_EOY <= 0) {
						RiderAccTPD_EOY = 0.00;
					}
				}
			}
			else{
				RiderAccTPD_EOY = 0.00;
			}
			
			[ECAR1AccTPDEOY addObject:[NSString stringWithFormat:@"%f", RiderAccTPD_EOY]];
			[OverallAddTPDEOY addObject:[ECAR1AccTPDEOY objectAtIndex: i - 1]];
			
			//----------
			
			[RiderDistributionCost addObject:[NSString stringWithFormat:@"%f", [tempECAR1AnnualPrem doubleValue ] * [[CommissionRate objectAtIndex:i - 1] doubleValue ]/100.00]];
			
			
		}
		
		int inputAge;
		if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
			for (int a= 1; a<=[ECAR1RiderTerm intValue]; a++) {
				if (Age >= 0){
					inputAge = Age + a;
					
					QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_ECAR (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
								"'col3','col4','col5','col6','col7','col8') VALUES ( "
								" \"%@\",\"%d\",\"%@\",\"%d\",\"%d\",\"%@\", '%.0f', '%.0f','%.0f', '%.0f', '%.0f', '%.0f', '%.0f')",
								SINo, a, @"DATA", a, inputAge, [ECAR1AnnualPremium objectAtIndex:a - 1], round([[RiderYearlyIncome objectAtIndex:a -1] doubleValue]),
								round([[RiderSurrenderValue objectAtIndex:a-1] doubleValue]), round([[RiderTPDBegin objectAtIndex:a-1] doubleValue]),
								round([[RiderTPDEnd objectAtIndex:a-1] doubleValue]), round([[ECAR1AccTPD objectAtIndex:a-1] doubleValue]),
								round([[ECAR1AccTPDEOY objectAtIndex:a-1] doubleValue]), round([[RiderDistributionCost objectAtIndex:a-1] doubleValue])];
					
					//NSLog(@"%@", QuerySQL);
					if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
						if (sqlite3_step(statement) == SQLITE_DONE) {
							
						}
						sqlite3_finalize(statement);
					}
					
				}
			}
			sqlite3_close(contactDB);
		}
		NSLog(@"--------- ECAR1 end --------");
	}
	
	int tempToAdd = 0;
	
	if (OverallAddTPDBegin.count < 30) {
		tempToAdd = 30 - OverallAddTPDBegin.count;
		
		for (int i = 0; i < tempToAdd; i ++) {
			[OverallAddTPDBegin addObject:@"0.00"];
			[OverallAddTPDEOY addObject:@"0.00"];
			[OverallYearlyIncome addObject:@"0.00"];
		}
	}
	
	
}

-(double)TPDLimit :(int)aaAgeEOY{
	if (aaAgeEOY <= 6) {
		return 100000.00;
	}
	else if (aaAgeEOY > 6 && aaAgeEOY <= 14) {
		return 500000.00;
	}
	else if (aaAgeEOY > 14 && aaAgeEOY <= 65) {
		return 3500000.00;
	}
	else{
		return 0.00;
	}
}

-(void)InsertToUL_Temp_Summary{
	sqlite3_stmt *statement;
    NSString *QuerySQL;
	
		NSLog(@"--------- UL_Temp_Summary begin --------");
	
		int inputAge;
	

	
		if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
			for (int a= 1; a<=30; a++) {
				if (Age >= 0){
					
					//int tempSustainYear = PolicySustainYear == 0 ? 100 : PolicySustainYear;
					
					inputAge = Age + a;
					
					//if (inputAge <= tempSustainYear) {
						if ([UnitizeRiderCode indexOfObject:@"CIRD"] != NSNotFound) {
							double NewOverallTPDBegin = [[OverallTPDBegin objectAtIndex: a - 1 ] doubleValue ] +
							[[UnitizeRiderSA objectAtIndex:[UnitizeRiderCode indexOfObject:@"CIRD"]] doubleValue ];
							[OverallTPDBegin replaceObjectAtIndex:a - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallTPDBegin]];
							
							double NewOverallTPDEOY = [[OverallTPDEOY objectAtIndex: a - 1 ] doubleValue ] +
							[[UnitizeRiderSA objectAtIndex:[UnitizeRiderCode indexOfObject:@"CIRD"]] doubleValue ];
							[OverallTPDEOY replaceObjectAtIndex:a - 1 withObject:[NSString stringWithFormat:@"%f", NewOverallTPDEOY]];
							
							
							
						}
						
						if (inputAge >= 65) {
							if (inputAge == 65) {
								[OverallOADBegin addObject:@"0.00"];
								[OverallOADEOY addObject:[NSString stringWithFormat:@"%f",[ strBasicSA doubleValue ] > OADLimit ? OADLimit : [strBasicSA doubleValue ]]];
							}
							else{
								[OverallOADBegin addObject:[NSString stringWithFormat:@"%f",[ strBasicSA doubleValue ] > OADLimit ? OADLimit : [strBasicSA doubleValue ]]];
								[OverallOADEOY addObject:[NSString stringWithFormat:@"%f",[ strBasicSA doubleValue ] > OADLimit ? OADLimit : [strBasicSA doubleValue ]]];
							}
							
						}
						else{
							[OverallOADBegin addObject:@"0.00"];
							[OverallOADEOY addObject:@"0.00"];
						}
							
						QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_Summary (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
									"'col3','col4','col5','col6','col7','col8','col9','col10','col11','col12','col13','col14','col15','col16','col17','col18','col19') VALUES ( "
									" \"%@\",\"%d\",\"%@\",\"%d\",\"%d\",\"%.2f\", '%.0f', '%.0f','%.0f', '%.0f', %.0f, '%.0f', '%.0f',\"%.0f\", '%.0f', '%.0f','%.0f', '%.0f', "
									" %.0f, '%.0f', '%.0f','%.0f','%.0f', '%.0f')",
									SINo, a, @"DATA", a, inputAge, [[OverallTotalPremiumPaid objectAtIndex:a - 1] doubleValue],
									round([[OverallTPDBegin objectAtIndex:a - 1] doubleValue ]),round([[OverallTPDEOY objectAtIndex:a - 1] doubleValue ]),
									round([[OverallOADBegin objectAtIndex:a - 1] doubleValue ]), round([[OverallOADEOY objectAtIndex:a - 1] doubleValue ]),
									round([[OverallAddTPDBegin objectAtIndex:a - 1] doubleValue ]), round([[OverallAddTPDEOY objectAtIndex:a - 1] doubleValue ]),
									round([[OverallYearlyIncome objectAtIndex:a - 1] doubleValue ]), round([[OverallMonthlyIncome objectAtIndex:a - 1] doubleValue ]),
									round([[OverallFullSurrenderValue objectAtIndex:a - 1] doubleValue ]),
									round([[OverallTotalFundSurrenderValueBull objectAtIndex:a - 1] doubleValue ]) + round([[OverallFullSurrenderValue objectAtIndex:a - 1] doubleValue ]) ,
									round([[OverallTotalFundSurrenderValueFlat objectAtIndex:a - 1] doubleValue ]) + round([[OverallFullSurrenderValue objectAtIndex:a - 1] doubleValue ]),
									round([[OverallTotalFundSurrenderValueBear objectAtIndex:a - 1] doubleValue ]) + round([[OverallFullSurrenderValue objectAtIndex:a - 1] doubleValue ]),
									round([[OverallEOYTotalTPDBull objectAtIndex:a - 1] doubleValue ]) + round([[OverallTPDEOY objectAtIndex:a - 1] doubleValue ]) ,
									round([[OverallEOYTotalTPDFlat objectAtIndex:a - 1] doubleValue ]) + round([[OverallTPDEOY objectAtIndex:a - 1] doubleValue ]),
									round([[OverallEOYTotalTPDBear objectAtIndex:a - 1] doubleValue ]) + round([[OverallTPDEOY objectAtIndex:a - 1] doubleValue ]),
									round([[OverallEOYTotalOADBull objectAtIndex:a - 1] doubleValue ]) ,
									round([[OverallEOYTotalOADFlat objectAtIndex:a - 1] doubleValue ]),
									round([[OverallEOYTotalOADBear objectAtIndex:a - 1] doubleValue ])];
					/*
					}
					else{
						[OverallAddTPDBegin addObject:@"0"];
						[OverallAddTPDEOY addObject:@"0"];
						[OverallEOYTotalOADBear addObject:@"0"];
						[OverallEOYTotalOADBull addObject:@"0"];
						[OverallEOYTotalOADFlat addObject:@"0"];
						[OverallEOYTotalTPDBear addObject:@"0"];
						[OverallEOYTotalTPDBull addObject:@"0"];
						[OverallEOYTotalTPDFlat addObject:@"0"];
						[OverallFullSurrenderValue addObject:@"0"];
						[OverallMonthlyIncome addObject:@"0"];
						[OverallOADBegin addObject:@"0"];
						[OverallOADEOY addObject:@"0"];
						[OverallTotalFundSurrenderValueBear addObject:@"0"];
						[OverallTotalFundSurrenderValueBull addObject:@"0"];
						[OverallTotalFundSurrenderValueFlat addObject:@"0"];
						[OverallTotalPremiumPaid addObject:@"0"];
						[OverallTPDBegin addObject:@"0"];
						[OverallTPDEOY addObject:@"0"];
						[OverallYearlyIncome addObject:@"0"];

						QuerySQL = [NSString stringWithFormat: @"Insert INTO UL_Temp_Summary (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
									"'col3','col4','col5','col6','col7','col8','col9','col10','col11','col12','col13','col14','col15','col16','col17','col18','col19') VALUES ( "
									" \"%@\",\"%d\",\"%@\",\"%d\",\"%d\",\"-\", \"-\", \"-\",\"-\", '-', '-', '-'', '-','-', '-', '-','-', '-', "
									" '-', '-', '-','-','-', '-')",
									SINo, a, @"DATA", a, inputAge];
					}
					*/
					
					
					
					
					//NSLog(@"%@", QuerySQL);
					if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
						if (sqlite3_step(statement) == SQLITE_DONE) {
							
						}
						sqlite3_finalize(statement);
					}
					
				}
			}
			sqlite3_close(contactDB);
		}
		NSLog(@"--------- UL_Temp_Summary end --------");
	
	
}


-(void)InsertToUL_Temp_Trad_Rider{
    
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    NSMutableArray *TotalRiderSurrenderValue = [[NSMutableArray alloc] init ];
    
    if (OtherRiderCode.count > 0) {
		NSLog(@"insert to UL_Temp_Trad_Rider --- start");
		
        for (int x = 0; x < 30; x++) {
            [TotalRiderSurrenderValue addObject:@"0.00"];
        }
        
        int page;
        
        int NoOfPages = ceil(OtherRiderCode.count/3.00);
        
        for (page =1; page <=NoOfPages; page++) {
            
            NSMutableArray *RiderCol1 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol2 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol3 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol4 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol5 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol6 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol7 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol8 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol9 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol10 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol11 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol12 = [[NSMutableArray alloc] init ];
			NSMutableArray *Rider1DDCost = [[NSMutableArray alloc] init ];
            NSMutableArray *Rider2DDCost = [[NSMutableArray alloc] init ];
            NSMutableArray *Rider3DDCost = [[NSMutableArray alloc] init ];
			
            
            for (int Rider =0; Rider < 3; Rider++) {
                int item = 3 * (page - 1) + Rider;
                
                if (item < OtherRiderCode.count) {
                    
                    NSString *tempRiderCode = [OtherRiderCode objectAtIndex:item];
                    NSString *tempRiderDesc = [OtherRiderDesc objectAtIndex:item];
                    NSString *tempRiderPlanOption = [OtherRiderPlanOption objectAtIndex:item];
                    double tempRiderSA = [[OtherRiderSA objectAtIndex:item] doubleValue ];
                    int tempRiderTerm = [[OtherRiderTerm objectAtIndex:item] intValue ];
                    double tempPremium = [[OtherRiderPremium objectAtIndex:item] doubleValue ];
                    NSMutableArray *tempCol1 = [[NSMutableArray alloc] init ];
                    NSMutableArray *tempCol2 = [[NSMutableArray alloc] init ];	
                    NSMutableArray *tempCol3 = [[NSMutableArray alloc] init ];
                    NSMutableArray *tempCol4 = [[NSMutableArray alloc] init ];
					NSMutableArray *tempCol5 = [[NSMutableArray alloc] init ];
					NSString *tempHL = [OtherRiderHL objectAtIndex:item];
                    NSString *tempHLTerm = [OtherRiderHLTerm objectAtIndex:item];
                    //NSString *tempHLP = [OtherRiderHLP objectAtIndex:item];
					//NSString *tempHLPTerm = [OtherRiderHLPTerm objectAtIndex:item];

					
					NSLog(@"%@, %d", [OtherRiderCode objectAtIndex:item], item);
					
					for (int row = 0; row < 3; row++) {
						
						if (row == 0) {
							[tempCol1 addObject:tempRiderDesc ];
							[tempCol2 addObject:@"" ];
							[tempCol3 addObject:@"" ];
							[tempCol4 addObject:@"" ];
							[tempCol5 addObject:@"" ];
						}
						
						if (row == 1) {
							if ([tempRiderCode isEqualToString:@"CIWP"] || [tempRiderCode isEqualToString:@"TPDWP"] ||
									 [tempRiderCode isEqualToString:@"PR"] || [tempRiderCode isEqualToString:@"LCWP"]) {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"Sum<br/>Assured" ];
								[tempCol3 addObject:@"Cash Surrender Value" ];
								[tempCol4 addObject:@"-" ];
								[tempCol5 addObject:@"-" ];
							}
							else if ([tempRiderCode isEqualToString:@"LSR"] ) {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"Sum Assured" ];
								[tempCol3 addObject:@"Cash Surrender Value" ];
								[tempCol4 addObject:@"-" ];
								[tempCol5 addObject:@"-" ];
							}
							else {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"-" ];
								[tempCol3 addObject:@"-" ];
								[tempCol4 addObject:@"-" ];
								[tempCol5 addObject:@"-" ];
							}
						}
						
						
					}

					double tempTotalRiderSurrenderValue = 0.00;
					NSMutableArray *Rate = [[NSMutableArray alloc] init ];
					NSMutableArray *Comm = [[NSMutableArray alloc] init ];
                
					if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
						QuerySQL = [NSString stringWithFormat:@"Select Rate from ES_Sys_Rider_Commission Where RiderTerm = \"%d\" "
									, tempRiderTerm ];
						if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
							while (sqlite3_step(statement) == SQLITE_ROW) {
								[Comm addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
								
							}
							sqlite3_finalize(statement);
						}
						
						sqlite3_close(contactDB);
					}
					
					if (Comm.count < 30) {
						
						int rowsToAdd = tempRiderTerm - Comm.count;
						for (int u =0; u<rowsToAdd; u++) {
							[Comm addObject:[Comm objectAtIndex:6]];
						}
					}
					
					for (int i = 0; i < 30; i++) {
						
						if (i < tempRiderTerm) {
							
								if ([tempRiderCode isEqualToString:@"CIWP"] || [tempRiderCode isEqualToString:@"TPDWP"] ||
									 [tempRiderCode isEqualToString:@"PR"] || [tempRiderCode isEqualToString:@"LCWP"]) {
								
									if (i == 0) {
										if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
											if ([tempRiderCode isEqualToString:@"CIWP"] || [tempRiderCode isEqualToString:@"TPDWP"]) {
												QuerySQL = [NSString stringWithFormat:@"Select CSV from ES_Sys_Rider_CSV Where plancode = \"%@\" "
															"AND FromAge = \"%d\" AND PolTerm = '%d' AND Sex = '%@'"
															, tempRiderCode, Age, i + 1, sex ];
												
											}
											else{
												if (PYAge > 0) {
													QuerySQL = [NSString stringWithFormat:@"Select CSV from ES_Sys_Rider_CSV Where plancode = \"%@\" "
																"AND FromAge = \"%d\" AND PolTerm = '%d' AND Sex = '%@'"
																, tempRiderCode, PYAge, i + 1, PYSex ];
												}
												else{
													QuerySQL = [NSString stringWithFormat:@"Select CSV from ES_Sys_Rider_CSV Where plancode = \"%@\" "
																"AND FromAge = \"%d\"  AND PolTerm = '%d' AND Sex = '%@'"
																, tempRiderCode, SecAge, i + 1, SecSex ];
												}
												
											}
											
											if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
												while (sqlite3_step(statement) == SQLITE_ROW) {
													[Rate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
													
												}
												sqlite3_finalize(statement);
											}
											
											
											
											
										}
										
										if (Rate.count < 30) {
											
											int rowsToAdd = 30 - Rate.count;
											for (int u =0; u<rowsToAdd; u++) {
												[Rate addObject:@"0.00"];
											}
										}
										
										
									}
									
								double actualPremium = 0.0;
								if([tempHL isEqualToString:@"(null)"] || [tempHL isEqualToString:@"0"] || [tempHL isEqualToString:@""] ) {
									
									actualPremium = tempPremium;
								}
								else{
									if(i + 1 <= [tempHLTerm intValue ] ){
										actualPremium = tempPremium;
									}
									else{
										actualPremium = tempPremium - ((tempRiderSA *  tempRiderSA/100.00)/100.00) * [tempHL doubleValue];
									}
								}
								/*
								if (![tempTempHL isEqualToString:@"(null)"] ) {
									if (i + 1 > [tempTempHLTerm intValue]) {
										actualPremium = actualPremium - ((waiverRiderSA *  tempRiderSA/100)/100) * [tempTempHL doubleValue];
									}
									
								}
								*/
									//NSLog(@"%f", actualPremium);
								[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
								[tempCol2 addObject:[NSString stringWithFormat:@"%.3f", tempRiderSA]];
								[tempCol3 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/100.00 ]];
								[tempCol4 addObject:[NSString stringWithFormat:@"-"]];
								[tempCol5 addObject:[NSString stringWithFormat:@"%.3f", actualPremium * [[Comm objectAtIndex:i] doubleValue ]/100.00]];
								if (i == 1) {
									/*
									[gWaiverAnnual addObject:[NSString stringWithFormat:@"%.9f", waiverRiderSA *  tempRiderSA/100.00] ];
									[gWaiverSemiAnnual addObject:[NSString stringWithFormat:@"%.9f", waiverRiderSASemiAnnual *  tempRiderSA/100.00] ];
									[gWaiverQuarterly addObject:[NSString stringWithFormat:@"%.9f", waiverRiderSAQuarterly *  tempRiderSA/100.00] ];
									[gWaiverMonthly addObject:[NSString stringWithFormat:@"%.9f", waiverRiderSAMonthly *  tempRiderSA/100.00] ];
									*/
								}
								
							}
							
							else if ([tempRiderCode isEqualToString:@"LSR"]) { 
								
								if (i == 0) {
									if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
										QuerySQL = [NSString stringWithFormat:@"Select CSV from ES_Sys_Rider_CSV Where plancode = \"%@\" AND FromAge = \"%d\""
													, tempRiderCode, Age];
										//NSLog(@"%@", QuerySQL);
										if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
											while (sqlite3_step(statement) == SQLITE_ROW) {
												[Rate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
												
											}
											sqlite3_finalize(statement);
										}
										sqlite3_close(contactDB);
									}
									
									if (Rate.count < 30) {
										
										int rowsToAdd = 30 - Rate.count;
										for (int u =0; u<rowsToAdd; u++) {
											[Rate addObject:@"0.00"];
										}
									}
								}
								
								double actualPremium = 0.0;
								if([tempHL isEqualToString:@"(null)"] || [tempHL isEqualToString:@"0"] || [tempHL isEqualToString:@""] ) {
									actualPremium = tempPremium;
								}
								else{
									if(i + 1 <= [tempHLTerm intValue ] ){
										actualPremium = tempPremium;
									}
									else{
										actualPremium = tempPremium - (tempRiderSA/1000.00) * [tempHL doubleValue];
									}
								}
								/*
								if (![tempTempHL isEqualToString:@"(null)"] ) {
									if (i + 1 > [tempTempHLTerm intValue]) {
										actualPremium = actualPremium - (tempRiderSA/1000) * [tempTempHL doubleValue];
									}
									
								}
								*/
								[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
								[tempCol2 addObject:[NSString stringWithFormat:@"%.0f", tempRiderSA]];
								[tempCol3 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
								[tempCol4 addObject:[NSString stringWithFormat:@"-"]];
								[tempCol5 addObject:[NSString stringWithFormat:@"%.3f", actualPremium * [[Comm objectAtIndex:i] doubleValue ]/100.00]];
								
								tempTotalRiderSurrenderValue = [[TotalRiderSurrenderValue objectAtIndex:i] doubleValue ];
								tempTotalRiderSurrenderValue = tempTotalRiderSurrenderValue + [[tempCol2 objectAtIndex:i] doubleValue ];
								[TotalRiderSurrenderValue replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%.3f", tempTotalRiderSurrenderValue]];
								
								double NewOverallTPDBegin = [[OverallTPDBegin objectAtIndex: i ] doubleValue ] + tempRiderSA * [self ReturnJuvenilienFactor:Age];
								[OverallTPDBegin replaceObjectAtIndex:i  withObject:[NSString stringWithFormat:@"%f", NewOverallTPDBegin]];
								
								double NewOverallTPDEOY = [[OverallTPDEOY objectAtIndex: i ] doubleValue ] + tempRiderSA * [self ReturnJuvenilienFactor:Age];
								[OverallTPDEOY replaceObjectAtIndex:i  withObject:[NSString stringWithFormat:@"%f", NewOverallTPDEOY]];
							}
							else {
								//no more rider 
							}
						}
						else {
							if ([tempRiderCode isEqualToString:@"CIWP"] || [tempRiderCode isEqualToString:@"TPDWP"] ||
									 [tempRiderCode isEqualToString:@"PR"] || [tempRiderCode isEqualToString:@"LCWP"]) {
								
								//[tempCol1 addObject:[NSString stringWithFormat:@"0.00", tempPremium]];
								[tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
								[tempCol2 addObject:[NSString stringWithFormat:@"0"]];
								[tempCol3 addObject:[NSString stringWithFormat:@"0"]];
								[tempCol4 addObject:[NSString stringWithFormat:@"-"]];
								[tempCol5 addObject:[NSString stringWithFormat:@"0.00"]];
							}
							
							else if ([tempRiderCode isEqualToString:@"LSR"]) {
								
								[tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
								[tempCol2 addObject:[NSString stringWithFormat:@"0"] ];
								[tempCol3 addObject:[NSString stringWithFormat:@"0"]];
								[tempCol4 addObject:[NSString stringWithFormat:@"-"]];
								[tempCol5 addObject:[NSString stringWithFormat:@"0.00"]];
							}
							else {
								[tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
								[tempCol2 addObject:[NSString stringWithFormat:@"-"]];
								[tempCol3 addObject:[NSString stringWithFormat:@"-"]];
								[tempCol4 addObject:[NSString stringWithFormat:@"-"]];
								[tempCol5 addObject:[NSString stringWithFormat:@"0.00"]];
							}
							
						}
						
						//EntireTotalPremiumPaid = EntireTotalPremiumPaid + [[tempCol1 objectAtIndex:i + 3] doubleValue ]; //i +3 to skip the first 3 items
						
					}
                    
                    
					if (Rider == 0){
						for (int p =0; p < 32; p++) {
							[RiderCol1 addObject:[tempCol1 objectAtIndex:p]];
							[RiderCol2 addObject:[tempCol2 objectAtIndex:p]];
							[RiderCol3 addObject:[tempCol3 objectAtIndex:p]];
							[RiderCol4 addObject:[tempCol4 objectAtIndex:p]];
							[Rider1DDCost addObject:[tempCol5 objectAtIndex:p]];
							
							if (p >= 2) {
								double NewOverallTotalPremiumPaid = [[OverallTotalPremiumPaid objectAtIndex:p - 2 ] doubleValue ] +
								[[tempCol1 objectAtIndex:p] doubleValue ];
								[OverallTotalPremiumPaid replaceObjectAtIndex:p - 2 withObject:[NSString stringWithFormat:@"%f", NewOverallTotalPremiumPaid]];
								
								double NewOverallFullSurrenderValue = [[OverallFullSurrenderValue objectAtIndex:p - 2 ] doubleValue ] +
								[[tempCol3 objectAtIndex:p] doubleValue ];
								[OverallFullSurrenderValue replaceObjectAtIndex:p - 2 withObject:[NSString stringWithFormat:@"%f", NewOverallFullSurrenderValue]];
							}
							
							 
						}
					}
					else if (Rider == 1){
						for (int p =0; p < 32; p++) {
							[RiderCol5 addObject:[tempCol1 objectAtIndex:p]];
							[RiderCol6 addObject:[tempCol2 objectAtIndex:p]];
							[RiderCol7 addObject:[tempCol3 objectAtIndex:p]];
							[RiderCol8 addObject:[tempCol4 objectAtIndex:p]];
							[Rider2DDCost addObject:[tempCol5 objectAtIndex:p]];
								
							if (p >= 2) {
								double NewOverallTotalPremiumPaid = [[OverallTotalPremiumPaid objectAtIndex:p - 2] doubleValue ] +
								[[tempCol1 objectAtIndex:p] doubleValue ];
								[OverallTotalPremiumPaid replaceObjectAtIndex:p - 2 withObject:[NSString stringWithFormat:@"%f", NewOverallTotalPremiumPaid]];
								
								double NewOverallFullSurrenderValue = [[OverallFullSurrenderValue objectAtIndex:p - 2 ] doubleValue ] +
								[[tempCol3 objectAtIndex:p] doubleValue ];
								[OverallFullSurrenderValue replaceObjectAtIndex:p - 2 withObject:[NSString stringWithFormat:@"%f", NewOverallFullSurrenderValue]];
							}
							
							 
						}
					}
					else if (Rider == 2){
						for (int p =0; p < 32; p++) {
							[RiderCol9 addObject:[tempCol1 objectAtIndex:p]];
							[RiderCol10 addObject:[tempCol2 objectAtIndex:p]];
							[RiderCol11 addObject:[tempCol3 objectAtIndex:p]];
							[RiderCol12 addObject:[tempCol4 objectAtIndex:p]];
							[Rider3DDCost addObject:[tempCol5 objectAtIndex:p]];

							if (p >= 2) {
								double NewOverallTotalPremiumPaid = [[OverallTotalPremiumPaid objectAtIndex:p - 2 ] doubleValue ] +
								[[tempCol1 objectAtIndex:p] doubleValue ];
								[OverallTotalPremiumPaid replaceObjectAtIndex:p - 2 withObject:[NSString stringWithFormat:@"%f", NewOverallTotalPremiumPaid]];
								
								double NewOverallFullSurrenderValue = [[OverallFullSurrenderValue objectAtIndex:p - 2 ] doubleValue ] +
								[[tempCol3 objectAtIndex:p] doubleValue ];
								[OverallFullSurrenderValue replaceObjectAtIndex:p - 2 withObject:[NSString stringWithFormat:@"%f", NewOverallFullSurrenderValue]];
							}
							
							 
						}
					}
					
					
                    
                    Rate = Nil;
                    tempRiderCode = Nil;
                    tempRiderDesc = Nil;
                    tempRiderPlanOption = Nil;
                    tempCol1 = Nil;
                    tempCol2 = Nil;
                    tempCol3 = Nil;
                    tempCol4 = Nil;
                    
                }
                else {
                    if (Rider == 1) {
                        for (int row = 0; row < 30 + 2; row++){
                            [RiderCol5 addObject:@"-"];
                            [RiderCol6 addObject:@"-"];
                            [RiderCol7 addObject:@"-"];
                            [RiderCol8 addObject:@"-"];
							[Rider2DDCost addObject:@"0.00"];
                        }
                    }
                    if (Rider == 2) {
                        for (int row = 0; row < 30 + 2; row++){
                            [RiderCol9 addObject:@"-"];
                            [RiderCol10 addObject:@"-"];
                            [RiderCol11 addObject:@"-"];
                            [RiderCol12 addObject:@"-"];
							[Rider3DDCost addObject:@"0.00"];
                        }
                    }
                }
                
                
            }
            
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
                QuerySQL = [NSString stringWithFormat:@"Insert INTO UL_Temp_Trad_Rider(\"SINO\", \"SeqNo\", \"DataType\", \"PageNo\",\"col0_1\",\"col0_2\", "
                            " \"col1\",\"col2\",\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\",\"col13\" ) VALUES ("
                            " \"%@\", \"%d\", \"TITLE\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" "
                            " , \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" )", SINo, -2, page, @"", @"", [RiderCol1 objectAtIndex:0],[RiderCol2 objectAtIndex:0],
                            [RiderCol3 objectAtIndex:0],[RiderCol4 objectAtIndex:0],[RiderCol5 objectAtIndex:0],[RiderCol6 objectAtIndex:0],
                            [RiderCol7 objectAtIndex:0],[RiderCol8 objectAtIndex:0],[RiderCol9 objectAtIndex:0],[RiderCol10 objectAtIndex:0],
                            [RiderCol11 objectAtIndex:0],[RiderCol12 objectAtIndex:0], @"-"];
                
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
						
                    }
                    sqlite3_finalize(statement);
                }
                
                QuerySQL = [NSString stringWithFormat:@"Insert INTO UL_Temp_Trad_Rider(\"SINO\", \"SeqNo\", \"DataType\", \"PageNo\",\"col0_1\",\"col0_2\", "
                            " \"col1\",\"col2\",\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\",\"col13\" ) VALUES ("
                            " \"%@\", \"%d\", \"HEADER\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" "
                            " , \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\" )", SINo, -1, page, @"Policy Year", @"Life Ass'd Age at the end of Year",
                            [RiderCol1 objectAtIndex:1],[RiderCol2 objectAtIndex:1],
                            [RiderCol3 objectAtIndex:1],[RiderCol4 objectAtIndex:1],[RiderCol5 objectAtIndex:1],[RiderCol6 objectAtIndex:1],
                            [RiderCol7 objectAtIndex:1],[RiderCol8 objectAtIndex:1],[RiderCol9 objectAtIndex:1],[RiderCol10 objectAtIndex:1],
                            [RiderCol11 objectAtIndex:1],[RiderCol12 objectAtIndex:1], @"-"];
                
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                sqlite3_close(contactDB);
            }
            
			//NSLog(@"%d %d %d", Rider1DDCost.count, Rider2DDCost.count, Rider3DDCost.count);
            
            for (int j=1; j <= 30; j++) {
                
                if (j <= 30) {
					int currentAge = Age + j;
                    
                    NSString *strSeqNo = @"";
                    if (j < 10) {
                        strSeqNo = [NSString stringWithFormat:@"0%d", j];
                    }
                    else {
                        strSeqNo = [NSString stringWithFormat:@"%d", j];
                    }
                    
                    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
						
						NSString *value1 = [[RiderCol1 objectAtIndex:j + 1] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.2f", [[RiderCol1 objectAtIndex:j + 1] doubleValue ]];
						NSString *value2 = [[RiderCol2 objectAtIndex:j + 1] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol2 objectAtIndex:j + 1] doubleValue ])];
						NSString *value3 = [[RiderCol3 objectAtIndex:j + 1] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol3 objectAtIndex:j + 1] doubleValue ])];
						NSString *value4 = [[RiderCol4 objectAtIndex:j + 1] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol4 objectAtIndex:j + 1] doubleValue ])];
						NSString *value5 = [[RiderCol5 objectAtIndex:j + 1] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.2f", [[RiderCol5 objectAtIndex:j + 1] doubleValue ]];
						NSString *value6 = [[RiderCol6 objectAtIndex:j + 1] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol6 objectAtIndex:j + 1] doubleValue ])];
						NSString *value7 = [[RiderCol7 objectAtIndex:j + 1] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol7 objectAtIndex:j + 1] doubleValue ])];
						NSString *value8 = [[RiderCol8 objectAtIndex:j + 1] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol8 objectAtIndex:j + 1] doubleValue ])];
						NSString *value9 = [[RiderCol9 objectAtIndex:j + 1] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.2f", [[RiderCol9 objectAtIndex:j + 1] doubleValue ]];
						NSString *value10 = [[RiderCol10 objectAtIndex:j + 1] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol10 objectAtIndex:j + 1] doubleValue ])];
						NSString *value11 = [[RiderCol11 objectAtIndex:j + 1] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol11 objectAtIndex:j + 1] doubleValue ])];
						NSString *value12 = [[RiderCol12 objectAtIndex:j + 1] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol12 objectAtIndex:j + 1] doubleValue ])];
						
						double TotalDDCost = [[Rider1DDCost objectAtIndex:j + 1] doubleValue ] + [[Rider2DDCost objectAtIndex:j + 1] doubleValue ] + [[Rider3DDCost objectAtIndex:j + 1] doubleValue ];
						
						QuerySQL = [NSString stringWithFormat:@"Insert INTO UL_Temp_Trad_Rider(\"SINO\", \"SeqNo\", \"DataType\", \"PageNo\",\"col0_1\",\"col0_2\", "
									" \"col1\",\"col2\",\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\",\"col13\" ) VALUES ("
									" \"%@\", \"%@\", \"DATA\", \"%d\", \"%d\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" "
									" , \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", '%.0f' )", SINo, strSeqNo , page, j, currentAge, value1,value2,
									value3,value4,value5,value6,value7, value8, value9, value10, value11, value12, round(TotalDDCost)];
						
						
						if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
							if (sqlite3_step(statement) == SQLITE_DONE) {
								
							}
							sqlite3_finalize(statement);
						}
						
                        value1 = Nil;
                        value2 = Nil;
                        value3 = Nil;
                        value4 = Nil;
                        value5 = Nil;
                        value6 = Nil;
                        value7 = Nil;
                        value8 = Nil;
                        value9 = Nil;
                        value10 = Nil;
                        value11 = Nil;
                        value12 = Nil;
                        
						sqlite3_close(contactDB);
					}
					strSeqNo = Nil;
                }
            }
			
			
            RiderCol1 = Nil;
            RiderCol2 = Nil;
            RiderCol3 = Nil;
            RiderCol4 = Nil;
            RiderCol5 = Nil;
            RiderCol6 = Nil;
            RiderCol7 = Nil;
            RiderCol8 = Nil;
            RiderCol9 = Nil;
            RiderCol10 = Nil;
            RiderCol11 = Nil;
            RiderCol12 = Nil;
            
        }
        /*
		if ([PDSorSI isEqualToString:@"SI"]) {
			for (int v= 0; v < PolicyTerm; v ++) {
				double tempA;
				double tempB;
				tempA = [[SummaryNonGuaranteedSurrenderValueA objectAtIndex:v] doubleValue ];
				tempA = tempA + [[TotalRiderSurrenderValue objectAtIndex:v] doubleValue ];
				[SummaryNonGuaranteedSurrenderValueA replaceObjectAtIndex:v withObject: [NSString stringWithFormat:@"%.3f", tempA]];
				
				tempB = [[SummaryNonGuaranteedSurrenderValueB objectAtIndex:v] doubleValue ];
				tempB = tempB + [[TotalRiderSurrenderValue objectAtIndex:v] doubleValue ];
				[SummaryNonGuaranteedSurrenderValueB replaceObjectAtIndex:v withObject: [NSString stringWithFormat:@"%.3f", tempB]];
				
				if (v  == PolicyTerm - 1) {
					// EntireMaturityValueA = EntireMaturityValueA + [[SummaryNonGuaranteedSurrenderValueA objectAtIndex:v] doubleValue ];
					// EntireMaturityValueB = EntireMaturityValueB + [[SummaryNonGuaranteedSurrenderValueB objectAtIndex:v] doubleValue ];
				}
				
			}
		}
        */
		NSLog(@"insert to UL_Temp_Trad_Rider --- End");
    }
    
    
    statement = Nil;
    QuerySQL = Nil;
    TotalRiderSurrenderValue = Nil;
	
}


-(void)GetRTUPData{
	sqlite3_stmt *statement;
	NSString *querySQL;
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		querySQL = [NSString stringWithFormat:@"SELECT FromYear, ForYear, Amount WHERE SINo=\"%@\"",SINo];
		
		if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			if (sqlite3_step(statement) == SQLITE_ROW) {
				strRTUPFrom = [NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 0) - 1];
				strRTUPFor = [NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 1) + 1];
				strRTUPAmount = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
			}
			else{
				strRTUPFrom = @"";
				strRTUPFor = @"";
				strRTUPAmount = @"";
			}
			
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
}

-(void)PopulateData{
	sqlite3_stmt *statement;
	NSString *querySQL;
	
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
	
		
	querySQL = [NSString stringWithFormat:@"SELECT fund, option, partial_withd_pct, EverGreen2025, EverGreen2028, "
				"EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund FROM UL_fund_maturity_option WHERE SINo=\"%@\"",SINo];
	
	Fund2023PartialReinvest = 100.00; //means fully withdraw
	Fund2025PartialReinvest = 100.00;
	Fund2028PartialReinvest = 100.00;
	Fund2030PartialReinvest = 100.00;
	Fund2035PartialReinvest = 100.00;
	//NSLog(@"%@", querySQL);
	if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{
		while (sqlite3_step(statement) == SQLITE_ROW)
		{
			if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2023"]) {
				if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"ReInvest"]) {
					Fund2023PartialReinvest = 0;
					Fund2023ReinvestTo2025Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)] doubleValue ] ;
					Fund2023ReinvestTo2028Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)] doubleValue ] ;
					Fund2023ReinvestTo2030Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] doubleValue ] ;
					Fund2023ReinvestTo2035Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
					Fund2023ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
					Fund2023ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					Fund2023ReinvestToDanaFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)] doubleValue ] ;
				}
				else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"Partial"]) {
					Fund2023PartialReinvest = 100 - [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] doubleValue ] ;
					Fund2023ReinvestTo2025Fac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)] doubleValue ] ;
					Fund2023ReinvestTo2028Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)] doubleValue ] ;
					Fund2023ReinvestTo2030Fac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] doubleValue ] ;
					Fund2023ReinvestTo2035Fac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
					Fund2023ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
					Fund2023ReinvestToRetFac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					Fund2023ReinvestToDanaFac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)] doubleValue ] ;
				}
				else{
					Fund2023PartialReinvest = 100;
				}
			}
			else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2025"]) {
				if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"ReInvest"]) {
					Fund2025PartialReinvest = 0;
					Fund2025ReinvestTo2028Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)] doubleValue ] ;
					Fund2025ReinvestTo2030Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] doubleValue ] ;
					Fund2025ReinvestTo2035Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
					Fund2025ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
					Fund2025ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					Fund2025ReinvestToDanaFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)] doubleValue ] ;
				}
				else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"Partial"]) {
					Fund2025PartialReinvest = 100 -  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] doubleValue ] ;
					Fund2025ReinvestTo2028Fac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)] doubleValue ] ;
					Fund2025ReinvestTo2030Fac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] doubleValue ] ;
					Fund2025ReinvestTo2035Fac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
					Fund2025ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
					Fund2025ReinvestToRetFac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					Fund2025ReinvestToDanaFac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)] doubleValue ] ;
				}
				else{
					Fund2025PartialReinvest = 100;
				}
			}
			else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2028"]) {
				if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"ReInvest"]) {
					Fund2028PartialReinvest = 0;
					Fund2028ReinvestTo2030Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] doubleValue ] ;
					Fund2028ReinvestTo2035Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
					Fund2028ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
					Fund2028ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					Fund2028ReinvestToDanaFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)] doubleValue ] ;
				}
				else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"Partial"]) {
					Fund2028PartialReinvest = 100 - [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] doubleValue ] ;
					Fund2028ReinvestTo2030Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] doubleValue ] ;
					Fund2028ReinvestTo2035Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
					Fund2028ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
					Fund2028ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					Fund2028ReinvestToDanaFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)] doubleValue ] ;
				}
				else{
					Fund2028PartialReinvest = 100;
				}
			}
			else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2030"]) {
				if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"ReInvest"]) {
					Fund2030PartialReinvest = 0;
					Fund2030ReinvestTo2035Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
					Fund2030ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
					Fund2030ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					Fund2030ReinvestToDanaFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)] doubleValue ] ;
				}
				else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"Partial"]) {
					Fund2030PartialReinvest = 100 -  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] doubleValue ] ;
					Fund2030ReinvestTo2035Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
					Fund2030ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
					Fund2030ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					Fund2030ReinvestToDanaFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)] doubleValue ] ;
				}
				else{
					Fund2030PartialReinvest = 100;
				}
			}
			else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2035"]) {
				if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"ReInvest"]) {
					Fund2035PartialReinvest = 0;
					Fund2035ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
					Fund2035ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					Fund2035ReinvestToDanaFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)] doubleValue ] ;
				}
				else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"Partial"]) {
					Fund2035PartialReinvest =  100 - [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] doubleValue ] ;
					Fund2035ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
					Fund2035ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					Fund2035ReinvestToDanaFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)] doubleValue ] ;
				}
				else{
					Fund2035PartialReinvest = 100;
				}
			}
			
		}
		sqlite3_finalize(statement);
	}
	
	
	sqlite3_close(contactDB);
}
}

-(double)CalculateBUMP{
	double FirstBasicMort = [self ReturnBasicMort:Age]/1000.00;
	double FirstSA = BasicSA;
	double SecondBasicMort = [self ReturnBasicMort:Age + 1]/1000.00;
	double SecondSA = 0;
	double ThirdBasicMort = [self ReturnBasicMort:Age + 2]/1000.00;
	double BUMP1;
	double BUMP2;
	
	//NSLog(@"%f, %f, %f", FirstBasicMort, SecondBasicMort, ThirdBasicMort);
	
	//[self getExistingBasic]; //disable as it will change getbumpmode
	[self CalcInst:@""];
	[self GetRegWithdrawal];
	[self ReturnFundFactor]; // get factor for each fund
	[self CalcYearDiff]; //get the yearDiff
	//[self SurrenderValue:2 andMonth:0 andLevel:0];
	SecondSA = BasicSA - HSurrenderValue;
	//NSLog(@"dasdas %f", HSurrenderValue);
	if ([getHL isEqualToString:@""] || [getHL isEqualToString:@"(null)"]) {
		getHL = @"0";
	}
	
	if ([getHLPct isEqualToString:@""] || [getHLPct isEqualToString:@"(null)"]) {
		getHLPct= @"0";
	}
	
	if ([getOccLoading isEqualToString:@"STD"]) {
		getOccLoading = @"0";
	}
	
	double MortDate = [self GetMortDate ];
	
	double ModeRate = [self ReturnModeRate:strBumpMode];
	double divideMode = [self ReturnDivideMode];
	double PremAllocation = [self ReturnPremAllocation_V:1];
	double ExcessPrem =  [self ReturnExcessPrem:1];
	
		//NSLog(@" %f,%f,%f,%f, %f", MortDate, ModeRate, divideMode, PremAllocation, ExcessPrem);
	double FirstBasicSA =  (FirstSA * ((FirstBasicMort * MortDate + SecondBasicMort * (12 - MortDate))/12.00 * (1 + [getHLPct intValue]/100.00 ) +
									   ([getHL doubleValue] /1000.00) + ([getOccLoading doubleValue ]/1000.00)));
	
	double SecondBasicSA =  (SecondSA * ((SecondBasicMort * MortDate + ThirdBasicMort * (12 - MortDate))/12.00 * (1 + [getHLPct intValue]/100.00 ) +
										 ([getHL doubleValue] /1000.00) + ([getOccLoading doubleValue ]/1000.00)));
	
	//NSLog(@"%f %f ", FirstBasicSA, SecondBasicSA);
	
	BUMP1 = (ModeRate * (PremAllocation * ([strBasicPremium_Bump doubleValue ] * divideMode) +
						 (0.95 * (ExcessPrem + [strGrayRTUPAmount doubleValue ]))) -
			 (((PolicyFee * 12) + FirstBasicSA + 0) * 12.5/12.00))/divideMode;
	
	BUMP2 = (ModeRate * ([self ReturnPremAllocation:2] * ([strBasicPremium_Bump doubleValue ] * divideMode) +
						 (0.95 * ([self ReturnExcessPrem:2] + [strGrayRTUPAmount doubleValue ]))) -
			 (((PolicyFee * 12) + SecondBasicSA + 0) * 12.5/12.00))/divideMode;
	
	/*
	if (BUMP1 < 0.00) {
		
		PremReq = ((((0.01 * divideMode) + (((PolicyFee * 12) + FirstBasicSA + 0) * 12.5/12.00))/ModeRate -
					(0.95 * (ExcessPrem + [strRTUPAmount doubleValue ])))/PremAllocation)/divideMode;
		 
		
	}
	*/
	NSLog(@"bump1 = %f, bump2 = %f", BUMP1, BUMP2);
	NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
	[format setNumberStyle:NSNumberFormatterDecimalStyle];
	[format setRoundingMode:NSNumberFormatterRoundHalfUp];
	[format setMaximumFractionDigits:2];
	[self ResetData];
	
	/*
	for (int i =1; i <= 30 ; i++) {
		
		VUCashValueNegative = false;
		if (i == YearDiff2023 || i == YearDiff2025 || i == YearDiff2028 || i == YearDiff2030 || i == YearDiff2035) {
			for (int m = 1; m <= 12; m++) {
				
				MonthFundValueOfTheYearValueTotalHigh = [self ReturnMonthFundValueOfTheYearValueTotalHigh:i andMonth:m];
				//NSLog(@"%d %f %f %f", m, MonthVURetValueHigh, MonthVU2035ValueHigh, MonthFundValueOfTheYearValueTotalHigh );
				[self SurrenderValue:i andMonth:m andLevel:1];
				
				
				MonthFundValueOfTheYearValueTotalMedian = [self ReturnMonthFundValueOfTheYearValueTotalMedian:i andMonth:m];
				[self SurrenderValue:i andMonth:m andLevel:2];
				
				
				MonthFundValueOfTheYearValueTotalLow = [self ReturnMonthFundValueOfTheYearValueTotalLow:i andMonth:m];
				//NSLog(@"%d %f %f %f", m, MonthVURetValueLow, MonthVU2035ValueLow, MonthFundValueOfTheYearValueTotalLow );
				[self SurrenderValue:i andMonth:m andLevel:3];
				
			}
			
		}
		else{
			VUCashValueNegative = false;
			FundValueOfTheYearValueTotalHigh = [self ReturnFundValueOfTheYearValueTotalHigh:i];
			FundValueOfTheYearValueTotalMedian = [self ReturnFundValueOfTheYearValueTotalMedian:i];
			FundValueOfTheYearValueTotalLow = [self ReturnFundValueOfTheYearValueTotalLow:i];
			[self SurrenderValue:i andMonth:0 andLevel:0];
		}
		
		
		
		NSLog(@"%d) %f, %f, %f",i, HSurrenderValue, MSurrenderValue, LSurrenderValue );
		NSLog(@"%d) %f,%f,%f,%f,%f,%f,%f", i, VUCashValueHigh,VURetValueHigh,VU2023ValueHigh, VU2025ValueHigh,VU2028ValueHigh, VU2030ValueHigh, VU2035ValueHigh);
		//NSLog(@"%d) %f,%f,%f,%f,%f,%f,%f", i, VUCashValueLow,VURetValueLow,VU2023ValueLow, VU2025ValueLow,VU2028ValueLow, VU2030ValueLow, VU2035ValueLow);
		
	}
	*/
	/*
	if (BUMP1 > BUMP2) {
		return [[NSString stringWithFormat:@"%@", [format stringFromNumber:[NSNumber numberWithFloat:BUMP2]]] doubleValue ];
	}
	else{
		//return [[NSString stringWithFormat:@"%.2f", BUMP1] doubleValue ];
		return [[NSString stringWithFormat:@"%@", [format stringFromNumber:[NSNumber numberWithFloat:BUMP1]]] doubleValue ];
	}
	*/
	return [[NSString stringWithFormat:@"%@", [format stringFromNumber:[NSNumber numberWithFloat:BUMP1]]] doubleValue ];
	
}

-(void)ResetData{
	VUCashPrevValueHigh =0;
	VURetPrevValueHigh  =0;
	VUDanaPrevValueHigh  =0;
	VU2023PrevValuehigh = 0;
	VU2025PrevValuehigh =0;
	VU2028PrevValuehigh =0;
	VU2030PrevValuehigh = 0;
	VU2035PrevValuehigh = 0;
	RiderVUCashPrevValueHigh =0;
	RiderVURetPrevValueHigh  =0;
	RiderVUDanaPrevValueHigh  =0;
	RiderVU2023PrevValuehigh = 0;
	RiderVU2025PrevValuehigh =0;
	RiderVU2028PrevValuehigh =0;
	RiderVU2030PrevValuehigh = 0;
	RiderVU2035PrevValuehigh = 0;

	
	VUCashPrevValueMedian =0;
	VURetPrevValueMedian  =0;
	VUDanaPrevValueMedian  =0;
	VU2023PrevValueMedian = 0;
	VU2025PrevValueMedian =0;
	VU2028PrevValueMedian =0;
	VU2030PrevValueMedian = 0;
	VU2035PrevValueMedian = 0;
	RiderVUCashPrevValueMedian =0;
	RiderVURetPrevValueMedian  =0;
	RiderVUDanaPrevValueMedian  =0;
	RiderVU2023PrevValueMedian = 0;
	RiderVU2025PrevValueMedian =0;
	RiderVU2028PrevValueMedian =0;
	RiderVU2030PrevValueMedian = 0;
	RiderVU2035PrevValueMedian = 0;
	
	VUCashPrevValueLow =0;
	VURetPrevValueLow  =0;
	VUDanaPrevValueLow  =0;
	VU2023PrevValueLow = 0;
	VU2025PrevValueLow =0;
	VU2028PrevValueLow =0;
	VU2030PrevValueLow = 0;
	VU2035PrevValueLow = 0;
	RiderVUCashPrevValueLow =0;
	RiderVURetPrevValueLow  =0;
	RiderVUDanaPrevValueLow  =0;
	RiderVU2023PrevValueLow = 0;
	RiderVU2025PrevValueLow =0;
	RiderVU2028PrevValueLow =0;
	RiderVU2030PrevValueLow = 0;
	RiderVU2035PrevValueLow = 0;
	
	MonthVUCashPrevValueHigh =0;
	MonthVURetPrevValueHigh  =0;
	MonthVUDanaPrevValueHigh  =0;
	MonthVU2023PrevValuehigh = 0;
	MonthVU2025PrevValuehigh =0;
	MonthVU2028PrevValuehigh =0;
	MonthVU2030PrevValuehigh = 0;
	MonthVU2035PrevValuehigh = 0;
	RiderMonthVUCashPrevValueHigh =0;
	RiderMonthVURetPrevValueHigh  =0;
	RiderMonthVUDanaPrevValueHigh  =0;
	RiderMonthVU2023PrevValuehigh = 0;
	RiderMonthVU2025PrevValuehigh =0;
	RiderMonthVU2028PrevValuehigh =0;
	RiderMonthVU2030PrevValuehigh = 0;
	RiderMonthVU2035PrevValuehigh = 0;
	
	MonthVUCashPrevValueMedian =0;
	MonthVURetPrevValueMedian  =0;
	MonthVUDanaPrevValueMedian  =0;
	MonthVU2023PrevValueMedian = 0;
	MonthVU2025PrevValueMedian =0;
	MonthVU2028PrevValueMedian =0;
	MonthVU2030PrevValueMedian = 0;
	MonthVU2035PrevValueMedian = 0;
	RiderMonthVUCashPrevValueMedian =0;
	RiderMonthVURetPrevValueMedian  =0;
	RiderMonthVUDanaPrevValueMedian  =0;
	RiderMonthVU2023PrevValueMedian = 0;
	RiderMonthVU2025PrevValueMedian =0;
	RiderMonthVU2028PrevValueMedian =0;
	RiderMonthVU2030PrevValueMedian = 0;
	RiderMonthVU2035PrevValueMedian = 0;
	
	MonthVUCashPrevValueLow =0;
	MonthVURetPrevValueLow  =0;
	MonthVUDanaPrevValueLow  =0;
	MonthVU2023PrevValueLow = 0;
	MonthVU2025PrevValueLow =0;
	MonthVU2028PrevValueLow =0;
	MonthVU2030PrevValueLow = 0;
	MonthVU2035PrevValueLow = 0;
	RiderMonthVUCashPrevValueLow =0;
	RiderMonthVURetPrevValueLow  =0;
	RiderMonthVUDanaPrevValueLow  =0;
	RiderMonthVU2023PrevValueLow = 0;
	RiderMonthVU2025PrevValueLow =0;
	RiderMonthVU2028PrevValueLow =0;
	RiderMonthVU2030PrevValueLow = 0;
	RiderMonthVU2035PrevValueLow = 0;
	
	temp2023High = 0;
	temp2023Median= 0;
	temp2023Low = 0;
	temp2025High = 0;
	temp2025Median = 0;
	temp2025Low = 0;
	temp2028High = 0;
	temp2028Median = 0;
	temp2028Low = 0;
	temp2030High = 0;
	temp2030Median = 0;
	temp2030Low = 0;
	temp2035High = 0;
	temp2035Median = 0;
	temp2035Low = 0;
	Ridertemp2023High = 0;
	Ridertemp2023Median= 0;
	Ridertemp2023Low = 0;
	Ridertemp2025High = 0;
	Ridertemp2025Median = 0;
	Ridertemp2025Low = 0;
	Ridertemp2028High = 0;
	Ridertemp2028Median = 0;
	Ridertemp2028Low = 0;
	Ridertemp2030High = 0;
	Ridertemp2030Median = 0;
	Ridertemp2030Low = 0;
	Ridertemp2035High = 0;
	Ridertemp2035Median = 0;
	Ridertemp2035Low = 0;
}

#pragma mark - Surrender Value Calculation for basic
-(void)SurrenderValue :(int)aaPolicyYear andMonth:(int)aaMonth andLevel:(int)aaLevel{
	if (aaPolicyYear == YearDiff2023 || aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2028 || aaPolicyYear == YearDiff2030 ||
		aaPolicyYear == YearDiff2035) {
		//month
		if (aaLevel == 1) {
			HSurrenderValue = [self ReturnHSurrenderValue:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth ];
			
		}
		else if (aaLevel == 2){
			MSurrenderValue = [self ReturnMSurrenderValue:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth ];
			
		}
		else if (aaLevel == 3){
			LSurrenderValue = [self ReturnLSurrenderValue:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth ];
			
		}
		else{
			
		}
		
		if (aaLevel == 1) {
			HRiderSurrenderValue = [self ReturnRiderHSurrenderValue:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth ];;
		}
		else if (aaLevel == 2){
			MRiderSurrenderValue = [self ReturnRiderMSurrenderValue:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth ];
		}
		else if (aaLevel == 3){
			LRiderSurrenderValue = [self ReturnRiderLSurrenderValue:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth ];
		}
		
		
	} else {
		//year
		HSurrenderValue = [self ReturnHSurrenderValue:aaPolicyYear andYearOrMonth:@"Y" andMonth:0 ];
		MSurrenderValue = [self ReturnMSurrenderValue:aaPolicyYear andYearOrMonth:@"Y" andMonth:0 ];
		LSurrenderValue = [self ReturnLSurrenderValue:aaPolicyYear andYearOrMonth:@"Y" andMonth:0 ];
		HRiderSurrenderValue = [self ReturnRiderHSurrenderValue:aaPolicyYear andYearOrMonth:@"Y" andMonth:0 ];
		MRiderSurrenderValue = [self ReturnRiderMSurrenderValue:aaPolicyYear andYearOrMonth:@"Y" andMonth:0 ];
		LRiderSurrenderValue = [self ReturnRiderLSurrenderValue:aaPolicyYear andYearOrMonth:@"Y" andMonth:0 ];
	}
	/*
	 if (aaPolicyYear == YearDiff2035) {
	 //HSurrenderValue = HSurrenderValue - MonthFundMaturityValue2035_Bull;
	 MSurrenderValue = MSurrenderValue - MonthFundMaturityValue2035_Flat;
	 }
	 else if (aaPolicyYear == YearDiff2030){
	 HSurrenderValue = HSurrenderValue - MonthFundMaturityValue2030_Bull;
	 MSurrenderValue = MSurrenderValue - MonthFundMaturityValue2030_Flat;
	 }
	 else if (aaPolicyYear == YearDiff2028){
	 HSurrenderValue = HSurrenderValue - MonthFundMaturityValue2028_Bull;
	 MSurrenderValue = MSurrenderValue - MonthFundMaturityValue2028_Flat;
	 }
	 else if (aaPolicyYear == YearDiff2025){
	 HSurrenderValue = HSurrenderValue - MonthFundMaturityValue2025_Bull;
	 MSurrenderValue = MSurrenderValue - MonthFundMaturityValue2025_Flat;
	 }
	 else if (aaPolicyYear == YearDiff2023){
	 HSurrenderValue = HSurrenderValue - MonthFundMaturityValue2023_Bull;
	 MSurrenderValue = MSurrenderValue - MonthFundMaturityValue2023_Flat;
	 }
	 else{
	 HSurrenderValue = HSurrenderValue - 0;
	 MSurrenderValue = MSurrenderValue - 0;
	 }
	 */
	
	
}

-(double)ReturnHSurrenderValue :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth {
	//NSLog(@"%f", [self ReturnVUCashValueHigh:aaPolicyYear]);
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		
		VUCashValueHigh = [self ReturnVUCashValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:aaMonth];
		VURetValueHigh = [self ReturnVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VUDanaValueHigh = [self ReturnVUDanaValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2023ValueHigh = [self ReturnVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2025ValueHigh = [self ReturnVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2028ValueHigh = [self ReturnVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2030ValueHigh = [self ReturnVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2035ValueHigh = [self ReturnVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		
		
		/*
		 VU2023ValueHigh = [self ReturnVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2];
		 VU2025ValueHigh = [self ReturnVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2];
		 VU2028ValueHigh = [self ReturnVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2];
		 VU2030ValueHigh = [self ReturnVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2];
		 VU2035ValueHigh = [self ReturnVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2];
		 VUCashValueHigh = [self ReturnVUCashValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth];
		 VURetValueHigh = [self ReturnVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2];
		 */
		
	}
	else{
		VUCashValueHigh = [self ReturnVUCashValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:0];
		VURetValueHigh = [self ReturnVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VUDanaValueHigh = [self ReturnVUDanaValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2023ValueHigh = [self ReturnVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2025ValueHigh = [self ReturnVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2028ValueHigh = [self ReturnVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2030ValueHigh = [self ReturnVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2035ValueHigh = [self ReturnVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
	}
	
	
	
	if (VUCashValueHigh == 1 && VU2023ValueHigh == 0 && VU2025ValueHigh == 0 && VU2028ValueHigh == 0 &&
		VU2030ValueHigh == 0 && VU2035ValueHigh == 0 && VURetValueHigh == 0 && VUDanaValueHigh == 0) {
		return 0;
	} else {
		return VU2023ValueHigh + VU2025ValueHigh + VU2028ValueHigh + VU2030ValueHigh + VU2035ValueHigh +
		VUCashValueHigh + VURetValueHigh + VUDanaValueHigh;
	}
	
}





-(double)ReturnMSurrenderValue :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth {
	//NSLog(@"%f", [self ReturnVUCashValueHigh:aaPolicyYear]);
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		
		VUCashValueMedian = [self ReturnVUCashValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:aaMonth];
		VURetValueMedian = [self ReturnVURetValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VUDanaValueMedian = [self ReturnVUDanaValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2023ValueMedian = [self ReturnVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2025ValueMedian = [self ReturnVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2028ValueMedian = [self ReturnVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2030ValueMedian = [self ReturnVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2035ValueMedian = [self ReturnVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		
	}
	else{
		VUCashValueMedian = [self ReturnVUCashValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:0];
		VURetValueMedian = [self ReturnVURetValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VUDanaValueMedian = [self ReturnVUDanaValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2023ValueMedian = [self ReturnVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2025ValueMedian = [self ReturnVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2028ValueMedian = [self ReturnVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2030ValueMedian = [self ReturnVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2035ValueMedian = [self ReturnVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		
	}
	
	
	
	if (VUCashValueMedian == 1 && VU2023ValueMedian == 0 && VU2025ValueMedian == 0 && VU2028ValueMedian == 0 &&
		VU2030ValueMedian == 0 && VU2035ValueMedian == 0 && VURetValueMedian == 0 && VUDanaValueMedian == 0) {
		return 0;
	} else {
		//NSLog(@"%f,%f,%f,%f,%f,%f,%f", VUCashValueMedian,VURetValueMedian,VU2023ValueMedian, VU2025ValueMedian,VU2028ValueMedian, VU2030ValueMedian, VU2035ValueMedian);
		return VU2023ValueMedian + VU2025ValueMedian + VU2028ValueMedian + VU2030ValueMedian + VU2035ValueMedian +
		VUCashValueMedian + VURetValueMedian + VUDanaValueMedian;
		
	}
	
}

-(double)ReturnLSurrenderValue :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth {
	//NSLog(@"%f", [self ReturnVUCashValueHigh:aaPolicyYear]);
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		
		VUCashValueLow = [self ReturnVUCashValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:aaMonth];
		VURetValueLow = [self ReturnVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VUDanaValueLow = [self ReturnVUDanaValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2023ValueLow = [self ReturnVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2025ValueLow = [self ReturnVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2028ValueLow = [self ReturnVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2030ValueLow = [self ReturnVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2035ValueLow = [self ReturnVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		
		
	}
	else{
		VUCashValueLow = [self ReturnVUCashValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:0];
		VURetValueLow = [self ReturnVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VUDanaValueLow = [self ReturnVUDanaValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2023ValueLow = [self ReturnVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2025ValueLow = [self ReturnVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2028ValueLow = [self ReturnVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2030ValueLow = [self ReturnVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2035ValueLow = [self ReturnVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		
	}
	
	
	
	if (VUCashValueLow == 1 && VU2023ValueLow == 0 && VU2025ValueLow == 0 && VU2028ValueLow == 0 &&
		VU2030ValueLow == 0 && VU2035ValueLow == 0 && VURetValueLow == 0 && VUDanaValueLow == 0) {
		return 0;
	} else {
		return VU2023ValueLow + VU2025ValueLow + VU2028ValueLow + VU2030ValueLow + VU2035ValueLow + VUCashValueLow + VURetValueLow + VUDanaValueLow;
		
	}
	
}

#pragma mark - Surrender Value Calculation for Rider

-(double)ReturnRiderHSurrenderValue :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth {
	//NSLog(@"%f", [self ReturnVUCashValueHigh:aaPolicyYear]);
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		
		RiderVUCashValueHigh = [self ReturnRiderVUCashValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:aaMonth];
		RiderVURetValueHigh = [self ReturnRiderVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVUDanaValueHigh = [self ReturnRiderVUDanaValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2023ValueHigh = [self ReturnRiderVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2025ValueHigh = [self ReturnRiderVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2028ValueHigh = [self ReturnRiderVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2030ValueHigh = [self ReturnRiderVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2035ValueHigh = [self ReturnRiderVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		
		
		/*
		 VU2023ValueHigh = [self ReturnVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2];
		 VU2025ValueHigh = [self ReturnVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2];
		 VU2028ValueHigh = [self ReturnVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2];
		 VU2030ValueHigh = [self ReturnVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2];
		 VU2035ValueHigh = [self ReturnVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2];
		 VUCashValueHigh = [self ReturnVUCashValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth];
		 VURetValueHigh = [self ReturnVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2];
		 */
		
	}
	else{
		RiderVUCashValueHigh = [self ReturnRiderVUCashValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:0];
		RiderVURetValueHigh = [self ReturnRiderVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVUDanaValueHigh = [self ReturnRiderVUDanaValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2023ValueHigh = [self ReturnRiderVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2025ValueHigh = [self ReturnRiderVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2028ValueHigh = [self ReturnRiderVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2030ValueHigh = [self ReturnRiderVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2035ValueHigh = [self ReturnRiderVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
	}
	
	
	
	if (RiderVUCashValueHigh == 1 && RiderVU2023ValueHigh == 0 && RiderVU2025ValueHigh == 0 && RiderVU2028ValueHigh == 0 &&
		RiderVU2030ValueHigh == 0 && RiderVU2035ValueHigh == 0 && RiderVURetValueHigh == 0 && RiderVUDanaValueHigh == 0) {
		return 0;
	} else {
		return RiderVU2023ValueHigh + RiderVU2025ValueHigh + RiderVU2028ValueHigh + RiderVU2030ValueHigh + RiderVU2035ValueHigh +
		RiderVUCashValueHigh + RiderVURetValueHigh + RiderVUDanaValueHigh;
	}
	
}





-(double)ReturnRiderMSurrenderValue :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth {
	//NSLog(@"%f", [self ReturnVUCashValueHigh:aaPolicyYear]);
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		
		RiderVUCashValueMedian = [self ReturnRiderVUCashValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:aaMonth];
		RiderVURetValueMedian = [self ReturnRiderVURetValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVUDanaValueMedian = [self ReturnRiderVUDanaValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2023ValueMedian = [self ReturnRiderVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2025ValueMedian = [self ReturnRiderVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2028ValueMedian = [self ReturnRiderVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2030ValueMedian = [self ReturnRiderVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2035ValueMedian = [self ReturnRiderVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		
	}
	else{
		RiderVUCashValueMedian = [self ReturnRiderVUCashValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:0];
		RiderVURetValueMedian = [self ReturnRiderVURetValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVUDanaValueMedian = [self ReturnRiderVUDanaValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2023ValueMedian = [self ReturnRiderVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2025ValueMedian = [self ReturnRiderVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2028ValueMedian = [self ReturnRiderVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2030ValueMedian = [self ReturnRiderVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2035ValueMedian = [self ReturnRiderVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		
	}
	
	
	
	if (RiderVUCashValueMedian == 1 && RiderVU2023ValueMedian == 0 && RiderVU2025ValueMedian == 0 && RiderVU2028ValueMedian == 0 &&
		RiderVU2030ValueMedian == 0 && RiderVU2035ValueMedian == 0 && RiderVURetValueMedian == 0 && RiderVUDanaValueMedian == 0) {
		return 0;
	} else {
		//NSLog(@"%f,%f,%f,%f,%f,%f,%f", VUCashValueMedian,VURetValueMedian,VU2023ValueMedian, VU2025ValueMedian,VU2028ValueMedian, VU2030ValueMedian, VU2035ValueMedian);
		return RiderVU2023ValueMedian + RiderVU2025ValueMedian + RiderVU2028ValueMedian + RiderVU2030ValueMedian + RiderVU2035ValueMedian +
		RiderVUCashValueMedian + RiderVURetValueMedian + RiderVUDanaValueMedian;
		
	}
	
}

-(double)ReturnRiderLSurrenderValue :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth {
	//NSLog(@"%f", [self ReturnVUCashValueHigh:aaPolicyYear]);
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		
		RiderVUCashValueLow = [self ReturnRiderVUCashValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:aaMonth];
		RiderVURetValueLow = [self ReturnRiderVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVUDanaValueLow = [self ReturnRiderVUDanaValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2023ValueLow = [self ReturnRiderVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2025ValueLow = [self ReturnRiderVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2028ValueLow = [self ReturnRiderVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2030ValueLow = [self ReturnRiderVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		RiderVU2035ValueLow = [self ReturnRiderVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		
		
	}
	else{
		RiderVUCashValueLow = [self ReturnRiderVUCashValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:0];
		RiderVURetValueLow = [self ReturnRiderVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVUDanaValueLow = [self ReturnRiderVUDanaValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2023ValueLow = [self ReturnRiderVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2025ValueLow = [self ReturnRiderVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2028ValueLow = [self ReturnRiderVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2030ValueLow = [self ReturnRiderVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		RiderVU2035ValueLow = [self ReturnRiderVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		
	}
	
	
	
	if (RiderVUCashValueLow == 1 && RiderVU2023ValueLow == 0 && RiderVU2025ValueLow == 0 && RiderVU2028ValueLow == 0 &&
		RiderVU2030ValueLow == 0 && RiderVU2035ValueLow == 0 && RiderVURetValueLow == 0 && RiderVUDanaValueLow == 0) {
		return 0;
	} else {
		return RiderVU2023ValueLow + RiderVU2025ValueLow + RiderVU2028ValueLow + RiderVU2030ValueLow + RiderVU2035ValueLow +
		RiderVUCashValueLow + RiderVURetValueLow + RiderVUDanaValueLow;
		
	}
	
}



-(void)ReturnFundFactor{
	sqlite3_stmt *statement;
	NSString *querySQL;
	
	querySQL = [NSString stringWithFormat:@"Select VU2023,VU2025,VU2028,VU2030,VU2035,VUCash,VURet,VURetOpt, VUCashOpt,VUDana,VUDanaOpt From UL_Details "
				" WHERE sino = '%@'", SINo];
	
	//NSLog(@"%@", querySQL);
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2023Factor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] intValue];
				VU2025Factor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] intValue];
				VU2028Factor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] intValue];
				VU2030Factor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)] intValue];
				VU2035Factor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)] intValue];
				VUCashFactor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] intValue];
				VURetFactor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] intValue];
				VURetOptFactor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] intValue];
				VUCashOptFactor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] intValue];
				VUDanaFactor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)] intValue];
				VUDanaOptFactor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 10)] intValue];
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
}

-(void)GetRegWithdrawal{
	sqlite3_stmt *statement;
	NSString *querySQL;
	
	querySQL = [NSString stringWithFormat:@"Select FromAge, ToAge, YearInt, Amount From UL_RegWithdrawal WHERE sino = '%@'", SINo];
	
	//NSLog(@"%@", querySQL);
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				RegWithdrawalStartYear = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] intValue];
				RegWithdrawalEndYear = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] intValue];
				RegWithdrawalIntYear = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] intValue];
				RegWithdrawalAmount = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)] doubleValue];
			}
			else{
				RegWithdrawalStartYear = 0;
				RegWithdrawalEndYear = 0;
				RegWithdrawalAmount = 0;
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
}



#pragma mark - Calculate Fund Surrender Value for Basic plan
-(double)ReturnVU2023ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)aaMonth{
	double currentValue;
	if (aaPolicyYear > YearDiff2023) {
		VU2023PrevValuehigh = 0.00;
		return 0.00;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			//month calculation
			
			
			if (aaMonth == 1) {
				MonthVU2023PrevValuehigh = VU2023PrevValuehigh;
			}
			
			if (aaMonth > MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				VU2023PrevValuehigh = 0.00;
				MonthVU2023PrevValuehigh = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2023PrevValuehigh;
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0 ) {
				
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:aaMonth] ) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:aaMonth] * VU2023Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
				pow((1 + [self ReturnVU2023InstHigh:@"A" ]), (1.00/12.00)) + MonthVU2023PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear] * [self ReturnLoyaltyBonusFactor:aaMonth]/100.00)) *
				pow((1 + [self ReturnVU2023InstHigh:@"A" ]), 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
				MAX(0, (MonthFundValueOfTheYearVU2023ValueHigh_Basic/MonthFundValueOfTheYearValueTotalHigh));
				
				
			}
			else{
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:aaMonth]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:aaMonth] * VU2023Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
				pow(1 + [self ReturnVU2023InstHigh:@"A" ], 1.00/12.00) + MonthVU2023PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:aaMonth]/100.00)) *
				pow(1 + [self ReturnVU2023InstHigh:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			if (aaMonth == MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				if (Fund2023PartialReinvest != 100) {
					MonthFundMaturityValue2023_Bull = MonthVU2023PrevValuehigh * (100 - Fund2023PartialReinvest)/100.00;
					
					temp2023High = currentValue * (100 - Fund2023PartialReinvest)/100.00;
					Withdrawtemp2023High = currentValue * (Fund2023PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2023_Bull = 0;
				}
				
				if (aaRound == 2) {
					MonthVU2023PrevValuehigh = 0;
				}
				else{
					MonthVU2023PrevValuehigh = tempPrev;
				}
			}
			else{
				if (aaRound == 2) {
					MonthVU2023PrevValuehigh = currentValue;
				}
				else{
					MonthVU2023PrevValuehigh = tempPrev;
				}
			}
			
			if (aaMonth == 12 && aaRound == 2) {
				VU2023PrevValuehigh = MonthVU2023PrevValuehigh + VU2023Value_EverCash1 + VU2023Value_EverCash6 + VU2023Value_EverCash55;
			}
			
			if (aaMonth == 12 && aaRound == 2) {
				return currentValue + VU2023Value_EverCash1 + VU2023Value_EverCash6 + VU2023Value_EverCash55;
			}
			else{
				return currentValue;
			}
			// below part to be edit later
		}
		else{
			//year calculation
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0 ) {
				
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
				(1 + VU2023InstHigh) + VU2023PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstHigh:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
				MAX(0,(FundValueOfTheYearVU2023ValueHigh_Basic/FundValueOfTheYearValueTotalHigh));
				
			}
			else{
				if (aaRound == 1) {
					currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor/100.00 * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
					(1 + VU2023InstHigh) + VU2023PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstHigh:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2023ValueHigh = currentValue;
				}
				else{
					currentValue = VU2023ValueHigh;
				}
				
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2023InstHigh:@"M"])/(pow((1 + [self ReturnVU2023InstHigh:@"A"]), (1.00/12.00)));
				}
			}
			
			if (aaRound == 2){
				VU2023PrevValuehigh = currentValue + VU2023Value_EverCash1 + VU2023Value_EverCash6 + (VU2023Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2023Value_EverCash1 + VU2023Value_EverCash6 + (VU2023Value_EverCash55 * CashFactor);
			// below part to be edit later
		}
		
	}
}

-(double)ReturnVU2023ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	double currentValue;
	if (aaPolicyYear > YearDiff2023) {
		VU2023PrevValueMedian = 0.00;
		return 0.00;
	}
	else{
		
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				MonthVU2023PrevValueMedian = VU2023PrevValueMedian;
			}
			
			if (i > MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				VU2023PrevValueMedian = 0.00;
				MonthVU2023PrevValueMedian = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2023PrevValueMedian;
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalMedian != 0 ) {
				
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2023Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
				pow(1 + [self ReturnVU2023InstMedian:@"A" ], 1.00/12.00) + MonthVU2023PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2023InstMedian:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2023ValueMedian_Basic/MonthFundValueOfTheYearValueTotalMedian));
				
			}
			else{
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2023Fac ] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2023Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
				pow(1 + [self ReturnVU2023InstMedian:@"A" ], 1.00/12.00) + MonthVU2023PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2023InstMedian:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			
			if (i == MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				if (Fund2023PartialReinvest != 100) {
					MonthFundMaturityValue2023_Flat = MonthVU2023PrevValueMedian * (100 - Fund2023PartialReinvest)/100.00;
					
					temp2023Median = currentValue * (100 - Fund2023PartialReinvest)/100.00;
					Withdrawtemp2023Median = currentValue * (Fund2023PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2023_Flat = 0;
				}
				
				if (aaRound == 2) {
					MonthVU2023PrevValueMedian = 0;
				}
				else{
					MonthVU2023PrevValueMedian = tempPrev;
				}
			}
			else{
				if (aaRound == 2) {
					MonthVU2023PrevValueMedian = currentValue;
				}
				else{
					MonthVU2023PrevValueMedian = tempPrev;
				}
				
			}
			
			
			if (i == 12 && aaRound == 2) {
				VU2023PrevValueMedian = MonthVU2023PrevValueMedian + VU2023Value_EverCash1 + VU2023Value_EverCash6 + VU2023Value_EverCash55;
			}
			
			if (i == 12 && aaRound == 2) {
				return currentValue + VU2023Value_EverCash1 + VU2023Value_EverCash6 + VU2023Value_EverCash55;
			}
			else{
				return currentValue;
			}
			// below part to be edit later
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0 ) {
				
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
				(1 + VU2023InstMedian) + VU2023PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstMedian:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				MAX(0,(FundValueOfTheYearVU2023ValueMedian_Basic/FundValueOfTheYearValueTotalMedian));
				
			}
			else{
				if (aaRound == 1) {
					currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor/100.00 * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
					(1 + VU2023InstMedian) + VU2023PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstMedian:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2023ValueMedian = currentValue;
				}
				else{
					currentValue = VU2023ValueMedian;
				}
				
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2023InstMedian:@"M"])/(pow((1 + [self ReturnVU2023InstMedian:@"A"]), (1.00/12.00)));
				}
			}
			
			if (aaRound == 2){
				VU2023PrevValueMedian = currentValue + VU2023Value_EverCash1 + VU2023Value_EverCash6 + (VU2023Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2023Value_EverCash1 + VU2023Value_EverCash6 + (VU2023Value_EverCash55 * CashFactor);
			// below part to be edit later
		}
		
	}
}

-(double)ReturnVU2023ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	double currentValue;
	if (aaPolicyYear > YearDiff2023) {
		VU2023PrevValueLow = 0.00;
		return 0.00;
	}
	else{
		
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				MonthVU2023PrevValueLow = VU2023PrevValueLow;
			}
			
			if (i > MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				VU2023PrevValueLow = 0.00;
				MonthVU2023PrevValueLow = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2023PrevValueLow;
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0 ) {
				
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2023Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
				pow(1 + [self ReturnVU2023InstLow:@"A" ], 1.00/12.00) + MonthVU2023PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2023InstLow:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2023ValueLow_Basic/MonthFundValueOfTheYearValueTotalLow));
				
			}
			else{
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2023Fac ] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2023Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
				pow(1 + [self ReturnVU2023InstLow:@"A" ], 1.00/12.00) + MonthVU2023PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2023InstLow:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			
			if (i == MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				if (Fund2023PartialReinvest != 100) {
					MonthFundMaturityValue2023_Bear = MonthVU2023PrevValueLow * (100 - Fund2023PartialReinvest)/100.00;
					
					temp2023Low = currentValue * (100 - Fund2023PartialReinvest)/100.00;
					Withdrawtemp2023Low = currentValue * (Fund2023PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2023_Bear = 0;
				}
				if (aaRound == 2) {
					MonthVU2023PrevValueLow = 0;
				}
				else{
					MonthVU2023PrevValueLow = tempPrev;
				}
			}
			else{
				if (aaRound == 2) {
					MonthVU2023PrevValueLow = currentValue;
				}
				else{
					MonthVU2023PrevValueLow = tempPrev;
				}
			}
			
			if (i == 12 && aaRound == 2) {
				VU2023PrevValueLow = MonthVU2023PrevValueLow + VU2023Value_EverCash1 + VU2023Value_EverCash6 + VU2023Value_EverCash55;
			}
			
			if (i == 12 && aaRound == 2) {
				return currentValue + VU2023Value_EverCash1 + VU2023Value_EverCash6 + VU2023Value_EverCash55;
			}
			else{
				return currentValue;
			}
			// below part to be edit later
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0 ) {
				
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
				(1 + VU2023InstLow) + VU2023PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstLow:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				MAX(0,(FundValueOfTheYearVU2023ValueLow_Basic/FundValueOfTheYearValueTotalLow));
				
			}
			else{
				
				if (aaRound == 1) {
					currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor/100.00 * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
					(1 + VU2023InstLow) + VU2023PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstLow:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2023ValueLow = currentValue ;
				}
				else{
					currentValue = VU2023ValueLow;
				}
				
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2023InstLow:@"M"])/(pow((1 + [self ReturnVU2023InstLow:@"A"]), (1.00/12.00)));
				}
			}
			
			if (aaRound == 2){
				VU2023PrevValueLow = currentValue +  VU2023Value_EverCash1 + VU2023Value_EverCash6 + (VU2023Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2023Value_EverCash1 + VU2023Value_EverCash6 + (VU2023Value_EverCash55 * CashFactor);
			// below part to be edit later
		}
		
	}
}


-(double)ReturnVU2025ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2025) {
		VU2025PrevValuehigh = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				MonthVU2025PrevValuehigh = VU2025PrevValuehigh;
			}
			
			if (i > MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				VU2025PrevValuehigh = 0.00;
				MonthVU2025PrevValuehigh = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2025PrevValuehigh;
			
			if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVU2025PrevValuehigh = MonthVU2025PrevValuehigh + (temp2023High * Fund2023ReinvestTo2025Fac/100.00);
			}
			else{
				
			}
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0 ) {
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2025Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
				pow(1 + [self ReturnVU2025InstHigh:@"A" ], 1.00/12.00) + MonthVU2025PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2025InstHigh:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2025ValueHigh_Basic/MonthFundValueOfTheYearValueTotalHigh));
			}
			else{
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2025Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
				pow(1 + [self ReturnVU2025InstHigh:@"A" ], 1.00/12.00) + MonthVU2025PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2025InstHigh:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			
			if (i == MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				if (Fund2025PartialReinvest != 100) {
					MonthFundMaturityValue2025_Bull = MonthVU2025PrevValuehigh * (100 - Fund2025PartialReinvest)/100.00;
					
					temp2025High = currentValue * (100 - Fund2025PartialReinvest)/100.00;
					Withdrawtemp2025High = currentValue * (Fund2025PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2025_Bull = 0;
				}
				if (aaRound == 2){
					MonthVU2025PrevValuehigh = 0;
				}
				else{
					MonthVU2025PrevValuehigh = tempPrev;
				}
				
			}
			else{
				if (aaRound == 2){
					MonthVU2025PrevValuehigh = currentValue;
				}
				else{
					MonthVU2025PrevValuehigh = tempPrev;
				}
				
			}
			
			
			if (aaRound == 2 && i == 12) {
				VU2025PrevValuehigh = MonthVU2025PrevValuehigh + VU2025Value_EverCash1 + VU2025Value_EverCash6 + VU2025Value_EverCash55;
			}
			
			if (aaRound == 2 && i == 12) {
				return currentValue + VU2025Value_EverCash1 + VU2025Value_EverCash6 + VU2025Value_EverCash55;
			}
			else
			{
				return currentValue;
			}
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0 ) {
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
				(1 + VU2025InstHigh) + VU2025PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstHigh:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
				MAX(0,(FundValueOfTheYearVU2025ValueHigh_Basic/FundValueOfTheYearValueTotalHigh));
				
				
			}
			else{
				
				if (aaRound == 1) {
					currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
					(1 + VU2025InstHigh) + VU2025PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstHigh:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					
					VU2025ValueHigh = currentValue;
				}
				else{
					currentValue = VU2025ValueHigh;
				}
				
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2025InstHigh:@"M"])/(pow((1 + [self ReturnVU2025InstHigh:@"A"]), (1.00/12.00)));
				}
			}
			
			if (aaRound == 2) {
				VU2025PrevValuehigh = currentValue + VU2025Value_EverCash1 + VU2025Value_EverCash6  + (VU2025Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2025Value_EverCash1 + VU2025Value_EverCash6 + (VU2025Value_EverCash55 * CashFactor);
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnVU2025ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2025) {
		VU2025PrevValueMedian = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			
			if (i == 1) {
				MonthVU2025PrevValueMedian = VU2025PrevValueMedian;
			}
			
			if (i > MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				VU2025PrevValueMedian = 0.00;
				MonthVU2025PrevValueMedian = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2025PrevValueMedian;
			
			if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVU2025PrevValueMedian = MonthVU2025PrevValueMedian + (temp2023Median * Fund2023ReinvestTo2025Fac/100.00);
			}
			else{
				
			}
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalMedian != 0 ) {
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2025Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
				pow(1 + [self ReturnVU2025InstMedian:@"A" ], 1.00/12.00) + MonthVU2025PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2025InstMedian:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2025ValueMedian_Basic/MonthFundValueOfTheYearValueTotalMedian));
			}
			else{
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2025Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
				pow(1 + [self ReturnVU2025InstMedian:@"A" ], 1.00/12.00) + MonthVU2025PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2025InstMedian:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			
			if (i == MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				if (Fund2025PartialReinvest != 100) {
					MonthFundMaturityValue2025_Flat = MonthVU2025PrevValueMedian * (100 - Fund2025PartialReinvest)/100.00;
					
					temp2025Median = currentValue * (100 - Fund2025PartialReinvest)/100.00;
					Withdrawtemp2025Median = currentValue * (Fund2025PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2025_Flat = 0;
				}
				if (aaRound == 2){
					MonthVU2025PrevValueMedian = 0;
				}
				else{
					MonthVU2025PrevValueMedian = tempPrev;
				}
				
			}
			else{
				if (aaRound == 2){
					MonthVU2025PrevValueMedian = currentValue;
				}
				else{
					MonthVU2025PrevValueMedian = tempPrev;
				}
				
			}
			
			
			if (aaRound == 2 && i == 12) {
				VU2025PrevValueMedian = MonthVU2025PrevValueMedian + VU2025Value_EverCash1 + VU2025Value_EverCash6 + VU2025Value_EverCash55;
			}
			
			if (aaRound == 2 && i == 12) {
				return currentValue + VU2025Value_EverCash1 + VU2025Value_EverCash6 + VU2025Value_EverCash55;
			}
			else{
				return currentValue;
			}
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0 ) {
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
				(1 + VU2025InstMedian) + VU2025PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstMedian:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				MAX(0,(FundValueOfTheYearVU2025ValueMedian_Basic/FundValueOfTheYearValueTotalMedian));
			}
			else{
				if (aaRound == 1) {
					currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
					(1 + VU2025InstMedian) + VU2025PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstMedian:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					
					VU2025ValueMedian = currentValue;
				}
				else{
					currentValue = VU2025ValueMedian;
				}
				
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2025InstMedian:@"M"])/(pow((1 + [self ReturnVU2025InstMedian:@"A"]), (1.00/12.00)));
				}
			}
			
			if (aaRound == 2) {
				VU2025PrevValueMedian = currentValue + VU2025Value_EverCash1 + VU2025Value_EverCash6  + (VU2025Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2025Value_EverCash1 + VU2025Value_EverCash6  + (VU2025Value_EverCash55 * CashFactor);
		}
		
	}
	
	// below part to be edit later
}


-(double)ReturnVU2025ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2025) {
		VU2025PrevValueLow = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			
			if (i == 1) {
				MonthVU2025PrevValueLow = VU2025PrevValueLow;
			}
			
			if (i > MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				VU2025PrevValueLow = 0.00;
				MonthVU2025PrevValueLow = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2025PrevValueLow;
			
			if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVU2025PrevValueLow = MonthVU2025PrevValueLow + (temp2023Low * Fund2023ReinvestTo2025Fac/100.00);
			}
			else{
				
			}
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0 ) {
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2025Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
				pow(1 + [self ReturnVU2025InstLow:@"A" ], 1.00/12.00) + MonthVU2025PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2025InstLow:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2025ValueLow_Basic/MonthFundValueOfTheYearValueTotalLow));
			}
			else{
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2025Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
				pow(1 + [self ReturnVU2025InstLow:@"A" ], 1.00/12.00) + MonthVU2025PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2025InstLow:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			
			if (i == MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				if (Fund2025PartialReinvest != 100) {
					MonthFundMaturityValue2025_Bear = MonthVU2025PrevValueLow * (100 - Fund2025PartialReinvest)/100.00;
					
					temp2025Low = currentValue * (100 - Fund2025PartialReinvest)/100.00;
					Withdrawtemp2025Low = currentValue * (Fund2025PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2025_Bear = 0;
				}
				if (aaRound == 2){
					MonthVU2025PrevValueLow = 0;
				}
				else{
					MonthVU2025PrevValueLow = tempPrev;
				}
				
			}
			else{
				if (aaRound == 2){
					MonthVU2025PrevValueLow = currentValue;
				}
				else{
					MonthVU2025PrevValueLow = tempPrev;
				}
				
			}
			
			if (aaRound == 2 && i == 12) {
				VU2025PrevValueLow = MonthVU2025PrevValueLow + VU2025Value_EverCash1 + VU2025Value_EverCash6 + VU2025Value_EverCash55;
			}
			
			if (aaRound == 2 && i == 12) {
				return currentValue + VU2025Value_EverCash1 + VU2025Value_EverCash6 + VU2025Value_EverCash55;
			}
			else{
				return currentValue;
			}
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0 ) {
				currentValue =((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
				(1 + VU2025InstLow) + VU2025PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstLow:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				MAX(0,(FundValueOfTheYearVU2025ValueLow_Basic/FundValueOfTheYearValueTotalLow));
			}
			else{
				if (aaRound == 1) {
					currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
					(1 + VU2025InstLow) + VU2025PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstLow:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					
					VU2025ValueLow = currentValue;
				}
				else{
					currentValue =VU2025ValueLow;
				}
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2025InstLow:@"M"])/(pow((1 + [self ReturnVU2025InstLow:@"A"]), (1.00/12.00)));
				}
			}

			
			if (aaRound == 2) {
				VU2025PrevValueLow = currentValue + VU2025Value_EverCash1 + VU2025Value_EverCash6  + (VU2025Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2025Value_EverCash1 + VU2025Value_EverCash6  + (VU2025Value_EverCash55 * CashFactor);
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnVU2028ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2028) {
		VU2028PrevValuehigh = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				MonthVU2028PrevValuehigh = VU2028PrevValuehigh;
			}
			
			if (i > MonthDiff2028 && aaPolicyYear == YearDiff2028) {
				VU2028PrevValuehigh = 0.00;
				MonthVU2028PrevValuehigh = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2028PrevValuehigh;
			if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				MonthVU2028PrevValuehigh = MonthVU2028PrevValuehigh + (temp2025High * Fund2025ReinvestTo2028Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVU2028PrevValuehigh = MonthVU2028PrevValuehigh + (temp2023High * Fund2023ReinvestTo2028Fac/100.00);
			}
			else{
				
			}
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0) {
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2028Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
				pow(1 + [self ReturnVU2028InstHigh:@"A" ], 1.00/12.00) + MonthVU2028PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2028InstHigh:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2028ValueHigh_Basic/MonthFundValueOfTheYearValueTotalHigh));
			}
			else{
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2028Factor/100.00 * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
				pow(1 + [self ReturnVU2028InstHigh:@"A" ], 1.00/12.00)+ MonthVU2028PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2028InstHigh:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			
			if (i == MonthDiff2028 && aaPolicyYear == YearDiff2028) {
				if (Fund2028PartialReinvest != 100) {
					MonthFundMaturityValue2028_Bull = MonthVU2028PrevValuehigh * (100 - Fund2028PartialReinvest)/100.00;
					
					temp2028High = currentValue * (100 - Fund2028PartialReinvest)/100.00;
					Withdrawtemp2028High = currentValue * (Fund2028PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2028_Bull = 0;
				}
				if (aaRound == 2) {
					MonthVU2028PrevValuehigh = 0;
				}
				else{
					MonthVU2028PrevValuehigh = tempPrev;
				}
			}
			else{
				if (aaRound == 2) {
					MonthVU2028PrevValuehigh = currentValue;
				}
				else{
					MonthVU2028PrevValuehigh = tempPrev;
				}
				
			}
			
			if (i == 12 && aaRound == 2) {
				VU2028PrevValuehigh = MonthVU2028PrevValuehigh + VU2028Value_EverCash1 + VU2028Value_EverCash6 + VU2028Value_EverCash55;
			}
			
			if (i == 12 && aaRound == 2) {
				return currentValue + + VU2028Value_EverCash1 + VU2028Value_EverCash6 + VU2028Value_EverCash55;
			}
			else
			{
				return currentValue;
			}
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0) {
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
				(1 + VU2028InstHigh) + VU2028PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstHigh:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
				MAX(0,(FundValueOfTheYearVU2028ValueHigh_Basic/FundValueOfTheYearValueTotalHigh));
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
					(1 + VU2028InstHigh) + VU2028PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstHigh:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2028ValueHigh = currentValue;
				}
				else{
					currentValue = VU2028ValueHigh;
				}
				
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2028InstHigh:@"M"])/(pow((1 + [self ReturnVU2028InstHigh:@"A"]), (1.00/12.00)));
				}
			}

			
			if (aaRound == 2) {
				VU2028PrevValuehigh = currentValue + VU2028Value_EverCash1 + VU2025Value_EverCash6  + (VU2025Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2028Value_EverCash1 + VU2025Value_EverCash6  + (VU2025Value_EverCash55 * CashFactor);
			
		}
		
	}
	
}

-(double)ReturnVU2028ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2028) {
		VU2028PrevValueMedian = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				MonthVU2028PrevValueMedian = VU2028PrevValueMedian;
			}
			
			if (i > MonthDiff2028 && aaPolicyYear == YearDiff2028) {
				VU2028PrevValueMedian = 0.00;
				MonthVU2028PrevValueMedian = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2028PrevValueMedian;
			if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				MonthVU2028PrevValueMedian = MonthVU2028PrevValueMedian + (temp2025Median * Fund2025ReinvestTo2028Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVU2028PrevValueMedian = MonthVU2028PrevValueMedian + (temp2023Median * Fund2023ReinvestTo2028Fac/100.00);
			}
			else{
				
			}
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalMedian != 0) {
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2028Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
				pow(1 + [self ReturnVU2028InstMedian:@"A" ], 1.00/12.00) + MonthVU2028PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2028InstMedian:@"A"],1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2028ValueMedian_Basic/MonthFundValueOfTheYearValueTotalMedian));
			}
			else{
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2028Factor/100.00 * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
				pow(1 + [self ReturnVU2028InstMedian:@"A" ], 1.00/12.00)+ MonthVU2028PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2028InstMedian:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			if (i == MonthDiff2028 && aaPolicyYear == YearDiff2028) {
				if (Fund2028PartialReinvest != 100) {
					MonthFundMaturityValue2028_Flat = MonthVU2028PrevValueMedian * (100 - Fund2028PartialReinvest)/100.00;
					
					temp2028Median = currentValue * (100 - Fund2028PartialReinvest)/100.00;
					Withdrawtemp2028Median = currentValue * (Fund2028PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2028_Flat = 0;
				}
				
				if (aaRound == 2) {
					MonthVU2028PrevValueMedian = 0;
				}
				else{
					MonthVU2028PrevValueMedian = tempPrev;
				}
			}
			else{
				if (aaRound == 2) {
					MonthVU2028PrevValueMedian = currentValue;
				}
				else{
					MonthVU2028PrevValueMedian = tempPrev;
				}
				
			}
			
			if (i == 12 && aaRound == 2) {
				VU2028PrevValueMedian = MonthVU2028PrevValueMedian + VU2028Value_EverCash1 + VU2028Value_EverCash6 + VU2028Value_EverCash55;
			}
			
			if (i == 12 && aaRound == 2) {
				return currentValue + VU2028Value_EverCash1 + VU2028Value_EverCash6 + VU2028Value_EverCash55;
			}
			else{
				return currentValue;
			}
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0) {
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
				(1 + VU2028InstMedian) + VU2028PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstMedian:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				MAX(0,(FundValueOfTheYearVU2028ValueMedian_Basic/FundValueOfTheYearValueTotalMedian));
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
					(1 + VU2028InstMedian) + VU2028PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstMedian:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2028ValueMedian = currentValue;
				}
				else{
					currentValue = VU2028ValueMedian;
				}
				
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2028InstMedian:@"M"])/(pow((1 + [self ReturnVU2028InstMedian:@"A"]), (1.00/12.00)));
				}
			}

			
			if (aaRound == 2) {
				VU2028PrevValueMedian = currentValue + VU2028Value_EverCash1 + VU2028Value_EverCash6  + (VU2028Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2028Value_EverCash1 + VU2028Value_EverCash6  + (VU2028Value_EverCash55 * CashFactor);
		}
		
	}
	
}

-(double)ReturnVU2028ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2028) {
		VU2028PrevValueLow = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			if (i == 1) {
				MonthVU2028PrevValueLow = VU2028PrevValueLow;
			}
			
			if (i > MonthDiff2028 && aaPolicyYear == YearDiff2028) {
				VU2028PrevValueLow = 0.00;
				MonthVU2028PrevValueLow = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2028PrevValueLow;
			if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				MonthVU2028PrevValueLow = MonthVU2028PrevValueLow + (temp2025Low * Fund2025ReinvestTo2028Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVU2028PrevValueLow = MonthVU2028PrevValueLow + (temp2023Low * Fund2023ReinvestTo2028Fac/100.00);
			}
			else{
				
			}
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0) {
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2028Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
				pow(1 + [self ReturnVU2028InstLow:@"A" ], 1.00/12.00) + MonthVU2028PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2028InstLow:@"A"],1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2028ValueLow_Basic/MonthFundValueOfTheYearValueTotalLow));
			}
			else{
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2028Factor/100.00 * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
				pow(1 + [self ReturnVU2028InstLow:@"A" ], 1.00/12.00)+ MonthVU2028PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2028InstLow:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			if (i == MonthDiff2028 && aaPolicyYear == YearDiff2028) {
				if (Fund2028PartialReinvest != 100) {
					MonthFundMaturityValue2028_Bear = MonthVU2028PrevValueLow * (100 - Fund2028PartialReinvest)/100.00;
					
					temp2028Low = currentValue * (100 - Fund2028PartialReinvest)/100.00;
					Withdrawtemp2028Low = currentValue * (Fund2028PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2028_Bear = 0;
				}
				
				if (aaRound == 2) {
					MonthVU2028PrevValueLow = 0;
				}
				else{
					MonthVU2028PrevValueLow = tempPrev;
				}
				
			}
			else{
				if (aaRound == 2) {
					MonthVU2028PrevValueLow = currentValue;
				}
				else{
					MonthVU2028PrevValueLow = tempPrev;
				}
				
			}
			
			if (i == 12 && aaRound == 2) {
				VU2028PrevValueLow = MonthVU2028PrevValueLow + VU2028Value_EverCash1 + VU2028Value_EverCash6 + VU2028Value_EverCash55;
			}
			
			if (i == 12 && aaRound == 2) {
				return currentValue + VU2028Value_EverCash1 + VU2028Value_EverCash6 + VU2028Value_EverCash55;
			}
			else{
				return currentValue;
			}
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0) {
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
				(1 + VU2028InstLow) + VU2028PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstLow:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				MAX(0,(FundValueOfTheYearVU2028ValueLow_Basic/FundValueOfTheYearValueTotalLow));
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
					(1 + VU2028InstLow) + VU2028PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstLow:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2028ValueLow = currentValue;
				}
				else{
					currentValue = VU2028ValueLow;
				}
				
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2028InstLow:@"M"])/(pow((1 + [self ReturnVU2028InstLow:@"A"]), (1.00/12.00)));
				}
			}

			
			if (aaRound == 2) {
				VU2028PrevValueLow = currentValue + VU2028Value_EverCash1 + VU2028Value_EverCash6  + (VU2028Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2028Value_EverCash1 + VU2028Value_EverCash6  + (VU2028Value_EverCash55 * CashFactor);
		}
		
	}
	
}

-(double)ReturnVU2030ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2030) {
		VU2030PrevValuehigh = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			if (i == 1) {
				MonthVU2030PrevValuehigh = VU2030PrevValuehigh;
			}
			
			if (i > MonthDiff2030 && aaPolicyYear == YearDiff2030) {
				VU2030PrevValuehigh = 0.00;
				MonthVU2030PrevValuehigh = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2030PrevValuehigh;
			if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				MonthVU2030PrevValuehigh = MonthVU2030PrevValuehigh + (temp2028High * Fund2028ReinvestTo2030Fac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				MonthVU2030PrevValuehigh = MonthVU2030PrevValuehigh + (temp2025High * Fund2025ReinvestTo2030Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVU2030PrevValuehigh = MonthVU2030PrevValuehigh + (temp2023High * Fund2023ReinvestTo2030Fac/100.00);
			}
			else{
				
			}
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0) {
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear  andMonth:i] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2030Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
				pow(1 + [self ReturnVU2030InstHigh:@"A" ], 1.00/12.00) + MonthVU2030PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2030InstHigh:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
				//MAX(0,(MonthFundValueOfTheYearVU2030ValueHigh_Basic/MonthFundValueOfTheYearValueTotalHigh));
				MAX(0,(MonthFundValueOfTheYearVU2030ValueHigh_Basic/MonthFundValueOfTheYearValueTotalHigh));
			}
			else{
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear  andMonth:i] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2030Factor/100.00 * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
				pow(1 + [self ReturnVU2030InstHigh:@"A" ], 1.00/12.00) + MonthVU2030PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2030InstHigh:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			
			if (i == MonthDiff2030 && aaPolicyYear == YearDiff2030) {
				if (Fund2030PartialReinvest != 100) {
					MonthFundMaturityValue2030_Bear = MonthVU2030PrevValuehigh * (100 - Fund2030PartialReinvest)/100.00;
					
					temp2030High = currentValue * (100 - Fund2030PartialReinvest)/100.00;
					Withdrawtemp2030High = currentValue * (Fund2030PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2030_Bear = 0;
				}
				if (aaRound == 2) {
					MonthVU2030PrevValuehigh = 0;
				}
				
			}
			else{
				if (aaRound == 2) {
					MonthVU2030PrevValuehigh = currentValue;
				}
				else{
					MonthVU2030PrevValuehigh = tempPrev;
				}
				
			}
			
			if (aaRound == 2 && i == 12) {
				VU2030PrevValuehigh = MonthVU2030PrevValuehigh + VU2030Value_EverCash1 + VU2030Value_EverCash6 + VU2030Value_EverCash55;
			}
			
			if (aaRound == 2 && i == 12) {
				return currentValue + VU2030Value_EverCash1 + VU2030Value_EverCash6 + VU2030Value_EverCash55;
			}
			else{
				return currentValue;
			}
			
			
		}
		else{
			
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0) {
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
				(1 + VU2030InstHigh) + VU2030PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstHigh:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
				MAX(0,(FundValueOfTheYearVU2030ValueHigh_Basic/FundValueOfTheYearValueTotalHigh));
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
					(1 + VU2030InstHigh) + VU2030PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstHigh:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2030ValueHigh = currentValue;
				}
				else{
					currentValue = VU2030ValueHigh;
				}
				
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2030InstHigh:@"M"])/(pow((1 + [self ReturnVU2030InstHigh:@"A"]), (1.00/12.00)));
				}
			}
			
			if (aaRound == 2) {
				VU2030PrevValuehigh = currentValue + VU2030Value_EverCash1 + VU2030Value_EverCash6  + (VU2030Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2030Value_EverCash1 + VU2030Value_EverCash6  + (VU2030Value_EverCash55 * CashFactor);
			
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnVU2030ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2030) {
		VU2030PrevValueMedian = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				MonthVU2030PrevValueMedian = VU2030PrevValueMedian;
			}
			
			if (i > MonthDiff2030 && aaPolicyYear == YearDiff2030) {
				VU2030PrevValueMedian = 0.00;
				MonthVU2030PrevValueMedian = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2030PrevValueMedian;
			if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				MonthVU2030PrevValueMedian = MonthVU2030PrevValueMedian + (temp2028Median * Fund2028ReinvestTo2030Fac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				MonthVU2030PrevValueMedian = MonthVU2030PrevValueMedian + (temp2025Median * Fund2025ReinvestTo2030Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVU2030PrevValueMedian = MonthVU2030PrevValueMedian + (temp2023Median * Fund2023ReinvestTo2030Fac/100.00);
			}
			else{
				
			}
			
			if (VUCashValueNegative ==TRUE && MonthFundValueOfTheYearValueTotalMedian != 0) {
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear andMonth:i] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2030Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
				pow(1 + [self ReturnVU2030InstMedian:@"A" ], 1.00/12.00) + MonthVU2030PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2030InstMedian:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2030ValueMedian_Basic/MonthFundValueOfTheYearValueTotalMedian));
			}
			else{
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]* [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear andMonth:i] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2030Factor/100.00 * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
				pow(1 + [self ReturnVU2030InstMedian:@"A" ], 1.00/12.00) + MonthVU2030PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2030InstMedian:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			
			if (i == MonthDiff2030 && aaPolicyYear == YearDiff2030) {
				if (Fund2030PartialReinvest != 100) {
					MonthFundMaturityValue2030_Flat = MonthVU2030PrevValueMedian * (100 - Fund2030PartialReinvest)/100.00;
					temp2030Median = currentValue * (100 - Fund2030PartialReinvest)/100.00;
					Withdrawtemp2030Median = currentValue * (Fund2030PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2030_Flat = 0;
				}
				if (aaRound == 2) {
					MonthVU2030PrevValueMedian = 0;
				}
				
			}
			else{
				if (aaRound == 2) {
					MonthVU2030PrevValueMedian = currentValue;
				}
				else{
					MonthVU2030PrevValueMedian = tempPrev;
				}
			}
			
			if (aaRound == 2 && i == 12) {
				VU2030PrevValueMedian = MonthVU2030PrevValueMedian + VU2030Value_EverCash1 + VU2030Value_EverCash6 + VU2030Value_EverCash55;
			}
			
			if (aaRound == 2 && i == 12) {
				return currentValue + VU2030Value_EverCash1 + VU2030Value_EverCash6 + VU2030Value_EverCash55;
			}
			else
			{
				return currentValue;
			}
			
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0) {
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
				(1 + VU2030InstMedian) + VU2030PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstMedian:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				MAX(0,(FundValueOfTheYearVU2030ValueMedian_Basic/FundValueOfTheYearValueTotalMedian));
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
					(1 + VU2030InstMedian) + VU2030PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstMedian:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2030ValueMedian = currentValue;
				}
				else{
					currentValue = VU2030ValueMedian;
				}
				
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2030InstMedian:@"M"])/(pow((1 + [self ReturnVU2030InstMedian:@"A"]), (1.00/12.00)));
				}
			}
			
			if (aaRound == 2) {
				VU2030PrevValueMedian = currentValue + VU2030Value_EverCash1 + VU2030Value_EverCash6  + (VU2030Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2030Value_EverCash1 + VU2030Value_EverCash6  + (VU2030Value_EverCash55 * CashFactor);
			
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnVU2030ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2030) {
		VU2030PrevValueLow = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			if (i == 1) {
				MonthVU2030PrevValueLow = VU2030PrevValueLow;
			}
			
			if (i > MonthDiff2030 && aaPolicyYear == YearDiff2030) {
				VU2030PrevValueLow = 0.00;
				MonthVU2030PrevValueLow = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2030PrevValueLow;
			if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				MonthVU2030PrevValueLow = MonthVU2030PrevValueLow + (temp2028Low * Fund2028ReinvestTo2030Fac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				MonthVU2030PrevValueLow = MonthVU2030PrevValueLow + (temp2025Low * Fund2025ReinvestTo2030Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVU2030PrevValueLow = MonthVU2030PrevValueLow + (temp2023Low * Fund2023ReinvestTo2030Fac/100.00);
			}
			else{
				
			}
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0) {
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear andMonth:i] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2030Factor/100.00 * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
				pow(1 + [self ReturnVU2030InstLow:@"A" ], 1.00/12.00) + MonthVU2030PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2030InstLow:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2030ValueLow_Basic/MonthFundValueOfTheYearValueTotalLow));
			}
			else{
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]* [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear andMonth:i] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2030Factor/100.00 * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
				pow(1 + [self ReturnVU2030InstLow:@"A" ], 1.00/12.00) + MonthVU2030PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2030InstLow:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			
			if (i == MonthDiff2030 && aaPolicyYear == YearDiff2030) {
				if (Fund2030PartialReinvest != 100) {
					MonthFundMaturityValue2030_Bear = MonthVU2030PrevValueLow * (100 - Fund2030PartialReinvest)/100.00;
					temp2030Low = currentValue * (100 - Fund2030PartialReinvest)/100.00;
					Withdrawtemp2030Low = currentValue * (Fund2030PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2030_Bear = 0;
				}
				if (aaRound == 2) {
					MonthVU2030PrevValueLow = 0;
				}
				
			}
			else{
				if (aaRound == 2) {
					MonthVU2030PrevValueLow = currentValue;
				}
				else{
					MonthVU2030PrevValueLow = tempPrev;
				}
				
			}
			
			if (aaRound == 2 && i == 12) {
				VU2030PrevValueLow = MonthVU2030PrevValueLow + VU2030Value_EverCash1 + VU2030Value_EverCash6 + VU2030Value_EverCash55;
			}
			
			if (aaRound == 2 && i == 12) {
				return currentValue + VU2030Value_EverCash1 + VU2030Value_EverCash6 + VU2030Value_EverCash55;
			}
			else{
				return currentValue;
			}
			
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0) {
				currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
				(1 + VU2030InstLow) + VU2030PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstLow:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				MAX(0,(FundValueOfTheYearVU2030ValueLow_Basic/FundValueOfTheYearValueTotalLow));
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
					(1 + VU2030InstLow) + VU2030PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstLow:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2030ValueLow = currentValue;
				}
				else{
					currentValue = VU2030ValueLow;
				}
				
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2030InstLow:@"M"])/(pow((1 + [self ReturnVU2030InstLow:@"A"]), (1.00/12.00)));
				}
			}
			
			if (aaRound == 2) {
				VU2030PrevValueLow = currentValue + VU2030Value_EverCash1 + VU2030Value_EverCash6  + (VU2030Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2030Value_EverCash1 + VU2030Value_EverCash6  + (VU2030Value_EverCash55 * CashFactor);
			
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnVU2035ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2035) {
		VU2035PrevValuehigh = 0.00;		
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				MonthVU2035PrevValuehigh = VU2035PrevValuehigh;
			}
			
			if (i > MonthDiff2035 && aaPolicyYear == YearDiff2035) {
				MonthVU2035PrevValuehigh = 0;
				VU2035PrevValuehigh = 0.00;
				return 0;
			}
			
			double tempPrev = MonthVU2035PrevValuehigh;
			if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
				MonthVU2035PrevValuehigh = MonthVU2035PrevValuehigh + (temp2030High * Fund2030ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				MonthVU2035PrevValuehigh = MonthVU2035PrevValuehigh + (temp2028High * Fund2028ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				MonthVU2035PrevValuehigh = MonthVU2035PrevValuehigh + (temp2025High * Fund2025ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVU2035PrevValuehigh = MonthVU2035PrevValuehigh + (temp2023High * Fund2023ReinvestTo2035Fac/100.00);
			}
			else{
				
			}
			
						
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0 ) {
				
				currentValue=  ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i] ) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2035Factor/100.00 * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
				pow(1 + [self ReturnVU2035InstHigh:@"A"], 1.00/12.00) + MonthVU2035PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2035InstHigh:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2035ValueHigh_Basic/MonthFundValueOfTheYearValueTotalHigh));
				if (aaPolicyYear == 23) {
					//NSLog(@"%f %f %f", NegativeValueOfMaxCashFundHigh, MonthVU2035ValueHigh, MonthFundValueOfTheYearValueTotalHigh );
				}
			}
			else if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh == 0 ) {
				currentValue = 0;
			}
			else{
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2035Factor/100.00 * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
				pow(1 + [self ReturnVU2035InstHigh:@"A"], 1.00/12.00) + MonthVU2035PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2035InstHigh:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			
			if (i == MonthDiff2035 && aaPolicyYear == YearDiff2035) {
				if (Fund2035PartialReinvest != 100) {
					
					MonthFundMaturityValue2035_Bull = MonthVU2035PrevValuehigh * (100 - Fund2035PartialReinvest)/100.00;
					
					temp2035High = currentValue * (100 - Fund2035PartialReinvest)/100.00;
					Withdrawtemp2035High = currentValue * (Fund2035PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2035_Bull = 0;
				}
				
				if (aaRound == 2) {
					MonthVU2035PrevValuehigh = 0;
				}
				else{
					MonthVU2035PrevValuehigh = tempPrev;
				}
				
			}
			
			else{
				
				if (aaRound == 2) {
					MonthVU2035PrevValuehigh = currentValue;
				}
				else{
					MonthVU2035PrevValuehigh = tempPrev;
				}
				
			}
			
			
			if (i == 12 && aaRound == 2) {
				VU2035PrevValuehigh = MonthVU2035PrevValuehigh + VU2035Value_EverCash1 + VU2035Value_EverCash6  + VU2035Value_EverCash55;
			}

			
			
			if (i == 12 && aaRound == 2) {
				return currentValue + VU2035Value_EverCash1 + VU2035Value_EverCash6 + VU2035Value_EverCash55;
			}
			else{
				//return MonthVU2035PrevValuehigh;
				return currentValue;
			}
			
			
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0 ) {
				
				currentValue=  ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
				(1 + VU2035InstHigh) + VU2035PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstHigh:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
				MAX(0,(FundValueOfTheYearVU2035ValueHigh_Basic/FundValueOfTheYearValueTotalHigh));
				
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
					(1 + VU2035InstHigh) + VU2035PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstHigh:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					
					VU2035ValueHigh = currentValue;
				}
				else{
					currentValue = VU2035ValueHigh;
				}
				
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2035InstHigh:@"M"])/(pow((1 + [self ReturnVU2035InstHigh:@"A"]), (1.00/12.00)));
				}
			}
			
			if (aaRound == 2) {
				VU2035PrevValuehigh = currentValue + VU2035Value_EverCash1 + VU2035Value_EverCash6 + (VU2035Value_EverCash55 * CashFactor);
			}
			
			
			return currentValue + VU2035Value_EverCash1 + VU2035Value_EverCash6 + (VU2035Value_EverCash55 * CashFactor);
		}
		
		
	}
}

-(double)ReturnVU2035ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2035) {
		VU2035PrevValueMedian = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			if (i == 1) {
				MonthVU2035PrevValueMedian = VU2035PrevValueMedian;
			}
			
			if (i > MonthDiff2035 && aaPolicyYear == YearDiff2035) {
				VU2035PrevValueMedian = 0.00;
				MonthVU2035PrevValueMedian = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2035PrevValueMedian;
			if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
				MonthVU2035PrevValueMedian = MonthVU2035PrevValueMedian + (temp2030Median * Fund2030ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				MonthVU2035PrevValueMedian = MonthVU2035PrevValueMedian + (temp2028Median * Fund2028ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				MonthVU2035PrevValueMedian = MonthVU2035PrevValueMedian + (temp2025Median * Fund2025ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVU2035PrevValueMedian = MonthVU2035PrevValueMedian + (temp2023Median * Fund2023ReinvestTo2035Fac/100.00);
			}
			else{
				
			}
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalMedian != 0 ) {
				
				currentValue=  ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2035Factor/100.00 * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
				pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/12.00)) + MonthVU2035PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/12.00)) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2035ValueMedian_Basic/MonthFundValueOfTheYearValueTotalMedian));
			}
			else{
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] *[self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2035Factor/100.00 * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
				pow((1 + [self ReturnVU2035InstMedian:@"A" ]), (1.00/12.00)) + MonthVU2035PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/12.00)) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			
			
			if (i == MonthDiff2035 && aaPolicyYear == YearDiff2035) {
				if (Fund2035PartialReinvest != 100) {
					MonthFundMaturityValue2035_Flat = MonthVU2035PrevValueMedian * (100 - Fund2035PartialReinvest)/100.00;
					temp2035Median = currentValue * (100 - Fund2035PartialReinvest)/100.00;
					Withdrawtemp2035Median = currentValue * (Fund2035PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2035_Flat = 0;
				}
				if (aaRound == 2) {
					MonthVU2035PrevValueMedian = 0;
				}
				else{
					MonthVU2035PrevValueMedian = tempPrev;
				}
				
			}
			else{
				if (aaRound == 2) {
					MonthVU2035PrevValueMedian = currentValue;
				}
				else{
					MonthVU2035PrevValueMedian = tempPrev;
				}
				
			}
			
			if (i == 12 && aaRound == 2) {
				VU2035PrevValueMedian = MonthVU2035PrevValueMedian + VU2035Value_EverCash1 + VU2035Value_EverCash6 + VU2035Value_EverCash55;
			}
			
			//return MonthVU2035PrevValueMedian;
			if (i == 12 && aaRound == 2) {
				return currentValue + VU2035Value_EverCash1 + VU2035Value_EverCash6 + VU2035Value_EverCash55;
			}
			else{
				return currentValue;
			}
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0 ) {
				
				currentValue=  ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] ) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
				(1 + VU2035InstMedian) + VU2035PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstMedian:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				MAX(0,(FundValueOfTheYearVU2035ValueMedian_Basic/FundValueOfTheYearValueTotalMedian));
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
					(1 + VU2035InstMedian) + VU2035PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstMedian:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2035ValueMedian = currentValue;
				}
				else{
					currentValue = VU2035ValueMedian;
				}
			}
			
			//NSLog(@"%f", VU2035InstMedian);
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2035InstMedian:@"M"])/(pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/12.00)));
				}
			}
			
			if (aaRound == 2) {
				VU2035PrevValueMedian = currentValue + VU2035Value_EverCash1 + VU2035Value_EverCash6 + (VU2035Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2035Value_EverCash1 + VU2035Value_EverCash6 + (VU2035Value_EverCash55 * CashFactor);
		}
		
		
	}
}

-(double)ReturnVU2035ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2035) {
		VU2035PrevValueLow = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			if (i == 1) {
				MonthVU2035PrevValueLow = VU2035PrevValueLow;
			}
			
			if (i > MonthDiff2035 && aaPolicyYear == YearDiff2035) {
				VU2035PrevValueLow = 0.00;
				MonthVU2035PrevValueLow = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2035PrevValueLow;
			if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
				MonthVU2035PrevValueLow = MonthVU2035PrevValueLow + (temp2030Low * Fund2030ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				MonthVU2035PrevValueLow = MonthVU2035PrevValueLow + (temp2028Low * Fund2028ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				MonthVU2035PrevValueLow = MonthVU2035PrevValueLow + (temp2025Low * Fund2025ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVU2035PrevValueLow = MonthVU2035PrevValueLow + (temp2023Low * Fund2023ReinvestTo2035Fac/100.00);
			}
			else{
				
			}
			
			if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0 ) {
				
				currentValue=  ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2035Factor/100.00 * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
				pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/12.00)) + MonthVU2035PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/12.00)) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				MAX(0,(MonthFundValueOfTheYearVU2035ValueLow_Basic/MonthFundValueOfTheYearValueTotalLow));
			}
			else{
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] *[self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VU2035Factor/100.00 * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
				pow((1 + [self ReturnVU2035InstLow:@"A" ]), (1.00/12.00)) + MonthVU2035PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/12.00)) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			}
			
			
			if (i == MonthDiff2035 && aaPolicyYear == YearDiff2035) {
				if (Fund2035PartialReinvest != 100) {
					MonthFundMaturityValue2035_Bear = MonthVU2035PrevValueLow * (100 - Fund2035PartialReinvest)/100.00;
					temp2035Low = currentValue * (100 - Fund2035PartialReinvest)/100.00;
					Withdrawtemp2035Low = currentValue * (Fund2035PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2035_Bear = 0;
				}
				
				if (aaRound == 2) {
					MonthVU2035PrevValueLow = 0;
				}
				else{
					MonthVU2035PrevValueLow = tempPrev;
				}
				
			}
			else{
				if (aaRound == 2) {
					MonthVU2035PrevValueLow = currentValue;
				}
				else{
					MonthVU2035PrevValueLow = tempPrev;
				}
			}
			
			if (aaRound == 2 && i == 12) {
				VU2035PrevValueLow = MonthVU2035PrevValueLow + VU2035Value_EverCash1 + VU2035Value_EverCash6 + VU2035Value_EverCash55;
			}
			
			//return MonthVU2035PrevValueLow;
			if (aaRound == 2 && i == 12) {
				return currentValue + VU2035Value_EverCash1 + VU2035Value_EverCash6 + VU2035Value_EverCash55;
			}
			else{
				return currentValue;
			}
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0 ) {
				
				currentValue=  ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] ) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
				(1 + VU2035InstLow) + VU2035PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstLow:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				MAX(0,(FundValueOfTheYearVU2035ValueLow_Basic/FundValueOfTheYearValueTotalLow));
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
					(1 + VU2035InstLow) + VU2035PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstLow:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2035ValueLow = currentValue;
				}
				else{
					currentValue = VU2035ValueLow;
				}
			}
			
			if (ECAR55Exist == TRUE) {
				if (Age + aaPolicyYear < 55) {
					CashFactor = 0.00;
				}
				else if(Age + aaPolicyYear == 55){
					CashFactor = 1.00;
				}
				else{
					CashFactor = 12 * (1 + [self ReturnVU2035InstLow:@"M"])/(pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/12.00)));
				}
			}
			
			if (aaRound == 2) {
				VU2035PrevValueLow = currentValue + VU2035Value_EverCash1 + VU2035Value_EverCash6 + (VU2035Value_EverCash55 * CashFactor);
			}
			
			return currentValue + VU2035Value_EverCash1 + VU2035Value_EverCash6 + (VU2035Value_EverCash55 * CashFactor);
		}
		
		
	}
}


-(double)ReturnVUCashValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)i {
	
	double tempValue = 0.00;
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		if (i == 1) {
			MonthVUCashPrevValueHigh = VUCashPrevValueHigh;
		}
		
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			
			MonthVUCashPrevValueHigh = MonthVUCashPrevValueHigh + (temp2035High * Fund2035ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			MonthVUCashPrevValueHigh = MonthVUCashPrevValueHigh + (temp2030High * Fund2030ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			//NSLog(@"%f", temp2028High);
			MonthVUCashPrevValueHigh = MonthVUCashPrevValueHigh + (temp2028High * Fund2028ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			MonthVUCashPrevValueHigh = MonthVUCashPrevValueHigh + (temp2025High * Fund2025ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			MonthVUCashPrevValueHigh = MonthVUCashPrevValueHigh + (temp2023High * Fund2023ReinvestToCashFac/100.00);
		}
		else{
			
		}
		
		tempValue = ((( [strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor +
					 [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor +
					 [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor) *
		pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/12.00)) + MonthVUCashPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
		pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/12.00)) - (PolicyFee + [self ReturnTotalBasicMortHigh:aaPolicyYear]) -
		([self ReturnRegWithdrawal:aaPolicyYear] * [self ReturnRegWithdrawalFactor:i]);
		
		MonthVUCashPrevValueHigh =  tempValue;
		//NSLog(@"%f", MonthVUCashPrevValueHigh);
		
		if (tempValue < 0) {
			MonthVUCashPrevValueHigh = 1.00;
		}
		else{
			MonthVUCashPrevValueHigh = tempValue;
		}
		
		if (i == 12) {
			VUCashPrevValueHigh = MonthVUCashPrevValueHigh + VUCashValue_EverCash1 + VUCashValue_EverCash6 + VUCashValue_EverCash55;;
		}
		
		if (tempValue < 0 && MonthFundValueOfTheYearValueTotalHigh != 0) {
			NegativeValueOfMaxCashFundHigh = tempValue;
			VUCashValueNegative = TRUE;
			return MonthVUCashPrevValueHigh;
		} else {
			NegativeValueOfMaxCashFundHigh = tempValue;
			VUCashValueNegative = FALSE;
			if (i == 12) {
				return MonthVUCashPrevValueHigh	+ VUCashValue_EverCash1 + VUCashValue_EverCash6 + VUCashValue_EverCash55;;
			}
			else{
				return MonthVUCashPrevValueHigh + 0; // to be edit later
			}
			
		}
		
	}
	else
	{
		tempValue = ((( [strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear] * CYFactor +
					 [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear] * CYFactor +
					 [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * [self ReturnVUCashFac:aaPolicyYear] * CYFactor) *
		(1 + [self ReturnVUCashInstHigh:@""]) + VUCashPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUCashInstHigh:@"A"]) -
		(PolicyFee + [self ReturnTotalBasicMortHigh:aaPolicyYear]) * [self ReturnVUCashHigh] -
		([self ReturnRegWithdrawal:aaPolicyYear] * 1);
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear < 55) {
				CashFactor = 0.00;
			}
			else if(Age + aaPolicyYear == 55){
				CashFactor = 1.00;
			}
			else{
				CashFactor = 12 * (1 + [self ReturnVUCashInstHigh:@"M"])/(pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/12.00)));
			}
		}
		
		if (tempValue < 0) {
			VUCashPrevValueHigh = 1.00;
		}
		else{
			VUCashPrevValueHigh = tempValue + VUCashValue_EverCash1 + VUCashValue_EverCash6 + (VUCashValue_EverCash55 * CashFactor) ;
		}
		
		
		//VUCashPrevValueHigh = tempValue;
		if (tempValue < 0 && FundValueOfTheYearValueTotalHigh != 0) {
			//NegativeValueOfMaxCashFundHigh = tempValue;
			NegativeValueOfMaxCashFundHigh = tempValue;
			VUCashValueNegative = TRUE;
			return VUCashPrevValueHigh;
		} else {
			VUCashValueNegative = FALSE;
			NegativeValueOfMaxCashFundHigh = tempValue;
			return tempValue + VUCashValue_EverCash1 + VUCashValue_EverCash6 + (VUCashValue_EverCash55 * CashFactor) ; // to be edit later
		}
	}
	
	
	
	
	
}

-(double)ReturnVUCashValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)i{
	
	double tempValue = 0.00;
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		if (i == 1) {
			MonthVUCashPrevValueMedian = VUCashPrevValueMedian;
		}
		
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			MonthVUCashPrevValueMedian = MonthVUCashPrevValueMedian + (temp2035Median * Fund2035ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			MonthVUCashPrevValueMedian = MonthVUCashPrevValueMedian + (temp2030Median * Fund2030ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			MonthVUCashPrevValueMedian = MonthVUCashPrevValueMedian + (temp2028Median * Fund2028ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			MonthVUCashPrevValueMedian = MonthVUCashPrevValueMedian + (temp2025Median * Fund2025ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			MonthVUCashPrevValueMedian = MonthVUCashPrevValueMedian + (temp2023Median * Fund2023ReinvestToCashFac/100.00);
		}
		else{
			
		}
		
		tempValue = ((( [strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor +
					 [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor +
					 [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor) *
		pow(1 + [self ReturnVUCashInstMedian:@"A"], 1.00/12.00) + MonthVUCashPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
		pow(1 + [self ReturnVUCashInstMedian:@"A"], 1.00/12.00) - (PolicyFee + [self ReturnTotalBasicMortMedian:aaPolicyYear]) -
		([self ReturnRegWithdrawal:aaPolicyYear] * [self ReturnRegWithdrawalFactor:i]);
		
		MonthVUCashPrevValueMedian = tempValue;
		
		if (tempValue < 0) {
			MonthVUCashPrevValueMedian = 1.00;
		}
		else{
			MonthVUCashPrevValueMedian = tempValue;
		}
		
		
		if (i == 12) {
			VUCashPrevValueMedian = MonthVUCashPrevValueMedian + VUCashValue_EverCash1 + VUCashValue_EverCash6 + VUCashValue_EverCash55;
		}
		
		
		if (tempValue < 0 && MonthFundValueOfTheYearValueTotalMedian != 0) {
			NegativeValueOfMaxCashFundMedian = tempValue;
			VUCashValueNegative = TRUE;
			return  MonthVUCashPrevValueMedian;
		} else {
			NegativeValueOfMaxCashFundMedian =  tempValue;
			VUCashValueNegative = FALSE;
			if (i == 12) {
				return  MonthVUCashPrevValueMedian + VUCashValue_EverCash1 + VUCashValue_EverCash6 + VUCashValue_EverCash55;
			}
			else{
				return  MonthVUCashPrevValueMedian; // to be edit later
			}
		}
		
		
		
		
	}
	else{
		tempValue = ((( [strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear] * CYFactor +
					 [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear] * CYFactor +
					 [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * [self ReturnVUCashFac:aaPolicyYear] * CYFactor) *
		(1 + [self ReturnVUCashInstMedian:@""]) + VUCashPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUCashInstMedian:@"A"]) -
		(PolicyFee + [self ReturnTotalBasicMortMedian:aaPolicyYear]) * [self ReturnVUCashMedian] -
		([self ReturnRegWithdrawal:aaPolicyYear] * 1);
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear < 55) {
				CashFactor = 0.00;
			}
			else if(Age + aaPolicyYear == 55){
				CashFactor = 1.00;
			}
			else{
				CashFactor = 12 * (1 + [self ReturnVUCashInstMedian:@"M"])/(pow((1 + [self ReturnVUCashInstMedian:@"A"]), (1.00/12.00)));
			}
		}
		
		if (tempValue < 0) {
			VUCashPrevValueMedian = 1.00;
		}
		else{
			VUCashPrevValueMedian = tempValue + VUCashValue_EverCash1 + VUCashValue_EverCash6 + (VUCashValue_EverCash55 * CashFactor);
		}
		
		//VUCashPrevValueMedian = tempValue;
		if (tempValue < 0 && FundValueOfTheYearValueTotalMedian != 0) {
			NegativeValueOfMaxCashFundMedian = tempValue;
			VUCashValueNegative = TRUE;
			return VUCashPrevValueMedian;
			//return tempValue;
		} else {
			NegativeValueOfMaxCashFundMedian = tempValue;
			VUCashValueNegative = FALSE;
			return tempValue + VUCashValue_EverCash1 + VUCashValue_EverCash6 + (VUCashValue_EverCash55 * CashFactor);
		}
		
		
	}
	
	
	
	
}


-(double)ReturnVUCashValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)i{
	
	double tempValue = 0.00;
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		if (i == 1) {
			MonthVUCashPrevValueLow = VUCashPrevValueLow;
		}
		
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			MonthVUCashPrevValueLow = MonthVUCashPrevValueLow + (temp2035Low * Fund2035ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			MonthVUCashPrevValueLow = MonthVUCashPrevValueLow + (temp2030Low * Fund2030ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			MonthVUCashPrevValueLow = MonthVUCashPrevValueLow + (temp2028Low * Fund2028ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			MonthVUCashPrevValueLow = MonthVUCashPrevValueLow + (temp2025Low * Fund2025ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			MonthVUCashPrevValueLow = MonthVUCashPrevValueLow + (temp2023Low * Fund2023ReinvestToCashFac/100.00);
		}
		else{
			
		}
		
		tempValue = ((( [strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor +
					 [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor +
					 [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor) *
		pow(1 + [self ReturnVUCashInstLow:@"A"], 1.00/12.00) + MonthVUCashPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
		pow(1 + [self ReturnVUCashInstLow:@"A"], 1.00/12.00) - (PolicyFee + [self ReturnTotalBasicMortLow:aaPolicyYear]) -
		([self ReturnRegWithdrawal:aaPolicyYear] * [self ReturnRegWithdrawalFactor:i]);
		
		
		
		if (tempValue < 0) {
			MonthVUCashPrevValueLow = 1.00;
		}
		else{
			MonthVUCashPrevValueLow = tempValue;
		}
		
		if (i == 12) {
			VUCashPrevValueLow = MonthVUCashPrevValueLow + VUCashValue_EverCash1 + VUCashValue_EverCash6 + VUCashValue_EverCash55;
		}
		
		
		
		
		if (tempValue < 0 && MonthFundValueOfTheYearValueTotalLow != 0) {
			NegativeValueOfMaxCashFundLow = tempValue;
			VUCashValueNegative = TRUE;
			return  MonthVUCashPrevValueLow;
		} else {
			NegativeValueOfMaxCashFundLow =  tempValue;
			VUCashValueNegative = FALSE;
			if (i == 12) {
				return  MonthVUCashPrevValueLow  + VUCashValue_EverCash1 + VUCashValue_EverCash6 + VUCashValue_EverCash55;
			}
			else{
				return  MonthVUCashPrevValueLow; // to be edit later
			}
		}
	}
	else{
		tempValue = ((( [strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear] * CYFactor +
					 [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear] * CYFactor +
					 [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * [self ReturnVUCashFac:aaPolicyYear] * CYFactor) *
		(1 + [self ReturnVUCashInstLow:@""]) + VUCashPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUCashInstLow:@"A"]) -
		(PolicyFee + [self ReturnTotalBasicMortLow:aaPolicyYear]) * [self ReturnVUCashLow] -
		([self ReturnRegWithdrawal:aaPolicyYear] * 1);
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear < 55) {
				CashFactor = 0.00;
			}
			else if(Age + aaPolicyYear == 55){
				CashFactor = 1.00;
			}
			else{
				CashFactor = 12 * (1 + [self ReturnVUCashInstLow:@"M"])/(pow((1 + [self ReturnVUCashInstLow:@"A"]), (1.00/12.00)));
			}
		}
		
		if (tempValue < 0) {
			VUCashPrevValueLow = 1.00;
		}
		else{
			VUCashPrevValueLow = tempValue + VUCashValue_EverCash1 + VUCashValue_EverCash6 + (VUCashValue_EverCash55 * CashFactor);
		}
		
		//VUCashPrevValueLow = tempValue;
		if (tempValue < 0 && FundValueOfTheYearValueTotalLow != 0) {
			NegativeValueOfMaxCashFundLow = tempValue;
			VUCashValueNegative = TRUE;
			return VUCashPrevValueLow;
			//return tempValue;
		} else {
			NegativeValueOfMaxCashFundLow = tempValue;
			VUCashValueNegative = FALSE;
			return tempValue + VUCashValue_EverCash1 + VUCashValue_EverCash6 + (VUCashValue_EverCash55 * CashFactor); // to be edit later
		}
	}
	
	
	
	
}


-(double)ReturnVURetValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)i{
	
	double currentValue =0.0;
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		
		if (i == 1) {
			MonthVURetPrevValueHigh = VURetPrevValueHigh ;
		}
		
		double tempPrev = MonthVURetPrevValueHigh;
		
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)) {
			MonthVURetPrevValueHigh = MonthVURetPrevValueHigh + (temp2035High * Fund2035ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			MonthVURetPrevValueHigh = MonthVURetPrevValueHigh + (temp2030High * Fund2030ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			MonthVURetPrevValueHigh = MonthVURetPrevValueHigh + (temp2028High * Fund2028ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			MonthVURetPrevValueHigh = MonthVURetPrevValueHigh + (temp2025High * Fund2025ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			MonthVURetPrevValueHigh = MonthVURetPrevValueHigh + (temp2023High * Fund2023ReinvestToRetFac/100.00);
		}
		else{
			
		}
		
		//NSLog(@"%f", MonthVURetPrevValueHigh);
		if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0 ) {
			currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear andMonth:i] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VURetFactor/100.00 * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
			pow(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"],1.00/12.00) + MonthVURetPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"], 1.00/12.00) -
			([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
			MAX(0,(MonthFundValueOfTheYearVURetValueHigh_Basic/MonthFundValueOfTheYearValueTotalHigh));
			
			//NSLog(@"%f %f %f",NegativeValueOfMaxCashFundHigh, MonthVURetValueHigh,MonthFundValueOfTheYearValueTotalHigh );
			
		}
		else{
			currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] * CYFactor +
							[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VURetFactor/100.00 * CYFactor +
							[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
			pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]),(1.00/12.00)) + MonthVURetPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/12.00)) -
			([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			
			
		}
		
		//NSLog(@"%f, %f, %f, %f",NegativeValueOfMaxCashFundHigh, MonthVURetValueHigh, MonthFundValueOfTheYearValueTotalHigh, currentValue);
		
		if (aaRound == 2) {
			MonthVURetPrevValueHigh = currentValue;
		}
		else{
			MonthVURetPrevValueHigh = tempPrev;
		}
		
		
		if (i == 12  && aaRound == 2) {
			VURetPrevValueHigh = MonthVURetPrevValueHigh + VURetValue_EverCash1 + VURetValue_EverCash6 + VURetValue_EverCash55;
		}
		
		//NSLog(@"%d %f %f, %d ", i, MonthVURetValueHigh, MonthFundValueOfTheYearValueTotalHigh, VUCashValueNegative);
		//return MonthVURetPrevValueHigh;
		
		if (i == 12  && aaRound == 2) {
			return currentValue + VURetValue_EverCash1 + VURetValue_EverCash6 + VURetValue_EverCash55;
		}
		else{
			return currentValue;		
		}
		
		
		
	}
	else{
		//if (VUCashValueHigh < 0 && [self ReturnFundValueOfTheYearValueTotalHigh:aaPolicyYear] != 0 ) {
		if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0 ) {
			currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
			(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@""]) + VURetPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]) -
			([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
			MAX(0,(FundValueOfTheYearVURetValueHigh_Basic/FundValueOfTheYearValueTotalHigh));
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
				(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@""]) + VURetPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				VURetValueHigh = currentValue;
			}
			else{
				currentValue = VURetValueHigh;
			}
			
		}
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear < 55) {
				CashFactor = 0.00;
			}
			else if(Age + aaPolicyYear == 55){
				CashFactor = 1.00;
			}
			else{
				CashFactor = 12 * (1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"M"])/(pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/12.00)));
			}
		}
		
		if (aaRound == 2) {
			VURetPrevValueHigh = currentValue + VURetValue_EverCash1 + VURetValue_EverCash6 + (VURetValue_EverCash55 * CashFactor);
		}
		
		
		return currentValue + VURetValue_EverCash1 + VURetValue_EverCash6 + (VURetValue_EverCash55 * CashFactor);
	}
	
	
}

-(double)ReturnVURetValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		
		if (i == 1) {
			MonthVURetPrevValueMedian = VURetPrevValueMedian ;
		}
		
		double tempPrev = MonthVURetPrevValueMedian;
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			MonthVURetPrevValueMedian = MonthVURetPrevValueMedian + (temp2035Median * Fund2035ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			MonthVURetPrevValueMedian = MonthVURetPrevValueMedian + (temp2030Median * Fund2030ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			MonthVURetPrevValueMedian = MonthVURetPrevValueMedian + (temp2028Median * Fund2028ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			MonthVURetPrevValueMedian = MonthVURetPrevValueMedian + (temp2025Median * Fund2025ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			MonthVURetPrevValueMedian = MonthVURetPrevValueMedian + (temp2023Median * Fund2023ReinvestToRetFac/100.00);
		}
		else{
			
		}
		
		if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalMedian != 0 ) {
			currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VURetFactor/100.00 * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
			pow(1 + [self ReturnVURetInstMedian:@"A"], 1.00/12.00) + MonthVURetPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVURetInstMedian:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
			MAX(0,(MonthFundValueOfTheYearVURetValueMedian_Basic/MonthFundValueOfTheYearValueTotalMedian));
			
		}
		else{
			currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] * CYFactor +
							[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VURetFactor/100.00 * CYFactor +
							[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
			pow(1 + [self ReturnVURetInstMedian:@"A"], 1.00/12.00) + MonthVURetPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVURetInstMedian:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			
		}
		
		if (aaRound == 2) {
			MonthVURetPrevValueMedian = currentValue;
		}
		else{
			MonthVURetPrevValueMedian = tempPrev;
		}
		
		if (i == 12  && aaRound == 2) {
			VURetPrevValueMedian = MonthVURetPrevValueMedian + VURetValue_EverCash1 + VURetValue_EverCash6 + VURetValue_EverCash55;
		}
		
		if (i == 12  && aaRound == 2) {
			//return MonthVURetPrevValueMedian;
			return currentValue + VURetValue_EverCash1 + VURetValue_EverCash6 + VURetValue_EverCash55;
		}
		else
		{
			return currentValue;
		}
		
		
	}
	else{
		//if (VUCashValueMedian < 0 && [self ReturnFundValueOfTheYearValueTotalMedian:aaPolicyYear] != 0 ) {
		if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0 ) {
			currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
			(1 + [self ReturnVURetInstMedian:@""]) + VURetPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstMedian:@"A"]) -
			([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
			MAX(0,(FundValueOfTheYearVURetValueMedian_Basic/FundValueOfTheYearValueTotalMedian));
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
				(1 + [self ReturnVURetInstMedian:@""]) + VURetPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstMedian:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				VURetValueMedian = currentValue;
			}
			else{
				currentValue = VURetValueMedian;
			}
		}
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear < 55) {
				CashFactor = 0.00;
			}
			else if(Age + aaPolicyYear == 55){
				CashFactor = 1.00;
			}
			else{
				CashFactor = 12 * (1 + [self ReturnVURetInstMedian:@"M"])/(pow((1 + [self ReturnVURetInstMedian:@"A"]), (1.00/12.00)));
			}
		}
		
		if (aaRound == 2) {
			VURetPrevValueMedian = currentValue + VURetValue_EverCash1 + VURetValue_EverCash6 + (VURetValue_EverCash55 * CashFactor);
		}
		return currentValue + VURetValue_EverCash1 + VURetValue_EverCash6 + (VURetValue_EverCash55 * CashFactor);
	}
	
}

-(double)ReturnVURetValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		
		if (i == 1) {
			MonthVURetPrevValueLow = VURetPrevValueLow ;
		}
		
		double tempPrev = MonthVURetPrevValueLow;
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			MonthVURetPrevValueLow = MonthVURetPrevValueLow + (temp2035Low * Fund2035ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			MonthVURetPrevValueLow = MonthVURetPrevValueLow + (temp2030Low * Fund2030ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			MonthVURetPrevValueLow = MonthVURetPrevValueLow + (temp2028Low * Fund2028ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			MonthVURetPrevValueLow = MonthVURetPrevValueLow + (temp2025Low * Fund2025ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			MonthVURetPrevValueLow = MonthVURetPrevValueLow + (temp2023Low * Fund2023ReinvestToRetFac/100.00);
		}
		else{
			
		}
		
		if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0 ) {
			currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VURetFactor/100.00 * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
			pow(1 + [self ReturnVURetInstLow:@"A"], 1.00/12.00) + MonthVURetPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVURetInstLow:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
			MAX(0,(MonthFundValueOfTheYearVURetValueLow_Basic/MonthFundValueOfTheYearValueTotalLow));
			
		}
		else{
			currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] * CYFactor +
							[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VURetFactor/100.00 * CYFactor +
							[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
			pow(1 + [self ReturnVURetInstLow:@"A"], 1.00/12.00) + MonthVURetPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVURetInstLow:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			
		}
		
		
		if (aaRound == 2) {
			MonthVURetPrevValueLow = currentValue;
		}
		else{
			MonthVURetPrevValueLow = tempPrev;
		}
		
		if (i == 12  && aaRound == 2) {
			VURetPrevValueLow = MonthVURetPrevValueLow + VURetValue_EverCash1 + VURetValue_EverCash6  + VURetValue_EverCash55;
		}
		
		if (i == 12  && aaRound == 2) {
			//return MonthVURetPrevValueLow;
			return currentValue + VURetValue_EverCash1 + VURetValue_EverCash6 + VURetValue_EverCash55;
		}
		else{
			return currentValue;
		}
		
	}
	else{
		if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0 ) {
			currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
			(1 + [self ReturnVURetInstLow:@""]) + VURetPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstLow:@"A"]) -
			([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
			MAX(0,(FundValueOfTheYearVURetValueLow_Basic/FundValueOfTheYearValueTotalLow));
			
			//NSLog(@"");
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
				(1 + [self ReturnVURetInstLow:@""]) + VURetPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstLow:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				VURetValueLow = currentValue;
			}
			else{
				currentValue = VURetValueLow;
			}
			
		}
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear < 55) {
				CashFactor = 0.00;
			}
			else if(Age + aaPolicyYear == 55){
				CashFactor = 1.00;
			}
			else{
				CashFactor = 12 * (1 + [self ReturnVURetInstLow:@"M"])/(pow((1 + [self ReturnVURetInstLow:@"A"]), (1.00/12.00)));
			}
		}
		
		if (aaRound == 2) {
			VURetPrevValueLow = currentValue + VURetValue_EverCash1 + VURetValue_EverCash6 + (VURetValue_EverCash55 * CashFactor);
		}
		return currentValue + VURetValue_EverCash1 + VURetValue_EverCash6 + (VURetValue_EverCash55 * CashFactor);
	}
	
}

-(double)ReturnVUDanaValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)i{
	
	double currentValue =0.0;
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		
		if (i == 1) {
			MonthVUDanaPrevValueHigh = VUDanaPrevValueHigh ;
		}
		
		double tempPrev = MonthVUDanaPrevValueHigh;
		
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)) {
			MonthVUDanaPrevValueHigh = MonthVUDanaPrevValueHigh + (temp2035High * Fund2035ReinvestToDanaFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			MonthVUDanaPrevValueHigh = MonthVUDanaPrevValueHigh + (temp2030High * Fund2030ReinvestToDanaFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			MonthVUDanaPrevValueHigh = MonthVUDanaPrevValueHigh + (temp2028High * Fund2028ReinvestToDanaFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			MonthVUDanaPrevValueHigh = MonthVUDanaPrevValueHigh + (temp2025High * Fund2025ReinvestToDanaFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			MonthVUDanaPrevValueHigh = MonthVUDanaPrevValueHigh + (temp2023High * Fund2023ReinvestToDanaFac/100.00);
		}
		else{
			
		}
		
		//NSLog(@"%f", MonthVURetPrevValueHigh);
		if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0 ) {
			currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear andMonth:i] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VUDanaFactor/100.00 * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VUDanaFactor * CYFactor) *
			pow(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"],1.00/12.00) + MonthVUDanaPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"], 1.00/12.00) -
			([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
			MAX(0,(MonthFundValueOfTheYearVUDanaValueHigh_Basic/MonthFundValueOfTheYearValueTotalHigh));
			
			//NSLog(@"%f %f %f",NegativeValueOfMaxCashFundHigh, MonthVURetValueHigh,MonthFundValueOfTheYearValueTotalHigh );
			
		}
		else{
			currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear  andMonth:i] * CYFactor +
							[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VUDanaFactor/100.00 * CYFactor +
							[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VUDanaFactor * CYFactor) *
			pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]),(1.00/12.00)) + MonthVUDanaPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/12.00)) -
			([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			
			
		}
		
		//NSLog(@"%f, %f, %f, %f",NegativeValueOfMaxCashFundHigh, MonthVURetValueHigh, MonthFundValueOfTheYearValueTotalHigh, currentValue);
		
		if (aaRound == 2) {
			MonthVUDanaPrevValueHigh = currentValue;
		}
		else{
			MonthVUDanaPrevValueHigh = tempPrev;
		}
		
		
		if (i == 12  && aaRound == 2) {
			VUDanaPrevValueHigh = MonthVUDanaPrevValueHigh + VUDanaValue_EverCash1 + VUDanaValue_EverCash6 + VUDanaValue_EverCash55;
		}
		
		//NSLog(@"%d %f %f, %d ", i, MonthVURetValueHigh, MonthFundValueOfTheYearValueTotalHigh, VUCashValueNegative);
		//return MonthVURetPrevValueHigh;
		if (i == 12  && aaRound == 2) {
			return currentValue + VUDanaValue_EverCash1 + VUDanaValue_EverCash6 + VUDanaValue_EverCash55;
		}
		else{
			return currentValue ;
		}
		
		
		
		
	}
	else{
		//if (VUCashValueHigh < 0 && [self ReturnFundValueOfTheYearValueTotalHigh:aaPolicyYear] != 0 ) {
		if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0 ) {
			currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUDanaFac:aaPolicyYear] * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VUDanaFactor * CYFactor) *
			(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@""]) + VUDanaPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]) -
			([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
			MAX(0,(FundValueOfTheYearVUDanaValueHigh_Basic/FundValueOfTheYearValueTotalHigh));
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUDanaFac:aaPolicyYear] * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VUDanaFactor * CYFactor) *
				(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@""]) + VUDanaPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				
				VUDanaValueHigh = currentValue;
			}
			else{
				currentValue = VUDanaValueHigh;
			}
			
		}

		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear < 55) {
				CashFactor = 0.00;
			}
			else if(Age + aaPolicyYear == 55){
				CashFactor = 1.00;
			}
			else{
				CashFactor = 12 * (1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"M"])/(pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/12.00)));
			}
		}
		
		//NSLog(@"%d %f, %d ", aaPolicyYear,  [self ReturnVUDanaFac:aaPolicyYear], aaRound );
		
		if (aaRound == 2) {
			VUDanaPrevValueHigh = currentValue +  VUDanaValue_EverCash1 + VUDanaValue_EverCash6 + (VUDanaValue_EverCash55 * CashFactor);
		}
		
		return currentValue +  VUDanaValue_EverCash1 + VUDanaValue_EverCash6 + (VUDanaValue_EverCash55 * CashFactor);
	}
	
	
}

-(double)ReturnVUDanaValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		
		if (i == 1) {
			MonthVUDanaPrevValueMedian = VUDanaPrevValueMedian ;
		}
		
		double tempPrev = MonthVUDanaPrevValueMedian;
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			MonthVUDanaPrevValueMedian = MonthVUDanaPrevValueMedian + (temp2035Median * Fund2035ReinvestToDanaFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			MonthVUDanaPrevValueMedian = MonthVUDanaPrevValueMedian + (temp2030Median * Fund2030ReinvestToDanaFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			MonthVUDanaPrevValueMedian = MonthVUDanaPrevValueMedian + (temp2028Median * Fund2028ReinvestToDanaFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			MonthVUDanaPrevValueMedian = MonthVUDanaPrevValueMedian + (temp2025Median * Fund2025ReinvestToDanaFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			MonthVUDanaPrevValueMedian = MonthVUDanaPrevValueMedian + (temp2023Median * Fund2023ReinvestToDanaFac/100.00);
		}
		else{
			
		}
		
		if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalMedian != 0 ) {
			currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear  andMonth:i] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VUDanaFactor/100.00 * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VUDanaFactor * CYFactor) *
			pow(1 + [self ReturnVUDanaInstMedian:@"A"], 1.00/12.00) + MonthVUDanaPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVUDanaInstMedian:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
			MAX(0,(MonthFundValueOfTheYearVUDanaValueMedian_Basic/MonthFundValueOfTheYearValueTotalMedian));
			
		}
		else{
			currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear  andMonth:i] * CYFactor +
							[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VUDanaFactor/100.00 * CYFactor +
							[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VUDanaFactor * CYFactor) *
			pow(1 + [self ReturnVUDanaInstMedian:@"A"], 1.00/12.00) + MonthVUDanaPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVUDanaInstMedian:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			
		}
		
		if (aaRound == 2) {
			MonthVUDanaPrevValueMedian = currentValue;
		}
		else{
			MonthVUDanaPrevValueMedian = tempPrev;
		}
		
		if (i == 12  && aaRound == 2) {
			VUDanaPrevValueMedian = MonthVUDanaPrevValueMedian + VUDanaValue_EverCash1 + VUDanaValue_EverCash6 + VUDanaValue_EverCash55;
		}
		
		if (i == 12  && aaRound == 2) {
			//return MonthVURetPrevValueMedian;
			return currentValue + VUDanaValue_EverCash1 + VUDanaValue_EverCash6 + VUDanaValue_EverCash55;
		}
		else{
			//return MonthVURetPrevValueMedian;
			return currentValue;
		}
		
	}
	else{
		//if (VUCashValueMedian < 0 && [self ReturnFundValueOfTheYearValueTotalMedian:aaPolicyYear] != 0 ) {
		if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0 ) {
			currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUDanaFac:aaPolicyYear] * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VUDanaFactor * CYFactor) *
			(1 + [self ReturnVUDanaInstMedian:@""]) + VUDanaPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUDanaInstMedian:@"A"]) -
			([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
			MAX(0,(FundValueOfTheYearVUDanaValueMedian_Basic/FundValueOfTheYearValueTotalMedian));
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUDanaFac:aaPolicyYear] * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VUDanaFactor * CYFactor) *
				(1 + [self ReturnVUDanaInstMedian:@""]) + VUDanaPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUDanaInstMedian:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				VUDanaValueMedian = currentValue;
			}
			else{
				currentValue = VUDanaValueMedian;
			}
		}
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear < 55) {
				CashFactor = 0.00;
			}
			else if(Age + aaPolicyYear == 55){
				CashFactor = 1.00;
			}
			else{
				CashFactor = 12 * (1 + [self ReturnVUDanaInstMedian:@"M"])/(pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (1.00/12.00)));
			}
		}
		
		if (aaRound == 2) {
			VUDanaPrevValueMedian = currentValue +  VUDanaValue_EverCash1  + VUDanaValue_EverCash6 + (VUDanaValue_EverCash55 * CashFactor);
		}
		return currentValue +  VUDanaValue_EverCash1 + VUDanaValue_EverCash6 + (VUDanaValue_EverCash55 * CashFactor);
	}
	
}

-(double)ReturnVUDanaValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		
		if (i == 1) {
			MonthVUDanaPrevValueLow = VUDanaPrevValueLow ;
		}
		
		double tempPrev = MonthVUDanaPrevValueLow;
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			MonthVUDanaPrevValueLow = MonthVUDanaPrevValueLow + (temp2035Low * Fund2035ReinvestToDanaFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			MonthVUDanaPrevValueLow = MonthVUDanaPrevValueLow + (temp2030Low * Fund2030ReinvestToDanaFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			MonthVUDanaPrevValueLow = MonthVUDanaPrevValueLow + (temp2028Low * Fund2028ReinvestToDanaFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			MonthVUDanaPrevValueLow = MonthVUDanaPrevValueLow + (temp2025Low * Fund2025ReinvestToDanaFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			MonthVUDanaPrevValueLow = MonthVUDanaPrevValueLow + (temp2023Low * Fund2023ReinvestToDanaFac/100.00);
		}
		else{
			
		}
		
		if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0 ) {
			currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear  andMonth:i] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VUDanaFactor/100.00 * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VUDanaFactor * CYFactor) *
			pow(1 + [self ReturnVUDanaInstLow:@"A"], 1.00/12.00) + MonthVUDanaPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVUDanaInstLow:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
			MAX(0,(MonthFundValueOfTheYearVUDanaValueLow_Basic/MonthFundValueOfTheYearValueTotalLow));
			
		}
		else{
			currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear  andMonth:i] * CYFactor +
							[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnPremiumFactor:i] * VUDanaFactor/100.00 * CYFactor +
							[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VUDanaFactor * CYFactor) *
			pow(1 + [self ReturnVUDanaInstLow:@"A"], 1.00/12.00) + MonthVUDanaPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVUDanaInstLow:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
			
		}
		
		
		if (aaRound == 2) {
			MonthVUDanaPrevValueLow = currentValue;
		}
		else{
			MonthVUDanaPrevValueLow = tempPrev;
		}
		
		if (i == 12  && aaRound == 2) {
			VUDanaPrevValueLow = MonthVUDanaPrevValueLow + VUDanaValue_EverCash1 + VUDanaValue_EverCash6 + VUDanaValue_EverCash55;
		}
		
		if (i == 12  && aaRound == 2) {
			//return MonthVURetPrevValueLow;
			return currentValue + VUDanaValue_EverCash1 + VUDanaValue_EverCash6 + VUDanaValue_EverCash55;
		}
		else{
			return currentValue;
		}
		
	}
	else{
		if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0 ) {
			currentValue= ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUDanaFac:aaPolicyYear] * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VUDanaFactor * CYFactor) *
			(1 + [self ReturnVUDanaInstLow:@""]) + VUDanaPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUDanaInstLow:@"A"]) -
			([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
			MAX(0,(FundValueOfTheYearVUDanaValueLow_Basic/FundValueOfTheYearValueTotalLow));
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([strBasicPremium doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUDanaFac:aaPolicyYear] * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VUDanaFactor * CYFactor) *
				(1 + [self ReturnVUDanaInstLow:@""]) + VUDanaPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUDanaInstLow:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				VUDanaValueLow = currentValue;
			}
			else{
				currentValue = VUDanaValueLow;
			}
			
		}
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear < 55) {
				CashFactor = 0.00;
			}
			else if(Age + aaPolicyYear == 55){
				CashFactor = 1.00;
			}
			else{
				CashFactor = 12 * (1 + [self ReturnVUDanaInstLow:@"M"])/(pow((1 + [self ReturnVUDanaInstLow:@"A"]), (1.00/12.00)));
			}
		}
		
		if (aaRound == 2) {
			VUDanaPrevValueLow = currentValue +  VUDanaValue_EverCash1 + VUDanaValue_EverCash6 + (VUDanaValue_EverCash55 * CashFactor);
		}
		return currentValue +  VUDanaValue_EverCash1 + VUDanaValue_EverCash6 + (VUDanaValue_EverCash55 * CashFactor);
	}
	
}



-(double)ReturnRegWithdrawal :(int)aaPolicyYear{
	if (aaPolicyYear >= RegWithdrawalStartYear) {
		if (aaPolicyYear <= RegWithdrawalEndYear) {
			if ((aaPolicyYear - RegWithdrawalStartYear) % RegWithdrawalIntYear == 0) {
				return RegWithdrawalAmount;
			}
			else{
				return 0;
			}
		}
		else{
			return 0;
		}
	}
	else{
		return 0;
	}
}

-(double)ReturnRegWithdrawalFactor :(int)aaMonth{
	if (aaMonth == 12) {
		return 1.00;
	}
	else{
		return 0;
	}
}

-(double)ReturnRegTopUpPrem{
	/*
	if (![strGrayRTUPAmount isEqualToString:@""]) {
		return [strGrayRTUPAmount doubleValue ];
	}
	else{
		return 0;
	}
	 */
	return [strGrayRTUPAmount doubleValue ];
}

-(double)ReturnRiderRegTopUpPrem :(int) aaPolicyYear{
	if ([strRRTUOPrem isEqualToString:@""]) {
		return 0.00;
	}
	else{
		if (aaPolicyYear > [strRRTUOFrom intValue ] && aaPolicyYear < ([strRRTUOFrom intValue] + [strRRTUOFor intValue])) {
			return [strRRTUOPrem doubleValue];
		}
		else{
			return 0.00;
		}
	}
	
}


#pragma mark - Calculate Fund Surrender Value for Rider
-(double)ReturnRiderVU2023ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)aaMonth{
	double currentValue;
	if (aaPolicyYear > YearDiff2023) {
		RiderVU2023PrevValuehigh = 0.00;
		return 0.00;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			//month calculation
			
			
			if (aaMonth == 1) {
				RiderMonthVU2023PrevValuehigh = RiderVU2023PrevValuehigh;
			}
			
			if (aaMonth > MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				RiderMonthVU2023PrevValuehigh = 0;
				RiderVU2023PrevValuehigh = 0.00;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2023PrevValuehigh;
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalHigh != 0 ) {
				
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:aaMonth] ) + IncreasePrem) * [self ReturnVU2023Fac] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2023Factor * [self ReturnPremiumFactor:aaMonth]) *
				pow((1 + [self ReturnVU2023InstHigh:@"A" ]), (1.00/12.00)) + RiderMonthVU2023PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear] * [self ReturnLoyaltyBonusFactor:aaMonth]/100.00)) *
				pow((1 + [self ReturnVU2023InstHigh:@"A" ]), 1.00/12.00)  + (NegativeValueOfMaxCashFundHigh - 1) * (RiderMonthVU2023ValueHigh/RiderMonthFundValueOfTheYearValueTotalHigh);
				
			}
			else{
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:aaMonth]) + IncreasePrem) * [self ReturnVU2023Fac] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2023Factor * [self ReturnPremiumFactor:aaMonth]) *
				pow(1 + [self ReturnVU2023InstHigh:@"A" ], 1.00/12.00) + RiderMonthVU2023PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:aaMonth]/100.00)) *
				pow(1 + [self ReturnVU2023InstHigh:@"A" ], 1.00/12.00);
			}
			if (aaMonth == MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				if (Fund2023PartialReinvest != 100) {
					MonthFundMaturityValue2023_Bull = MonthVU2023PrevValuehigh * (100 - Fund2023PartialReinvest)/100.00;
					
					Ridertemp2023High = currentValue * (100 - Fund2023PartialReinvest)/100.00;
					RiderWithdrawtemp2023High = currentValue * (Fund2023PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2023_Bull = 0;
				}
				
				if (aaRound == 2) {
					RiderMonthVU2023PrevValuehigh = 0;
				}
				else{
					RiderMonthVU2023PrevValuehigh = tempPrev;
				}
			}
			else{
				if (aaRound == 2) {
					RiderMonthVU2023PrevValuehigh = currentValue;
				}
				else{
					RiderMonthVU2023PrevValuehigh = tempPrev;
				}
			}
			
			if (aaMonth == 12 && aaRound == 2) {
				RiderVU2023PrevValuehigh = RiderMonthVU2023PrevValuehigh;
			}
			
			return currentValue;
			// below part to be edit later
		}
		else{
			//year calculation
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalHigh != 0 ) {
				
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2023Fac] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2023Factor) *
				(1 + VU2023InstHigh) + RiderVU2023PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstHigh:@"A"])
				+ (RiderNegativeValueOfMaxCashFundHigh - 1) * (RiderVU2023ValueHigh/RiderFundValueOfTheYearValueTotalHigh);
				
			}
			else{
				if (aaRound == 1) {
					currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2023Fac]  +
								   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2023Factor) *
					(1 + VU2023InstHigh) + RiderVU2023PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstHigh:@"A"]);
					RiderVU2023ValueHigh = currentValue;
				}
				else{
					currentValue = RiderVU2023ValueHigh;
				}
				
			}
			
			if (aaRound == 2){
				RiderVU2023PrevValuehigh = currentValue;
			}
			
			return currentValue;
			// below part to be edit later
		}
		
	}
}

-(double)ReturnRiderVU2023ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	double currentValue;
	if (aaPolicyYear > YearDiff2023) {
		RiderVU2023PrevValueMedian = 0.00;
		return 0.00;
	}
	else{
		
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				RiderMonthVU2023PrevValueMedian = RiderVU2023PrevValueMedian;
			}
			
			if (i > MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				RiderMonthVU2023PrevValueMedian = 0;
				RiderVU2023PrevValueMedian = 0.00;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2023PrevValueMedian;
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalMedian != 0 ) {
				
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2023Fac]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2023Factor) *
				pow(1 + [self ReturnVU2023InstMedian:@"A" ], 1.00/12.00) + RiderMonthVU2023PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2023InstMedian:@"A" ], 1.00/12.00) + (RiderNegativeValueOfMaxCashFundMedian - 1) *
				(RiderMonthVU2023ValueMedian/RiderMonthFundValueOfTheYearValueTotalMedian);
				
			}
			else{
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2023Fac ]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2023Factor) *
				pow(1 + [self ReturnVU2023InstMedian:@"A" ], 1.00/12.00) + RiderMonthVU2023PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2023InstMedian:@"A" ], 1.00/12.00);
			}
			
			if (i == MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				if (Fund2023PartialReinvest != 100) {
					MonthFundMaturityValue2023_Flat = MonthVU2023PrevValueMedian * (100 - Fund2023PartialReinvest)/100.00;
					
					Ridertemp2023Median = currentValue * (100 - Fund2023PartialReinvest)/100.00;
					RiderWithdrawtemp2023Median = currentValue * (Fund2023PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2023_Flat = 0;
				}
				
				if (aaRound == 2) {
					RiderMonthVU2023PrevValueMedian = 0;
				}
				else{
					RiderMonthVU2023PrevValueMedian = tempPrev;
				}
			}
			else{
				if (aaRound == 2) {
					RiderMonthVU2023PrevValueMedian = currentValue;
				}
				else{
					RiderMonthVU2023PrevValueMedian = tempPrev;
				}
				
			}
			
			
			if (i == 12 && aaRound == 2) {
				RiderVU2023PrevValueMedian = RiderMonthVU2023PrevValueMedian;
			}
			
			return currentValue;
			// below part to be edit later
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalMedian != 0 ) {
				
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2023Fac]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2023Factor) *
				(1 + VU2023InstMedian) + RiderVU2023PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstMedian:@"A"])
				+ (RiderNegativeValueOfMaxCashFundMedian - 1) * (RiderVU2023ValueMedian/RiderFundValueOfTheYearValueTotalMedian);
				
			}
			else{
				if (aaRound == 1) {
					currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2023Fac]  +
								   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2023Factor  +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
					(1 + VU2023InstMedian) + RiderVU2023PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstMedian:@"A"]);
					RiderVU2023ValueMedian = currentValue;
				}
				else{
					currentValue = RiderVU2023ValueMedian;
				}
				
			}
			
			if (aaRound == 2){
				RiderVU2023PrevValueMedian = currentValue;
			}
			
			return currentValue;
			// below part to be edit later
		}
		
	}
}

-(double)ReturnRiderVU2023ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	double currentValue;
	if (aaPolicyYear > YearDiff2023) {
		RiderVU2023PrevValueLow = 0.00;
		return 0.00;
	}
	else{
		
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				RiderMonthVU2023PrevValueLow = RiderVU2023PrevValueLow;
			}
			
			if (i > MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				RiderVU2023PrevValueLow = 0.00;
				RiderMonthVU2023PrevValueLow = 0;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2023PrevValueLow;
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalLow != 0 ) {
				
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2023Fac]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2023Factor * [self ReturnPremiumFactor:aaPolicyYear]) *
				pow(1 + [self ReturnVU2023InstLow:@"A" ], 1.00/12.00) + RiderMonthVU2023PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2023InstLow:@"A" ], 1.00/12.00)  + (RiderNegativeValueOfMaxCashFundLow - 1) *
				(RiderMonthVU2023ValueLow/RiderMonthFundValueOfTheYearValueTotalLow);
				
			}
			else{
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2023Fac ]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2023Factor * [self ReturnPremiumFactor:aaPolicyYear]) *
				pow(1 + [self ReturnVU2023InstLow:@"A" ], 1.00/12.00) + RiderMonthVU2023PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2023InstLow:@"A" ], 1.00/12.00);
			}
			
			if (i == MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				if (Fund2023PartialReinvest != 100) {
					MonthFundMaturityValue2023_Bear = RiderMonthVU2023PrevValueLow * (100 - Fund2023PartialReinvest)/100.00;
					
					Ridertemp2023Low = currentValue * (100 - Fund2023PartialReinvest)/100.00;
					RiderWithdrawtemp2023Low = currentValue * (Fund2023PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2023_Bear = 0;
				}
				if (aaRound == 2) {
					RiderMonthVU2023PrevValueLow = 0;
				}
				else{
					RiderMonthVU2023PrevValueLow = tempPrev;
				}
			}
			else{
				if (aaRound == 2) {
					RiderMonthVU2023PrevValueLow = currentValue;
				}
				else{
					RiderMonthVU2023PrevValueLow = tempPrev;
				}
			}
			
			if (i == 12 && aaRound == 2) {
				RiderVU2023PrevValueLow = RiderMonthVU2023PrevValueLow;
			}
			
			return currentValue;
			// below part to be edit later
			 
			
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalLow != 0 ) {
				
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1 ] doubleValue ]) + IncreasePrem) * [self ReturnVU2023Fac]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2023Factor * [self ReturnPremiumFactor:aaPolicyYear]) *
				(1 + VU2023InstLow) + RiderVU2023PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstLow:@"A"]) +
				(RiderNegativeValueOfMaxCashFundLow - 1) * (RiderVU2023ValueLow/RiderFundValueOfTheYearValueTotalLow);
				
			}
			else{
				
				if (aaRound == 1) {
					currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2023Fac] * +
								   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2023Factor * [self ReturnPremiumFactor:aaPolicyYear]) *
					(1 + VU2023InstLow) + RiderVU2023PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstLow:@"A"]);
					RiderVU2023ValueLow = currentValue ;
				}
				else{
					currentValue = RiderVU2023ValueLow;
				}
				
			}
			
			if (aaRound == 2){
				RiderVU2023PrevValueLow = currentValue;
			}
			
			return currentValue;
			// below part to be edit later
		}
		
	}
}


-(double)ReturnRiderVU2025ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2025) {
		RiderVU2025PrevValuehigh = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				RiderMonthVU2025PrevValuehigh = RiderVU2025PrevValuehigh;
			}
			
			if (i > MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				RiderVU2025PrevValuehigh = 0.00;
				RiderMonthVU2025PrevValuehigh = 0;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2025PrevValuehigh;
			
			if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				RiderMonthVU2025PrevValuehigh = RiderMonthVU2025PrevValuehigh + (Ridertemp2023High * Fund2023ReinvestTo2025Fac/100.00);
			}
			else{
				
			}
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalHigh != 0 ) {
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]  * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2025Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2025InstHigh:@"A" ], 1.00/12.00) + RiderMonthVU2025PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2025InstHigh:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (RiderNegativeValueOfMaxCashFundHigh - 1) *
				(RiderMonthVU2025ValueHigh/RiderMonthFundValueOfTheYearValueTotalHigh);
			}
			else{
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2025Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2025InstHigh:@"A" ], 1.00/12.00) + RiderMonthVU2025PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2025InstHigh:@"A" ], 1.00/12.00);
			}
			
			if (i == MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				if (Fund2025PartialReinvest != 100) {
					MonthFundMaturityValue2025_Bull = MonthVU2025PrevValuehigh * (100 - Fund2025PartialReinvest)/100.00;
					
					Ridertemp2025High = currentValue * (100 - Fund2025PartialReinvest)/100.00;
					RiderWithdrawtemp2025High = currentValue * (Fund2025PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2025_Bull = 0;
				}
				if (aaRound == 2){
					RiderMonthVU2025PrevValuehigh = 0;
				}
				else{
					RiderMonthVU2025PrevValuehigh = tempPrev;
				}
				
			}
			else{
				if (aaRound == 2){
					RiderMonthVU2025PrevValuehigh = currentValue;
				}
				else{
					RiderMonthVU2025PrevValuehigh = tempPrev;
				}
				
			}
			
			
			if (aaRound == 2 && i == 12) {
				RiderVU2025PrevValuehigh = RiderMonthVU2025PrevValuehigh;
			}
			
			return currentValue;
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalHigh != 0 ) {
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2025Factor * [self ReturnPremiumFactor:i]) *
				(1 + VU2025InstHigh) + RiderVU2025PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstHigh:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (RiderNegativeValueOfMaxCashFundHigh - 1) *
				(RiderVU2025ValueHigh/RiderFundValueOfTheYearValueTotalHigh);
				
				
			}
			else{
				
				if (aaRound == 1) {
					currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] +
								   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2025Factor * [self ReturnPremiumFactor:i]) *
					(1 + VU2025InstHigh) + RiderVU2025PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstHigh:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					
					RiderVU2025ValueHigh = currentValue;
				}
				else{
					currentValue = RiderVU2025ValueHigh;
				}
				
			}
			
			if (aaRound == 2) {
				RiderVU2025PrevValuehigh = currentValue;
			}
			
			return currentValue;
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnRiderVU2025ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2025) {
		RiderVU2025PrevValueMedian = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			
			if (i == 1) {
				RiderMonthVU2025PrevValueMedian = RiderVU2025PrevValueMedian;
			}
			
			if (i > MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				RiderVU2025PrevValueMedian = 0.00;
				RiderMonthVU2025PrevValueMedian = 0;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2025PrevValueMedian;
			
			if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				RiderMonthVU2025PrevValueMedian = RiderMonthVU2025PrevValueMedian + (Ridertemp2023Median * Fund2023ReinvestTo2025Fac/100.00);
			}
			else{
				
			}
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalMedian != 0 ) {
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2025Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2025InstMedian:@"A" ], 1.00/12.00) + RiderMonthVU2025PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2025InstMedian:@"A" ], 1.00/12.00) + (NegativeValueOfMaxCashFundMedian - 1) *
				(RiderMonthVU2025ValueMedian/RiderMonthFundValueOfTheYearValueTotalMedian);
			}
			else{
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2025Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2025InstMedian:@"A" ], 1.00/12.00) + RiderMonthVU2025PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2025InstMedian:@"A" ], 1.00/12.00);
			}
			
			if (i == MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				if (Fund2025PartialReinvest != 100) {
					MonthFundMaturityValue2025_Flat = RiderMonthVU2025PrevValueMedian * (100 - Fund2025PartialReinvest)/100.00;
					
					Ridertemp2025Median = currentValue * (100 - Fund2025PartialReinvest)/100.00;
					RiderWithdrawtemp2025Median = currentValue * (Fund2025PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2025_Flat = 0;
				}
				if (aaRound == 2){
					RiderMonthVU2025PrevValueMedian = 0;
				}
				else{
					RiderMonthVU2025PrevValueMedian = tempPrev;
				}
				
			}
			else{
				if (aaRound == 2){
					RiderMonthVU2025PrevValueMedian = currentValue;
				}
				else{
					RiderMonthVU2025PrevValueMedian = tempPrev;
				}
				
			}
			
			
			if (aaRound == 2 && i == 12) {
				RiderVU2025PrevValueMedian = RiderMonthVU2025PrevValueMedian;
			}
			
			
			return currentValue;
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalMedian != 0 ) {
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2025Factor * [self ReturnPremiumFactor:i]) *
				(1 + VU2025InstMedian) + RiderVU2025PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstMedian:@"A"]) + (RiderNegativeValueOfMaxCashFundMedian - 1) *
				(RiderVU2025ValueMedian/RiderFundValueOfTheYearValueTotalMedian);
			}
			else{
				if (aaRound == 1) {
					currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear]  +
								   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2025Factor * [self ReturnPremiumFactor:i]) *
					(1 + VU2025InstMedian) + RiderVU2025PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstMedian:@"A"]);
					
					RiderVU2025ValueMedian = currentValue;
				}
				else{
					currentValue = RiderVU2025ValueMedian;
				}
				
			}
			
			if (aaRound == 2) {
				RiderVU2025PrevValueMedian = currentValue;
			}
			
			return currentValue;
		}
		
	}
	
	// below part to be edit later
}


-(double)ReturnRiderVU2025ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2025) {
		RiderVU2025PrevValueLow = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			
			if (i == 1) {
				RiderMonthVU2025PrevValueLow = RiderVU2025PrevValueLow;
			}
			
			if (i > MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				RiderVU2025PrevValueLow = 0.00;
				RiderMonthVU2025PrevValueLow = 0;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2025PrevValueLow;
			
			if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				RiderMonthVU2025PrevValueLow = RiderMonthVU2025PrevValueLow + (Ridertemp2023Low * Fund2023ReinvestTo2025Fac/100.00);
			}
			else{
				
			}
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalLow != 0 ) {
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2025Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2025InstLow:@"A" ], 1.00/12.00) + RiderMonthVU2025PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2025InstLow:@"A" ], 1.00/12.00) + (RiderNegativeValueOfMaxCashFundLow - 1) *
				(RiderMonthVU2025ValueLow/RiderMonthFundValueOfTheYearValueTotalLow);
			}
			else{
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]  * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2025Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2025InstLow:@"A" ], 1.00/12.00) + RiderMonthVU2025PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2025InstLow:@"A" ], 1.00/12.00);
			}
			
			if (i == MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				if (Fund2025PartialReinvest != 100) {
					MonthFundMaturityValue2025_Bear = RiderMonthVU2025PrevValueLow * (100 - Fund2025PartialReinvest)/100.00;
					
					Ridertemp2025Low = currentValue * (100 - Fund2025PartialReinvest)/100.00;
					RiderWithdrawtemp2025Low = currentValue * (Fund2025PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2025_Bear = 0;
				}
				if (aaRound == 2){
					RiderMonthVU2025PrevValueLow = 0;
				}
				else{
					RiderMonthVU2025PrevValueLow = tempPrev;
				}
				
			}
			else{
				if (aaRound == 2){
					RiderMonthVU2025PrevValueLow = currentValue;
				}
				else{
					RiderMonthVU2025PrevValueLow = tempPrev;
				}
				
			}
			
			if (aaRound == 2 && i == 12) {
				RiderVU2025PrevValueLow = RiderMonthVU2025PrevValueLow;
			}
			
			
			return currentValue;
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalLow != 0 ) {
				currentValue =((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] ) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2025Factor * [self ReturnPremiumFactor:i]) *
				(1 + VU2025InstLow) + RiderVU2025PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstLow:@"A"]) + (RiderNegativeValueOfMaxCashFundLow - 1) *
				(RiderVU2025ValueLow/RiderFundValueOfTheYearValueTotalLow);
			}
			else{
				if (aaRound == 1) {
					currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] +
								   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2025Factor * [self ReturnPremiumFactor:i]) *
					(1 + VU2025InstLow) + RiderVU2025PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstLow:@"A"]);
					
					RiderVU2025ValueLow = currentValue;
				}
				else{
					currentValue =RiderVU2025ValueLow;
				}
			}
			
			if (aaRound == 2) {
				RiderVU2025PrevValueLow = currentValue;
			}
			
			return currentValue;
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnRiderVU2028ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2028) {
		RiderVU2028PrevValuehigh = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				RiderMonthVU2028PrevValuehigh = RiderVU2028PrevValuehigh;
			}
			
			if (i > MonthDiff2028 && aaPolicyYear == YearDiff2028) {
				RiderVU2028PrevValuehigh = 0.00;
				RiderMonthVU2028PrevValuehigh = 0;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2028PrevValuehigh;
			if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				RiderMonthVU2028PrevValuehigh = RiderMonthVU2028PrevValuehigh + (Ridertemp2025High * Fund2025ReinvestTo2028Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				RiderMonthVU2028PrevValuehigh = RiderMonthVU2028PrevValuehigh + (Ridertemp2023High * Fund2023ReinvestTo2028Fac/100.00);
			}
			else{
				
			}
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalHigh != 0) {
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2028Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2028InstHigh:@"A" ], 1.00/12.00) + RiderMonthVU2028PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2028InstHigh:@"A"], 1.00/12.00) + (RiderNegativeValueOfMaxCashFundHigh - 1) *
				(RiderMonthVU2028ValueHigh/RiderMonthFundValueOfTheYearValueTotalHigh);
			}
			else{
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2028Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2028InstHigh:@"A" ], 1.00/12.00)+ RiderMonthVU2028PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2028InstHigh:@"A"], 1.00/12.00);
			}
			
			if (i == MonthDiff2028 && aaPolicyYear == YearDiff2028) {
				if (Fund2028PartialReinvest != 100) {
					MonthFundMaturityValue2028_Bull = MonthVU2028PrevValuehigh * (100 - Fund2028PartialReinvest)/100.00;
					
					Ridertemp2028High = currentValue * (100 - Fund2028PartialReinvest)/100.00;
					RiderWithdrawtemp2028High = currentValue * (Fund2028PartialReinvest)/100.00;
					//NSLog(@"%f", temp2028High);
				}
				else{
					MonthFundMaturityValue2028_Bull = 0;
				}
				if (aaRound == 2) {
					RiderMonthVU2028PrevValuehigh = 0;
				}
				else{
					RiderMonthVU2028PrevValuehigh = tempPrev;
				}
			}
			else{
				if (aaRound == 2) {
					RiderMonthVU2028PrevValuehigh = currentValue;
				}
				else{
					RiderMonthVU2028PrevValuehigh = tempPrev;
				}
				
			}
			
			if (i == 12 && aaRound == 2) {
				RiderVU2028PrevValuehigh = RiderMonthVU2028PrevValuehigh;
			}
			
			return currentValue;
			
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalHigh != 0) {
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2028Factor * [self ReturnPremiumFactor:i]) *
				(1 + VU2028InstHigh) + RiderVU2028PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstHigh:@"A"]) + (RiderNegativeValueOfMaxCashFundHigh - 1) *
				(RiderVU2028ValueHigh/RiderFundValueOfTheYearValueTotalHigh);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] +
									[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2028Factor * [self ReturnPremiumFactor:i]) *
					(1 + VU2028InstHigh) + RiderVU2028PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstHigh:@"A"]);
					RiderVU2028ValueHigh = currentValue;
				}
				else{
					currentValue = RiderVU2028ValueHigh;
				}
				
			}
			
			if (aaRound == 2) {
				RiderVU2028PrevValuehigh = currentValue;
			}
			
			return currentValue;
			
		}
		
	}
	
}

-(double)ReturnRiderVU2028ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2028) {
		RiderVU2028PrevValueMedian = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				RiderMonthVU2028PrevValueMedian = RiderVU2028PrevValueMedian;
			}
			
			if (i > MonthDiff2028 && aaPolicyYear == YearDiff2028) {
				RiderVU2028PrevValueMedian = 0.00;
				RiderMonthVU2028PrevValueMedian = 0;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2028PrevValueMedian;
			if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				RiderMonthVU2028PrevValueMedian = RiderMonthVU2028PrevValueMedian + (Ridertemp2025Median * Fund2025ReinvestTo2028Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				RiderMonthVU2028PrevValueMedian = RiderMonthVU2028PrevValueMedian + (Ridertemp2023Median * Fund2023ReinvestTo2028Fac/100.00);
			}
			else{
				
			}
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalMedian != 0) {
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2028Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2028InstMedian:@"A" ], 1.00/12.00) + RiderMonthVU2028PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2028InstMedian:@"A"],1.00/12.00) + (RiderNegativeValueOfMaxCashFundMedian - 1) *
				(RiderMonthVU2028ValueMedian/RiderMonthFundValueOfTheYearValueTotalMedian);
			}
			else{
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2028Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2028InstMedian:@"A" ], 1.00/12.00)+ RiderMonthVU2028PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2028InstMedian:@"A"], 1.00/12.00);
			}
			if (i == MonthDiff2028 && aaPolicyYear == YearDiff2028) {
				if (Fund2028PartialReinvest != 100) {
					MonthFundMaturityValue2028_Flat = RiderMonthVU2028PrevValueMedian * (100 - Fund2028PartialReinvest)/100.00;
					
					Ridertemp2028Median = currentValue * (100 - Fund2028PartialReinvest)/100.00;
					RiderWithdrawtemp2028Median = currentValue * (Fund2028PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2028_Flat = 0;
				}
				
				if (aaRound == 2) {
					RiderMonthVU2028PrevValueMedian = 0;
				}
				else{
					RiderMonthVU2028PrevValueMedian = tempPrev;
				}
			}
			else{
				if (aaRound == 2) {
					RiderMonthVU2028PrevValueMedian = currentValue;
				}
				else{
					RiderMonthVU2028PrevValueMedian = tempPrev;
				}
				
			}
			
			if (i == 12 && aaRound == 2) {
				RiderVU2028PrevValueMedian = RiderMonthVU2028PrevValueMedian;
			}
			
			
			return currentValue;
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalMedian != 0) {
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2028Factor * [self ReturnPremiumFactor:i]) *
				(1 + VU2028InstMedian) + RiderVU2028PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstMedian:@"A"]) + (RiderNegativeValueOfMaxCashFundMedian - 1) *
				(RiderVU2028ValueMedian/RiderFundValueOfTheYearValueTotalMedian);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] +
									[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2028Factor * [self ReturnPremiumFactor:i]) *
					(1 + VU2028InstMedian) + RiderVU2028PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstMedian:@"A"]);
					RiderVU2028ValueMedian = currentValue;
				}
				else{
					currentValue = RiderVU2028ValueMedian;
				}
				
			}
			
			if (aaRound == 2) {
				RiderVU2028PrevValueMedian = currentValue;
			}
			
			return currentValue;
		}
		
	}
	
}

-(double)ReturnRiderVU2028ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2028) {
		RiderVU2028PrevValueLow = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			if (i == 1) {
				RiderMonthVU2028PrevValueLow = RiderVU2028PrevValueLow;
			}
			
			if (i > MonthDiff2028 && aaPolicyYear == YearDiff2028) {
				RiderVU2028PrevValueLow = 0.00;
				RiderMonthVU2028PrevValueLow = 0;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2028PrevValueLow;
			if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				RiderMonthVU2028PrevValueLow = RiderMonthVU2028PrevValueLow + (Ridertemp2025Low * Fund2025ReinvestTo2028Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				RiderMonthVU2028PrevValueLow = RiderMonthVU2028PrevValueLow + (Ridertemp2023Low * Fund2023ReinvestTo2028Fac/100.00);
			}
			else{
				
			}
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalLow != 0) {
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2028Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2028InstLow:@"A" ], 1.00/12.00) + RiderMonthVU2028PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2028InstLow:@"A"],1.00/12.00) + (RiderNegativeValueOfMaxCashFundLow - 1) *
				(RiderMonthVU2028ValueLow/RiderMonthFundValueOfTheYearValueTotalLow);
			}
			else{
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2028Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2028InstLow:@"A" ], 1.00/12.00)+ RiderMonthVU2028PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2028InstLow:@"A"], 1.00/12.00);
			}
			if (i == MonthDiff2028 && aaPolicyYear == YearDiff2028) {
				if (Fund2028PartialReinvest != 100) {
					MonthFundMaturityValue2028_Bear = RiderMonthVU2028PrevValueLow * (100 - Fund2028PartialReinvest)/100.00;
					
					Ridertemp2028Low = currentValue * (100 - Fund2028PartialReinvest)/100.00;
					RiderWithdrawtemp2028Low = currentValue * (Fund2028PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2028_Bear = 0;
				}
				
				if (aaRound == 2) {
					RiderMonthVU2028PrevValueLow = 0;
				}
				else{
					RiderMonthVU2028PrevValueLow = tempPrev;
				}
				
			}
			else{
				if (aaRound == 2) {
					RiderMonthVU2028PrevValueLow = currentValue;
				}
				else{
					RiderMonthVU2028PrevValueLow = tempPrev;
				}
				
			}
			
			if (i == 12 && aaRound == 2) {
				RiderVU2028PrevValueLow = RiderMonthVU2028PrevValueLow;
			}
			
			
			return currentValue;
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalLow != 0) {
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2028Factor * [self ReturnPremiumFactor:i]) *
				(1 + VU2028InstLow) + RiderVU2028PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstLow:@"A"]) + (RiderNegativeValueOfMaxCashFundLow - 1) *
				(RiderVU2028ValueLow/RiderFundValueOfTheYearValueTotalLow);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] +
									[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2028Factor * [self ReturnPremiumFactor:i]) *
					(1 + VU2028InstLow) + RiderVU2028PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstLow:@"A"]);
					RiderVU2028ValueLow = currentValue;
				}
				else{
					currentValue = RiderVU2028ValueLow;
				}
				
			}
			
			if (aaRound == 2) {
				RiderVU2028PrevValueLow = currentValue;
			}
			
			return currentValue;
		}
		
	}
	
}

-(double)ReturnRiderVU2030ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2030) {
		RiderVU2030PrevValuehigh = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			if (i == 1) {
				RiderMonthVU2030PrevValuehigh = RiderVU2030PrevValuehigh;
			}
			
			if (i > MonthDiff2030 && aaPolicyYear == YearDiff2030) {
				RiderVU2030PrevValuehigh = 0.00;
				RiderMonthVU2030PrevValuehigh = 0;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2030PrevValuehigh;
			if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				RiderMonthVU2030PrevValuehigh = RiderMonthVU2030PrevValuehigh + (Ridertemp2028High * Fund2028ReinvestTo2030Fac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				RiderMonthVU2030PrevValuehigh = RiderMonthVU2030PrevValuehigh + (Ridertemp2025High * Fund2025ReinvestTo2030Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				RiderMonthVU2030PrevValuehigh = RiderMonthVU2030PrevValuehigh + (Ridertemp2023High * Fund2023ReinvestTo2030Fac/100.00);
			}
			else{
				
			}
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalHigh != 0) {
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear  andMonth:i]  +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2030Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2030InstHigh:@"A" ], 1.00/12.00) + RiderMonthVU2030PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2030InstHigh:@"A"], 1.00/12.00)  + (RiderNegativeValueOfMaxCashFundHigh - 1) *
				(RiderMonthVU2030ValueHigh/RiderMonthFundValueOfTheYearValueTotalHigh);
			}
			else{
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear  andMonth:i]  +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2030Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2030InstHigh:@"A" ], 1.00/12.00) + RiderMonthVU2030PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2030InstHigh:@"A"], 1.00/12.00);
			}
			
			if (i == MonthDiff2030 && aaPolicyYear == YearDiff2030) {
				if (Fund2030PartialReinvest != 100) {
					MonthFundMaturityValue2030_Bear = RiderMonthVU2030PrevValuehigh * (100 - Fund2030PartialReinvest)/100.00;
					
					Ridertemp2030High = currentValue * (100 - Fund2030PartialReinvest)/100.00;
					RiderWithdrawtemp2030High = currentValue * (Fund2030PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2030_Bear = 0;
				}
				if (aaRound == 2) {
					RiderMonthVU2030PrevValuehigh = 0;
				}
				
			}
			else{
				if (aaRound == 2) {
					RiderMonthVU2030PrevValuehigh = currentValue;
				}
				else{
					RiderMonthVU2030PrevValuehigh = tempPrev;
				}
				
			}
			
			if (aaRound == 2 && i == 12) {
				RiderVU2030PrevValuehigh = RiderMonthVU2030PrevValuehigh;
			}
			
			return currentValue;
			
		}
		else{
			
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalHigh != 0) {
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2030Factor * [self ReturnPremiumFactor:i]) *
				(1 + VU2030InstHigh) + RiderVU2030PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstHigh:@"A"]) + (RiderNegativeValueOfMaxCashFundHigh - 1) *
				(RiderVU2030ValueHigh/RiderFundValueOfTheYearValueTotalHigh);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear]  +
									[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2030Factor * [self ReturnPremiumFactor:i]) *
					(1 + VU2030InstHigh) + RiderVU2030PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstHigh:@"A"]);
					RiderVU2030ValueHigh = currentValue;
				}
				else{
					currentValue = RiderVU2030ValueHigh;
				}
				
			}
			
			if (aaRound == 2) {
				RiderVU2030PrevValuehigh = currentValue;
			}
			
			return currentValue;
			
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnRiderVU2030ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2030) {
		RiderVU2030PrevValueMedian = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				RiderMonthVU2030PrevValueMedian = RiderVU2030PrevValueMedian;
			}
			
			if (i > MonthDiff2030 && aaPolicyYear == YearDiff2030) {
				RiderVU2030PrevValueMedian = 0.00;
				RiderMonthVU2030PrevValueMedian = 0;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2030PrevValueMedian;
			if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				RiderMonthVU2030PrevValueMedian = RiderMonthVU2030PrevValueMedian + (Ridertemp2028Median * Fund2028ReinvestTo2030Fac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				RiderMonthVU2030PrevValueMedian = RiderMonthVU2030PrevValueMedian + (Ridertemp2025Median * Fund2025ReinvestTo2030Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				RiderMonthVU2030PrevValueMedian = RiderMonthVU2030PrevValueMedian + (Ridertemp2023Median * Fund2023ReinvestTo2030Fac/100.00);
			}
			else{
				
			}
			
			if (RiderVUCashValueNegative ==TRUE && RiderMonthFundValueOfTheYearValueTotalMedian != 0) {
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear andMonth:i] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2030Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2030InstMedian:@"A" ], 1.00/12.00) + RiderMonthVU2030PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2030InstMedian:@"A"], 1.00/12.00) + (RiderNegativeValueOfMaxCashFundMedian - 1) *
				(RiderMonthVU2030ValueMedian/RiderMonthFundValueOfTheYearValueTotalMedian);
			}
			else{
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear andMonth:i]  +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2030Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2030InstMedian:@"A" ], 1.00/12.00) + RiderMonthVU2030PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2030InstMedian:@"A"], 1.00/12.00);
			}
			
			if (i == MonthDiff2030 && aaPolicyYear == YearDiff2030) {
				if (Fund2030PartialReinvest != 100) {
					MonthFundMaturityValue2030_Flat = MonthVU2030PrevValueMedian * (100 - Fund2030PartialReinvest)/100.00;
					Ridertemp2030Median = currentValue * (100 - Fund2030PartialReinvest)/100.00;
					RiderWithdrawtemp2030Median = currentValue * (Fund2030PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2030_Flat = 0;
				}
				if (aaRound == 2) {
					RiderMonthVU2030PrevValueMedian = 0;
				}
				
			}
			else{
				if (aaRound == 2) {
					RiderMonthVU2030PrevValueMedian = currentValue;
				}
				else{
					RiderMonthVU2030PrevValueMedian = tempPrev;
				}
			}
			
			if (aaRound == 2 && i == 12) {
				RiderVU2030PrevValueMedian = RiderMonthVU2030PrevValueMedian;
			}
			
			
			return currentValue;
			
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalMedian != 0) {
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2030Factor * [self ReturnPremiumFactor:i]) *
				(1 + VU2030InstMedian) + RiderVU2030PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstMedian:@"A"]) + (RiderNegativeValueOfMaxCashFundMedian - 1) *
				(RiderVU2030ValueMedian/RiderFundValueOfTheYearValueTotalMedian);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] +
									[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2030Factor * [self ReturnPremiumFactor:i]) *
					(1 + VU2030InstMedian) + RiderVU2030PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstMedian:@"A"]);
					RiderVU2030ValueMedian = currentValue;
				}
				else{
					currentValue = RiderVU2030ValueMedian;
				}
				
			}
			
			if (aaRound == 2) {
				RiderVU2030PrevValueMedian = currentValue;
			}
			
			return currentValue;
			
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnRiderVU2030ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2030) {
		RiderVU2030PrevValueLow = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			if (i == 1) {
				RiderMonthVU2030PrevValueLow = RiderVU2030PrevValueLow;
			}
			
			if (i > MonthDiff2030 && aaPolicyYear == YearDiff2030) {
				RiderVU2030PrevValueLow = 0.00;
				RiderMonthVU2030PrevValueLow = 0;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2030PrevValueLow;
			if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				RiderMonthVU2030PrevValueLow = RiderMonthVU2030PrevValueLow + (Ridertemp2028Low * Fund2028ReinvestTo2030Fac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				RiderMonthVU2030PrevValueLow = RiderMonthVU2030PrevValueLow + (Ridertemp2025Low * Fund2025ReinvestTo2030Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				RiderMonthVU2030PrevValueLow = RiderMonthVU2030PrevValueLow + (Ridertemp2023Low * Fund2023ReinvestTo2030Fac/100.00);
			}
			else{
				
			}
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalLow != 0) {
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear andMonth:i] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2030Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2030InstLow:@"A" ], 1.00/12.00) + RiderMonthVU2030PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2030InstLow:@"A"], 1.00/12.00) + (RiderNegativeValueOfMaxCashFundLow - 1) *
				(RiderMonthVU2030ValueLow/RiderMonthFundValueOfTheYearValueTotalLow);
			}
			else{
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear andMonth:i] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2030Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2030InstLow:@"A" ], 1.00/12.00) + RiderMonthVU2030PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2030InstLow:@"A"], 1.00/12.00);
			}
			
			if (i == MonthDiff2030 && aaPolicyYear == YearDiff2030) {
				if (Fund2030PartialReinvest != 100) {
					MonthFundMaturityValue2030_Bear = MonthVU2030PrevValueLow * (100 - Fund2030PartialReinvest)/100.00;
					Ridertemp2030Low = currentValue * (100 - Fund2030PartialReinvest)/100.00;
					RiderWithdrawtemp2030Low = currentValue * (Fund2030PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2030_Bear = 0;
				}
				if (aaRound == 2) {
					RiderMonthVU2030PrevValueLow = 0;
				}
				
			}
			else{
				if (aaRound == 2) {
					RiderMonthVU2030PrevValueLow = currentValue;
				}
				else{
					RiderMonthVU2030PrevValueLow = tempPrev;
				}
				
			}
			
			if (aaRound == 2 && i == 12) {
				RiderVU2030PrevValueLow = RiderMonthVU2030PrevValueLow;
			}
			
			
			return currentValue;
			
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalLow != 0) {
				currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] +
							   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2030Factor * [self ReturnPremiumFactor:i]) *
				(1 + VU2030InstLow) + RiderVU2030PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstLow:@"A"]) + (RiderNegativeValueOfMaxCashFundLow - 1) *
				(RiderVU2030ValueLow/RiderFundValueOfTheYearValueTotalLow);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear]  +
									[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2030Factor * [self ReturnPremiumFactor:i]) *
					(1 + VU2030InstLow) + RiderVU2030PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstLow:@"A"]);
					RiderVU2030ValueLow = currentValue;
				}
				else{
					currentValue = RiderVU2030ValueLow;
				}
				
			}
			
			if (aaRound == 2) {
				RiderVU2030PrevValueLow = currentValue;
			}
			
			return currentValue;
			
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnRiderVU2035ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2035) {
		RiderVU2035PrevValuehigh = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
			if (i == 1) {
				RiderMonthVU2035PrevValuehigh = RiderVU2035PrevValuehigh;
			}
			
			if (i > MonthDiff2035 && aaPolicyYear == YearDiff2035) {
				RiderMonthVU2035PrevValuehigh = 0;
				RiderVU2035PrevValuehigh = 0.00;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2035PrevValuehigh;
			if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
				RiderMonthVU2035PrevValuehigh = RiderMonthVU2035PrevValuehigh + (Ridertemp2030High * Fund2030ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				RiderMonthVU2035PrevValuehigh = RiderMonthVU2035PrevValuehigh + (Ridertemp2028High * Fund2028ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				RiderMonthVU2035PrevValuehigh = RiderMonthVU2035PrevValuehigh + (Ridertemp2025High * Fund2025ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				RiderMonthVU2035PrevValuehigh = RiderMonthVU2035PrevValuehigh + (Ridertemp2023High * Fund2023ReinvestTo2035Fac/100.00);
			}
			else{
				
			}
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalHigh != 0 ) {
				
				currentValue=  ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i] ) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2035Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2035InstHigh:@"A"], 1.00/12.00) + RiderMonthVU2035PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2035InstHigh:@"A"], 1.00/12.00) + (RiderNegativeValueOfMaxCashFundHigh - 1) *
				(RiderMonthVU2035ValueHigh/RiderMonthFundValueOfTheYearValueTotalHigh);
				if (aaPolicyYear == 23) {
					//NSLog(@"%f %f %f", NegativeValueOfMaxCashFundHigh, MonthVU2035ValueHigh, MonthFundValueOfTheYearValueTotalHigh );
				}
			}
			else if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalHigh == 0 ) {
				currentValue = 0;
			}
			else{
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2035Factor * [self ReturnPremiumFactor:i]) *
				pow(1 + [self ReturnVU2035InstHigh:@"A"], 1.00/12.00) + RiderMonthVU2035PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow(1 + [self ReturnVU2035InstHigh:@"A"], 1.00/12.00);
			}
			
			if (i == MonthDiff2035 && aaPolicyYear == YearDiff2035) {
				if (Fund2035PartialReinvest != 100) {
					
					MonthFundMaturityValue2035_Bull = RiderMonthVU2035PrevValuehigh * (100 - Fund2035PartialReinvest)/100.00;
					
					Ridertemp2035High = currentValue * (100 - Fund2035PartialReinvest)/100.00;
					RiderWithdrawtemp2035High = currentValue * (Fund2035PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2035_Bull = 0;
				}
				
				if (aaRound == 2) {
					RiderMonthVU2035PrevValuehigh = 0;
				}
				else{
					RiderMonthVU2035PrevValuehigh = tempPrev;
				}
				
			}
			
			else{
				
				if (aaRound == 2) {
					RiderMonthVU2035PrevValuehigh = currentValue;
				}
				else{
					RiderMonthVU2035PrevValuehigh = tempPrev;
				}
				
			}
			
			if (i == 12 && aaRound == 2) {
				RiderVU2035PrevValuehigh = RiderMonthVU2035PrevValuehigh;
			}
			
			
			//return MonthVU2035PrevValuehigh;
			return currentValue;
			
			
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalHigh != 0 ) {
				
				currentValue=  ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] ) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2035Factor * [self ReturnPremiumFactor:i]) *
				(1 + VU2035InstHigh) + RiderVU2035PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstHigh:@"A"]) + (RiderNegativeValueOfMaxCashFundHigh - 1) *
				(RiderVU2035ValueHigh/RiderFundValueOfTheYearValueTotalHigh);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear]  +
									[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2035Factor * [self ReturnPremiumFactor:i]) *
					(1 + VU2035InstHigh) + RiderVU2035PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstHigh:@"A"]);
					
					RiderVU2035ValueHigh = currentValue;
				}
				else{
					currentValue = RiderVU2035ValueHigh;
				}
				
			}
			
			if (aaRound == 2) {
				RiderVU2035PrevValuehigh = currentValue;
			}
			
			
			return currentValue;
		}
		
		
	}
}

-(double)ReturnRiderVU2035ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2035) {
		RiderVU2035PrevValueMedian = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			if (i == 1) {
				RiderMonthVU2035PrevValueMedian = RiderVU2035PrevValueMedian;
			}
			
			if (i > MonthDiff2035 && aaPolicyYear == YearDiff2035) {
				RiderVU2035PrevValueMedian = 0.00;
				RiderMonthVU2035PrevValueMedian = 0;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2035PrevValueMedian;
			if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
				RiderMonthVU2035PrevValueMedian = RiderMonthVU2035PrevValueMedian + (Ridertemp2030Median * Fund2030ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				RiderMonthVU2035PrevValueMedian = RiderMonthVU2035PrevValueMedian + (Ridertemp2028Median * Fund2028ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				RiderMonthVU2035PrevValueMedian = RiderMonthVU2035PrevValueMedian + (Ridertemp2025Median * Fund2025ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				RiderMonthVU2035PrevValueMedian = RiderMonthVU2035PrevValueMedian + (Ridertemp2023Median * Fund2023ReinvestTo2035Fac/100.00);
			}
			else{
				
			}
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalMedian != 0 ) {
				
				currentValue=  ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2035Factor * [self ReturnPremiumFactor:i]) *
				pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/12.00)) + RiderMonthVU2035PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/12.00)) + (RiderNegativeValueOfMaxCashFundMedian - 1) *
				(RiderMonthVU2035ValueMedian/RiderMonthFundValueOfTheYearValueTotalMedian);
			}
			else{
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] *[self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2035Factor * [self ReturnPremiumFactor:i]) *
				pow((1 + [self ReturnVU2035InstMedian:@"A" ]), (1.00/12.00)) + RiderMonthVU2035PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/12.00));
			}
			
			
			if (i == MonthDiff2035 && aaPolicyYear == YearDiff2035) {
				if (Fund2035PartialReinvest != 100) {
					MonthFundMaturityValue2035_Flat = RiderMonthVU2035PrevValueMedian * (100 - Fund2035PartialReinvest)/100.00;
					Ridertemp2035Median = currentValue * (100 - Fund2035PartialReinvest)/100.00;
					RiderWithdrawtemp2035Median = currentValue * (Fund2035PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2035_Flat = 0;
				}
				if (aaRound == 2) {
					RiderMonthVU2035PrevValueMedian = 0;
				}
				else{
					RiderMonthVU2035PrevValueMedian = tempPrev;
				}
				
			}
			else{
				if (aaRound == 2) {
					RiderMonthVU2035PrevValueMedian = currentValue;
				}
				else{
					RiderMonthVU2035PrevValueMedian = tempPrev;
				}
				
			}
			
			if (i == 12 && aaRound == 2) {
				RiderVU2035PrevValueMedian = RiderMonthVU2035PrevValueMedian;
			}
			
			//return MonthVU2035PrevValueMedian;
			return currentValue;
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalMedian != 0 ) {
				
				currentValue=  ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] ) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear]  +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2035Factor * [self ReturnPremiumFactor:i]) *
				(1 + VU2035InstMedian) + RiderVU2035PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstMedian:@"A"]) + (RiderNegativeValueOfMaxCashFundMedian - 1) *
				(RiderVU2035ValueMedian/RiderFundValueOfTheYearValueTotalMedian);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] +
									[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2035Factor * [self ReturnPremiumFactor:i]) *
					(1 + VU2035InstMedian) + RiderVU2035PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstMedian:@"A"]);
					RiderVU2035ValueMedian = currentValue;
				}
				else{
					currentValue = RiderVU2035ValueMedian;
				}
			}
			
			if (aaRound == 2) {
				RiderVU2035PrevValueMedian = currentValue;
			}
			
			return currentValue;
		}
		
		
	}
}

-(double)ReturnRiderVU2035ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2035) {
		RiderVU2035PrevValueLow = 0.00;
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			if (i == 1) {
				RiderMonthVU2035PrevValueLow = RiderVU2035PrevValueLow;
			}
			
			if (i > MonthDiff2035 && aaPolicyYear == YearDiff2035) {
				RiderVU2035PrevValueLow = 0.00;
				RiderMonthVU2035PrevValueLow = 0;
				return 0;
			}
			
			double tempPrev = RiderMonthVU2035PrevValueLow;
			if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
				RiderMonthVU2035PrevValueLow = RiderMonthVU2035PrevValueLow + (Ridertemp2030Low * Fund2030ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				RiderMonthVU2035PrevValueLow = RiderMonthVU2035PrevValueLow + (Ridertemp2028Low * Fund2028ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				RiderMonthVU2035PrevValueLow = RiderMonthVU2035PrevValueLow + (Ridertemp2025Low * Fund2025ReinvestTo2035Fac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				RiderMonthVU2035PrevValueLow = RiderMonthVU2035PrevValueLow + (Ridertemp2023Low * Fund2023ReinvestTo2035Fac/100.00);
			}
			else{
				
			}
			
			if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalLow != 0 ) {
				
				currentValue=  ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i]  +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2035Factor * [self ReturnPremiumFactor:i]) *
				pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/12.00)) + RiderMonthVU2035PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/12.00)) + (RiderNegativeValueOfMaxCashFundLow - 1) *
				(RiderMonthVU2035ValueLow/RiderMonthFundValueOfTheYearValueTotalLow);
			}
			else{
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] *[self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2035Factor * [self ReturnPremiumFactor:i]) *
				pow((1 + [self ReturnVU2035InstLow:@"A" ]), (1.00/12.00)) + RiderMonthVU2035PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
				pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/12.00));
			}
			
			
			if (i == MonthDiff2035 && aaPolicyYear == YearDiff2035) {
				if (Fund2035PartialReinvest != 100) {
					MonthFundMaturityValue2035_Bear = MonthVU2035PrevValueLow * (100 - Fund2035PartialReinvest)/100.00;
					Ridertemp2035Low = currentValue * (100 - Fund2035PartialReinvest)/100.00;
					RiderWithdrawtemp2035Low = currentValue * (Fund2035PartialReinvest)/100.00;
				}
				else{
					MonthFundMaturityValue2035_Bear = 0;
				}
				
				if (aaRound == 2) {
					RiderMonthVU2035PrevValueLow = 0;
				}
				else{
					RiderMonthVU2035PrevValueLow = tempPrev;
				}
				
			}
			else{
				if (aaRound == 2) {
					RiderMonthVU2035PrevValueLow = currentValue;
				}
				else{
					RiderMonthVU2035PrevValueLow = tempPrev;
				}
			}
			
			if (aaRound == 2 && i == 12) {
				RiderVU2035PrevValueLow = RiderMonthVU2035PrevValueLow;
			}
			
			//return MonthVU2035PrevValueLow;
			return currentValue;
		}
		else{
			if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalLow != 0 ) {
				
				currentValue=  ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] ) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear]  +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2035Factor * [self ReturnPremiumFactor:i]) *
				(1 + VU2035InstLow) + RiderVU2035PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstLow:@"A"]) + (RiderNegativeValueOfMaxCashFundLow - 1) *
				(RiderVU2035ValueLow/RiderFundValueOfTheYearValueTotalLow);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] ) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] +
									[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VU2035Factor * [self ReturnPremiumFactor:i]) *
					(1 + VU2035InstLow) + RiderVU2035PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstLow:@"A"]);
					RiderVU2035ValueLow = currentValue;
				}
				else{
					currentValue = RiderVU2035ValueLow;
				}
			}
			
			if (aaRound == 2) {
				RiderVU2035PrevValueLow = currentValue;
			}
			
			return currentValue;
		}
		
		
	}
}


-(double)ReturnRiderVUCashValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)i {
	
	double tempValue = 0.00;
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		if (i == 1) {
			RiderMonthVUCashPrevValueHigh = RiderVUCashPrevValueHigh;
		}
		
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			
			RiderMonthVUCashPrevValueHigh = RiderMonthVUCashPrevValueHigh + (Ridertemp2035High * Fund2035ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			RiderMonthVUCashPrevValueHigh = RiderMonthVUCashPrevValueHigh + (Ridertemp2030High * Fund2030ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			//NSLog(@"%f", temp2028High);
			RiderMonthVUCashPrevValueHigh = RiderMonthVUCashPrevValueHigh + (Ridertemp2028High * Fund2028ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			RiderMonthVUCashPrevValueHigh = RiderMonthVUCashPrevValueHigh + (Ridertemp2025High * Fund2025ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			RiderMonthVUCashPrevValueHigh = RiderMonthVUCashPrevValueHigh + (Ridertemp2023High * Fund2023ReinvestToCashFac/100.00);
		}
		else{
			
		}
		
		tempValue = ((( [[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear andMonth:i] +
					 [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * [self ReturnPremiumFactor:i]) *
		pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/12.00)) + RiderMonthVUCashPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
		pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/12.00)) - ([self ReturnRiderPolicyFee:aaPolicyYear] + [self ReturnTotalRiderMort:aaPolicyYear]);
		
		RiderMonthVUCashPrevValueHigh =  tempValue;
		//NSLog(@"%f", MonthVUCashPrevValueHigh);
		
		if (tempValue < 0) {
			RiderMonthVUCashPrevValueHigh = 1.00;
		}
		else{
			RiderMonthVUCashPrevValueHigh = tempValue;
		}
		
		if (i == 12) {
			RiderVUCashPrevValueHigh = RiderMonthVUCashPrevValueHigh;
		}
		
		if (tempValue < 0 && RiderMonthFundValueOfTheYearValueTotalHigh != 0) {
			RiderNegativeValueOfMaxCashFundHigh = tempValue;
			RiderVUCashValueNegative = TRUE;
			return RiderMonthVUCashPrevValueHigh;
		} else {
			RiderNegativeValueOfMaxCashFundHigh = tempValue;
			RiderVUCashValueNegative = FALSE;
			return RiderMonthVUCashPrevValueHigh + 0; // to be edit later
		}
		
	}
	else
	{
		tempValue = ((( [[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear] +
					 [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear] * [self ReturnPremiumFactor:i]) *
		(1 + [self ReturnVUCashInstHigh:@""]) + RiderVUCashPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUCashInstHigh:@"A"]) -
		([self ReturnRiderPolicyFee:aaPolicyYear ] + [self ReturnTotalRiderMort:aaPolicyYear]) * [self ReturnVUCashHigh];
		//NSLog(@"%f, %f", [self ReturnRiderPolicyFee:aaPolicyYear ], [self ReturnTotalRiderMort:aaPolicyYear] );
		
		if (tempValue < 0) {
			RiderVUCashPrevValueHigh = 1.00;
		}
		else{
			RiderVUCashPrevValueHigh = tempValue;
		}
		
		
		//VUCashPrevValueHigh = tempValue;
		if (tempValue < 0 && RiderFundValueOfTheYearValueTotalHigh != 0) {
			//NegativeValueOfMaxCashFundHigh = tempValue;
			RiderNegativeValueOfMaxCashFundHigh = tempValue;
			RiderVUCashValueNegative = TRUE;
			return RiderVUCashPrevValueHigh;
		} else {
			RiderVUCashValueNegative = FALSE;
			RiderNegativeValueOfMaxCashFundHigh = tempValue;
			return tempValue + 0; // to be edit later
		}
	}
	
	
	
	
	
}

-(double)ReturnRiderVUCashValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)i{
	
	double tempValue = 0.00;
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		if (i == 1) {
			RiderMonthVUCashPrevValueMedian = RiderVUCashPrevValueMedian;
		}
		
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			RiderMonthVUCashPrevValueMedian = RiderMonthVUCashPrevValueMedian + (Ridertemp2035Median * Fund2035ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			RiderMonthVUCashPrevValueMedian = RiderMonthVUCashPrevValueMedian + (Ridertemp2030Median * Fund2030ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			RiderMonthVUCashPrevValueMedian = RiderMonthVUCashPrevValueMedian + (Ridertemp2028Median * Fund2028ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			RiderMonthVUCashPrevValueMedian = RiderMonthVUCashPrevValueMedian + (Ridertemp2025Median * Fund2025ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			RiderMonthVUCashPrevValueMedian = RiderMonthVUCashPrevValueMedian + (Ridertemp2023Median * Fund2023ReinvestToCashFac/100.00);
		}
		else{
			
		}
		
		tempValue = ((( [[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear andMonth:i] +
					 [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * [self ReturnPremiumFactor:i]) *
		pow(1 + [self ReturnVUCashInstMedian:@"A"], 1.00/12.00) + RiderMonthVUCashPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
		pow(1 + [self ReturnVUCashInstMedian:@"A"], 1.00/12.00) - ([self ReturnRiderPolicyFee:aaPolicyYear ] + [self ReturnTotalRiderMort:aaPolicyYear]);
		
		RiderMonthVUCashPrevValueMedian = tempValue;
		
		if (tempValue < 0) {
			RiderMonthVUCashPrevValueMedian = 1.00;
		}
		else{
			RiderMonthVUCashPrevValueMedian = tempValue;
		}
		
		if (i == 12) {
			RiderVUCashPrevValueMedian = RiderMonthVUCashPrevValueMedian;
		}
		
		
		if (tempValue < 0 && RiderMonthFundValueOfTheYearValueTotalMedian != 0) {
			RiderNegativeValueOfMaxCashFundMedian = tempValue;
			RiderVUCashValueNegative = TRUE;
			return  RiderMonthVUCashPrevValueMedian;
		} else {
			RiderNegativeValueOfMaxCashFundMedian =  tempValue;
			RiderVUCashValueNegative = FALSE;
			return  RiderMonthVUCashPrevValueMedian + 0; // to be edit later
		}
		
		
		
		
	}
	else{
		tempValue = ((( [[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear] +
					 [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear] * [self ReturnPremiumFactor:i]) *
		(1 + [self ReturnVUCashInstMedian:@""]) + RiderVUCashPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUCashInstMedian:@"A"]) -
		([self ReturnRiderPolicyFee:aaPolicyYear ] + [self ReturnTotalRiderMort:aaPolicyYear]) * [self ReturnVUCashMedian];
		
		
		if (tempValue < 0) {
			RiderVUCashPrevValueMedian = 1.00;
		}
		else{
			RiderVUCashPrevValueMedian = tempValue;
		}
		
		//VUCashPrevValueMedian = tempValue;
		if (tempValue < 0 && RiderFundValueOfTheYearValueTotalMedian != 0) {
			RiderNegativeValueOfMaxCashFundMedian = tempValue;
			RiderVUCashValueNegative = TRUE;
			return RiderVUCashPrevValueMedian;
			//return tempValue;
		} else {
			RiderNegativeValueOfMaxCashFundMedian = tempValue;
			RiderVUCashValueNegative = FALSE;
			return tempValue + 0; // to be edit later
		}
	}
	
	
	
	
}


-(double)ReturnRiderVUCashValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)i{
	
	double tempValue = 0.00;
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		if (i == 1) {
			RiderMonthVUCashPrevValueLow = RiderVUCashPrevValueLow;
		}
		
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			RiderMonthVUCashPrevValueLow = RiderMonthVUCashPrevValueLow + (Ridertemp2035Low * Fund2035ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			RiderMonthVUCashPrevValueLow = RiderMonthVUCashPrevValueLow + (Ridertemp2030Low * Fund2030ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			RiderMonthVUCashPrevValueLow = RiderMonthVUCashPrevValueLow + (Ridertemp2028Low * Fund2028ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			RiderMonthVUCashPrevValueLow = RiderMonthVUCashPrevValueLow + (Ridertemp2025Low * Fund2025ReinvestToCashFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			RiderMonthVUCashPrevValueLow = RiderMonthVUCashPrevValueLow + (Ridertemp2023Low * Fund2023ReinvestToCashFac/100.00);
		}
		else{
			
		}
		
		tempValue = ((( [[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear andMonth:i] +
					 [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * [self ReturnPremiumFactor:i]) *
		pow(1 + [self ReturnVUCashInstLow:@"A"], 1.00/12.00) + RiderMonthVUCashPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
		pow(1 + [self ReturnVUCashInstLow:@"A"], 1.00/12.00) - ([self ReturnRiderPolicyFee:aaPolicyYear ] + [self ReturnTotalRiderMort:aaPolicyYear]);
		
		
		
		if (tempValue < 0) {
			RiderMonthVUCashPrevValueLow = 1.00;
		}
		else{
			RiderMonthVUCashPrevValueLow = tempValue;
		}
		
		if (i == 12) {
			RiderVUCashPrevValueLow = RiderMonthVUCashPrevValueLow;
		}
		
		
		
		
		if (tempValue < 0 && RiderMonthFundValueOfTheYearValueTotalLow != 0) {
			RiderNegativeValueOfMaxCashFundLow = tempValue;
			RiderVUCashValueNegative = TRUE;
			return  RiderMonthVUCashPrevValueLow;
		} else {
			RiderNegativeValueOfMaxCashFundLow =  tempValue;
			RiderVUCashValueNegative = FALSE;
			return  RiderMonthVUCashPrevValueLow + 0; // to be edit later
		}
	}
	else{
		tempValue = ((( [[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear] +
					 [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear] * [self ReturnPremiumFactor:i]) *
		(1 + [self ReturnVUCashInstLow:@""]) + RiderVUCashPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUCashInstLow:@"A"]) -
		([self ReturnRiderPolicyFee:aaPolicyYear ] + [self ReturnTotalRiderMort:aaPolicyYear]) * [self ReturnVUCashLow];
		
		if (tempValue < 0) {
			RiderVUCashPrevValueLow = 1.00;
		}
		else{
			RiderVUCashPrevValueLow = tempValue;
		}
		
		//VUCashPrevValueLow = tempValue;
		if (tempValue < 0 && RiderFundValueOfTheYearValueTotalLow != 0) {
			RiderNegativeValueOfMaxCashFundLow = tempValue;
			RiderVUCashValueNegative = TRUE;
			return RiderVUCashPrevValueLow;
			//return tempValue;
		} else {
			RiderNegativeValueOfMaxCashFundLow = tempValue;
			RiderVUCashValueNegative = FALSE;
			return tempValue + 0; // to be edit later
		}
	}
	
	
	
	
}


-(double)ReturnRiderVURetValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)i{
	
	double currentValue =0.0;
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		
		if (i == 1) {
			RiderMonthVURetPrevValueHigh = RiderVURetPrevValueHigh ;
		}
		
		double tempPrev = RiderMonthVURetPrevValueHigh;
		
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)) {
			RiderMonthVURetPrevValueHigh = RiderMonthVURetPrevValueHigh + (Ridertemp2035High * Fund2035ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			RiderMonthVURetPrevValueHigh = RiderMonthVURetPrevValueHigh + (Ridertemp2030High * Fund2030ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			RiderMonthVURetPrevValueHigh = RiderMonthVURetPrevValueHigh + (Ridertemp2028High * Fund2028ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			RiderMonthVURetPrevValueHigh = RiderMonthVURetPrevValueHigh + (Ridertemp2025High * Fund2025ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			RiderMonthVURetPrevValueHigh = RiderMonthVURetPrevValueHigh + (Ridertemp2023High * Fund2023ReinvestToRetFac/100.00);
		}
		else{
			
		}
		
		//NSLog(@"%f", MonthVURetPrevValueHigh);
		if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalHigh != 0 ) {
			currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear andMonth:i] +
						   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VURetFactor * [self ReturnPremiumFactor:i]) *
			pow(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"],1.00/12.00) + RiderMonthVURetPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"], 1.00/12.00) + (RiderNegativeValueOfMaxCashFundHigh - 1) *
			(RiderMonthVURetValueHigh/RiderMonthFundValueOfTheYearValueTotalHigh);
			
			//NSLog(@"%f %f %f",NegativeValueOfMaxCashFundHigh, MonthVURetValueHigh,MonthFundValueOfTheYearValueTotalHigh );
			
		}
		else{
			currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] +
							[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VURetFactor * [self ReturnPremiumFactor:i]) *
			pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]),(1.00/12.00)) + RiderMonthVURetPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/12.00));
			
			
		}
		
		//NSLog(@"%f, %f, %f, %f",NegativeValueOfMaxCashFundHigh, MonthVURetValueHigh, MonthFundValueOfTheYearValueTotalHigh, currentValue);
		
		if (aaRound == 2) {
			RiderMonthVURetPrevValueHigh = currentValue;
		}
		else{
			RiderMonthVURetPrevValueHigh = tempPrev;
		}
		
		
		if (i == 12  && aaRound == 2) {
			RiderVURetPrevValueHigh = RiderMonthVURetPrevValueHigh;
		}
		
		//NSLog(@"%d %f %f, %d ", i, MonthVURetValueHigh, MonthFundValueOfTheYearValueTotalHigh, VUCashValueNegative);
		//return MonthVURetPrevValueHigh;
		return currentValue;
		
		
		
		
	}
	else{
		//if (VUCashValueHigh < 0 && [self ReturnFundValueOfTheYearValueTotalHigh:aaPolicyYear] != 0 ) {
		if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalHigh != 0 ) {
			currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] ) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] +
						   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VURetFactor * [self ReturnPremiumFactor:i]) *
			(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@""]) + RiderVURetPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]) + (RiderNegativeValueOfMaxCashFundHigh - 1) *
			(RiderVURetValueHigh/RiderFundValueOfTheYearValueTotalHigh);
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] ) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VURetFactor * [self ReturnPremiumFactor:i]) *
				(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@""]) + RiderVURetPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]);
				RiderVURetValueHigh = currentValue;
			}
			else{
				currentValue = RiderVURetValueHigh;
			}
			
		}
		
		if (aaRound == 2) {
			RiderVURetPrevValueHigh = currentValue;
		}
		
		return currentValue;
	}
	
	
}

-(double)ReturnRiderVURetValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		
		if (i == 1) {
			RiderMonthVURetPrevValueMedian = RiderVURetPrevValueMedian ;
		}
		
		double tempPrev = RiderMonthVURetPrevValueMedian;
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			RiderMonthVURetPrevValueMedian = RiderMonthVURetPrevValueMedian + (Ridertemp2035Median * Fund2035ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			RiderMonthVURetPrevValueMedian = RiderMonthVURetPrevValueMedian + (Ridertemp2030Median * Fund2030ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			RiderMonthVURetPrevValueMedian = RiderMonthVURetPrevValueMedian + (Ridertemp2028Median * Fund2028ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			RiderMonthVURetPrevValueMedian = RiderMonthVURetPrevValueMedian + (Ridertemp2025Median * Fund2025ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			RiderMonthVURetPrevValueMedian = RiderMonthVURetPrevValueMedian + (Ridertemp2023Median * Fund2023ReinvestToRetFac/100.00);
		}
		else{
			
		}
		
		if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalMedian != 0 ) {
			currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] +
						   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VURetFactor * [self ReturnPremiumFactor:i]) *
			pow(1 + [self ReturnVURetInstMedian:@"A"], 1.00/12.00) + RiderMonthVURetPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVURetInstMedian:@"A"], 1.00/12.00) + (RiderNegativeValueOfMaxCashFundMedian - 1) *
			(RiderMonthVURetValueMedian/RiderMonthFundValueOfTheYearValueTotalMedian);
			
		}
		else{
			currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] +
							[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VURetFactor * [self ReturnPremiumFactor:i]) *
			pow(1 + [self ReturnVURetInstMedian:@"A"], 1.00/12.00) + RiderMonthVURetPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVURetInstMedian:@"A"], 1.00/12.00);
			
		}
		
		if (aaRound == 2) {
			RiderMonthVURetPrevValueMedian = currentValue;
		}
		else{
			RiderMonthVURetPrevValueMedian = tempPrev;
		}
		
		if (i == 12  && aaRound == 2) {
			RiderVURetPrevValueMedian = RiderMonthVURetPrevValueMedian ;
		}
		
		
		//return MonthVURetPrevValueMedian;
		return currentValue;
		
	}
	else{
		//if (VUCashValueMedian < 0 && [self ReturnFundValueOfTheYearValueTotalMedian:aaPolicyYear] != 0 ) {
		if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalMedian != 0 ) {
			currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] +
						   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VURetFactor * [self ReturnPremiumFactor:i]) *
			(1 + [self ReturnVURetInstMedian:@""]) + RiderVURetPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstMedian:@"A"]) + (RiderNegativeValueOfMaxCashFundMedian - 1) *
			(RiderVURetValueMedian/RiderFundValueOfTheYearValueTotalMedian);
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VURetFactor * [self ReturnPremiumFactor:i]) *
				(1 + [self ReturnVURetInstMedian:@""]) + RiderVURetPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstMedian:@"A"]);
				RiderVURetValueMedian = currentValue;
			}
			else{
				currentValue = RiderVURetValueMedian;
			}
		}
		
		if (aaRound == 2) {
			RiderVURetPrevValueMedian = currentValue;
		}
		return currentValue;
	}
	
}

-(double)ReturnRiderVURetValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		
		if (i == 1) {
			RiderMonthVURetPrevValueLow = RiderVURetPrevValueLow ;
		}
		
		double tempPrev = RiderMonthVURetPrevValueLow;
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			RiderMonthVURetPrevValueLow = RiderMonthVURetPrevValueLow + (Ridertemp2035Low * Fund2035ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			RiderMonthVURetPrevValueLow = RiderMonthVURetPrevValueLow + (Ridertemp2030Low * Fund2030ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			RiderMonthVURetPrevValueLow = RiderMonthVURetPrevValueLow + (Ridertemp2028Low * Fund2028ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			RiderMonthVURetPrevValueLow = RiderMonthVURetPrevValueLow + (Ridertemp2025Low * Fund2025ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			RiderMonthVURetPrevValueLow = RiderMonthVURetPrevValueLow + (Ridertemp2023Low * Fund2023ReinvestToRetFac/100.00);
		}
		else{
			
		}
		
		if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalLow != 0 ) {
			currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] +
						   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VURetFactor * [self ReturnPremiumFactor:i]) *
			pow(1 + [self ReturnVURetInstLow:@"A"], 1.00/12.00) + RiderMonthVURetPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVURetInstLow:@"A"], 1.00/12.00) + (RiderNegativeValueOfMaxCashFundLow - 1) *
			(RiderMonthVURetValueLow/RiderMonthFundValueOfTheYearValueTotalLow);
			
		}
		else{
			currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] +
							[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VURetFactor * [self ReturnPremiumFactor:i]) *
			pow(1 + [self ReturnVURetInstLow:@"A"], 1.00/12.00) + RiderMonthVURetPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVURetInstLow:@"A"], 1.00/12.00);
			
		}
		
		
		if (aaRound == 2) {
			RiderMonthVURetPrevValueLow = currentValue;
		}
		else{
			RiderMonthVURetPrevValueLow = tempPrev;
		}
		
		if (i == 12  && aaRound == 2) {
			RiderVURetPrevValueLow = RiderMonthVURetPrevValueLow ;
		}
		
		//return MonthVURetPrevValueLow;
		return currentValue;
		
	}
	else{
		if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalLow != 0 ) {
			currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear]  +
						   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VURetFactor * [self ReturnPremiumFactor:i]) *
			(1 + [self ReturnVURetInstLow:@""]) + RiderVURetPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstLow:@"A"]) + (RiderNegativeValueOfMaxCashFundLow - 1) *
			(RiderVURetValueLow/RiderFundValueOfTheYearValueTotalLow);
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VURetFactor * [self ReturnPremiumFactor:i]) *
				(1 + [self ReturnVURetInstLow:@""]) + RiderVURetPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstLow:@"A"]);
				RiderVURetValueLow = currentValue;
			}
			else{
				currentValue = RiderVURetValueLow;
			}
			
		}
		
		if (aaRound == 2) {
			RiderVURetPrevValueLow = currentValue;
		}
		return currentValue;
	}
	
}

-(double)ReturnRiderVUDanaValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)i{
	
	double currentValue =0.0;
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		
		if (i == 1) {
			RiderMonthVUDanaPrevValueHigh = RiderVUDanaPrevValueHigh ;
		}
		
		double tempPrev = RiderMonthVUDanaPrevValueHigh;
		
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)) {
			RiderMonthVUDanaPrevValueHigh = RiderMonthVUDanaPrevValueHigh + (Ridertemp2035High * Fund2035ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			RiderMonthVUDanaPrevValueHigh = RiderMonthVUDanaPrevValueHigh + (Ridertemp2030High * Fund2030ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			RiderMonthVUDanaPrevValueHigh = RiderMonthVUDanaPrevValueHigh + (Ridertemp2028High * Fund2028ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			RiderMonthVUDanaPrevValueHigh = RiderMonthVUDanaPrevValueHigh + (Ridertemp2025High * Fund2025ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			RiderMonthVUDanaPrevValueHigh = RiderMonthVUDanaPrevValueHigh + (Ridertemp2023High * Fund2023ReinvestToRetFac/100.00);
		}
		else{
			
		}
		
		//NSLog(@"%f", MonthVURetPrevValueHigh);
		if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalHigh != 0 ) {
			currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear andMonth:i] +
						   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VUDanaFactor * [self ReturnPremiumFactor:i]) *
			pow(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"],1.00/12.00) + RiderMonthVUDanaPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"], 1.00/12.00) + (RiderNegativeValueOfMaxCashFundHigh - 1) *
			(RiderMonthVUDanaValueHigh/RiderMonthFundValueOfTheYearValueTotalHigh);
			
			//NSLog(@"%f %f %f",NegativeValueOfMaxCashFundHigh, MonthVURetValueHigh,MonthFundValueOfTheYearValueTotalHigh );
			
		}
		else{
			currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear  andMonth:i] +
							[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VUDanaFactor * [self ReturnPremiumFactor:i]) *
			pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]),(1.00/12.00)) + RiderMonthVUDanaPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/12.00));
			
			
		}
		
		//NSLog(@"%f, %f, %f, %f",NegativeValueOfMaxCashFundHigh, MonthVURetValueHigh, MonthFundValueOfTheYearValueTotalHigh, currentValue);
		
		if (aaRound == 2) {
			RiderMonthVUDanaPrevValueHigh = currentValue;
		}
		else{
			RiderMonthVUDanaPrevValueHigh = tempPrev;
		}
		
		
		if (i == 12  && aaRound == 2) {
			RiderVUDanaPrevValueHigh = RiderMonthVUDanaPrevValueHigh;
		}
		
		//NSLog(@"%d %f %f, %d ", i, MonthVURetValueHigh, MonthFundValueOfTheYearValueTotalHigh, VUCashValueNegative);
		//return MonthVURetPrevValueHigh;
		return currentValue;
		
		
		
		
	}
	else{
		//if (VUCashValueHigh < 0 && [self ReturnFundValueOfTheYearValueTotalHigh:aaPolicyYear] != 0 ) {
		if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalHigh != 0 ) {
			currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] ) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear] +
						   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VUDanaFactor * [self ReturnPremiumFactor:i]) *
			(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@""]) + RiderVUDanaPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]) + (RiderNegativeValueOfMaxCashFundHigh - 1) *
			(RiderVUDanaValueHigh/RiderFundValueOfTheYearValueTotalHigh);
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] ) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VUDanaFactor * [self ReturnPremiumFactor:i]) *
				(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@""]) + RiderVUDanaPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]);
				RiderVUDanaValueHigh = currentValue;
			}
			else{
				currentValue = RiderVUDanaValueHigh;
			}
			
		}
		
		if (aaRound == 2) {
			RiderVUDanaPrevValueHigh = currentValue;
		}
		
		return currentValue;
	}
	
	
}

-(double)ReturnRiderVUDanaValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		
		if (i == 1) {
			RiderMonthVUDanaPrevValueMedian = RiderVUDanaPrevValueMedian ;
		}
		
		double tempPrev = RiderMonthVUDanaPrevValueMedian;
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			RiderMonthVUDanaPrevValueMedian = RiderMonthVUDanaPrevValueMedian + (Ridertemp2035Median * Fund2035ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			RiderMonthVUDanaPrevValueMedian = RiderMonthVUDanaPrevValueMedian + (Ridertemp2030Median * Fund2030ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			RiderMonthVUDanaPrevValueMedian = RiderMonthVUDanaPrevValueMedian + (Ridertemp2028Median * Fund2028ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			RiderMonthVUDanaPrevValueMedian = RiderMonthVUDanaPrevValueMedian + (Ridertemp2025Median * Fund2025ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			RiderMonthVUDanaPrevValueMedian = RiderMonthVUDanaPrevValueMedian + (Ridertemp2023Median * Fund2023ReinvestToRetFac/100.00);
		}
		else{
			
		}
		
		if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalMedian != 0 ) {
			currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear  andMonth:i] +
						   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VUDanaFactor * [self ReturnPremiumFactor:i]) *
			pow(1 + [self ReturnVUDanaInstMedian:@"A"], 1.00/12.00) + RiderMonthVUDanaPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVUDanaInstMedian:@"A"], 1.00/12.00) + (RiderNegativeValueOfMaxCashFundMedian - 1) *
			(RiderMonthVUDanaValueMedian/RiderMonthFundValueOfTheYearValueTotalMedian);
			
		}
		else{
			currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear  andMonth:i] +
							[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VUDanaFactor * [self ReturnPremiumFactor:i]) *
			pow(1 + [self ReturnVUDanaInstMedian:@"A"], 1.00/12.00) + RiderMonthVUDanaPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVUDanaInstMedian:@"A"], 1.00/12.00);
			
		}
		
		if (aaRound == 2) {
			RiderMonthVUDanaPrevValueMedian = currentValue;
		}
		else{
			RiderMonthVUDanaPrevValueMedian = tempPrev;
		}
		
		if (i == 12  && aaRound == 2) {
			RiderVUDanaPrevValueMedian = RiderMonthVUDanaPrevValueMedian ;
		}
		
		
		//return MonthVURetPrevValueMedian;
		return currentValue;
		
	}
	else{
		//if (VUCashValueMedian < 0 && [self ReturnFundValueOfTheYearValueTotalMedian:aaPolicyYear] != 0 ) {
		if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalMedian != 0 ) {
			currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear] +
						   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VUDanaFactor * [self ReturnPremiumFactor:i]) *
			(1 + [self ReturnVUDanaInstMedian:@""]) + RiderVUDanaPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUDanaInstMedian:@"A"]) + (RiderNegativeValueOfMaxCashFundMedian - 1) *
			(RiderVUDanaValueMedian/RiderFundValueOfTheYearValueTotalMedian);
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VUDanaFactor * [self ReturnPremiumFactor:i]) *
				(1 + [self ReturnVUDanaInstMedian:@""]) + RiderVUDanaPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUDanaInstMedian:@"A"]);
				RiderVUDanaValueMedian = currentValue;
			}
			else{
				currentValue = RiderVUDanaValueMedian;
			}
		}
		
		if (aaRound == 2) {
			RiderVUDanaPrevValueMedian = currentValue;
		}
		return currentValue;
	}
	
}

-(double)ReturnRiderVUDanaValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		
		
		if (i == 1) {
			RiderMonthVUDanaPrevValueLow = RiderVUDanaPrevValueLow ;
		}
		
		double tempPrev = RiderMonthVUDanaPrevValueLow;
		if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
			RiderMonthVUDanaPrevValueLow = RiderMonthVUDanaPrevValueLow + (Ridertemp2035Low * Fund2035ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
			RiderMonthVUDanaPrevValueLow = RiderMonthVUDanaPrevValueLow + (Ridertemp2030Low * Fund2030ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
			RiderMonthVUDanaPrevValueLow = RiderMonthVUDanaPrevValueLow + (Ridertemp2028Low * Fund2028ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
			RiderMonthVUDanaPrevValueLow = RiderMonthVUDanaPrevValueLow + (Ridertemp2025Low * Fund2025ReinvestToRetFac/100.00);
		}
		else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
			RiderMonthVUDanaPrevValueLow = RiderMonthVUDanaPrevValueLow + (Ridertemp2023Low * Fund2023ReinvestToRetFac/100.00);
		}
		else{
			
		}
		
		if (RiderVUCashValueNegative == TRUE && RiderMonthFundValueOfTheYearValueTotalLow != 0 ) {
			currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear  andMonth:i] +
						   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VUDanaFactor * [self ReturnPremiumFactor:i]) *
			pow(1 + [self ReturnVUDanaInstLow:@"A"], 1.00/12.00) + RiderMonthVUDanaPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVUDanaInstLow:@"A"], 1.00/12.00) + (RiderNegativeValueOfMaxCashFundLow - 1) *
			(RiderMonthVUDanaValueLow/RiderMonthFundValueOfTheYearValueTotalLow);
			
		}
		else{
			currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear  andMonth:i] +
							[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VUDanaFactor * [self ReturnPremiumFactor:i]) *
			pow(1 + [self ReturnVUDanaInstLow:@"A"], 1.00/12.00) + RiderMonthVUDanaPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVUDanaInstLow:@"A"], 1.00/12.00);
			
		}
		
		
		if (aaRound == 2) {
			RiderMonthVUDanaPrevValueLow = currentValue;
		}
		else{
			RiderMonthVUDanaPrevValueLow = tempPrev;
		}
		
		if (i == 12  && aaRound == 2) {
			RiderVUDanaPrevValueLow = RiderMonthVUDanaPrevValueLow ;
		}
		
		//return MonthVURetPrevValueLow;
		return currentValue;
		
	}
	else{
		if (RiderVUCashValueNegative == TRUE && RiderFundValueOfTheYearValueTotalLow != 0 ) {
			currentValue= ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear]  +
						   [self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VUDanaFactor * [self ReturnPremiumFactor:i]) *
			(1 + [self ReturnVUDanaInstLow:@""]) + RiderVUDanaPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUDanaInstLow:@"A"]) + (RiderNegativeValueOfMaxCashFundLow - 1) *
			(RiderVUDanaValueLow/RiderFundValueOfTheYearValueTotalLow);
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([[UniTotalRiderPremWithAlloc objectAtIndex:aaPolicyYear - 1] doubleValue ]) + IncreasePrem) * [self ReturnVUDanaFac:aaPolicyYear] +
								[self ReturnRiderRegTopUpPrem:aaPolicyYear] * RegularAllo * VUDanaFactor * [self ReturnPremiumFactor:i]) *
				(1 + [self ReturnVUDanaInstLow:@""]) + RiderVUDanaPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUDanaInstLow:@"A"]);
				RiderVUDanaValueLow = currentValue;
			}
			else{
				currentValue = RiderVUDanaValueLow;
			}
			
		}
		
		if (aaRound == 2) {
			RiderVUDanaPrevValueLow = currentValue;
		}
		return currentValue;
	}
	
}

#pragma mark - Calculate Total Yearly Income for each fund for Rider ECAR1,ECAR6,ECAR55

-(void)ReturnEverCash1 :(int)aaPolicyYear {
	double ECAR1SA = [ECAR1SumAssured doubleValue ];
	
	if(ECAR1Exist == FALSE){
		VU2023Value_EverCash1 = 0.00;
		VU2025Value_EverCash1 = 0.00;
		VU2028Value_EverCash1 = 0.00;
		VU2030Value_EverCash1 = 0.00;
		VU2035Value_EverCash1 = 0.00;
		VURetValue_EverCash1 = 0.00;
		VUDanaValue_EverCash1 = 0.00;
		VUCashValue_EverCash1 = 0.00;
	}
	else{
		if (aaPolicyYear <= [ECAR1RiderTerm intValue] && [ECAR1ReinvestGYI isEqualToString:@"Yes"] ) {
			VUCash_FundAllo_Percen = [self ReturnVUCashFac:aaPolicyYear] * 100;
			VU2025_FundAllo_Percen = [self ReturnVU2025Fac:aaPolicyYear] * 100;
			VU2028_FundAllo_Percen = [self ReturnVU2028Fac:aaPolicyYear] * 100;
			VU2030_FundAllo_Percen = [self ReturnVU2030Fac:aaPolicyYear] * 100;
			VU2035_FundAllo_Percen = [self ReturnVU2035Fac:aaPolicyYear] * 100;
			VURet_FundAllo_Percen = [self ReturnVURetFac:aaPolicyYear] * 100;
			VUDana_FundAllo_Percen = [self ReturnVUDanaFac:aaPolicyYear] * 100;
			/*
			if ([strBumpMode isEqualToString:@"S" ]) {
				ECAR1SA = ECAR1SA / 0.5;
			}
			else if ([strBumpMode isEqualToString:@"Q" ]){
				ECAR1SA = ECAR1SA / 0.25;
			}
			else if ([strBumpMode isEqualToString:@"M" ]){
				ECAR1SA = ECAR1SA / 0.0833333;
			}
			else{
				ECAR1SA = ECAR1SA / 1.00;
			}
			*/
			if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = ECAR1SA;
				}
				else{
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = ECAR1SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2028Value_EverCash1 = ECAR1SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash1 = ECAR1SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash1 = ECAR1SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash1 = 0.00;
				}
			}
			else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = ECAR1SA;
				}
				else{
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = ECAR1SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash1 = ECAR1SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash1 = ECAR1SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash1 = 0.00;
				}
			}
			else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = ECAR1SA;
				}
				else{
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = ECAR1SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash1 = ECAR1SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash1 = 0.00;
				}
			}
			else if (aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = ECAR1SA;
				}
				else{
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = ECAR1SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash1 = 0.00;
				}
			}
			else if (aaPolicyYear == FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = ECAR1SA;
				}
				else{
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash1 = 0.00;
				}
			}
			else if (aaPolicyYear > FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = ECAR1SA;
				}
				else{
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash1 = 0.00;
				}
			}
			else{
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = 0.00;
				}
				else{
					if (VU2023_FundAllo_Percen > 0) {
						VU2023Value_EverCash1 = ECAR1SA * (VU2023_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2023Value_EverCash1 = 0.00;
					}
					
					if (VU2025_FundAllo_Percen > 0) {
						VU2025Value_EverCash1 = ECAR1SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2025Value_EverCash1 = 0.00;
					}
					
					if (VU2028_FundAllo_Percen > 0) {
						VU2028Value_EverCash1 = ECAR1SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2028Value_EverCash1 = 0.00;
					}
					
					if (VU2030_FundAllo_Percen > 0) {
						VU2030Value_EverCash1 = ECAR1SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2030Value_EverCash1 = 0.00;
					}
					
					if (VU2035_FundAllo_Percen > 0) {
						VU2035Value_EverCash1 = ECAR1SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2035Value_EverCash1 = 0.00;
					}
					
					if (VURet_FundAllo_Percen > 0) {
						VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VURetValue_EverCash1 = 0.00;
					}
					
					if (VUDana_FundAllo_Percen > 0) {
						VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VUDanaValue_EverCash1 = 0.00;
					}
				}
				
			}
			
		}
		else{
			VU2023Value_EverCash1 = 0.00;
			VU2025Value_EverCash1 = 0.00;
			VU2028Value_EverCash1 = 0.00;
			VU2030Value_EverCash1 = 0.00;
			VU2035Value_EverCash1 = 0.00;
			VURetValue_EverCash1 = 0.00;
			VUDanaValue_EverCash1 = 0.00;
			VUCashValue_EverCash1 = 0.00;
		}
	}
	
	
}

-(void)ReturnMonthEverCash1 :(int)aaPolicyYear andMonth :(int)aaMonth {
	double ECAR1SA = [ECAR1SumAssured doubleValue ];
	
	if(ECAR1Exist == FALSE){
		VU2023Value_EverCash1 = 0.00;
		VU2025Value_EverCash1 = 0.00;
		VU2028Value_EverCash1 = 0.00;
		VU2030Value_EverCash1 = 0.00;
		VU2035Value_EverCash1 = 0.00;
		VURetValue_EverCash1 = 0.00;
		VUDanaValue_EverCash1 = 0.00;
		VUCashValue_EverCash1 = 0.00;
	}
	else{
		if (aaPolicyYear <= [ECAR1RiderTerm intValue] && [ECAR1ReinvestGYI isEqualToString:@"Yes"] ) {
			VUCash_FundAllo_Percen = [self ReturnVUCashFac:aaPolicyYear andMonth:aaMonth ] * 100;
			VU2025_FundAllo_Percen = [self ReturnVU2025Fac:aaPolicyYear andMonth:aaMonth] * 100;
			VU2028_FundAllo_Percen = [self ReturnVU2028Fac:aaPolicyYear andMonth:aaMonth] * 100;
			VU2030_FundAllo_Percen = [self ReturnVU2030Fac:aaPolicyYear andMonth:aaMonth] * 100;
			VU2035_FundAllo_Percen = [self ReturnVU2035Fac:aaPolicyYear andMonth:aaMonth] * 100;
			VURet_FundAllo_Percen = [self ReturnVURetFac:aaPolicyYear andMonth:aaMonth] * 100;
			VUDana_FundAllo_Percen = [self ReturnVUDanaFac:aaPolicyYear andMonth:aaMonth] * 100;
			/*
			if ([strBumpMode isEqualToString:@"S" ]) {
				ECAR1SA = ECAR1SA / 0.5;
			}
			else if ([strBumpMode isEqualToString:@"Q" ]){
				ECAR1SA = ECAR1SA / 0.25;
			}
			else if ([strBumpMode isEqualToString:@"M" ]){
				ECAR1SA = ECAR1SA / 0.0833333;
			}
			else{
				ECAR1SA = ECAR1SA / 1.00;
			}
			*/
			if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = ECAR1SA;
				}
				else{
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = ECAR1SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2028Value_EverCash1 = ECAR1SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash1 = ECAR1SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash1 = ECAR1SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash1 = 0.00;
				}
			}
			else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = ECAR1SA;
				}
				else{
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = ECAR1SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash1 = ECAR1SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash1 = ECAR1SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash1 = 0.00;
				}
			}
			else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = ECAR1SA;
				}
				else{
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = ECAR1SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash1 = ECAR1SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash1 = 0.00;
				}
			}
			else if (aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = ECAR1SA;
				}
				else{
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = ECAR1SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash1 = 0.00;
				}
			}
			else if (aaPolicyYear == FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = ECAR1SA;
				}
				else{
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash1 = 0.00;
				}
			}
			else if (aaPolicyYear > FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = ECAR1SA;
				}
				else{
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash1 = 0.00;
				}
			}
			else{
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash1 = 0.00;
					VU2025Value_EverCash1 = 0.00;
					VU2028Value_EverCash1 = 0.00;
					VU2030Value_EverCash1 = 0.00;
					VU2035Value_EverCash1 = 0.00;
					VURetValue_EverCash1 = 0.00;
					VUDanaValue_EverCash1 = 0.00;
					VUCashValue_EverCash1 = 0.00;
				}
				else{
					if (VU2023_FundAllo_Percen > 0) {
						VU2023Value_EverCash1 = ECAR1SA * (VU2023_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2023Value_EverCash1 = 0.00;
					}
					
					if (VU2025_FundAllo_Percen > 0) {
						VU2025Value_EverCash1 = ECAR1SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2025Value_EverCash1 = 0.00;
					}
					
					if (VU2028_FundAllo_Percen > 0) {
						VU2028Value_EverCash1 = ECAR1SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2028Value_EverCash1 = 0.00;
					}
					
					if (VU2030_FundAllo_Percen > 0) {
						VU2030Value_EverCash1 = ECAR1SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2030Value_EverCash1 = 0.00;
					}
					
					if (VU2035_FundAllo_Percen > 0) {
						VU2035Value_EverCash1 = ECAR1SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
						
					}
					else{
						VU2035Value_EverCash1 = 0.00;
					}
					
					if (VURet_FundAllo_Percen > 0) {
						VURetValue_EverCash1 = ECAR1SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VURetValue_EverCash1 = 0.00;
					}
					
					if (VUDana_FundAllo_Percen > 0) {
						VUDanaValue_EverCash1 = ECAR1SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VUDanaValue_EverCash1 = 0.00;
					}
				}
				
			}
			
		}
		else{
			VU2023Value_EverCash1 = 0.00;
			VU2025Value_EverCash1 = 0.00;
			VU2028Value_EverCash1 = 0.00;
			VU2030Value_EverCash1 = 0.00;
			VU2035Value_EverCash1 = 0.00;
			VURetValue_EverCash1 = 0.00;
			VUDanaValue_EverCash1 = 0.00;
			VUCashValue_EverCash1 = 0.00;
		}
	}
	

	
}

-(void)ReturnEverCash6 :(int)aaPolicyYear {
	double ECAR6SA = [ECAR6SumAssured doubleValue ];
	
	if(ECAR6Exist == FALSE){
		VU2023Value_EverCash6 = 0.00;
		VU2025Value_EverCash6 = 0.00;
		VU2028Value_EverCash6 = 0.00;
		VU2030Value_EverCash6 = 0.00;
		VU2035Value_EverCash6 = 0.00;
		VURetValue_EverCash6 = 0.00;
		VUDanaValue_EverCash6 = 0.00;
		VUCashValue_EverCash6 = 0.00;
	}
	else{
		if (aaPolicyYear >= 6 && aaPolicyYear <= [ECAR6RiderTerm intValue] && [ECAR6ReinvestGYI isEqualToString:@"Yes"] ) {
			VUCash_FundAllo_Percen = [self ReturnVUCashFac:aaPolicyYear] * 100;
			VU2025_FundAllo_Percen = [self ReturnVU2025Fac:aaPolicyYear] * 100;
			VU2028_FundAllo_Percen = [self ReturnVU2028Fac:aaPolicyYear] * 100;
			VU2030_FundAllo_Percen = [self ReturnVU2030Fac:aaPolicyYear] * 100;
			VU2035_FundAllo_Percen = [self ReturnVU2035Fac:aaPolicyYear] * 100;
			VURet_FundAllo_Percen = [self ReturnVURetFac:aaPolicyYear] * 100;
			VUDana_FundAllo_Percen = [self ReturnVUDanaFac:aaPolicyYear] * 100;
			/*
			if ([strBumpMode isEqualToString:@"S" ]) {
				ECAR6SA = ECAR6SA / 0.5;
			}
			else if ([strBumpMode isEqualToString:@"Q" ]){
				ECAR6SA = ECAR6SA / 0.25;
			}
			else if ([strBumpMode isEqualToString:@"M" ]){
				ECAR6SA = ECAR6SA / 0.0833333;
			}
			else{
				ECAR6SA = ECAR6SA / 1.00;
			}
			*/
			if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = ECAR6SA;
				}
				else{
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = ECAR6SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2028Value_EverCash6 = ECAR6SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash6 = ECAR6SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash6 = ECAR6SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash6 = 0.00;
				}
			}
			else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = ECAR6SA;
				}
				else{
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = ECAR6SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash6 = ECAR6SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash6 = ECAR6SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash6 = 0.00;
				}
			}
			else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = ECAR6SA;
				}
				else{
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = ECAR6SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash6 = ECAR6SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash6 = 0.00;
				}
			}
			else if (aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = ECAR6SA;
				}
				else{
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = ECAR6SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash6 = 0.00;
				}
			}
			else if (aaPolicyYear == FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = ECAR6SA;
				}
				else{
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash6 = 0.00;
				}
			}
			else if (aaPolicyYear > FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6= 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = ECAR6SA;
				}
				else{
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash6 = 0.00;
				}
			}
			else{
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = 0.00;
				}
				else{
					if (VU2023_FundAllo_Percen > 0) {
						VU2023Value_EverCash6 = ECAR6SA * (VU2023_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2023Value_EverCash6 = 0.00;
					}
					
					if (VU2025_FundAllo_Percen > 0) {
						VU2025Value_EverCash6 = ECAR6SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2025Value_EverCash6 = 0.00;
					}
					
					if (VU2028_FundAllo_Percen > 0) {
						VU2028Value_EverCash6 = ECAR6SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2028Value_EverCash6 = 0.00;
					}
					
					if (VU2030_FundAllo_Percen > 0) {
						VU2030Value_EverCash6 = ECAR6SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2030Value_EverCash6 = 0.00;
					}
					
					if (VU2035_FundAllo_Percen > 0) {
						VU2035Value_EverCash6 = ECAR6SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2035Value_EverCash6 = 0.00;
					}
					
					if (VURet_FundAllo_Percen > 0) {
						VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VURetValue_EverCash6 = 0.00;
					}
					
					if (VUDana_FundAllo_Percen > 0) {
						VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VUDanaValue_EverCash6 = 0.00;
					}
				}
				
			}
			
		}
		else{
			VU2023Value_EverCash6 = 0.00;
			VU2025Value_EverCash6 = 0.00;
			VU2028Value_EverCash6 = 0.00;
			VU2030Value_EverCash6 = 0.00;
			VU2035Value_EverCash6 = 0.00;
			VURetValue_EverCash6 = 0.00;
			VUDanaValue_EverCash6 = 0.00;
			VUCashValue_EverCash6 = 0.00;
		}
	}
	
	
}

-(void)ReturnMonthEverCash6 :(int)aaPolicyYear andMonth :(int)aaMonth {
	double ECAR6SA = [ECAR6SumAssured doubleValue ];
	
	if(ECAR6Exist == FALSE){
		VU2023Value_EverCash6 = 0.00;
		VU2025Value_EverCash6 = 0.00;
		VU2028Value_EverCash6 = 0.00;
		VU2030Value_EverCash6 = 0.00;
		VU2035Value_EverCash6 = 0.00;
		VURetValue_EverCash6 = 0.00;
		VUDanaValue_EverCash6 = 0.00;
		VUCashValue_EverCash6 = 0.00;
	}
	else{
		if (aaPolicyYear >= 6 && aaPolicyYear <= [ECAR6RiderTerm intValue] && [ECAR6ReinvestGYI isEqualToString:@"Yes"] ) {
			VUCash_FundAllo_Percen = [self ReturnVUCashFac:aaPolicyYear andMonth:aaMonth ] * 100;
			VU2025_FundAllo_Percen = [self ReturnVU2025Fac:aaPolicyYear andMonth:aaMonth] * 100;
			VU2028_FundAllo_Percen = [self ReturnVU2028Fac:aaPolicyYear andMonth:aaMonth] * 100;
			VU2030_FundAllo_Percen = [self ReturnVU2030Fac:aaPolicyYear andMonth:aaMonth] * 100;
			VU2035_FundAllo_Percen = [self ReturnVU2035Fac:aaPolicyYear andMonth:aaMonth] * 100;
			VURet_FundAllo_Percen = [self ReturnVURetFac:aaPolicyYear andMonth:aaMonth] * 100;
			VUDana_FundAllo_Percen = [self ReturnVUDanaFac:aaPolicyYear andMonth:aaMonth] * 100;
			/*
			if ([strBumpMode isEqualToString:@"S" ]) {
				ECAR6SA = ECAR6SA / 0.5;
			}
			else if ([strBumpMode isEqualToString:@"Q" ]){
				ECAR6SA = ECAR6SA / 0.25;
			}
			else if ([strBumpMode isEqualToString:@"M" ]){
				ECAR6SA = ECAR6SA / 0.0833333;
			}
			else{
				ECAR6SA = ECAR6SA / 1.00;
			}
			*/
			if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = ECAR6SA;
				}
				else{
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = ECAR6SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2028Value_EverCash6 = ECAR6SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash6 = ECAR6SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash6 = ECAR6SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash6 = 0.00;
				}
			}
			else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = ECAR6SA;
				}
				else{
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = ECAR6SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash6 = ECAR6SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash6 = ECAR6SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash6 = 0.00;
				}
			}
			else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = ECAR6SA;
				}
				else{
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = ECAR6SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash6 = ECAR6SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash6 = 0.00;
				}
			}
			else if (aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;	
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = ECAR6SA;
				}
				else{
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = ECAR6SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash6 = 0.00;
				}
			}
			else if (aaPolicyYear == FundTerm2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = ECAR6SA;
				}
				else{
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash6 = 0.00;
				}
			}
			else if (aaPolicyYear > FundTerm2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = ECAR6SA;
				}
				else{
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash6 = 0.00;
				}
			}
			else{
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash6 = 0.00;
					VU2025Value_EverCash6 = 0.00;
					VU2028Value_EverCash6 = 0.00;
					VU2030Value_EverCash6 = 0.00;
					VU2035Value_EverCash6 = 0.00;
					VURetValue_EverCash6 = 0.00;
					VUDanaValue_EverCash6 = 0.00;
					VUCashValue_EverCash6 = 0.00;
				}
				else{
					if (VU2023_FundAllo_Percen > 0) {
						VU2023Value_EverCash6 = ECAR6SA * (VU2023_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2023Value_EverCash6 = 0.00;
					}
					
					if (VU2025_FundAllo_Percen > 0) {
						VU2025Value_EverCash6 = ECAR6SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2025Value_EverCash6 = 0.00;
					}
					
					if (VU2028_FundAllo_Percen > 0) {
						VU2028Value_EverCash6 = ECAR6SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2028Value_EverCash6 = 0.00;
					}
					
					if (VU2030_FundAllo_Percen > 0) {
						VU2030Value_EverCash6 = ECAR6SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VU2030Value_EverCash6 = 0.00;
					}
					
					if (VU2035_FundAllo_Percen > 0) {
						VU2035Value_EverCash6 = ECAR6SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
						
					}
					else{
						VU2035Value_EverCash6 = 0.00;
					}
					
					if (VURet_FundAllo_Percen > 0) {
						VURetValue_EverCash6 = ECAR6SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VURetValue_EverCash6 = 0.00;
					}
					
					if (VUDana_FundAllo_Percen > 0) {
						VUDanaValue_EverCash6 = ECAR6SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					}
					else{
						VUDanaValue_EverCash6 = 0.00;
					}
				}
				
			}
			
		}
		else{
			VU2023Value_EverCash6 = 0.00;
			VU2025Value_EverCash6 = 0.00;
			VU2028Value_EverCash6 = 0.00;
			VU2030Value_EverCash6 = 0.00;
			VU2035Value_EverCash6 = 0.00;
			VURetValue_EverCash6 = 0.00;
			VUDanaValue_EverCash6 = 0.00;
			VUCashValue_EverCash6 = 0.00;
		}
	}
	
	
	
}

-(void)ReturnEverCash55 :(int)aaPolicyYear {
	double ECAR55SA = [ECAR55SumAssured doubleValue ];
	
	if(ECAR55Exist == FALSE){
		VU2023Value_EverCash55 = 0.00;
		VU2025Value_EverCash55 = 0.00;
		VU2028Value_EverCash55 = 0.00;
		VU2030Value_EverCash55 = 0.00;
		VU2035Value_EverCash55 = 0.00;
		VURetValue_EverCash55 = 0.00;
		VUDanaValue_EverCash55 = 0.00;
		VUCashValue_EverCash55 = 0.00;
	}
	else{
		if (Age + aaPolicyYear >= 55 && aaPolicyYear <= [ECAR55RiderTerm intValue] && [ECAR55ReinvestGYI isEqualToString:@"Yes"] ) {
			VUCash_FundAllo_Percen = [self ReturnVUCashFac:aaPolicyYear] * 100;
			VU2025_FundAllo_Percen = [self ReturnVU2025Fac:aaPolicyYear] * 100;
			VU2028_FundAllo_Percen = [self ReturnVU2028Fac:aaPolicyYear] * 100;
			VU2030_FundAllo_Percen = [self ReturnVU2030Fac:aaPolicyYear] * 100;
			VU2035_FundAllo_Percen = [self ReturnVU2035Fac:aaPolicyYear] * 100;
			VURet_FundAllo_Percen = [self ReturnVURetFac:aaPolicyYear] * 100;
			VUDana_FundAllo_Percen = [self ReturnVUDanaFac:aaPolicyYear] * 100;
			
			double PrevVUCash_FundAllo_Percen = [self ReturnVUCashFac:aaPolicyYear - 1] * 100;
			double PrevVU2025_FundAllo_Percen = [self ReturnVU2025Fac:aaPolicyYear- 1] * 100;
			double PrevVU2028_FundAllo_Percen = [self ReturnVU2028Fac:aaPolicyYear- 1] * 100;
			double PrevVU2030_FundAllo_Percen = [self ReturnVU2030Fac:aaPolicyYear- 1] * 100;
			double PrevVU2035_FundAllo_Percen = [self ReturnVU2035Fac:aaPolicyYear- 1] * 100;
			double PrevVURet_FundAllo_Percen = [self ReturnVURetFac:aaPolicyYear- 1] * 100;
			double PrevVUDana_FundAllo_Percen = [self ReturnVUDanaFac:aaPolicyYear- 1] * 100;
			
			if ([strBumpMode isEqualToString:@"S" ]) {
				ECAR55SA = ECAR55SA / 0.5;
			}
			else if ([strBumpMode isEqualToString:@"Q" ]){
				ECAR55SA = ECAR55SA / 0.25;
			}
			else if ([strBumpMode isEqualToString:@"M" ]){
				ECAR55SA = ECAR55SA / 0.0833333;
			}
			else{
				ECAR55SA = ECAR55SA / 1.00;
			}
			
			if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
					if (PrevVUCash_FundAllo_Percen == 100) {
						PrevVUCashValue_EverCash55 = ECAR55SA;
					}
					else{
						PrevVUCashValue_EverCash55 = 0.00;
					}
				}
				else{
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = ECAR55SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2028Value_EverCash55 = ECAR55SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash55 = ECAR55SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash55 = ECAR55SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
					PrevVU2023Value_EverCash55 = ECAR55SA * (VU2023_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2025Value_EverCash55 = ECAR55SA * (PrevVU2025_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2028Value_EverCash55 = ECAR55SA * (PrevVU2028_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2030Value_EverCash55 = ECAR55SA * (PrevVU2030_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2035Value_EverCash55 = ECAR55SA * (PrevVU2035_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVURetValue_EverCash55 = ECAR55SA * (PrevVURet_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVUDanaValue_EverCash55 = ECAR55SA * (PrevVUDana_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					
				}
			}
			else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
					if (PrevVUCash_FundAllo_Percen == 100) {
						PrevVUCashValue_EverCash55 = ECAR55SA;
					}
					else{
						PrevVUCashValue_EverCash55 = 0.00;
					}
				}
				else{
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = ECAR55SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash55 = ECAR55SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash55 = ECAR55SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
					PrevVU2023Value_EverCash55 = 0.00;
					PrevVU2025Value_EverCash55 = ECAR55SA * (PrevVU2025_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2028Value_EverCash55 = ECAR55SA * (PrevVU2028_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2030Value_EverCash55 = ECAR55SA * (PrevVU2030_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2035Value_EverCash55 = ECAR55SA * (PrevVU2035_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVURetValue_EverCash55 = ECAR55SA * (PrevVURet_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVUDanaValue_EverCash55 = ECAR55SA * (PrevVUDana_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
				}
			}
			else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
					if (PrevVUCash_FundAllo_Percen == 100) {
						PrevVUCashValue_EverCash55 = ECAR55SA;
					}
					else{
						PrevVUCashValue_EverCash55 = 0.00;
					}
				}
				else{
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = ECAR55SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash55 = ECAR55SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
					PrevVU2023Value_EverCash55 = 0.00;
					PrevVU2025Value_EverCash55 = 0.00;
					PrevVU2028Value_EverCash55 = ECAR55SA * (PrevVU2028_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2030Value_EverCash55 = ECAR55SA * (PrevVU2030_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2035Value_EverCash55 = ECAR55SA * (PrevVU2035_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVURetValue_EverCash55 = ECAR55SA * (PrevVURet_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVUDanaValue_EverCash55 = ECAR55SA * (PrevVUDana_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
				}
			}
			else if (aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
					if (PrevVUCash_FundAllo_Percen == 100) {
						PrevVUCashValue_EverCash55 = ECAR55SA;
					}
					else{
						PrevVUCashValue_EverCash55 = 0.00;
					}
				}
				else{
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = ECAR55SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
					PrevVU2023Value_EverCash55 = 0.00;
					PrevVU2025Value_EverCash55 = 0.00;
					PrevVU2028Value_EverCash55 = 0.00;
					PrevVU2030Value_EverCash55 = ECAR55SA * (PrevVU2030_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2035Value_EverCash55 = ECAR55SA * (PrevVU2035_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVURetValue_EverCash55 = ECAR55SA * (PrevVURet_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVUDanaValue_EverCash55 = ECAR55SA * (PrevVUDana_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
				}
			}
			else if (aaPolicyYear == FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
					if (PrevVUCash_FundAllo_Percen == 100) {
						PrevVUCashValue_EverCash55 = ECAR55SA;
					}
					else{
						PrevVUCashValue_EverCash55 = 0.00;
					}
				}
				else{
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
					
					PrevVU2023Value_EverCash55 = 0.00;
					PrevVU2025Value_EverCash55 = 0.00;
					PrevVU2028Value_EverCash55 = 0.00;
					PrevVU2030Value_EverCash55 = 0.00;
					//PrevVU2035Value_EverCash55 = ECAR55SA * (PrevVU2035_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2035Value_EverCash55 = 0.00;
					PrevVURetValue_EverCash55 = ECAR55SA * (PrevVURet_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVUDanaValue_EverCash55 = ECAR55SA * (PrevVUDana_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
				}
			}
			else if (aaPolicyYear > FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
					if (PrevVUCash_FundAllo_Percen == 100) {
						PrevVUCashValue_EverCash55 = ECAR55SA;
					}
					else{
						PrevVUCashValue_EverCash55 = 0.00;
					}
						
					if (aaPolicyYear > FundTerm2035) {
						PrevVU2025Value_EverCash55 = 0.00;
						PrevVU2028Value_EverCash55 = 0.00;
						PrevVU2030Value_EverCash55 = 0.00;
						PrevVU2035Value_EverCash55 = 0.00;
						PrevVURetValue_EverCash55 = 0.00;
						PrevVUDanaValue_EverCash55 = 0.00;
					}
					
				}
				else{
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
					PrevVU2023Value_EverCash55 = 0.00;
					PrevVU2025Value_EverCash55 = 0.00;
					PrevVU2028Value_EverCash55 = 0.00;
					PrevVU2030Value_EverCash55 = 0.00;
					PrevVU2035Value_EverCash55 = ECAR55SA * (PrevVU2035_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVURetValue_EverCash55 = ECAR55SA * (PrevVURet_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVUDanaValue_EverCash55 = ECAR55SA * (PrevVUDana_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
				}
			}
			else{
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
					if (PrevVUCash_FundAllo_Percen == 100) {
						PrevVUCashValue_EverCash55 = ECAR55SA;
					}
					else{
						PrevVUCashValue_EverCash55 = 0.00;
					}
				}
				else{
					
					VU2023Value_EverCash55 = ECAR55SA * (VU2023_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2025Value_EverCash55 = ECAR55SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2028Value_EverCash55 = ECAR55SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash55 = ECAR55SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash55 = ECAR55SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
					PrevVU2023Value_EverCash55 = ECAR55SA * (VU2023_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2025Value_EverCash55 = ECAR55SA * (PrevVU2025_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2028Value_EverCash55 = ECAR55SA * (PrevVU2028_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2030Value_EverCash55 = ECAR55SA * (PrevVU2030_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVU2035Value_EverCash55 = ECAR55SA * (PrevVU2035_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVURetValue_EverCash55 = ECAR55SA * (PrevVURet_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
					PrevVUDanaValue_EverCash55 = ECAR55SA * (PrevVUDana_FundAllo_Percen / (100 - PrevVUCash_FundAllo_Percen));
				}
				
			}
			
		}
		else{
			VU2023Value_EverCash55 = 0.00;
			VU2025Value_EverCash55 = 0.00;
			VU2028Value_EverCash55 = 0.00;
			VU2030Value_EverCash55 = 0.00;
			VU2035Value_EverCash55 = 0.00;
			VURetValue_EverCash55 = 0.00;
			VUDanaValue_EverCash55 = 0.00;
			VUCashValue_EverCash55 = 0.00;
		}
	}
	
	
}

-(void)ReturnMonthEverCash55 :(int)aaPolicyYear  andMonth:(int)aaMonth {
	double ECAR55SA = [ECAR55SumAssured doubleValue ];
	
	if(ECAR55Exist == FALSE){
		VU2023Value_EverCash55 = 0.00;
		VU2025Value_EverCash55 = 0.00;
		VU2028Value_EverCash55 = 0.00;
		VU2030Value_EverCash55 = 0.00;
		VU2035Value_EverCash55 = 0.00;
		VURetValue_EverCash55 = 0.00;
		VUDanaValue_EverCash55 = 0.00;
		VUCashValue_EverCash55 = 0.00;
	}
	else{
		if (Age + aaPolicyYear >= 55 && aaPolicyYear <= [ECAR55RiderTerm intValue] && [ECAR55ReinvestGYI isEqualToString:@"Yes"] ) {
			VUCash_FundAllo_Percen = [self ReturnVUCashFac:aaPolicyYear andMonth:aaMonth] * 100;
			VU2025_FundAllo_Percen = [self ReturnVU2025Fac:aaPolicyYear andMonth:aaMonth] * 100;
			VU2028_FundAllo_Percen = [self ReturnVU2028Fac:aaPolicyYear andMonth:aaMonth] * 100;
			VU2030_FundAllo_Percen = [self ReturnVU2030Fac:aaPolicyYear andMonth:aaMonth] * 100;
			VU2035_FundAllo_Percen = [self ReturnVU2035Fac:aaPolicyYear andMonth:aaMonth] * 100;
			VURet_FundAllo_Percen = [self ReturnVURetFac:aaPolicyYear andMonth:aaMonth] * 100;
			VUDana_FundAllo_Percen = [self ReturnVUDanaFac:aaPolicyYear andMonth:aaMonth] * 100;
			
			if ([strBumpMode isEqualToString:@"S" ]) {
				ECAR55SA = ECAR55SA / 0.5;
			}
			else if ([strBumpMode isEqualToString:@"Q" ]){
				ECAR55SA = ECAR55SA / 0.25;
			}
			else if ([strBumpMode isEqualToString:@"M" ]){
				ECAR55SA = ECAR55SA / 0.0833333;
			}
			else{
				ECAR55SA = ECAR55SA / 1.00;
			}
			
			if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
				}
				else{
					VU2023Value_EverCash55 = ECAR55SA * (VU2023_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2025Value_EverCash55 = ECAR55SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2028Value_EverCash55 = ECAR55SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash55 = ECAR55SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash55 = ECAR55SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
				}
			}
			else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
				}
				else{
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = ECAR55SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2028Value_EverCash55 = ECAR55SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash55 = ECAR55SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash55 = ECAR55SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
				}
			}
			else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
				}
				else{
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = ECAR55SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash55 = ECAR55SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash55 = ECAR55SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
				}
			}
			else if (aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
				}
				else{
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = ECAR55SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash55 = ECAR55SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
				}
			}
			else if (aaPolicyYear == FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
				}
				else{
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
				}
			}
			else if (aaPolicyYear > FundTermPrev2035) {
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
				}
				else{
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = ECAR55SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
				}
			}
			else{
				if (VUCash_FundAllo_Percen == 100) {
					VU2023Value_EverCash55 = 0.00;
					VU2025Value_EverCash55 = 0.00;
					VU2028Value_EverCash55 = 0.00;
					VU2030Value_EverCash55 = 0.00;
					VU2035Value_EverCash55 = 0.00;
					VURetValue_EverCash55 = 0.00;
					VUDanaValue_EverCash55 = 0.00;
					VUCashValue_EverCash55 = ECAR55SA;
					
					
				}
				else{
					
					VU2023Value_EverCash55 = ECAR55SA * (VU2023_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2025Value_EverCash55 = ECAR55SA * (VU2025_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2028Value_EverCash55 = ECAR55SA * (VU2028_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2030Value_EverCash55 = ECAR55SA * (VU2030_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VU2035Value_EverCash55 = ECAR55SA * (VU2035_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VURetValue_EverCash55 = ECAR55SA * (VURet_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUDanaValue_EverCash55 = ECAR55SA * (VUDana_FundAllo_Percen / (100 - VUCash_FundAllo_Percen));
					VUCashValue_EverCash55 = 0.00;
					
				}
				
			}
			
		}
		else{
			VU2023Value_EverCash55 = 0.00;
			VU2025Value_EverCash55 = 0.00;
			VU2028Value_EverCash55 = 0.00;
			VU2030Value_EverCash55 = 0.00;
			VU2035Value_EverCash55 = 0.00;
			VURetValue_EverCash55 = 0.00;
			VUDanaValue_EverCash55 = 0.00;
			VUCashValue_EverCash55 = 0.00;
		}
	}
	
	
}




#pragma mark - Calculate Yearly Fund Value for Basic

-(double)ReturnFundValueOfTheYearValueTotalHigh: (int)aaPolicyYear{
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		return [self ReturnFundValueOfTheYearVU2023ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2025ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2028ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2030ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2035ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVURetValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVUDanaValueHigh:aaPolicyYear andYearOrMonth:@"M"];
	}
	else{
		return [self ReturnFundValueOfTheYearVU2023ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2025ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2028ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2030ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2035ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVURetValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVUDanaValueHigh:aaPolicyYear andYearOrMonth:@"Y"];
	}
	
	/*
	 return  0;
	 */
}



-(double)ReturnFundValueOfTheYearVU2023ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth {
	if (aaPolicyYear <= YearDiff2023) {
		double temp = [self ReturnVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2023ValueHigh_Basic = temp;
		}
		else{
			FundValueOfTheYearVU2023ValueHigh_Basic = temp;
		}
		return temp;
		//return [self ReturnVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2025ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2025) {
		double temp = [self ReturnVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2025ValueHigh_Basic = temp;
		}
		else{
			FundValueOfTheYearVU2025ValueHigh_Basic = temp;
		}
		return temp;
		//return [self ReturnVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}


-(double)ReturnFundValueOfTheYearVU2028ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2028) {
		double temp = [self ReturnVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2028ValueHigh_Basic = temp;
		}
		else{
			FundValueOfTheYearVU2028ValueHigh_Basic = temp;
		}
		return temp;
		//return [self ReturnVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2030ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2030) {
		double temp = [self ReturnVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];;
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2030ValueHigh_Basic = temp;
		}
		else{
			FundValueOfTheYearVU2030ValueHigh_Basic = temp;
		}
		return temp;
		
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2035ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2035) {
		double temp = [self ReturnVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2035ValueHigh_Basic = temp;
		}
		else{
			FundValueOfTheYearVU2035ValueHigh_Basic = temp;
		}
		return temp;
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVURetValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	double temp = [self ReturnVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		MonthFundValueOfTheYearVURetValueHigh_Basic = temp;
	}
	else
	{
		FundValueOfTheYearVURetValueHigh_Basic = temp;
	}
	
	
	return temp;
}

-(double)ReturnFundValueOfTheYearVUDanaValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	double temp = [self ReturnVUDanaValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		MonthFundValueOfTheYearVUDanaValueHigh_Basic = temp;
	}
	else
	{
		FundValueOfTheYearVUDanaValueHigh_Basic = temp;
	}
	return temp;
}

-(double)ReturnMonthFundValueOfTheYearValueTotalHigh: (int)aaPolicyYear andMonth:(int)aaMonth{
	
	[self ReturnMonthFundValueOfTheYearVURetValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnMonthFundValueOfTheYearVUDanaValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnMonthFundValueOfTheYearVU2023ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnMonthFundValueOfTheYearVU2025ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnMonthFundValueOfTheYearVU2028ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnMonthFundValueOfTheYearVU2030ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnMonthFundValueOfTheYearVU2035ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	
	
	return MonthVU2023ValueHigh + MonthVU2025ValueHigh + MonthVU2028ValueHigh + MonthVU2030ValueHigh + MonthVU2035ValueHigh + MonthVURetValueHigh + MonthVUDanaValueHigh;
	//return  0;
	
}

-(double)ReturnMonthFundValueOfTheYearVU2023ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	
	if (aaPolicyYear <= YearDiff2023) {
		MonthVU2023ValueHigh = [self ReturnVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2023ValueHigh_Basic = MonthVU2023ValueHigh;
		return MonthVU2023ValueHigh;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2025ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	
	if (aaPolicyYear <= YearDiff2025) {
		MonthVU2025ValueHigh = [self ReturnVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2025ValueHigh_Basic = MonthVU2025ValueHigh;
		return MonthVU2025ValueHigh;
	} else {
		return 0;
	}
}


-(double)ReturnMonthFundValueOfTheYearVU2028ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2028) {
		MonthVU2028ValueHigh = [self ReturnVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2028ValueHigh_Basic = MonthVU2028ValueHigh;
		return MonthVU2028ValueHigh;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2030ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2030) {
		MonthVU2030ValueHigh = [self ReturnVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2030ValueHigh_Basic = MonthVU2030ValueHigh;
		return MonthVU2030ValueHigh;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2035ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2035) {
		MonthVU2035ValueHigh = [self ReturnVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2035ValueHigh_Basic = MonthVU2035ValueHigh;
		return MonthVU2035ValueHigh;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVURetValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{

	MonthVURetValueHigh = [self ReturnVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	MonthFundValueOfTheYearVURetValueHigh_Basic = MonthVURetValueHigh;
	return MonthVURetValueHigh;
}

-(double)ReturnMonthFundValueOfTheYearVUDanaValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	MonthVUDanaValueHigh = [self ReturnVUDanaValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	MonthFundValueOfTheYearVUDanaValueHigh_Basic = MonthVUDanaValueHigh;
	return MonthVUDanaValueHigh;
}


-(double)ReturnFundValueOfTheYearValueTotalMedian: (int)aaPolicyYear{
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		
		return [self ReturnFundValueOfTheYearVU2023ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2025ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2028ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2030ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2035ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVURetValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVUDanaValueMedian:aaPolicyYear andYearOrMonth:@"M"];
	}
	else{
		return [self ReturnFundValueOfTheYearVU2023ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2025ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2028ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2030ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2035ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVURetValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVUDanaValueMedian:aaPolicyYear andYearOrMonth:@"Y"];
	}
	/*
	 return  0;
	 */
}


-(double)ReturnFundValueOfTheYearVU2023ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2023) {
		double temp = [self ReturnVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2023ValueMedian_Basic = temp;
		}
		else
		{
			FundValueOfTheYearVU2023ValueMedian_Basic = temp;
		}
		
		return temp;
		//return [self ReturnVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2025ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2025) {
		double temp = [self ReturnVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2025ValueMedian_Basic = temp;
		}
		else
		{
			FundValueOfTheYearVU2025ValueMedian_Basic = temp;
		}
		
		return temp;
		//return [self ReturnVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}


-(double)ReturnFundValueOfTheYearVU2028ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2028) {
		double temp = [self ReturnVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2028ValueMedian_Basic = temp;
		}
		else
		{
			FundValueOfTheYearVU2028ValueMedian_Basic = temp;
		}
		
		return temp;
		//return [self ReturnVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2030ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth {
	if (aaPolicyYear <= YearDiff2030) {
		double temp = [self ReturnVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2030ValueMedian_Basic = temp;
		}
		else
		{
			FundValueOfTheYearVU2030ValueMedian_Basic = temp;
		}
		
		return temp;
		//return [self ReturnVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2035ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2035) {
		double temp = [self ReturnVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2035ValueMedian_Basic = temp;
		}
		else
		{
			FundValueOfTheYearVU2035ValueMedian_Basic = temp;
		}
		
		return temp;
		//return [self ReturnVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVURetValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	
	double temp = [self ReturnVURetValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		MonthFundValueOfTheYearVURetValueMedian_Basic = temp;
	}
	else
	{
		FundValueOfTheYearVURetValueMedian_Basic = temp;
	}
	
	return temp;
}

-(double)ReturnFundValueOfTheYearVUDanaValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	double temp = [self ReturnVUDanaValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		MonthFundValueOfTheYearVUDanaValueMedian_Basic = temp;
	}
	else
	{
		FundValueOfTheYearVUDanaValueMedian_Basic = temp;
	}
	
	return temp;
	
	//return [self ReturnVUDanaValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
}

-(double)ReturnMonthFundValueOfTheYearValueTotalMedian: (int)aaPolicyYear andMonth:(int)aaMonth{
	
	return [self ReturnMonthFundValueOfTheYearVU2023ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	[self ReturnMonthFundValueOfTheYearVU2025ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	[self ReturnMonthFundValueOfTheYearVU2028ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	[self ReturnMonthFundValueOfTheYearVU2030ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	[self ReturnMonthFundValueOfTheYearVU2035ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	[self ReturnMonthFundValueOfTheYearVURetValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	[self ReturnMonthFundValueOfTheYearVUDanaValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth];
	
	
	
}


-(double)ReturnMonthFundValueOfTheYearVU2023ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2023) {
		MonthVU2023ValueMedian = [self ReturnVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2023ValueMedian_Basic = MonthVU2023ValueMedian;
		return MonthVU2023ValueMedian;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2025ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2025) {
		MonthVU2025ValueMedian = [self ReturnVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2025ValueMedian_Basic = MonthVU2025ValueMedian;
		return 	MonthVU2025ValueMedian;
	} else {
		return 0;
	}
}


-(double)ReturnMonthFundValueOfTheYearVU2028ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2028) {
		MonthVU2028ValueMedian = [self ReturnVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2028ValueMedian_Basic = MonthVU2028ValueMedian;
		return 	MonthVU2028ValueMedian;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2030ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2030) {
		MonthVU2030ValueMedian = [self ReturnVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2030ValueMedian_Basic = MonthVU2030ValueMedian;
		return 	MonthVU2030ValueMedian;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2035ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2035) {
		MonthVU2035ValueMedian = [self ReturnVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2035ValueMedian_Basic = MonthVU2035ValueMedian;
		return 	MonthVU2035ValueMedian;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVURetValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	MonthVURetValueMedian = [self ReturnVURetValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	MonthFundValueOfTheYearVURetValueMedian_Basic = MonthVURetValueMedian;
	return 	MonthVURetValueMedian;
}

-(double)ReturnMonthFundValueOfTheYearVUDanaValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	MonthVUDanaValueMedian = [self ReturnVUDanaValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	MonthFundValueOfTheYearVUDanaValueMedian_Basic = MonthVUDanaValueMedian;
	return 	MonthVUDanaValueMedian;
}

-(double)ReturnFundValueOfTheYearValueTotalLow: (int)aaPolicyYear{
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		return [self ReturnFundValueOfTheYearVU2023ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2025ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2028ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2030ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2035ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVURetValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVUDanaValueLow:aaPolicyYear andYearOrMonth:@"M"];
	}
	else{
		return [self ReturnFundValueOfTheYearVU2023ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2025ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2028ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2030ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2035ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVURetValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVUDanaValueLow:aaPolicyYear andYearOrMonth:@"Y"];
	}
	
	
	/*
	 return  0;
	 */
}


-(double)ReturnFundValueOfTheYearVU2023ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2023) {
		double temp = [self ReturnVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2023ValueLow_Basic = temp;
		}
		else
		{
			FundValueOfTheYearVU2023ValueLow_Basic = temp;
		}
		
		return temp;
		//return [self ReturnVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2025ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2025) {
		double temp = [self ReturnVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2025ValueLow_Basic = temp;
		}
		else
		{
			FundValueOfTheYearVU2025ValueLow_Basic = temp;
		}
		
		return temp;
		//return [self ReturnVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}


-(double)ReturnFundValueOfTheYearVU2028ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2028) {
		double temp = [self ReturnVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2028ValueLow_Basic = temp;
		}
		else
		{
			FundValueOfTheYearVU2028ValueLow_Basic = temp;
		}
		
		return temp;
		//return [self ReturnVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2030ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2030) {
		double temp = [self ReturnVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2030ValueLow_Basic = temp;
		}
		else
		{
			FundValueOfTheYearVU2030ValueLow_Basic = temp;
		}
		
		return temp;
		//return [self ReturnVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2035ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2035) {
		double temp = [self ReturnVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			MonthFundValueOfTheYearVU2035ValueLow_Basic = temp;
		}
		else
		{
			FundValueOfTheYearVU2035ValueLow_Basic = temp;
		}
		
		return temp;
		//return [self ReturnVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVURetValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	//return [self ReturnVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	double temp = [self ReturnVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		MonthFundValueOfTheYearVURetValueLow_Basic = temp;
	}
	else
	{
		FundValueOfTheYearVURetValueLow_Basic = temp;
	}
	
	return temp;
}

-(double)ReturnFundValueOfTheYearVUDanaValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	double temp = [self ReturnVUDanaValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		MonthFundValueOfTheYearVUDanaValueLow_Basic = temp;
	}
	else
	{
		FundValueOfTheYearVUDanaValueLow_Basic = temp;
	}
	
	return temp;
	//return [self ReturnVUDanaValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
}

-(double)ReturnMonthFundValueOfTheYearValueTotalLow: (int)aaPolicyYear andMonth:(int)aaMonth{
	
	return [self ReturnMonthFundValueOfTheYearVU2023ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	[self ReturnMonthFundValueOfTheYearVU2025ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	[self ReturnMonthFundValueOfTheYearVU2028ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	[self ReturnMonthFundValueOfTheYearVU2030ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	[self ReturnMonthFundValueOfTheYearVU2035ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	[self ReturnMonthFundValueOfTheYearVURetValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	[self ReturnMonthFundValueOfTheYearVUDanaValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	
	
}

-(double)ReturnMonthFundValueOfTheYearVU2023ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2023) {
		MonthVU2023ValueLow = [self ReturnVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2023ValueLow_Basic = MonthVU2023ValueLow;
		return MonthVU2023ValueLow;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2025ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2025) {
		MonthVU2025ValueLow = [self ReturnVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2025ValueLow_Basic = MonthVU2025ValueLow;
		return MonthVU2025ValueLow;
	} else {
		return 0;
	}
}


-(double)ReturnMonthFundValueOfTheYearVU2028ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2028) {
		MonthVU2028ValueLow = [self ReturnVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2028ValueLow_Basic = MonthVU2028ValueLow;
		return MonthVU2028ValueLow;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2030ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2030) {
		MonthVU2030ValueLow = [self ReturnVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2030ValueLow_Basic = MonthVU2030ValueLow;
		return MonthVU2030ValueLow;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2035ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2035) {
		MonthVU2035ValueLow = [self ReturnVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		MonthFundValueOfTheYearVU2035ValueLow_Basic = MonthVU2035ValueLow;
		return MonthVU2035ValueLow;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVURetValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	
	MonthVURetValueLow = [self ReturnVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	MonthFundValueOfTheYearVURetValueLow_Basic = MonthVURetValueLow;
	return MonthVURetValueLow;
}

-(double)ReturnMonthFundValueOfTheYearVUDanaValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	MonthVUDanaValueLow = [self ReturnVUDanaValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	MonthFundValueOfTheYearVUDanaValueLow_Basic = MonthVUDanaValueLow;
	return MonthVUDanaValueLow;
}

#pragma mark - Calculate Yearly Fund Value for Rider

-(double)ReturnRiderFundValueOfTheYearValueTotalHigh: (int)aaPolicyYear{
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		return [self ReturnRiderFundValueOfTheYearVU2023ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVU2025ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVU2028ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVU2030ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVU2035ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVURetValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVUDanaValueHigh:aaPolicyYear andYearOrMonth:@"M"];
	}
	else{
		return [self ReturnRiderFundValueOfTheYearVU2023ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVU2025ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVU2028ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVU2030ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVU2035ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVURetValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVUDanaValueHigh:aaPolicyYear andYearOrMonth:@"Y"];
	}
	
	/*
	 return  0;
	 */
}



-(double)ReturnRiderFundValueOfTheYearVU2023ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth {
	if (aaPolicyYear <= YearDiff2023) {
		return [self ReturnRiderVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnRiderFundValueOfTheYearVU2025ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2025) {
		return [self ReturnRiderVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}


-(double)ReturnRiderFundValueOfTheYearVU2028ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2028) {
		return [self ReturnRiderVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnRiderFundValueOfTheYearVU2030ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2030) {
		return [self ReturnRiderVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnRiderFundValueOfTheYearVU2035ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2035) {
		return [self ReturnRiderVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnRiderFundValueOfTheYearVURetValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	return [self ReturnRiderVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
}

-(double)ReturnRiderFundValueOfTheYearVUDanaValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	return [self ReturnRiderVUDanaValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
}


-(double)ReturnRiderMonthFundValueOfTheYearValueTotalHigh: (int)aaPolicyYear andMonth:(int)aaMonth{
	
	[self ReturnRiderMonthFundValueOfTheYearVURetValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnRiderMonthFundValueOfTheYearVUDanaValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnRiderMonthFundValueOfTheYearVU2023ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnRiderMonthFundValueOfTheYearVU2025ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnRiderMonthFundValueOfTheYearVU2028ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnRiderMonthFundValueOfTheYearVU2030ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnRiderMonthFundValueOfTheYearVU2035ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	
	
	return RiderMonthVU2023ValueHigh + RiderMonthVU2025ValueHigh + RiderMonthVU2028ValueHigh + RiderMonthVU2030ValueHigh + RiderMonthVU2035ValueHigh + RiderMonthVURetValueHigh + RiderMonthVUDanaValueHigh;
	//return  0;
	
}

-(double)ReturnRiderMonthFundValueOfTheYearVU2023ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	
	if (aaPolicyYear <= YearDiff2023) {
		RiderMonthVU2023ValueHigh = [self ReturnRiderVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return RiderMonthVU2023ValueHigh;
	} else {
		return 0;
	}
}

-(double)ReturnRiderMonthFundValueOfTheYearVU2025ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	
	if (aaPolicyYear <= YearDiff2025) {
		RiderMonthVU2025ValueHigh = [self ReturnRiderVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return RiderMonthVU2025ValueHigh;
	} else {
		return 0;
	}
}


-(double)ReturnRiderMonthFundValueOfTheYearVU2028ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2028) {
		RiderMonthVU2028ValueHigh = [self ReturnRiderVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return RiderMonthVU2028ValueHigh;
	} else {
		return 0;
	}
}

-(double)ReturnRiderMonthFundValueOfTheYearVU2030ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2030) {
		RiderMonthVU2030ValueHigh = [self ReturnRiderVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return RiderMonthVU2030ValueHigh;
	} else {
		return 0;
	}
}

-(double)ReturnRiderMonthFundValueOfTheYearVU2035ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2035) {
		RiderMonthVU2035ValueHigh = [self ReturnRiderVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return RiderMonthVU2035ValueHigh;
	} else {
		return 0;
	}
}

-(double)ReturnRiderMonthFundValueOfTheYearVURetValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	RiderMonthVURetValueHigh = [self ReturnRiderVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	return RiderMonthVURetValueHigh;
}

-(double)ReturnRiderMonthFundValueOfTheYearVUDanaValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	RiderMonthVUDanaValueHigh = [self ReturnRiderVUDanaValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	return RiderMonthVUDanaValueHigh;
}

-(double)ReturnRiderFundValueOfTheYearValueTotalMedian: (int)aaPolicyYear{
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		
		return [self ReturnRiderFundValueOfTheYearVU2023ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVU2025ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVU2028ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVU2030ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVU2035ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVURetValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVUDanaValueMedian:aaPolicyYear andYearOrMonth:@"M"];
	}
	else{
		return [self ReturnRiderFundValueOfTheYearVU2023ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVU2025ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVU2028ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVU2030ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVU2035ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVURetValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVUDanaValueMedian:aaPolicyYear andYearOrMonth:@"Y"];
	}
	/*
	 return  0;
	 */
}


-(double)ReturnRiderFundValueOfTheYearVU2023ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2023) {
		return [self ReturnRiderVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
		
	} else {
		return 0;
	}
}

-(double)ReturnRiderFundValueOfTheYearVU2025ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2025) {
		return [self ReturnRiderVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}


-(double)ReturnRiderFundValueOfTheYearVU2028ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2028) {
		return [self ReturnRiderVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnRiderFundValueOfTheYearVU2030ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth {
	if (aaPolicyYear <= YearDiff2030) {
		return [self ReturnRiderVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnRiderFundValueOfTheYearVU2035ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2035) {
		return [self ReturnRiderVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnRiderFundValueOfTheYearVURetValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	//return VURetValueMedian;
	return [self ReturnRiderVURetValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
}

-(double)ReturnRiderFundValueOfTheYearVUDanaValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	return [self ReturnRiderVUDanaValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
}

-(double)ReturnRiderMonthFundValueOfTheYearValueTotalMedian: (int)aaPolicyYear andMonth:(int)aaMonth{
	
	return
	[self ReturnRiderMonthFundValueOfTheYearVU2023ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	[self ReturnRiderMonthFundValueOfTheYearVU2025ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	[self ReturnRiderMonthFundValueOfTheYearVU2028ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	[self ReturnRiderMonthFundValueOfTheYearVU2030ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	[self ReturnRiderMonthFundValueOfTheYearVU2035ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	[self ReturnRiderMonthFundValueOfTheYearVURetValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	[self ReturnRiderMonthFundValueOfTheYearVUDanaValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth];
	
	
	
}


-(double)ReturnRiderMonthFundValueOfTheYearVU2023ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2023) {
		RiderMonthVU2023ValueMedian = [self ReturnRiderVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return RiderMonthVU2023ValueMedian;
	} else {
		return 0;
	}
}

-(double)ReturnRiderMonthFundValueOfTheYearVU2025ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2025) {
		RiderMonthVU2025ValueMedian = [self ReturnRiderVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return 	RiderMonthVU2025ValueMedian;
	} else {
		return 0;
	}
}


-(double)ReturnRiderMonthFundValueOfTheYearVU2028ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2028) {
		RiderMonthVU2028ValueMedian = [self ReturnRiderVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return 	RiderMonthVU2028ValueMedian;
	} else {
		return 0;
	}
}

-(double)ReturnRiderMonthFundValueOfTheYearVU2030ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2030) {
		RiderMonthVU2030ValueMedian = [self ReturnRiderVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return 	RiderMonthVU2030ValueMedian;
	} else {
		return 0;
	}
}

-(double)ReturnRiderMonthFundValueOfTheYearVU2035ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2035) {
		RiderMonthVU2035ValueMedian = [self ReturnRiderVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return 	RiderMonthVU2035ValueMedian;
	} else {
		return 0;
	}
}

-(double)ReturnRiderMonthFundValueOfTheYearVURetValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	RiderMonthVURetValueMedian = [self ReturnRiderVURetValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	return 	RiderMonthVURetValueMedian;
}

-(double)ReturnRiderMonthFundValueOfTheYearVUDanaValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	RiderMonthVUDanaValueMedian = [self ReturnRiderVUDanaValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	return 	RiderMonthVUDanaValueMedian;
}

-(double)ReturnRiderFundValueOfTheYearValueTotalLow: (int)aaPolicyYear{
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		return [self ReturnRiderFundValueOfTheYearVU2023ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVU2025ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVU2028ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVU2030ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVU2035ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVURetValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnRiderFundValueOfTheYearVUDanaValueLow:aaPolicyYear andYearOrMonth:@"M"];
	}
	else{
		return [self ReturnRiderFundValueOfTheYearVU2023ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVU2025ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVU2028ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVU2030ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVU2035ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVURetValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnRiderFundValueOfTheYearVUDanaValueLow:aaPolicyYear andYearOrMonth:@"Y"];
	}
	
	
	/*
	 return  0;
	 */
}


-(double)ReturnRiderFundValueOfTheYearVU2023ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2023) {
		return [self ReturnRiderVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnRiderFundValueOfTheYearVU2025ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2025) {
		return [self ReturnRiderVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}


-(double)ReturnRiderFundValueOfTheYearVU2028ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2028) {
		return [self ReturnRiderVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnRiderFundValueOfTheYearVU2030ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2030) {
		return [self ReturnRiderVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnRiderFundValueOfTheYearVU2035ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2035) {
		return [self ReturnRiderVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnRiderFundValueOfTheYearVURetValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	return [self ReturnRiderVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
}

-(double)ReturnRiderFundValueOfTheYearVUDanaValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	return [self ReturnRiderVUDanaValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
}

-(double)ReturnRiderMonthFundValueOfTheYearValueTotalLow: (int)aaPolicyYear andMonth:(int)aaMonth{
	
	return [self ReturnRiderMonthFundValueOfTheYearVU2023ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	[self ReturnRiderMonthFundValueOfTheYearVU2025ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	[self ReturnRiderMonthFundValueOfTheYearVU2028ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	[self ReturnRiderMonthFundValueOfTheYearVU2030ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	[self ReturnRiderMonthFundValueOfTheYearVU2035ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	[self ReturnRiderMonthFundValueOfTheYearVURetValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	[self ReturnRiderMonthFundValueOfTheYearVUDanaValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	
	
}

-(double)ReturnRiderMonthFundValueOfTheYearVU2023ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2023) {
		RiderMonthVU2023ValueLow = [self ReturnRiderVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return RiderMonthVU2023ValueLow;
	} else {
		return 0;
	}
}

-(double)ReturnRiderMonthFundValueOfTheYearVU2025ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2025) {
		RiderMonthVU2025ValueLow = [self ReturnRiderVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return RiderMonthVU2025ValueLow;
	} else {
		return 0;
	}
}


-(double)ReturnRiderMonthFundValueOfTheYearVU2028ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2028) {
		RiderMonthVU2028ValueLow = [self ReturnRiderVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return RiderMonthVU2028ValueLow;
	} else {
		return 0;
	}
}

-(double)ReturnRiderMonthFundValueOfTheYearVU2030ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2030) {
		RiderMonthVU2030ValueLow = [self ReturnRiderVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return RiderMonthVU2030ValueLow;
	} else {
		return 0;
	}
}

-(double)ReturnRiderMonthFundValueOfTheYearVU2035ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2035) {
		RiderMonthVU2035ValueLow = [self ReturnRiderVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return RiderMonthVU2035ValueLow;
	} else {
		return 0;
	}
}

-(double)ReturnRiderMonthFundValueOfTheYearVURetValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	RiderMonthVURetValueLow = [self ReturnRiderVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	return RiderMonthVURetValueLow;
}

-(double)ReturnRiderMonthFundValueOfTheYearVUDanaValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	RiderMonthVUDanaValueLow = [self ReturnRiderVUDanaValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	return RiderMonthVUDanaValueLow;
}

#pragma mark - RPUO Fund Balance Calculation

-(double)PaidUpOptionTable_2023_High :(double)aaValue andPolicyYear :(int)aaPolicyYear {
	double temp = 0.00;
	
	if (ECAR55Exist == TRUE) {
		
	}
	else{
		temp = aaValue * ((1 + [self ReturnVU2023InstHigh:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear])) + VU2023Value_EverCash55;
	}
	
	return temp + VU2023Value_EverCash1 + VU2023Value_EverCash6;
}

-(double)PaidUpOptionTable_2023_Median:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	double temp = 0.00;
	
	if (ECAR55Exist == TRUE) {
		
	}
	else{
		temp = aaValue * ((1 + [self ReturnVU2023InstMedian:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear])) + VU2023Value_EverCash55;
	}
	
	return temp + VU2023Value_EverCash1 + VU2023Value_EverCash6;
}

-(double)PaidUpOptionTable_2023_Low:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	double temp = 0.00;
	
	if (ECAR55Exist == TRUE) {
		
	}
	else{
		temp = aaValue * ((1 + [self ReturnVU2023InstLow:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear])) + VU2023Value_EverCash55;
	}
	
	return temp + VU2023Value_EverCash1 + VU2023Value_EverCash6;
}

-(double)PaidUpOptionTable_2025_High:(double)aaValue andPolicyYear :(int)aaPolicyYear {

	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVU2025InstHigh:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VU2025Value_EverCash55;

	
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2023 = 0.00;
		double BackTerm_2023 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023to2025_H * pow((1 + [self ReturnVU2025InstHigh:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;

		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVU2025InstHigh:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2025InstHigh:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2025InstHigh:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVU2025InstHigh:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = Value2 * GMIFactor_BackTermH2023 + PrevVU2025Value_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVU2025InstHigh:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{

			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVU2025InstHigh:@"M"])/(pow((1 + [self ReturnVU2025InstHigh:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VU2025Value_EverCash1 + VU2025Value_EverCash6;
	
}

-(double)PaidUpOptionTable_2025_Median:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVU2025InstMedian:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VU2025Value_EverCash55;
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2023 = 0.00;
		double BackTerm_2023 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023to2025_M * pow((1 + [self ReturnVU2025InstMedian:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVU2025InstMedian:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2025InstMedian:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2025InstMedian:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVU2025InstMedian:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = Value2 * GMIFactor_BackTermH2023 + PrevVU2025Value_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVU2025InstMedian:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVU2025InstMedian:@"M"])/(pow((1 + [self ReturnVU2025InstMedian:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VU2025Value_EverCash1 + VU2025Value_EverCash6;
	
}

-(double)PaidUpOptionTable_2025_Low:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVU2025InstLow:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VU2025Value_EverCash55;
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2023 = 0.00;
		double BackTerm_2023 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023to2025_L * pow((1 + [self ReturnVU2025InstLow:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVU2025InstLow:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2025InstLow:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2025InstLow:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVU2025InstLow:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = Value2 * GMIFactor_BackTermH2023 + PrevVU2025Value_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVU2025InstLow:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVU2025InstLow:@"M"])/(pow((1 + [self ReturnVU2025InstLow:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VU2025Value_EverCash1 + VU2025Value_EverCash6;
	
}

-(double)PaidUpOptionTable_2028_High:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVU2028InstHigh:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VU2028Value_EverCash55;
	
	
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2023 = 0.00;
		double BackTerm_2023 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023to2028_H * pow((1 + [self ReturnVU2028InstHigh:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVU2028InstHigh:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2028InstHigh:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2028InstHigh:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVU2028InstHigh:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2028Value_EverCash55 * GMIFactor_BackTermH2023 + PrevVU2028Value_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVU2028InstHigh:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2025 = 0.00;
		double BackTerm_2025 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025to2028_H * pow((1 + [self ReturnVU2028InstHigh:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVU2028InstHigh:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2028InstHigh:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVU2028InstHigh:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVU2028InstHigh:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2028Value_EverCash55 * GMIFactor_BackTermH2025 + PrevVU2028Value_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVU2028InstHigh:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVU2028InstHigh:@"M"])/(pow((1 + [self ReturnVU2028InstHigh:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VU2028Value_EverCash1 + VU2028Value_EverCash6;
	
}

-(double)PaidUpOptionTable_2028_Median:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVU2028InstMedian:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VU2028Value_EverCash55;
	
	
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2023 = 0.00;
		double BackTerm_2023 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023to2028_M * pow((1 + [self ReturnVU2028InstMedian:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVU2028InstMedian:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2028InstMedian:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2028InstMedian:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVU2028InstMedian:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2028Value_EverCash55 * GMIFactor_BackTermH2023 + PrevVU2028Value_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVU2028InstMedian:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2025 = 0.00;
		double BackTerm_2025 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025to2028_M * pow((1 + [self ReturnVU2028InstMedian:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVU2028InstMedian:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2028InstMedian:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVU2028InstMedian:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVU2028InstMedian:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2028Value_EverCash55 * GMIFactor_BackTermH2025 + PrevVU2028Value_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVU2028InstMedian:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVU2028InstMedian:@"M"])/(pow((1 + [self ReturnVU2028InstMedian:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VU2028Value_EverCash1 + VU2028Value_EverCash6;
	
}

-(double)PaidUpOptionTable_2028_Low:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVU2028InstLow:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VU2028Value_EverCash55;
	
	
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2023 = 0.00;
		double BackTerm_2023 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023to2028_L * pow((1 + [self ReturnVU2028InstLow:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVU2028InstLow:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2028InstLow:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2028InstLow:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVU2028InstLow:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2028Value_EverCash55 * GMIFactor_BackTermH2023 + PrevVU2028Value_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVU2028InstLow:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2025 = 0.00;
		double BackTerm_2025 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025to2028_L * pow((1 + [self ReturnVU2028InstLow:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVU2028InstLow:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2028InstLow:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVU2028InstLow:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVU2028InstLow:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2028Value_EverCash55 * GMIFactor_BackTermH2025 + PrevVU2028Value_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVU2028InstLow:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVU2028InstLow:@"M"])/(pow((1 + [self ReturnVU2028InstLow:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VU2025Value_EverCash1 + VU2025Value_EverCash6;
	
}

-(double)PaidUpOptionTable_2030_High:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVU2030InstHigh:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VU2030Value_EverCash55;
	
	
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2023 = 0.00;
		double BackTerm_2023 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023to2030_H * pow((1 + [self ReturnVU2030InstHigh:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVU2030InstHigh:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2030InstHigh:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2030InstHigh:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVU2030InstHigh:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2030Value_EverCash55 * GMIFactor_BackTermH2023 + PrevVU2030Value_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVU2030InstHigh:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2025 = 0.00;
		double BackTerm_2025 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025to2030_H * pow((1 + [self ReturnVU2030InstHigh:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVU2030InstHigh:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2030InstHigh:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVU2030InstHigh:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVU2030InstHigh:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2030Value_EverCash55 * GMIFactor_BackTermH2025 + PrevVU2030Value_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVU2030InstHigh:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2028 = 0.00;
		double BackTerm_2028 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028to2030_H * pow((1 + [self ReturnVU2030InstHigh:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVU2030InstHigh:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2030InstHigh:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVU2030InstHigh:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVU2030InstHigh:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2030Value_EverCash55 * GMIFactor_BackTermH2028 + PrevVU2030Value_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVU2030InstHigh:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVU2030InstHigh:@"M"])/(pow((1 + [self ReturnVU2030InstHigh:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VU2030Value_EverCash1 + VU2030Value_EverCash6;
	
}

-(double)PaidUpOptionTable_2030_Median:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVU2030InstMedian:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VU2030Value_EverCash55;
	
	
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2023 = 0.00;
		double BackTerm_2023 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023to2030_M * pow((1 + [self ReturnVU2030InstMedian:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVU2030InstMedian:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2030InstMedian:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2030InstMedian:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVU2030InstMedian:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2030Value_EverCash55 * GMIFactor_BackTermH2023 + PrevVU2030Value_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVU2030InstMedian:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2025 = 0.00;
		double BackTerm_2025 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025to2030_M * pow((1 + [self ReturnVU2030InstMedian:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVU2030InstMedian:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2030InstMedian:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVU2030InstMedian:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVU2030InstMedian:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2030Value_EverCash55 * GMIFactor_BackTermH2025 + PrevVU2030Value_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVU2030InstMedian:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2028 = 0.00;
		double BackTerm_2028 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028to2030_M * pow((1 + [self ReturnVU2030InstMedian:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVU2030InstMedian:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2030InstMedian:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVU2030InstMedian:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVU2030InstMedian:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2030Value_EverCash55 * GMIFactor_BackTermH2028 + PrevVU2030Value_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVU2030InstMedian:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVU2030InstMedian:@"M"])/(pow((1 + [self ReturnVU2030InstMedian:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VU2030Value_EverCash1 + VU2030Value_EverCash6;
	
}

-(double)PaidUpOptionTable_2030_Low:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVU2030InstLow:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VU2030Value_EverCash55;
	
	
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2023 = 0.00;
		double BackTerm_2023 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023to2030_L * pow((1 + [self ReturnVU2030InstLow:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVU2030InstLow:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2030InstLow:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2030InstLow:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVU2030InstLow:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2030Value_EverCash55 * GMIFactor_BackTermH2023 + PrevVU2030Value_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVU2030InstLow:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2025 = 0.00;
		double BackTerm_2025 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025to2030_L * pow((1 + [self ReturnVU2030InstLow:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVU2030InstLow:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2030InstLow:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVU2030InstLow:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVU2030InstLow:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2030Value_EverCash55 * GMIFactor_BackTermH2025 + PrevVU2030Value_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVU2030InstLow:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2028 = 0.00;
		double BackTerm_2028 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028to2030_L * pow((1 + [self ReturnVU2030InstLow:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVU2030InstLow:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2030InstLow:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVU2030InstLow:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVU2030InstLow:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2030Value_EverCash55 * GMIFactor_BackTermH2028 + PrevVU2030Value_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVU2030InstLow:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVU2030InstLow:@"M"])/(pow((1 + [self ReturnVU2030InstLow:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VU2030Value_EverCash1 + VU2030Value_EverCash6;
	
}

-(double)PaidUpOptionTable_2035_High:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVU2035InstHigh:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VU2035Value_EverCash55;
	
	
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2023 = 0.00;
		double BackTerm_2023 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023to2035_H * pow((1 + [self ReturnVU2035InstHigh:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVU2035InstHigh:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2035InstHigh:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2035InstHigh:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVU2035InstHigh:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2035Value_EverCash55 * GMIFactor_BackTermH2023 + PrevVU2035Value_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVU2035InstHigh:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2025 = 0.00;
		double BackTerm_2025 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025to2035_H * pow((1 + [self ReturnVU2035InstHigh:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVU2035InstHigh:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2035InstHigh:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVU2035InstHigh:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVU2035InstHigh:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2035Value_EverCash55 * GMIFactor_BackTermH2025 + PrevVU2035Value_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVU2035InstHigh:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2028 = 0.00;
		double BackTerm_2028 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028to2035_H * pow((1 + [self ReturnVU2035InstHigh:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVU2035InstHigh:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2035InstHigh:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVU2035InstHigh:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVU2035InstHigh:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2035Value_EverCash55 * GMIFactor_BackTermH2028 + PrevVU2035Value_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVU2035InstHigh:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2030) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2030"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2030 = 0.00;
		double BackTerm_2030 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2030 = 12 - [self roundUp:((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12) ];
		Value3 = ReinvestAmount2030to2035_H * pow((1 + [self ReturnVU2035InstHigh:@"A"]), BackTerm_2030/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2030 = (pow((1 + [self ReturnVU2035InstHigh:@"A"]), (BackTerm_2030 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2035InstHigh:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVU2035InstHigh:@"A"]), ((12 - BackTerm_2030) / 12.00))   - 1) / (pow(1 + [self ReturnVU2035InstHigh:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2035Value_EverCash55 * GMIFactor_BackTermH2030 + PrevVU2035Value_EverCash55 * GMIFactor_FrontTermH2030 * pow((1 + [self ReturnVU2035InstHigh:@"A"]), (BackTerm_2030 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVU2035InstHigh:@"M"])/(pow((1 + [self ReturnVU2035InstHigh:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VU2035Value_EverCash1 + VU2035Value_EverCash6;
	
}

-(double)PaidUpOptionTable_2035_Median:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVU2035InstMedian:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VU2035Value_EverCash55;
	
	
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2023 = 0.00;
		double BackTerm_2023 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023to2035_M * pow((1 + [self ReturnVU2035InstMedian:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVU2035InstMedian:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2035InstMedian:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVU2035InstMedian:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2035Value_EverCash55 * GMIFactor_BackTermH2023 + PrevVU2035Value_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVU2035InstMedian:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2025 = 0.00;
		double BackTerm_2025 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025to2035_M * pow((1 + [self ReturnVU2035InstMedian:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVU2035InstMedian:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVU2035InstMedian:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVU2035InstMedian:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2035Value_EverCash55 * GMIFactor_BackTermH2025 + PrevVU2035Value_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVU2035InstMedian:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2028 = 0.00;
		double BackTerm_2028 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028to2035_M * pow((1 + [self ReturnVU2035InstMedian:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVU2035InstMedian:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVU2035InstMedian:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVU2035InstMedian:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2035Value_EverCash55 * GMIFactor_BackTermH2028 + PrevVU2035Value_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVU2035InstMedian:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2030) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2030"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2030 = 0.00;
		double BackTerm_2030 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2030 = 12 - [self roundUp:((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12) ];
		Value3 = ReinvestAmount2030to2035_M * pow((1 + [self ReturnVU2035InstMedian:@"A"]), BackTerm_2030/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2030 = (pow((1 + [self ReturnVU2035InstMedian:@"A"]), (BackTerm_2030 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVU2035InstMedian:@"A"]), ((12 - BackTerm_2030) / 12.00))   - 1) / (pow(1 + [self ReturnVU2035InstMedian:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2035Value_EverCash55 * GMIFactor_BackTermH2030 + PrevVU2035Value_EverCash55 * GMIFactor_FrontTermH2030 * pow((1 + [self ReturnVU2035InstMedian:@"A"]), (BackTerm_2030 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVU2035InstMedian:@"M"])/(pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VU2035Value_EverCash1 + VU2035Value_EverCash6;
	
}

-(double)PaidUpOptionTable_2035_Low:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVU2035InstLow:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VU2035Value_EverCash55;
	
	
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2023 = 0.00;
		double BackTerm_2023 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023to2035_L * pow((1 + [self ReturnVU2035InstLow:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVU2035InstLow:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2035InstLow:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVU2035InstLow:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2035Value_EverCash55 * GMIFactor_BackTermH2023 + PrevVU2035Value_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVU2035InstLow:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2025 = 0.00;
		double BackTerm_2025 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025to2035_L * pow((1 + [self ReturnVU2035InstLow:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVU2035InstLow:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVU2035InstLow:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVU2035InstLow:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2035Value_EverCash55 * GMIFactor_BackTermH2025 + PrevVU2035Value_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVU2035InstLow:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2028 = 0.00;
		double BackTerm_2028 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028to2035_L * pow((1 + [self ReturnVU2035InstLow:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVU2035InstLow:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVU2035InstLow:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVU2035InstLow:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2035Value_EverCash55 * GMIFactor_BackTermH2028 + PrevVU2035Value_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVU2035InstLow:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2030) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2030"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		double RemainingTerm_2030 = 0.00;
		double BackTerm_2030 = 0.00;
		double Value3 = 0.00;
		RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2030 = 12 - [self roundUp:((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12) ];
		Value3 = ReinvestAmount2030to2035_L * pow((1 + [self ReturnVU2035InstLow:@"A"]), BackTerm_2030/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				double GMIFactor_BackTermH2030 = (pow((1 + [self ReturnVU2035InstLow:@"A"]), (BackTerm_2030 / 12.00)) - 1) / ( pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/ 12.00))   - 1);
				double GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVU2035InstLow:@"A"]), ((12 - BackTerm_2030) / 12.00))   - 1) / (pow(1 + [self ReturnVU2035InstLow:@"A"], (1.00/ 12.00))  - 1);
				double Value4 = VU2035Value_EverCash55 * GMIFactor_BackTermH2030 + PrevVU2035Value_EverCash55 * GMIFactor_FrontTermH2030 * pow((1 + [self ReturnVU2035InstLow:@"A"]), (BackTerm_2030 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVU2035InstLow:@"M"])/(pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VU2035Value_EverCash1 + VU2035Value_EverCash6;
	
}

-(double)PaidUpOptionTable_Ret_High:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double RemainingTerm_2023 = 0.00;
	double RemainingTerm_2025 = 0.00;
	double RemainingTerm_2028 = 0.00;
	double RemainingTerm_2030 = 0.00;
	double RemainingTerm_2035 = 0.00;
	double BackTerm_2023 = 0.00;
	double BackTerm_2025 = 0.00;
	double BackTerm_2028 = 0.00;
	double BackTerm_2030 = 0.00;
	double BackTerm_2035 = 0.00;
	double GMIFactor_BackTermH2023 = 0.00;
	double GMIFactor_BackTermH2025 = 0.00;
	double GMIFactor_BackTermH2028 = 0.00;
	double GMIFactor_BackTermH2030 = 0.00;
	double GMIFactor_BackTermH2035 = 0.00;
	
	double GMIFactor_FrontTermH2023 = 0.00;
	double GMIFactor_FrontTermH2025 = 0.00;
	double GMIFactor_FrontTermH2028 = 0.00;
	double GMIFactor_FrontTermH2030 = 0.00;
	double GMIFactor_FrontTermH2035 = 0.00;
	

	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VURetValue_EverCash55;
	double Value3 = 0.00;
	double Value4 = 0.00;
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023toRet_H * pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/ 12.00))   - 1);
				 GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2023 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2025 = 0.00;
		BackTerm_2025 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025toRet_H * pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2025 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2028 = 0.00;
		BackTerm_2028 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028toRet_H * pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2028 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2030) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2030"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2030 = 0.00;
		BackTerm_2030 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2030 = 12 - [self roundUp:((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12) ];
		Value3 = ReinvestAmount2030toRet_H * pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), BackTerm_2030/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2030 = (pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2030 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), ((12 - BackTerm_2030) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2030 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2030 * pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2030 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2035) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2035"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2035 = 0.00;
		BackTerm_2035 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2035 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2035 = 12 - [self roundUp:((RemainingTerm_2035 - round(ceil(RemainingTerm_2035)) + 1) * 12) ];
		Value3 = ReinvestAmount2035toRet_H * pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), BackTerm_2035/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2035 = (pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2035 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2035 = (pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), ((12 - BackTerm_2035) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2035 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2035 * pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2035 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"M"])/(pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VURetValue_EverCash1 + VURetValue_EverCash6;
	
}

-(double)PaidUpOptionTable_Ret_Median:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double RemainingTerm_2023 = 0.00;
	double RemainingTerm_2025 = 0.00;
	double RemainingTerm_2028 = 0.00;
	double RemainingTerm_2030 = 0.00;
	double RemainingTerm_2035 = 0.00;
	double BackTerm_2023 = 0.00;
	double BackTerm_2025 = 0.00;
	double BackTerm_2028 = 0.00;
	double BackTerm_2030 = 0.00;
	double BackTerm_2035 = 0.00;
	double GMIFactor_BackTermH2023 = 0.00;
	double GMIFactor_BackTermH2025 = 0.00;
	double GMIFactor_BackTermH2028 = 0.00;
	double GMIFactor_BackTermH2030 = 0.00;
	double GMIFactor_BackTermH2035 = 0.00;
	
	double GMIFactor_FrontTermH2023 = 0.00;
	double GMIFactor_FrontTermH2025 = 0.00;
	double GMIFactor_FrontTermH2028 = 0.00;
	double GMIFactor_FrontTermH2030 = 0.00;
	double GMIFactor_FrontTermH2035 = 0.00;
	
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVURetInstMedian:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VURetValue_EverCash55;
	double Value3 = 0.00;
	double Value4 = 0.00;
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023toRet_M * pow((1 + [self ReturnVURetInstMedian:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVURetInstMedian:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVURetInstMedian:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2023 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVURetInstMedian:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2025 = 0.00;
		BackTerm_2025 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025toRet_M * pow((1 + [self ReturnVURetInstMedian:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVURetInstMedian:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVURetInstMedian:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2025 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVURetInstMedian:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2028 = 0.00;
		BackTerm_2028 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028toRet_M * pow((1 + [self ReturnVURetInstMedian:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVURetInstMedian:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVURetInstMedian:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2028 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVURetInstMedian:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2030) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2030"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2030 = 0.00;
		BackTerm_2030 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2030 = 12 - [self roundUp:((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12) ];
		Value3 = ReinvestAmount2030toRet_M * pow((1 + [self ReturnVURetInstMedian:@"A"]), BackTerm_2030/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2030 = (pow((1 + [self ReturnVURetInstMedian:@"A"]), (BackTerm_2030 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVURetInstMedian:@"A"]), ((12 - BackTerm_2030) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2030 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2030 * pow((1 + [self ReturnVURetInstMedian:@"A"]), (BackTerm_2030 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2035) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2035"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2035 = 0.00;
		BackTerm_2035 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2035 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2035 = 12 - [self roundUp:((RemainingTerm_2035 - round(ceil(RemainingTerm_2035)) + 1) * 12) ];
		Value3 = ReinvestAmount2035toRet_M * pow((1 + [self ReturnVURetInstMedian:@"A"]), BackTerm_2035/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2035 = (pow((1 + [self ReturnVURetInstMedian:@"A"]), (BackTerm_2035 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2035 = (pow((1 + [self ReturnVURetInstMedian:@"A"]), ((12 - BackTerm_2035) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2035 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2035 * pow((1 + [self ReturnVURetInstMedian:@"A"]), (BackTerm_2035 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVURetInstMedian:@"M"])/(pow((1 + [self ReturnVURetInstMedian:@"A"]), (1.00/12.00)));
		}
	}

	return temp + VURetValue_EverCash1 + VURetValue_EverCash6;
	
}

-(double)PaidUpOptionTable_Ret_Low:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double RemainingTerm_2023 = 0.00;
	double RemainingTerm_2025 = 0.00;
	double RemainingTerm_2028 = 0.00;
	double RemainingTerm_2030 = 0.00;
	double RemainingTerm_2035 = 0.00;
	double BackTerm_2023 = 0.00;
	double BackTerm_2025 = 0.00;
	double BackTerm_2028 = 0.00;
	double BackTerm_2030 = 0.00;
	double BackTerm_2035 = 0.00;
	double GMIFactor_BackTermH2023 = 0.00;
	double GMIFactor_BackTermH2025 = 0.00;
	double GMIFactor_BackTermH2028 = 0.00;
	double GMIFactor_BackTermH2030 = 0.00;
	double GMIFactor_BackTermH2035 = 0.00;
	
	double GMIFactor_FrontTermH2023 = 0.00;
	double GMIFactor_FrontTermH2025 = 0.00;
	double GMIFactor_FrontTermH2028 = 0.00;
	double GMIFactor_FrontTermH2030 = 0.00;
	double GMIFactor_FrontTermH2035 = 0.00;
	
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVURetInstLow:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VURetValue_EverCash55;
	double Value3 = 0.00;
	double Value4 = 0.00;
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023toRet_L * pow((1 + [self ReturnVURetInstLow:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVURetInstLow:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVURetInstLow:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2023 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVURetInstLow:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2025 = 0.00;
		BackTerm_2025 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025toRet_L * pow((1 + [self ReturnVURetInstLow:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVURetInstLow:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVURetInstLow:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2025 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVURetInstLow:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2028 = 0.00;
		BackTerm_2028 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028toRet_L * pow((1 + [self ReturnVURetInstLow:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVURetInstLow:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVURetInstLow:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2028 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVURetInstLow:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2030) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2030"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2030 = 0.00;
		BackTerm_2030 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2030 = 12 - [self roundUp:((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12) ];
		Value3 = ReinvestAmount2030toRet_L * pow((1 + [self ReturnVURetInstLow:@"A"]), BackTerm_2030/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2030 = (pow((1 + [self ReturnVURetInstLow:@"A"]), (BackTerm_2030 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVURetInstLow:@"A"]), ((12 - BackTerm_2030) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2030 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2030 * pow((1 + [self ReturnVURetInstLow:@"A"]), (BackTerm_2030 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2035) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2035"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2035 = 0.00;
		BackTerm_2035 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2035 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2035 = 12 - [self roundUp:((RemainingTerm_2035 - round(ceil(RemainingTerm_2035)) + 1) * 12) ];
		Value3 = ReinvestAmount2035toRet_L * pow((1 + [self ReturnVURetInstLow:@"A"]), BackTerm_2035/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2035 = (pow((1 + [self ReturnVURetInstLow:@"A"]), (BackTerm_2035 / 12.00)) - 1) / ( pow((1 + [self ReturnVURetInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2035 = (pow((1 + [self ReturnVURetInstLow:@"A"]), ((12 - BackTerm_2035) / 12.00))   - 1) / (pow(1 + [self ReturnVURetInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VURetValue_EverCash55 * GMIFactor_BackTermH2035 + PrevVURetValue_EverCash55 * GMIFactor_FrontTermH2035 * pow((1 + [self ReturnVURetInstLow:@"A"]), (BackTerm_2035 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVURetInstLow:@"M"])/(pow((1 + [self ReturnVURetInstLow:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VURetValue_EverCash1 + VURetValue_EverCash6;
	
}

-(double)PaidUpOptionTable_Dana_High:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double RemainingTerm_2023 = 0.00;
	double RemainingTerm_2025 = 0.00;
	double RemainingTerm_2028 = 0.00;
	double RemainingTerm_2030 = 0.00;
	double RemainingTerm_2035 = 0.00;
	double BackTerm_2023 = 0.00;
	double BackTerm_2025 = 0.00;
	double BackTerm_2028 = 0.00;
	double BackTerm_2030 = 0.00;
	double BackTerm_2035 = 0.00;
	double GMIFactor_BackTermH2023 = 0.00;
	double GMIFactor_BackTermH2025 = 0.00;
	double GMIFactor_BackTermH2028 = 0.00;
	double GMIFactor_BackTermH2030 = 0.00;
	double GMIFactor_BackTermH2035 = 0.00;
	
	double GMIFactor_FrontTermH2023 = 0.00;
	double GMIFactor_FrontTermH2025 = 0.00;
	double GMIFactor_FrontTermH2028 = 0.00;
	double GMIFactor_FrontTermH2030 = 0.00;
	double GMIFactor_FrontTermH2035 = 0.00;
	
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VURetValue_EverCash55;
	double Value3 = 0.00;
	double Value4 = 0.00;
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023toDana_H * pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2023 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2025 = 0.00;
		BackTerm_2025 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025toDana_H * pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2025 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2028 = 0.00;
		BackTerm_2028 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028toDana_H * pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2028 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2030) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2030"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2030 = 0.00;
		BackTerm_2030 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2030 = 12 - [self roundUp:((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12) ];
		Value3 = ReinvestAmount2030toDana_H * pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), BackTerm_2030/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2030 = (pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2030 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), ((12 - BackTerm_2030) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2030 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2030 * pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2030 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2035) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2035"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2035 = 0.00;
		BackTerm_2035 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2035 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2035 = 12 - [self roundUp:((RemainingTerm_2035 - round(ceil(RemainingTerm_2035)) + 1) * 12) ];
		Value3 = ReinvestAmount2035toDana_H * pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), BackTerm_2035/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2035 = (pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2035 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2035 = (pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), ((12 - BackTerm_2035) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2035 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2035 * pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (BackTerm_2035 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"M"])/(pow((1 + [self ReturnVUDanaInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VUDanaValue_EverCash1 + VUDanaValue_EverCash6;
	
}

-(double)PaidUpOptionTable_Dana_Median:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double RemainingTerm_2023 = 0.00;
	double RemainingTerm_2025 = 0.00;
	double RemainingTerm_2028 = 0.00;
	double RemainingTerm_2030 = 0.00;
	double RemainingTerm_2035 = 0.00;
	double BackTerm_2023 = 0.00;
	double BackTerm_2025 = 0.00;
	double BackTerm_2028 = 0.00;
	double BackTerm_2030 = 0.00;
	double BackTerm_2035 = 0.00;
	double GMIFactor_BackTermH2023 = 0.00;
	double GMIFactor_BackTermH2025 = 0.00;
	double GMIFactor_BackTermH2028 = 0.00;
	double GMIFactor_BackTermH2030 = 0.00;
	double GMIFactor_BackTermH2035 = 0.00;
	
	double GMIFactor_FrontTermH2023 = 0.00;
	double GMIFactor_FrontTermH2025 = 0.00;
	double GMIFactor_FrontTermH2028 = 0.00;
	double GMIFactor_FrontTermH2030 = 0.00;
	double GMIFactor_FrontTermH2035 = 0.00;
	
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVUDanaInstMedian:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VUDanaValue_EverCash55;
	double Value3 = 0.00;
	double Value4 = 0.00;
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023toDana_M * pow((1 + [self ReturnVUDanaInstMedian:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVUDanaInstMedian:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2023 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2025 = 0.00;
		BackTerm_2025 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025toDana_M * pow((1 + [self ReturnVUDanaInstMedian:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVUDanaInstMedian:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2025 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2028 = 0.00;
		BackTerm_2028 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028toDana_M * pow((1 + [self ReturnVUDanaInstMedian:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVUDanaInstMedian:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2028 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2030) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2030"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2030 = 0.00;
		BackTerm_2030 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2030 = 12 - [self roundUp:((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12) ];
		Value3 = ReinvestAmount2030toDana_M * pow((1 + [self ReturnVUDanaInstMedian:@"A"]), BackTerm_2030/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2030 = (pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (BackTerm_2030 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVUDanaInstMedian:@"A"]), ((12 - BackTerm_2030) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2030 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2030 * pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (BackTerm_2030 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2035) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2035"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2035 = 0.00;
		BackTerm_2035 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2035 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2035 = 12 - [self roundUp:((RemainingTerm_2035 - round(ceil(RemainingTerm_2035)) + 1) * 12) ];
		Value3 = ReinvestAmount2035toDana_M * pow((1 + [self ReturnVUDanaInstMedian:@"A"]), BackTerm_2035/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2035 = (pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (BackTerm_2035 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2035 = (pow((1 + [self ReturnVUDanaInstMedian:@"A"]), ((12 - BackTerm_2035) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2035 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2035 * pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (BackTerm_2035 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVUDanaInstMedian:@"M"])/(pow((1 + [self ReturnVUDanaInstMedian:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VUDanaValue_EverCash1 + VUDanaValue_EverCash6;
	
}

-(double)PaidUpOptionTable_Dana_Low:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double RemainingTerm_2023 = 0.00;
	double RemainingTerm_2025 = 0.00;
	double RemainingTerm_2028 = 0.00;
	double RemainingTerm_2030 = 0.00;
	double RemainingTerm_2035 = 0.00;
	double BackTerm_2023 = 0.00;
	double BackTerm_2025 = 0.00;
	double BackTerm_2028 = 0.00;
	double BackTerm_2030 = 0.00;
	double BackTerm_2035 = 0.00;
	double GMIFactor_BackTermH2023 = 0.00;
	double GMIFactor_BackTermH2025 = 0.00;
	double GMIFactor_BackTermH2028 = 0.00;
	double GMIFactor_BackTermH2030 = 0.00;
	double GMIFactor_BackTermH2035 = 0.00;
	
	double GMIFactor_FrontTermH2023 = 0.00;
	double GMIFactor_FrontTermH2025 = 0.00;
	double GMIFactor_FrontTermH2028 = 0.00;
	double GMIFactor_FrontTermH2030 = 0.00;
	double GMIFactor_FrontTermH2035 = 0.00;
	
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVUDanaInstLow:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VUDanaValue_EverCash55;
	double Value3 = 0.00;
	double Value4 = 0.00;
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023toDana_L * pow((1 + [self ReturnVUDanaInstLow:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVUDanaInstLow:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVUDanaInstLow:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2023 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVUDanaInstLow:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2025 = 0.00;
		BackTerm_2025 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025toDana_L * pow((1 + [self ReturnVUDanaInstLow:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVUDanaInstLow:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVUDanaInstLow:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2025 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVUDanaInstLow:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2028 = 0.00;
		BackTerm_2028 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028toDana_L * pow((1 + [self ReturnVUDanaInstLow:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVUDanaInstLow:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVUDanaInstLow:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2028 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVUDanaInstLow:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2030) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2030"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2030 = 0.00;
		BackTerm_2030 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2030 = 12 - [self roundUp:((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12) ];
		Value3 = ReinvestAmount2030toDana_L * pow((1 + [self ReturnVUDanaInstLow:@"A"]), BackTerm_2030/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2030 = (pow((1 + [self ReturnVUDanaInstLow:@"A"]), (BackTerm_2030 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVUDanaInstLow:@"A"]), ((12 - BackTerm_2030) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2030 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2030 * pow((1 + [self ReturnVUDanaInstLow:@"A"]), (BackTerm_2030 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2035) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2035"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2035 = 0.00;
		BackTerm_2035 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2035 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2035 = 12 - [self roundUp:((RemainingTerm_2035 - round(ceil(RemainingTerm_2035)) + 1) * 12) ];
		Value3 = ReinvestAmount2035toDana_L * pow((1 + [self ReturnVUDanaInstLow:@"A"]), BackTerm_2035/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2035 = (pow((1 + [self ReturnVUDanaInstLow:@"A"]), (BackTerm_2035 / 12.00)) - 1) / ( pow((1 + [self ReturnVUDanaInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2035 = (pow((1 + [self ReturnVUDanaInstLow:@"A"]), ((12 - BackTerm_2035) / 12.00))   - 1) / (pow(1 + [self ReturnVUDanaInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUDanaValue_EverCash55 * GMIFactor_BackTermH2035 + PrevVUDanaValue_EverCash55 * GMIFactor_FrontTermH2035 * pow((1 + [self ReturnVUDanaInstLow:@"A"]), (BackTerm_2035 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVUDanaInstLow:@"M"])/(pow((1 + [self ReturnVUDanaInstLow:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VUDanaValue_EverCash1 + VUDanaValue_EverCash6;
	
}

-(double)PaidUpOptionTable_Cash_High:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double RemainingTerm_2023 = 0.00;
	double RemainingTerm_2025 = 0.00;
	double RemainingTerm_2028 = 0.00;
	double RemainingTerm_2030 = 0.00;
	double RemainingTerm_2035 = 0.00;
	double BackTerm_2023 = 0.00;
	double BackTerm_2025 = 0.00;
	double BackTerm_2028 = 0.00;
	double BackTerm_2030 = 0.00;
	double BackTerm_2035 = 0.00;
	double GMIFactor_BackTermH2023 = 0.00;
	double GMIFactor_BackTermH2025 = 0.00;
	double GMIFactor_BackTermH2028 = 0.00;
	double GMIFactor_BackTermH2030 = 0.00;
	double GMIFactor_BackTermH2035 = 0.00;
	
	double GMIFactor_FrontTermH2023 = 0.00;
	double GMIFactor_FrontTermH2025 = 0.00;
	double GMIFactor_FrontTermH2028 = 0.00;
	double GMIFactor_FrontTermH2030 = 0.00;
	double GMIFactor_FrontTermH2035 = 0.00;
	
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVUCashInstHigh:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VUCashValue_EverCash55;
	double Value3 = 0.00;
	double Value4 = 0.00;
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023toCash_H * pow((1 + [self ReturnVUCashInstHigh:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVUCashInstHigh:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVUCashInstHigh:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstHigh:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2023 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVUCashInstHigh:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2025 = 0.00;
		BackTerm_2025 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - round((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12);
		Value3 = ReinvestAmount2025toCash_H * pow((1 + [self ReturnVUCashInstHigh:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVUCashInstHigh:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVUCashInstHigh:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstHigh:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2025 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVUCashInstHigh:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2028 = 0.00;
		BackTerm_2028 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028toCash_H * pow((1 + [self ReturnVUCashInstHigh:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVUCashInstHigh:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVUCashInstHigh:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstHigh:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2028 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVUCashInstHigh:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2030) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2030"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2030 = 0.00;
		BackTerm_2030 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2030 = 12 - [self roundUp:((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12) ];
		Value3 = ReinvestAmount2030toCash_H * pow((1 + [self ReturnVUCashInstHigh:@"A"]), BackTerm_2030/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2030 = (pow((1 + [self ReturnVUCashInstHigh:@"A"]), (BackTerm_2030 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVUCashInstHigh:@"A"]), ((12 - BackTerm_2030) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstHigh:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2030 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2030 * pow((1 + [self ReturnVUCashInstHigh:@"A"]), (BackTerm_2030 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2035) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2035"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2035 = 0.00;
		BackTerm_2035 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2035 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2035 = 12 - [self roundUp:((RemainingTerm_2035 - round(ceil(RemainingTerm_2035)) + 1) * 12) ];
		Value3 = ReinvestAmount2035toCash_H * pow((1 + [self ReturnVUCashInstHigh:@"A"]), BackTerm_2035/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2035 = (pow((1 + [self ReturnVUCashInstHigh:@"A"]), (BackTerm_2035 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2035 = (pow((1 + [self ReturnVUCashInstHigh:@"A"]), ((12 - BackTerm_2035) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstHigh:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2035 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2035 * pow((1 + [self ReturnVUCashInstHigh:@"A"]), (BackTerm_2035 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVUCashInstHigh:@"M"])/(pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VUCashValue_EverCash1 + VUCashValue_EverCash6;
	
}

-(double)PaidUpOptionTable_Cash_Median:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double RemainingTerm_2023 = 0.00;
	double RemainingTerm_2025 = 0.00;
	double RemainingTerm_2028 = 0.00;
	double RemainingTerm_2030 = 0.00;
	double RemainingTerm_2035 = 0.00;
	double BackTerm_2023 = 0.00;
	double BackTerm_2025 = 0.00;
	double BackTerm_2028 = 0.00;
	double BackTerm_2030 = 0.00;
	double BackTerm_2035 = 0.00;
	double GMIFactor_BackTermH2023 = 0.00;
	double GMIFactor_BackTermH2025 = 0.00;
	double GMIFactor_BackTermH2028 = 0.00;
	double GMIFactor_BackTermH2030 = 0.00;
	double GMIFactor_BackTermH2035 = 0.00;
	
	double GMIFactor_FrontTermH2023 = 0.00;
	double GMIFactor_FrontTermH2025 = 0.00;
	double GMIFactor_FrontTermH2028 = 0.00;
	double GMIFactor_FrontTermH2030 = 0.00;
	double GMIFactor_FrontTermH2035 = 0.00;
	
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVUCashInstMedian:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VUCashValue_EverCash55;
	double Value3 = 0.00;
	double Value4 = 0.00;
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023toCash_M * pow((1 + [self ReturnVUCashInstMedian:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVUCashInstMedian:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVUCashInstMedian:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2023 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVUCashInstMedian:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2025 = 0.00;
		BackTerm_2025 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025toCash_M * pow((1 + [self ReturnVUCashInstMedian:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVUCashInstMedian:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVUCashInstMedian:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2025 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVUCashInstMedian:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2028 = 0.00;
		BackTerm_2028 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028toCash_M * pow((1 + [self ReturnVUCashInstMedian:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVUCashInstMedian:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVUCashInstMedian:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2028 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVUCashInstMedian:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2030) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2030"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2030 = 0.00;
		BackTerm_2030 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2030 = 12 - [self roundUp:((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12) ];
		Value3 = ReinvestAmount2030toCash_M * pow((1 + [self ReturnVUCashInstMedian:@"A"]), BackTerm_2030/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2030 = (pow((1 + [self ReturnVUCashInstMedian:@"A"]), (BackTerm_2030 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVUCashInstMedian:@"A"]), ((12 - BackTerm_2030) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2030 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2030 * pow((1 + [self ReturnVUCashInstMedian:@"A"]), (BackTerm_2030 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2035) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2035"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2035 = 0.00;
		BackTerm_2035 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2035 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2035 = 12 - [self roundUp:((RemainingTerm_2035 - round(ceil(RemainingTerm_2035)) + 1) * 12) ];
		Value3 = ReinvestAmount2035toCash_M * pow((1 + [self ReturnVUCashInstMedian:@"A"]), BackTerm_2035/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2035 = (pow((1 + [self ReturnVUCashInstMedian:@"A"]), (BackTerm_2035 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstMedian:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2035 = (pow((1 + [self ReturnVUCashInstMedian:@"A"]), ((12 - BackTerm_2035) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstMedian:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2035 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2035 * pow((1 + [self ReturnVUCashInstMedian:@"A"]), (BackTerm_2035 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVUCashInstMedian:@"M"])/(pow((1 + [self ReturnVUCashInstMedian:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VUCashValue_EverCash1 + VUCashValue_EverCash6;
	
}

-(double)PaidUpOptionTable_Cash_Low:(double)aaValue andPolicyYear :(int)aaPolicyYear {
	
	double RemainingTerm_2023 = 0.00;
	double RemainingTerm_2025 = 0.00;
	double RemainingTerm_2028 = 0.00;
	double RemainingTerm_2030 = 0.00;
	double RemainingTerm_2035 = 0.00;
	double BackTerm_2023 = 0.00;
	double BackTerm_2025 = 0.00;
	double BackTerm_2028 = 0.00;
	double BackTerm_2030 = 0.00;
	double BackTerm_2035 = 0.00;
	double GMIFactor_BackTermH2023 = 0.00;
	double GMIFactor_BackTermH2025 = 0.00;
	double GMIFactor_BackTermH2028 = 0.00;
	double GMIFactor_BackTermH2030 = 0.00;
	double GMIFactor_BackTermH2035 = 0.00;
	
	double GMIFactor_FrontTermH2023 = 0.00;
	double GMIFactor_FrontTermH2025 = 0.00;
	double GMIFactor_FrontTermH2028 = 0.00;
	double GMIFactor_FrontTermH2030 = 0.00;
	double GMIFactor_FrontTermH2035 = 0.00;
	
	
	double temp = 0.00;
	double Value1 = aaValue * (1 + [self ReturnVUCashInstLow:@"A"]) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	double Value2 = VUCashValue_EverCash55;
	double Value3 = 0.00;
	double Value4 = 0.00;
	
	if (aaPolicyYear == FundTerm2023) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2023"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		
		RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2023 = 12 - [self roundUp:((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12) ];
		Value3 = ReinvestAmount2023toCash_L * pow((1 + [self ReturnVUCashInstLow:@"A"]), BackTerm_2023/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2023 = (pow((1 + [self ReturnVUCashInstLow:@"A"]), (BackTerm_2023 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVUCashInstLow:@"A"]), ((12 - BackTerm_2023) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2023 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2023 * pow((1 + [self ReturnVUCashInstLow:@"A"]), (BackTerm_2023 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2025) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2025"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2025 = 0.00;
		BackTerm_2025 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2025 = 12 - [self roundUp:((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12) ];
		Value3 = ReinvestAmount2025toCash_L * pow((1 + [self ReturnVUCashInstLow:@"A"]), BackTerm_2025/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2025 = (pow((1 + [self ReturnVUCashInstLow:@"A"]), (BackTerm_2025 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVUCashInstLow:@"A"]), ((12 - BackTerm_2025) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2025 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2025 * pow((1 + [self ReturnVUCashInstLow:@"A"]), (BackTerm_2025 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2028) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2028"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2028 = 0.00;
		BackTerm_2028 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2028 = 12 - [self roundUp:((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12) ];
		Value3 = ReinvestAmount2028toCash_L * pow((1 + [self ReturnVUCashInstLow:@"A"]), BackTerm_2028/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2028 = (pow((1 + [self ReturnVUCashInstLow:@"A"]), (BackTerm_2028 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVUCashInstLow:@"A"]), ((12 - BackTerm_2028) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2028 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2028 * pow((1 + [self ReturnVUCashInstLow:@"A"]), (BackTerm_2028 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2030) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2030"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2030 = 0.00;
		BackTerm_2030 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2030 = 12 - [self roundUp:((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12) ];
		Value3 = ReinvestAmount2030toCash_L * pow((1 + [self ReturnVUCashInstLow:@"A"]), BackTerm_2030/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2030 = (pow((1 + [self ReturnVUCashInstLow:@"A"]), (BackTerm_2030 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVUCashInstLow:@"A"]), ((12 - BackTerm_2030) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2030 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2030 * pow((1 + [self ReturnVUCashInstLow:@"A"]), (BackTerm_2030 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else if (aaPolicyYear == FundTerm2035) {
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
		NSDate* d = [df dateFromString:getPlanCommDate];
		NSDate* d2 = [df dateFromString:@"26/12/2035"];
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		RemainingTerm_2035 = 0.00;
		BackTerm_2035 = 0.00;
		Value3 = 0.00;
		RemainingTerm_2035 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
		BackTerm_2035 = 12 - [self roundUp:((RemainingTerm_2035 - round(ceil(RemainingTerm_2035)) + 1) * 12) ];
		Value3 = ReinvestAmount2035toCash_L * pow((1 + [self ReturnVUCashInstLow:@"A"]), BackTerm_2035/12.00) ;
		temp = Value1 + Value3;
		
		if (ECAR55Exist == TRUE) {
			if (Age + aaPolicyYear == 55) {
				temp = temp + Value2;
			}
			else if (Age + aaPolicyYear > 55){
				GMIFactor_BackTermH2035 = (pow((1 + [self ReturnVUCashInstLow:@"A"]), (BackTerm_2035 / 12.00)) - 1) / ( pow((1 + [self ReturnVUCashInstLow:@"A"]), (1.00/ 12.00))   - 1);
				GMIFactor_FrontTermH2035 = (pow((1 + [self ReturnVUCashInstLow:@"A"]), ((12 - BackTerm_2035) / 12.00))   - 1) / (pow(1 + [self ReturnVUCashInstLow:@"A"], (1.00/ 12.00))  - 1);
				Value4 = VUCashValue_EverCash55 * GMIFactor_BackTermH2035 + PrevVUCashValue_EverCash55 * GMIFactor_FrontTermH2035 * pow((1 + [self ReturnVUCashInstLow:@"A"]), (BackTerm_2035 / 12.00));
				temp = temp + Value4;
			}
			else{
				
			}
		}
		
		
	}
	else{
		if (Age + aaPolicyYear < 55) {
			temp = Value1;
		}
		else if (Age + aaPolicyYear == 55){
			temp = Value1 + Value2;
		}
		else{
			temp = Value1 + Value2 * 12 * (1 + [self ReturnVUCashInstLow:@"M"])/(pow((1 + [self ReturnVUCashInstLow:@"A"]), (1.00/12.00)));
		}
	}
	
	return temp + VUCashValue_EverCash1 + VUCashValue_EverCash6;
	
}

-(double)PaidUpOptionTable_2023_L_Balance :(double)aaPrevPaidUpOptionTable_2023_Low andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2023"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2023 = 0.00;
	double FrontTerm_2023 = 0.00;
	double GMIFactor_FrontTermH2023 = 0.00;
	
	RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2023 = round((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2023InstLow:@"A"]),(FrontTerm_2023/12.00) ) - 1)/(pow((1 + [self ReturnVU2023InstLow:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2023_Low * pow((1 + [self ReturnVU2023InstLow:@"A"]), FrontTerm_2023/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}



-(double)PaidUpOptionTable_2025_L_Balance :(double)aaPrevPaidUpOptionTable_2025_Low andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2025"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2025 = 0.00;
	double FrontTerm_2025 = 0.00;
	double GMIFactor_FrontTermH2025 = 0.00;
	
	RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2025 = round((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVU2025InstLow:@"A"]),(FrontTerm_2025/12.00) ) - 1)/(pow((1 + [self ReturnVU2025InstLow:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2025_Low * pow((1 + [self ReturnVU2025InstLow:@"A"]), FrontTerm_2025/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}

-(double)PaidUpOptionTable_2028_L_Balance :(double)aaPrevPaidUpOptionTable_2028_Low andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2028"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2028 = 0.00;
	double FrontTerm_2028 = 0.00;
	double GMIFactor_FrontTermH2028 = 0.00;
	
	RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2028 = round((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVU2028InstLow:@"A"]),(FrontTerm_2028/12.00) ) - 1)/(pow((1 + [self ReturnVU2028InstLow:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2028_Low * pow((1 + [self ReturnVU2028InstLow:@"A"]), FrontTerm_2028/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}

-(double)PaidUpOptionTable_2030_L_Balance :(double)aaPrevPaidUpOptionTable_2030_Low andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2030"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2030 = 0.00;
	double FrontTerm_2030 = 0.00;
	double GMIFactor_FrontTermH2030 = 0.00;
	
	RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2030 = round((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVU2030InstLow:@"A"]),(FrontTerm_2030/12.00) ) - 1)/(pow((1 + [self ReturnVU2030InstLow:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2030_Low * pow((1 + [self ReturnVU2030InstLow:@"A"]), FrontTerm_2030/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}

-(double)PaidUpOptionTable_2035_L_Balance :(double)aaPrevPaidUpOptionTable_2035_Low andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2035"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2035 = 0.00;
	double FrontTerm_2035 = 0.00;
	double GMIFactor_FrontTermH2035 = 0.00;
	
	RemainingTerm_2035 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2035 = [self roundUp:((RemainingTerm_2035 - round(ceil(RemainingTerm_2035)) + 1) * 12) ];
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2035 = (pow((1 + [self ReturnVU2035InstLow:@"A"]),(FrontTerm_2035/12.00) ) - 1)/(pow((1 + [self ReturnVU2035InstLow:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2035_Low * pow((1 + [self ReturnVU2035InstLow:@"A"]), FrontTerm_2035/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}

-(double)PaidUpOptionTable_2023_M_Balance :(double)aaPrevPaidUpOptionTable_2023_Median andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2023"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2023 = 0.00;
	double FrontTerm_2023 = 0.00;
	double GMIFactor_FrontTermH2023 = 0.00;
	
	RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2023 = round((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2023InstMedian:@"A"]),(FrontTerm_2023/12.00) ) - 1)/(pow((1 + [self ReturnVU2023InstMedian:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2023_Median * pow((1 + [self ReturnVU2023InstMedian:@"A"]), FrontTerm_2023/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}

-(double)PaidUpOptionTable_2025_M_Balance :(double)aaPrevPaidUpOptionTable_2025_Median andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2025"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2025 = 0.00;
	double FrontTerm_2025 = 0.00;
	double GMIFactor_FrontTermH2025 = 0.00;
	
	RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2025 = round((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVU2025InstMedian:@"A"]),(FrontTerm_2025/12.00) ) - 1)/(pow((1 + [self ReturnVU2025InstMedian:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2025_Median * pow((1 + [self ReturnVU2025InstMedian:@"A"]), FrontTerm_2025/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}

-(double)PaidUpOptionTable_2028_M_Balance :(double)aaPrevPaidUpOptionTable_2028_Median andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2028"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2028 = 0.00;
	double FrontTerm_2028 = 0.00;
	double GMIFactor_FrontTermH2028 = 0.00;
	
	RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2028 = round((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVU2028InstMedian:@"A"]),(FrontTerm_2028/12.00) ) - 1)/(pow((1 + [self ReturnVU2028InstMedian:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2028_Median * pow((1 + [self ReturnVU2028InstMedian:@"A"]), FrontTerm_2028/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}

-(double)PaidUpOptionTable_2030_M_Balance :(double)aaPrevPaidUpOptionTable_2030_Median andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2030"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2030 = 0.00;
	double FrontTerm_2030 = 0.00;
	double GMIFactor_FrontTermH2030 = 0.00;
	
	RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2030 = round((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVU2030InstMedian:@"A"]),(FrontTerm_2030/12.00) ) - 1)/(pow((1 + [self ReturnVU2030InstMedian:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2030_Median * pow((1 + [self ReturnVU2030InstMedian:@"A"]), FrontTerm_2030/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}

-(double)PaidUpOptionTable_2035_M_Balance :(double)aaPrevPaidUpOptionTable_2035_Median andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2035"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2035 = 0.00;
	double FrontTerm_2035 = 0.00;
	double GMIFactor_FrontTermH2035 = 0.00;
	
	RemainingTerm_2035 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2035 = [self roundUp:((RemainingTerm_2035 - round(ceil(RemainingTerm_2035)) + 1) * 12) ];
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2035 = (pow((1 + [self ReturnVU2035InstMedian:@"A"]),(FrontTerm_2035/12.00) ) - 1)/(pow((1 + [self ReturnVU2035InstMedian:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2035_Median * pow((1 + [self ReturnVU2035InstMedian:@"A"]), FrontTerm_2035/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}

-(double)PaidUpOptionTable_2023_H_Balance :(double)aaPrevPaidUpOptionTable_2023_High andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2023"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2023 = 0.00;
	double FrontTerm_2023 = 0.00;
	double GMIFactor_FrontTermH2023 = 0.00;
	
	RemainingTerm_2023 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2023 = round((RemainingTerm_2023 - round(ceil(RemainingTerm_2023)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2023 = (pow((1 + [self ReturnVU2023InstHigh:@"A"]),(FrontTerm_2023/12.00) ) - 1)/(pow((1 + [self ReturnVU2023InstHigh:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2023_High * pow((1 + [self ReturnVU2023InstHigh:@"A"]), FrontTerm_2023/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}

-(double)PaidUpOptionTable_2025_H_Balance :(double)aaPrevPaidUpOptionTable_2025_High andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2025"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2025 = 0.00;
	double FrontTerm_2025 = 0.00;
	double GMIFactor_FrontTermH2025 = 0.00;
	
	RemainingTerm_2025 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2025 = round((RemainingTerm_2025 - round(ceil(RemainingTerm_2025)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2025 = (pow((1 + [self ReturnVU2025InstHigh:@"A"]),(FrontTerm_2025/12.00) ) - 1)/(pow((1 + [self ReturnVU2025InstHigh:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2025_High * pow((1 + [self ReturnVU2025InstHigh:@"A"]), FrontTerm_2025/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}

-(double)PaidUpOptionTable_2028_H_Balance :(double)aaPrevPaidUpOptionTable_2028_High andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2028"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2028 = 0.00;
	double FrontTerm_2028 = 0.00;
	double GMIFactor_FrontTermH2028 = 0.00;
	
	RemainingTerm_2028 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2028 = round((RemainingTerm_2028 - round(ceil(RemainingTerm_2028)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2028 = (pow((1 + [self ReturnVU2028InstHigh:@"A"]),(FrontTerm_2028/12.00) ) - 1)/(pow((1 + [self ReturnVU2028InstHigh:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2028_High * pow((1 + [self ReturnVU2028InstHigh:@"A"]), FrontTerm_2028/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}

-(double)PaidUpOptionTable_2030_H_Balance :(double)aaPrevPaidUpOptionTable_2030_High andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2030"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	double RemainingTerm_2030 = 0.00;
	double FrontTerm_2030 = 0.00;
	double GMIFactor_FrontTermH2030 = 0.00;
	
	RemainingTerm_2030 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2030 = round((RemainingTerm_2030 - round(ceil(RemainingTerm_2030)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2030 = (pow((1 + [self ReturnVU2030InstHigh:@"A"]),(FrontTerm_2030/12.00) ) - 1)/(pow((1 + [self ReturnVU2030InstHigh:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2030_High * pow((1 + [self ReturnVU2030InstHigh:@"A"]), FrontTerm_2030/12.00) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}


-(double)PaidUpOptionTable_2035_H_Balance :(double)aaPrevPaidUpOptionTable_2035_High andPolicyYear :(int)aaPolicyYear {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2035"];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];

	double RemainingTerm_2035 = 0.00;
	double FrontTerm_2035 = 0.00;
	double GMIFactor_FrontTermH2035 = 0.00;

	RemainingTerm_2035 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[self daysBetweenDate:d andDate:d2]/365.25]] doubleValue];
	FrontTerm_2035 = round((RemainingTerm_2035 -  round(ceil(RemainingTerm_2035)) + 1) * 12);
	if (ECAR55Exist == TRUE) {
		GMIFactor_FrontTermH2035 = (pow((1 + [self ReturnVU2035InstHigh:@"A"]),(FrontTerm_2035/12.00) ) - 1)/(pow((1 + [self ReturnVU2035InstHigh:@"A"]), 1.00/12.00) - 1);
		
		return 0.00;
	}
	else{
		return aaPrevPaidUpOptionTable_2035_High * pow((1 + [self ReturnVU2035InstHigh:@"A"]), (FrontTerm_2035/12.00)) * (1 + [self ReturnLoyaltyBonus:aaPolicyYear]/100.00);
	}
}


#pragma mark - Others
-(double)ReturnVU2023Fac{
	return (double)VU2023Factor/100.00;
}

-(double)ReturnVU2025Fac :(int)aaPolicyYear {
	double factor1 = (double)VU2025Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear > FundTermPrev2025){
		return factor3/100.00;
	}
	else{
		return (double)VU2025Factor/100.00;
	}
}

-(double)ReturnVU2025Fac :(int)aaPolicyYear andMonth:(int)aaMonth {
	double factor1 = (double)VU2025Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023) {
		return factor2/100.00;
	}
	else if (aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2025){
		return factor2/100.00;
	}
	else if (aaPolicyYear > FundTerm2025 && aaMonth > MonthDiff2025){
		return factor3/100.00;
	}
	else{
		return (double)VU2025Factor/100.00;
	}
}

-(double)ReturnVU2028Fac :(int)aaPolicyYear {
	double factor1 = (double)VU2028Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);;
	double factor4 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear > FundTermPrev2028){
		return factor4/100.00;
	}
	else{
		return (double)VU2028Factor/100.00;
	}
}

-(double)ReturnVU2028Fac :(int)aaPolicyYear andMonth:(int)aaMonth {
	double factor1 = (double)VU2028Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);;
	double factor4 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023) {
		return factor2/100.00;
	}
	else if (aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028 && aaMonth > MonthDiff2025) {
		return factor3/100.00;
	}
	else if (aaPolicyYear == FundTerm2028 && aaMonth <= MonthDiff2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear > FundTerm2028 && aaMonth > MonthDiff2028){
		return factor4/100.00;
	}
	else{
		return (double)VU2028Factor/100.00;
	}
}

-(double)ReturnVU2030Fac :(int)aaPolicyYear {
	double factor1 = (double)VU2030Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);;
	double factor4 = factor3 + (double)VU2028Factor * (factor3/[self FactorGroup:4]);;
	double factor5 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030) {
		return factor4/100.00;
	}
	else if (aaPolicyYear > FundTermPrev2030){
		return factor5/100.00;
	}
	else{
		return (double)VU2030Factor/100.00;
	}
}

-(double)ReturnVU2030Fac :(int)aaPolicyYear andMonth:(int)aaMonth {
	double factor1 = (double)VU2030Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);;
	double factor4 = factor3 + (double)VU2028Factor * (factor3/[self FactorGroup:4]);;
	double factor5 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023) {
		return factor2/100.00;
	}
	else if (aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028 && aaMonth > MonthDiff2025) {
		return factor3/100.00;
	}
	else if (aaPolicyYear == FundTerm2028 && aaMonth <= MonthDiff2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030 && aaMonth > MonthDiff2028) {
		return factor4/100.00;
	}
	else if (aaPolicyYear == FundTerm2030 && aaMonth <= MonthDiff2030) {
		return factor4/100.00;
	}
	else if (aaPolicyYear > FundTerm2030 && aaMonth > MonthDiff2030) {
		return factor5/100.00;
	}
	else{
		return (double)VU2030Factor/100.00;
	}
}

-(double)ReturnVU2035Fac :(int)aaPolicyYear {
	double factor1 = (double)VU2035Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);
	double factor4 = factor3 + (double)VU2028Factor * (factor3/[self FactorGroup:4]);
	double factor5 = factor4 + (double)VU2030Factor * (factor4/[self FactorGroup:5]);
	double factor6 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030) {
		return factor4/100.00;
	}
	else if (aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035) {
		return factor5/100.00;
	}
	else if (aaPolicyYear > FundTermPrev2035){
		return factor6/100.00;
	}
	else{
		return (double)VU2035Factor/100.00;
	}
}

-(double)ReturnVU2035Fac :(int)aaPolicyYear andMonth:(int)aaMonth   {
	double factor1 = (double)VU2035Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);
	double factor4 = factor3 + (double)VU2028Factor * (factor3/[self FactorGroup:4]);
	double factor5 = factor4 + (double)VU2030Factor * (factor4/[self FactorGroup:5]);
	double factor6 = 0.00;
	
	if(aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023 ){
		return factor2/100.00;
	}
	else if(aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2025){
		return factor2/100.00;
	}
	else if(aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028 && aaMonth > MonthDiff2025 ){
		return factor3/100.00;
	}
	else if(aaPolicyYear == FundTerm2028 && aaMonth <= MonthDiff2028){
		return factor3/100.00;
	}
	else if(aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030 && aaMonth > MonthDiff2028 ){
		return factor4/100.00;
	}
	else if(aaPolicyYear == FundTerm2030 && aaMonth <= MonthDiff2030){
		return factor4/100.00;
	}
	else if(aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035 && aaMonth > MonthDiff2030 ){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035 && aaMonth <= MonthDiff2035){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035 && aaMonth > MonthDiff2035){
		return factor6/100.00;
	}
	else{
		return (double)VU2035Factor/100.00;
	}
	
	
}


-(double)ReturnVUCashFac :(int)aaPolicyYear {
	double factor2;
	double factor3;
	double factor4;
	double factor5;
	double factor6;
	
	if(VUCashOptFactor > 0 && [self FactorGroup:2] == 0){
		factor2 = (double)VUCashOptFactor;
	}
	else{
		factor2 = (double)VUCashFactor;
	}
	
	if(VUCashOptFactor > 0 && [self FactorGroup:3] == 0){
		factor3 = (double)VUCashOptFactor;
	}
	else{
		factor3 = (double)VUCashFactor;
	}
	
	if(VUCashOptFactor > 0 && [self FactorGroup:4] == 0){
		factor4 = (double)VUCashOptFactor;
	}
	else{
		factor4 = (double)VUCashFactor;
	}
	
	if(VUCashOptFactor > 0 && [self FactorGroup:5] == 0){
		factor5 = (double)VUCashOptFactor;
	}
	else{
		factor5 = (double)VUCashFactor;
	}
	
	if(VUCashOptFactor > 0 && [self FactorGroup:6] == 0){
		factor6 = (double)VUCashOptFactor;
	}
	else{
		factor6 = (double)VUCashFactor;
	}
	
	
	if(aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025){
		return factor2/100.00;
	}
	else if(aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028){
		return factor3/100.00;
	}
	else if(aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030){
		return factor4/100.00;
	}
	else if(aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035){
		return factor6/100.00;
	}
	else{
		return (double)VUCashFactor/100.00;
	}
	
}

-(double)ReturnVUCashFac :(int)aaPolicyYear andMonth:(int)aaMonth  {
	double factor2;
	double factor3;
	double factor4;
	double factor5;
	double factor6;
	
	if(VUCashOptFactor > 0 && [self FactorGroup:2] == 0){
		factor2 = (double)VUCashOptFactor;
	}
	else{
		factor2 = (double)VUCashFactor;
	}
	
	if(VUCashOptFactor > 0 && [self FactorGroup:3] == 0){
		factor3 = (double)VUCashOptFactor;
	}
	else{
		factor3 = (double)VUCashFactor;
	}
	
	if(VUCashOptFactor > 0 && [self FactorGroup:4] == 0){
		factor4 = (double)VUCashOptFactor;
	}
	else{
		factor4 = (double)VUCashFactor;
	}
	
	if(VUCashOptFactor > 0 && [self FactorGroup:5] == 0){
		factor5 = (double)VUCashOptFactor;
	}
	else{
		factor5 = (double)VUCashFactor;
	}
	
	if(VUCashOptFactor > 0 && [self FactorGroup:6] == 0){
		factor6 = (double)VUCashOptFactor;
	}
	else{
		factor6 = (double)VUCashFactor;
	}
	
	if(aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023 ){
		return factor2/100.00;
	}
	else if(aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2023){
		return factor2/100.00;
	}
	else if(aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028 && aaMonth > MonthDiff2025 ){
		return factor3/100.00;
	}
	else if(aaPolicyYear == FundTerm2028 && aaMonth <= MonthDiff2028){
		return factor3/100.00;
	}
	else if(aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030 && aaMonth > MonthDiff2028 ){
		return factor4/100.00;
	}
	else if(aaPolicyYear == FundTerm2030 && aaMonth <= MonthDiff2030){
		return factor4/100.00;
	}
	else if(aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035 && aaMonth > MonthDiff2030 ){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035 && aaMonth <= MonthDiff2035){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035 && aaMonth > MonthDiff2035){
		return factor6/100.00;
	}
	else{
		return (double)VUCashFactor/100.00;
	}
	
}

-(double)ReturnVURetFac :(int)aaPolicyYear {
	double factor1;
	double factor2;
	double factor3;
	double factor4;
	double factor5;
	double factor6;
	
	if (VURetFactor > 0) {
		factor1 =(double)VURetFactor;
		factor2 = factor1 + (double)VU2023Factor * (double)(factor1/[self FactorGroup:2]);
		factor3 = factor2 + (double)VU2025Factor * (double)(factor2/[self FactorGroup:3]);
		factor4 = factor3 + (double)VU2028Factor * (double)(factor3/[self FactorGroup:4]);
		factor5 = factor4 + (double)VU2030Factor * (double)(factor4/[self FactorGroup:5]);
		factor6 = factor5 + (double)VU2035Factor * (double)(factor5/[self FactorGroup:6]);
	}
	else if (VURetOptFactor > 0){
		if ([self FactorGroup:2] == 0) {
			factor2 = (double)VURetOptFactor;
		}
		else{
			factor2 = 0.00;
		}
		
		if ([self FactorGroup:3] == 0) {
			factor3 = (double)VURetOptFactor;
		}
		else{
			factor3 = 0.00;
		}
		
		if ([self FactorGroup:4] == 0) {
			factor4 = (double)VURetOptFactor;
		}
		else{
			factor4 = 0.00;
		}
		
		if ([self FactorGroup:5] == 0) {
			factor5 = (double)VURetOptFactor;
		}
		else{
			factor5 = 0.00;
		}
		
		if ([self FactorGroup:6] == 0) {
			factor6 = (double)VURetOptFactor;
		}
		else{
			factor6 = 0.00;
		}
	}
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030) {
		return factor4/100.00;
	}
	else if (aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035) {
		return factor5/100.00;
	}
	else if (aaPolicyYear > FundTermPrev2035) {
		return factor6/100.00;
	}
	else{
		return (double)VURetFactor/100.00;
	}
}

-(double)ReturnVURetFac :(int)aaPolicyYear andMonth:(int) aaMonth {
	double factor1 = 0.00;
	double factor2 = 0.00;
	double factor3 = 0.00;
	double factor4 = 0.00;
	double factor5 = 0.00;
	double factor6 = 0.00;
	
	if (VURetFactor > 0) {
		factor1 =(double)VURetFactor;
		factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
		factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);
		factor4 = factor3 + (double)VU2028Factor * (factor3/[self FactorGroup:4]);
		factor5 = factor4 + (double)VU2030Factor * (factor4/[self FactorGroup:5]);
		factor6 = factor5 + (double)VU2035Factor * (factor5/[self FactorGroup:6]);
	}
	else if (VURetOptFactor > 0){
		if ([self FactorGroup:2] == 0) {
			factor2 = (double)VURetOptFactor;
		}
		else{
			factor2 = 0.00;
		}
		
		if ([self FactorGroup:3] == 0) {
			factor3 = (double)VURetOptFactor;
		}
		else{
			factor3 = 0.00;
		}
		
		if ([self FactorGroup:4] == 0) {
			factor4 = (double)VURetOptFactor;
		}
		else{
			factor4 = 0.00;
		}
		
		if ([self FactorGroup:5] == 0) {
			factor5 = (double)VURetOptFactor;
		}
		else{
			factor5 = 0.00;
		}
		
		if ([self FactorGroup:6] == 0) {
			factor6 = (double)VURetOptFactor;
		}
		else{
			factor6 = 0.00;
		}
	}
	
	if(aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023 ){
		return factor2/100.00;
	}
	else if(aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2023){
		return factor2/100.00;
	}
	else if(aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028 && aaMonth > MonthDiff2025 ){
		return factor3/100.00;
	}
	else if(aaPolicyYear == FundTerm2028 && aaMonth <= MonthDiff2028){
		return factor3/100.00;
	}
	else if(aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030 && aaMonth > MonthDiff2028 ){
		return factor4/100.00;
	}
	else if(aaPolicyYear == FundTerm2030 && aaMonth <= MonthDiff2030){
		return factor4/100.00;
	}
	else if(aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035 && aaMonth > MonthDiff2030 ){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035 && aaMonth <= MonthDiff2035){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035 && aaMonth > MonthDiff2035){
		return factor6/100.00;
	}
	else{
		return (double)VURetFactor/100.00;
	}
}

-(double)ReturnVUDanaFac :(int)aaPolicyYear {
	double factor1 = 0.00;
	double factor2 = 0.00;
	double factor3 = 0.00;
	double factor4 = 0.00;
	double factor5 = 0.00;
	double factor6 = 0.00;
	
	if (VUDanaFactor > 0) {
		factor1 =(double)VUDanaFactor;
		factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
		factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);
		factor4 = factor3 + (double)VU2028Factor * (factor3/[self FactorGroup:4]);
		factor5 = factor4 + (double)VU2030Factor * (factor4/[self FactorGroup:5]);
		factor6 = factor5 + (double)VU2035Factor * (factor5/[self FactorGroup:6]);
	}
	else if (VUDanaOptFactor > 0){
		if ([self FactorGroup:2] == 0) {
			factor2 = (double)VUDanaOptFactor;
		}
		else{
			factor2 = 0.00;
		}
		
		if ([self FactorGroup:3] == 0) {
			factor3 = (double)VUDanaOptFactor;
		}
		else{
			factor3 = 0.00;
		}
		
		if ([self FactorGroup:4] == 0) {
			factor4 = (double)VUDanaOptFactor;
		}
		else{
			factor4 = 0.00;
		}
		
		if ([self FactorGroup:5] == 0) {
			factor5 = (double)VUDanaOptFactor;
		}
		else{
			factor5 = 0.00;
		}
		
		if ([self FactorGroup:6] == 0) {
			factor6 = (double)VUDanaOptFactor;
		}
		else{
			factor6 = 0.00;
		}
	}
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030) {
		return factor4/100.00;
	}
	else if (aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035) {
		return factor5/100.00;
	}
	else if (aaPolicyYear > FundTermPrev2035) {

		double temp = factor6/100.00;
		return temp;
	}
	else{
		return (double)VUDanaFactor/100.00;
	}
}

-(double)ReturnVUDanaFac :(int)aaPolicyYear andMonth:(int) aaMonth {
	double factor1;
	double factor2;
	double factor3;
	double factor4;
	double factor5;
	double factor6;
	
	if (VUDanaFactor > 0) {
		factor1 =(double)VUDanaFactor;
		factor2 = factor1 + (double)VU2023Factor * (double)(factor1/[self FactorGroup:2]);
		factor3 = factor2 + (double)VU2025Factor * (double)(factor2/[self FactorGroup:3]);
		factor4 = factor3 + (double)VU2028Factor * (double)(factor3/[self FactorGroup:4]);
		factor5 = factor4 + (double)VU2030Factor * (double)(factor4/[self FactorGroup:5]);
		factor6 = factor5 + (double)VU2035Factor * (double)(factor5/[self FactorGroup:6]);
	}
	else if (VUDanaOptFactor > 0){
		if ([self FactorGroup:2] == 0) {
			factor2 = (double)VUDanaOptFactor;
		}
		else{
			factor2 = 0.00;
		}
		
		if ([self FactorGroup:3] == 0) {
			factor3 = (double)VUDanaOptFactor;
		}
		else{
			factor3 = 0.00;
		}
		
		if ([self FactorGroup:4] == 0) {
			factor4 = (double)VUDanaOptFactor;
		}
		else{
			factor4 = 0.00;
		}
		
		if ([self FactorGroup:5] == 0) {
			factor5 = (double)VUDanaOptFactor;
		}
		else{
			factor5 = 0.00;
		}
		
		if ([self FactorGroup:6] == 0) {
			factor6 = (double)VUDanaOptFactor;
		}
		else{
			factor6 = 0.00;
		}
	}
	else{
		return 0.00;
	}
	
	if(aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023 ){
		return factor2/100.00;
	}
	else if(aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2023){
		return factor2/100.00;
	}
	else if(aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028 && aaMonth > MonthDiff2025 ){
		return factor3/100.00;
	}
	else if(aaPolicyYear == FundTerm2028 && aaMonth <= MonthDiff2028){
		return factor3/100.00;
	}
	else if(aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030 && aaMonth > MonthDiff2028 ){
		return factor4/100.00;
	}
	else if(aaPolicyYear == FundTerm2030 && aaMonth <= MonthDiff2030){
		return factor4/100.00;
	}
	else if(aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035 && aaMonth > MonthDiff2030 ){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035 && aaMonth <= MonthDiff2035){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035 && aaMonth > MonthDiff2035){
		return factor6/100.00;
	}
	else{
		return (double)VUDanaFactor/100.00;
	}
}



-(double)FactorGroup : (uint)aaGroup{
	if (aaGroup == 1) {
		return VU2023Factor + VU2025Factor + VU2028Factor + VU2030Factor + VU2035Factor + VURetFactor + VUDanaFactor;
	}
	else if (aaGroup == 2) {
		return VU2025Factor + VU2028Factor + VU2030Factor + VU2035Factor + VURetFactor + VUDanaFactor;
	}
	else if (aaGroup == 3) {
		return VU2028Factor + VU2030Factor + VU2035Factor + VURetFactor + VUDanaFactor;
	}
	else if (aaGroup == 4) {
		return VU2030Factor + VU2035Factor + VURetFactor + VUDanaFactor;
	}
	else if (aaGroup == 5) {
		return VU2035Factor + VURetFactor + VUDanaFactor;
	}
	else {
		return VURetFactor + VUDanaFactor;
	}
}

-(double)ReturnTotalBasicMortHigh: (int)aaPolicyYear{
	double tempBasicMort = ([self ReturnBasicMort:(Age + aaPolicyYear -1)]/1000.00);
	double tempTotalBasicMortHigh = [strBasicSA doubleValue ] * (tempBasicMort * (1 + [getHLPct doubleValue ]/100.00) +
											   [getHL doubleValue]/1000.00 + [getOccLoading doubleValue ]/1000.00)/12.00;
	return tempTotalBasicMortHigh;
}

-(double)ReturnTotalBasicMortMedian: (int)aaPolicyYear{
	return [strBasicSA doubleValue ] * (([self ReturnBasicMort:Age + aaPolicyYear -1]/1000.00) * (1 + [getHLPct doubleValue ]/100.00) +
											 [getHL doubleValue]/1000.00 + [getOccLoading doubleValue ]/1000.00)/12.00;
}

-(double)ReturnTotalBasicMortLow: (int)aaPolicyYear{
	return [strBasicSA doubleValue ] * (([self ReturnBasicMort:Age + aaPolicyYear -1]/1000.00) * (1 + [getHLPct doubleValue ]/100.00) +
											 [getHL doubleValue]/1000.00 + [getOccLoading doubleValue ]/1000.00)/12.00;
}

-(double)ReturnTotalRiderMort: (int)aaPolicyYear{
	double tempTotal = 0.00;
	sqlite3_stmt *statement;
	NSString *QuerySQL;
	NSMutableArray *UnitizeRiderAlloc = [[NSMutableArray alloc] init ];
	NSMutableArray *UnitizeRiderMort = [[NSMutableArray alloc] init ];
	/*
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		QuerySQL = [NSString stringWithFormat: @"Select ridercode, SumAssured, ifnull(Hloading, '0') as Hloading, ifnull(HLoadingPct, '0') as HLoadingPct, "
					"RiderTerm, planOption, Deductible from ul_rider_details Where  "
					"  sino = '%@' AND ridercode in ('CIRD', 'DCA', 'ACIR', 'HMM', 'MG_IV', "
					"'WI', 'MR', 'TPDMLA', 'PA', 'DHI')", SINo];
		
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
				[UnitizeRiderCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
				[UnitizeRiderSA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
				[UnitizeRiderHL addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]];
				[UnitizeRiderHLPct addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)]];
				[UnitizeRiderTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)]];
				[UnitizeRiderPlanChoice addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)]];
				[UnitizeRiderDeductible addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)]];
				//NSLog(@"10- 1 ok");
			}
            sqlite3_finalize(statement);
        }
		
		sqlite3_close(contactDB);
	}
	*/
	if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){

		for (int i = 0; i < UnitizeRiderCode.count; i++) {
			if ([[UnitizeRiderCode objectAtIndex:i] isEqualToString:@"ACIR"]) {
				QuerySQL = [NSString stringWithFormat: @"select Rate from ES_Sys_Rider_Mort where plancode = '%@' AND sex = '%@' AND fromage='%d' AND smoker = '%@' ",
							[UnitizeRiderCode objectAtIndex:i] ,getSexLA, Age + aaPolicyYear - 1, getSmokerLA];
			}
			else if ([[UnitizeRiderCode objectAtIndex:i] isEqualToString:@"CIRD"]){
				QuerySQL = [NSString stringWithFormat: @"select Rate from ES_Sys_Rider_Mort where plancode = '%@' AND sex = '%@' AND fromage='%d' AND PolYear = '%d' AND Term = '%@' ",
							[UnitizeRiderCode objectAtIndex:i], getSexLA, Age + aaPolicyYear - 1, aaPolicyYear, [UnitizeRiderTerm objectAtIndex:i] ];
			}
			else if ([[UnitizeRiderCode objectAtIndex:i] isEqualToString:@"WI"] ||
					 [[UnitizeRiderCode objectAtIndex:i] isEqualToString:@"PA"] ||
					 [[UnitizeRiderCode objectAtIndex:i] isEqualToString:@"MR"] ||
					 [[UnitizeRiderCode objectAtIndex:i] isEqualToString:@"TPDMLA"] ||
					 [[UnitizeRiderCode objectAtIndex:i] isEqualToString:@"DHI"] ||
					 [[UnitizeRiderCode objectAtIndex:i] isEqualToString:@"DCA"]){
				
				QuerySQL = [NSString stringWithFormat: @"select Rate from ES_Sys_Rider_Mort where plancode = '%@' AND sex = '%@' AND fromage='%d' AND  OccClass= '%d' ",
							[UnitizeRiderCode objectAtIndex:i], getSexLA, Age + aaPolicyYear - 1, getOccpClass ];
			}
			else if ([[UnitizeRiderCode objectAtIndex:i] isEqualToString:@"HMM"]){
				NSString *ccc;
				if ([[UnitizeRiderPlanChoice objectAtIndex:i] isEqualToString:@"HMM_150"]) {
					ccc = @"MM150";
				}
				else if ([[UnitizeRiderPlanChoice objectAtIndex:i] isEqualToString:@"HMM_200"]) {
					ccc = @"MM200";
				}
				else if ([[UnitizeRiderPlanChoice objectAtIndex:i] isEqualToString:@"HMM_300"]) {
					ccc = @"MM300";
				}
				else if ([[UnitizeRiderPlanChoice objectAtIndex:i] isEqualToString:@"HMM_400"]) {
					ccc = @"MM400";
				}
				
				QuerySQL = [NSString stringWithFormat: @"select Rate from ES_Sys_Rider_Mort where plancode = '%@' AND sex = '%@' AND fromage='%d' AND  OccClass= '%d' "
							"AND Type = '%@' AND Deductible = '%@'",
							[UnitizeRiderCode objectAtIndex:i], getSexLA, Age + aaPolicyYear - 1, getOccpClass, ccc, [UnitizeRiderDeductible objectAtIndex:i] ];
			}
			else if ([[UnitizeRiderCode objectAtIndex:i] isEqualToString:@"MG_IV"]){
				NSString *ccc;
				if ([[UnitizeRiderPlanChoice objectAtIndex:i] isEqualToString:@"MGIVP_150"]) {
					ccc = @"MGIV_150";
				}
				else if ([[UnitizeRiderPlanChoice objectAtIndex:i] isEqualToString:@"MGIVP_200"]) {
					ccc = @"MGIV_200";
				}
				else if ([[UnitizeRiderPlanChoice objectAtIndex:i] isEqualToString:@"MGIVP_300"]) {
					ccc = @"MGIV_300";
				}
				else if ([[UnitizeRiderPlanChoice objectAtIndex:i] isEqualToString:@"MGIVP_400"]) {
					ccc = @"MGIV_400";
				}
				
				
				QuerySQL = [NSString stringWithFormat: @"select Rate from ES_Sys_Rider_Mort where plancode = '%@' AND sex = '%@' AND fromage='%d' AND  OccClass= '%d' "
							"AND Type = '%@'",
							[UnitizeRiderCode objectAtIndex:i], getSexLA, Age + aaPolicyYear - 1, getOccpClass, ccc];
			}
			
			
			//NSLog(@"%@", QuerySQL);
			if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
				if (sqlite3_step(statement) == SQLITE_ROW) {
					[UnitizeRiderMort addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
						//NSLog(@"10- 2 ok");
				}
				else{
					[UnitizeRiderMort addObject:@"0.00"];
				}
				sqlite3_finalize(statement);
			}
			else{
				[UnitizeRiderMort addObject:@"0.00"];
			}
			
			QuerySQL = [NSString stringWithFormat: @"select Rate from ES_Sys_Rider_Allocation where Term = '%@' AND PolYear = '%d'",
						[UnitizeRiderTerm objectAtIndex:i], aaPolicyYear];
				
				//NSLog(@"%@", QuerySQL);
			if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
				if (sqlite3_step(statement) == SQLITE_ROW) {
					[UnitizeRiderAlloc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
					
				}
				else{
					[UnitizeRiderAlloc addObject:@"0.00"];
				}
				sqlite3_finalize(statement);
			}
			else{
				[UnitizeRiderAlloc addObject:@"0.00"];
			}
			
		}
		sqlite3_close(contactDB);

	}

	for (int i = 0; i < [UnitizeRiderCode count]; i++) {

		NSString *RidercodeFromArray = [UnitizeRiderCode objectAtIndex:i];
		double SAFromArray = [[UnitizeRiderSA objectAtIndex:i] doubleValue ];
		double HLFromArray = [[UnitizeRiderHL objectAtIndex:i] doubleValue ];
		double  HLPctFromArray = [[UnitizeRiderHLPct objectAtIndex:i] doubleValue ];
		double  RiderMortFromArray = [[UnitizeRiderMort objectAtIndex:i] doubleValue ];
		double RiderAllocFromArray = [[UnitizeRiderAlloc objectAtIndex:i]doubleValue ]/100.00;
		double tempOccloading = 0.00;
		
		if ([self ISRiderOccLoading:RidercodeFromArray] == FALSE ) {
			tempOccloading = 0.00;
		}
		else{
			tempOccloading = [getOccLoading doubleValue];
		}
		
		//NSLog(@"%d, %@, %f, %f, %f, %f, %f", aaPolicyYear,  RidercodeFromArray, SAFromArray, HLFromArray, HLPctFromArray, RiderMortFromArray, RiderAllocFromArray);
		if ([RidercodeFromArray isEqualToString:@"CIRD"] || [RidercodeFromArray isEqualToString:@"ACIR" ] ) {
			//tempTotal = tempTotal +  (SAFromArray * (RiderMortFromArray/1000.00) * (1.00 + HLPctFromArray/100.00) + HLFromArray + SAFromArray * [getOccLoading doubleValue]/1000.00)/12.00 * RiderAllocFromArray;
			tempTotal = tempTotal +  (SAFromArray * (RiderMortFromArray/1000.00) * (1.00 + HLPctFromArray/100.00)  + SAFromArray * (tempOccloading + HLFromArray)/1000.00)/12.00 * RiderAllocFromArray;
			if ([RidercodeFromArray isEqualToString:@"CIRD"]) {
				CIRDExist = TRUE;
			}

		}
		else if ([RidercodeFromArray isEqualToString:@"WI"] || [RidercodeFromArray isEqualToString:@"PA" ] ||
				 [RidercodeFromArray isEqualToString:@"PA"] || [RidercodeFromArray isEqualToString:@"MR" ] ||
				 [RidercodeFromArray isEqualToString:@"TPDMLA"] || [RidercodeFromArray isEqualToString:@"DCA" ]) {
			
			//tempTotal = tempTotal +  (SAFromArray * (RiderMortFromArray/100.00) * RiderAllocFromArray * (1 + HLPctFromArray/100.00) + HLFromArray + SAFromArray * [getOccLoading doubleValue ]/1000.00)/12.00;
			tempTotal = tempTotal +  (SAFromArray * (RiderMortFromArray/100.00)  * (1 + HLPctFromArray/100.00) + SAFromArray * (tempOccloading + HLFromArray)/1000.00)/12.00 * RiderAllocFromArray;
		}
		else if ([RidercodeFromArray isEqualToString:@"DCA"]) {
			//tempTotal = tempTotal +  ((10000.00 + SAFromArray) * (RiderMortFromArray/100.00) * RiderAllocFromArray * (1 + HLPctFromArray/100.00) + HLFromArray + (10000.00 + SAFromArray) * [getOccLoading doubleValue ]/1000.00)/12;
			tempTotal = tempTotal +  ((10000.00 + SAFromArray) * (RiderMortFromArray/100.00)  * (1 + HLPctFromArray/100.00) + (10000.00 + SAFromArray) * (tempOccloading + HLFromArray)/1000.00)/12 * RiderAllocFromArray;
		}
		else if ([RidercodeFromArray isEqualToString:@"HMM"] || [RidercodeFromArray isEqualToString:@"MG_IV"] ) {
			tempTotal = tempTotal +  (RiderMortFromArray * (1 + HLPctFromArray/100.00) + SAFromArray * (tempOccloading + HLFromArray)/1000.00)/12.00 * RiderAllocFromArray;
		}
		
	}

	return tempTotal;
}

-(BOOL)ISRiderOccLoading : (NSString *)aaRiderCode{
	if ([aaRiderCode isEqualToString:@"CIWP"] || [aaRiderCode isEqualToString:@"HMM"] || [aaRiderCode isEqualToString:@"MG_IV"] || [aaRiderCode isEqualToString:@"ACIR"] ||
		[aaRiderCode isEqualToString:@"DHI"] || [aaRiderCode isEqualToString:@"TPDMLA"] || [aaRiderCode isEqualToString:@"MR"] || [aaRiderCode isEqualToString:@"PA"] ||
		[aaRiderCode isEqualToString:@"WI"] || [aaRiderCode isEqualToString:@"DCA"]) {
		return FALSE;
	}
	else{
		return TRUE;
	}
}

-(double)ReturnRiderPolicyFee: (int)aaPolicyYear{
	//sqlite3_stmt *statement;
	//NSString *QuerySQL;

	/*
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		QuerySQL = [NSString stringWithFormat: @"Select * From UL_Rider_Details Where sino = '%@' AND ridercode in ('CIRD')", SINo];
		
		//NSLog(@"%@", QuerySQL);
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
				cird
			}
            sqlite3_finalize(statement);
        }
		
		sqlite3_close(contactDB);
	}
	 */
	if (CIRDExist == TRUE) {
		if (aaPolicyYear <= 10) {
			return 3.00;
		}
		else{
			return 0.00;
		}
	}
	else{
		return 0.00;
	}
}

-(double)ReturnBasicCommisionFee: (int)aaPolicyYear{
	sqlite3_stmt *statement;
	NSString *QuerySQL;
	double value = 0.00;
	
	 if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
		 QuerySQL = [NSString stringWithFormat: @"Select Rate From ES_Sys_Basic_Commission Where Year = %d", aaPolicyYear];
	 
		 //NSLog(@"%@", QuerySQL);
		 if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			 if (sqlite3_step(statement) == SQLITE_ROW) {
				 value = sqlite3_column_double(statement, 0);
			 }
			 else{
				 value = 0.00;
			 }
			 sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	 }

	
	return value;
}

-(double)ReturnRiderCommisionFee: (int)aaPolicyYear{
	sqlite3_stmt *statement;
	NSString *QuerySQL;
	double value = 0.00;
	double TotalValue = 0.00;
	
	if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
		for (int i =0; i < [UnitizeRiderCode count]; i++) {
			QuerySQL = [NSString stringWithFormat: @"Select Rate From ES_Sys_Rider_Commission Where PolYear = %d AND RiderTerm = '%@' ",
						aaPolicyYear, [UnitizeRiderTerm objectAtIndex:i]];
			
			//NSLog(@"%@", QuerySQL);
			if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
				if (sqlite3_step(statement) == SQLITE_ROW) {
					value = sqlite3_column_double(statement, 0);
				}
				else{
					value = 0.00;
				}
				sqlite3_finalize(statement);
			}
			
			TotalValue = TotalValue + ([[UnitizeRiderPremium objectAtIndex:i] doubleValue ] * value)/100.00;
		}
		
		sqlite3_close(contactDB);
	}
	
	
	return TotalValue;
}



-(double)ReturnVUCashHigh{
	double VUCashHighS = pow((1.00 + [self ReturnVUCashInstHigh:@""]), 1.00/12.00) - 1.00 ;
	
	return (pow((1.00 + VUCashHighS), 12.00) - 1.00)/(VUCashHighS / (1.00 + VUCashHighS));
}

-(double)ReturnVUCashMedian{
	double VUCashMedianS = pow((1.00 + [self ReturnVUCashInstMedian:@""]), 1.00/12.00) - 1.00 ;
	
	return (pow((1.00 + VUCashMedianS), 12.00) - 1.00)/(VUCashMedianS / (1.00 + VUCashMedianS));
}

-(double)ReturnVUCashLow{
	double VUCashLowS = pow((1.00 + [self ReturnVUCashInstLow:@""]), 1.00/12.00) - 1.00 ;
	
	return (pow((1.00 + VUCashLowS), 12) - 1)/(VUCashLowS / (1.00 + VUCashLowS));
}

-(double)ReturnVU2023InstHigh: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0532298;
	}
	else{
		return 0.00;
	}
}

-(double)ReturnVU2025InstHigh: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0588615;
	}
	else{
		return 0.00;
	}
}

-(double)ReturnVU2028InstHigh: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0739896;
	}
	else{
		return 0.00;
	}
}

-(double)ReturnVU2030InstHigh: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.077761;
	}
	else{
		return 0.00;
	}
}

-(double)ReturnVU2035InstHigh: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0817997;
	}
	else{
		return 0.00;
	}
}

-(double)ReturnVU2023InstMedian: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0290813;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2025InstMedian: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0340098;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2028InstMedian: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0389747;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2030InstMedian: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0413285;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2035InstMedian: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0439735;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2023InstLow: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0113432;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2025InstLow: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.01146;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2028InstLow: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0121202;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2030InstLow: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0121884;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2035InstLow: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0122828;
	}
	else{
		return 0;
	}
}

-(void)CalcInst: (NSString *)aaMOP{
	sqlite3_stmt *statement;
	NSString *querySQL;
	NSString *MOP;
	
	if ([aaMOP isEqualToString:@""]) {
		MOP = strBumpMode;
	} else {
		MOP = aaMOP;
	}
	
	if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2023InstHigh = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2023InstMedian = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2023InstLow = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		//------------
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2025InstHigh = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2025InstMedian = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2025InstLow = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		//-----------
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2028InstHigh = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2028InstMedian = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2028InstLow = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		//--------
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2030InstHigh = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2030InstMedian = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2030InstLow = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		// ----------
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2035InstHigh = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2035InstMedian = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2035InstLow = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
}

-(double)ReturnVUCashInstHigh :(NSString *)aaMOP{
	
	NSString *MOP;
	if ([aaMOP isEqualToString:@""]) {
		MOP = strBumpMode;
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		return 0.0251;
	}
	else if ([MOP isEqualToString:@"S"]) {
		return 0.0187861;
	}
	else if ([MOP isEqualToString:@"Q"]) {
		return 0.0156389;
	}
	else {
		return 0.0135443;
	}
}

-(double)ReturnVUCashInstMedian :(NSString *)aaMOP{
	NSString *MOP;
	if ([aaMOP isEqualToString:@""]) {
		MOP = strBumpMode;
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		return 0.0228;
	}
	else if ([MOP isEqualToString:@"S"]) {
		return 0.0170679;
	}
	else if ([MOP isEqualToString:@"Q"]) {
		return 0.0142098;
	}
	else {
		return 0.0123075;
	}
}

-(double)ReturnVUCashInstLow :(NSString *)aaMOP{
	NSString *MOP;
	if ([aaMOP isEqualToString:@""]) {
		MOP = strBumpMode;
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		return 0.0205;
	}
	else if ([MOP isEqualToString:@"S"]) {
		return 0.015349;
	}
	else if ([MOP isEqualToString:@"Q"]) {
		return 0.01278;
	}
	else {
		return 0.0110697;
	}
}

-(double)ReturnVURetInstHigh :(int)aaPolicyYear  andMOP:(NSString *)aaMOP{
	NSString *MOP = strBumpMode;
	
	if ([aaMOP isEqualToString:@""]) {
		MOP = strBumpMode;
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		if (aaPolicyYear <= 20) {
			return 0.05808;
		}
		else{
			return 0.03784;
		}
	}
	else if ([MOP isEqualToString:@"S"]) {
		if (aaPolicyYear <= 20) {
			return 0.0433551;
		}
		else{
			return 0.0282922;
		}
	}
	else if ([MOP isEqualToString:@"Q"]) {
		if (aaPolicyYear <= 20) {
			return 0.0360438;
		}
		else{
			return 0.0235402;
		}
	}
	else {
		if (aaPolicyYear <= 20) {
			return 0.0311887;
		}
		else{
			return 0.0203804;
		}
	}
}

-(double)ReturnVURetInstMedian :(NSString *)aaMOP{
	
	NSString *MOP = strBumpMode;
	
	if ([aaMOP isEqualToString:@""]) {
		MOP = strBumpMode;
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		return 0.03324;
	}
	else if ([MOP isEqualToString:@"S"]) {
		return 0.0248621;
	}
	else if ([MOP isEqualToString:@"Q"]) {
		return 0.0206901;
	}
	else {
		return 0.0179151;
	}
}

-(double)ReturnVURetInstLow :(NSString *)aaMOP{
	
	NSString *MOP = strBumpMode;
	
	if ([aaMOP isEqualToString:@""]) {
		MOP = strBumpMode;
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		return 0.02312;
	}
	else if ([MOP isEqualToString:@"S"]) {
		return 0.017307;
	}
	else if ([MOP isEqualToString:@"Q"]) {
		return 0.0144087;
	}
	else {
		return 0.0124796;
	}
}

-(double)ReturnVUDanaInstHigh :(int)aaPolicyYear  andMOP:(NSString *)aaMOP{
	NSString *MOP = strBumpMode;
	
	if ([aaMOP isEqualToString:@""]) {
		MOP = strBumpMode;
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		if (aaPolicyYear <= 20) {
			return 0.0606;
		}
		else{
			return 0.0376;
		}
	}
	else if ([MOP isEqualToString:@"S"]) {
		if (aaPolicyYear <= 20) {
			return 0.0452272;
		}
		else{
			return 0.0281133;
		}
	}
	else if ([MOP isEqualToString:@"Q"]) {
		if (aaPolicyYear <= 20) {
			return 0.0375965;
		}
		else{
			return 0.0233916;
		}
	}
	else {
		if (aaPolicyYear <= 20) {
			return 0.03253;
		}
		else{
			return 0.0202518;
		}
	}
}

-(double)ReturnVUDanaInstMedian :(NSString *)aaMOP{
	
	NSString *MOP = strBumpMode;
	
	if ([aaMOP isEqualToString:@""]) {
		MOP = strBumpMode;
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		return 0.0376;
	}
	else if ([MOP isEqualToString:@"S"]) {
		return 0.0281133;
	}
	else if ([MOP isEqualToString:@"Q"]) {
		return 0.0233916;
	}
	else {
		return 0.0202518;
	}
}

-(double)ReturnVUDanaInstLow :(NSString *)aaMOP{
	NSString *MOP = strBumpMode;
	
	if ([aaMOP isEqualToString:@""]) {
		MOP = strBumpMode;
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		return 0.0146;
	}
	else if ([MOP isEqualToString:@"S"]) {
		return 0.0109368;
	}
	else if ([MOP isEqualToString:@"Q"]) {
		return 0.0091085;
	}
	else {
		return 0.0078908;
	}
}


-(double)ReturnLoyaltyBonus :(int)aaPolicyYear{
	if (aaPolicyYear == 7) {
		return 0.04;
	}
	else if (aaPolicyYear == 8){
		return 0.08;
	}
	else if (aaPolicyYear == 9){
		return 0.12;
	}
	else if (aaPolicyYear == 10){
		return 0.16;
	}
	else if (aaPolicyYear > 10){
		return 0.2;
	}
	else{
		return 0;
	}
}

-(int)ReturnLoyaltyBonusFactor: (int)aaMonth{
	if (aaMonth == 1) {
		return 1;
	}
	else{
		return 0;
	}
}

-(double)ReturnPremiumFactor: (int)aaMonth{
	NSString *MOP = strBumpMode;
	
	if ([MOP isEqualToString:@"A" ]) {
		if (aaMonth == 1) {
			return 1.00;
		}
		else{
			return 0;
		}
	}
	else if([MOP isEqualToString:@"S" ]) {
		if (aaMonth == 1 || aaMonth == 7 ) {
			return 0.5;
		}
		else{
			return 0;
		}
	}
	else if([MOP isEqualToString:@"Q" ]) {
		if (aaMonth == 1 || aaMonth == 4 || aaMonth == 7 || aaMonth == 10 ) {
			return 0.25;
		}
		else{
			return 0;
		}
	}
	else {
		return 1.00/12.00;
	}
	
}

-(void)CalcYearDiff{
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2023"];
	NSDate* d3 = [df dateFromString:@"26/12/2025"];
	NSDate* d4 = [df dateFromString:@"26/12/2028"];
	NSDate* d5 = [df dateFromString:@"26/12/2030"];
	NSDate* d6 = [df dateFromString:@"26/12/2035"];
	NSDate *fromDate;
    NSDate *toDate2;
	NSDate *toDate3;
	NSDate *toDate4;
	NSDate *toDate5;
	NSDate *toDate6;
	
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
				 interval:NULL forDate:d];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate2
				 interval:NULL forDate:d2];
	[calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate3
				 interval:NULL forDate:d3];
	[calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate4
				 interval:NULL forDate:d4];
	[calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate5
				 interval:NULL forDate:d5];
	[calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate6
				 interval:NULL forDate:d6];
	
    NSDateComponents *difference2 = [calendar components:NSDayCalendarUnit
												fromDate:fromDate toDate:toDate2 options:0];
    NSDateComponents *difference3 = [calendar components:NSDayCalendarUnit
												fromDate:fromDate toDate:toDate3 options:0];
    NSDateComponents *difference4 = [calendar components:NSDayCalendarUnit
												fromDate:fromDate toDate:toDate4 options:0];
    NSDateComponents *difference5 = [calendar components:NSDayCalendarUnit
												fromDate:fromDate toDate:toDate5 options:0];
    NSDateComponents *difference6 = [calendar components:NSDayCalendarUnit
												fromDate:fromDate toDate:toDate6 options:0];
	
	
	NSString *round2 = [NSString stringWithFormat:@"%.2f", [difference2 day]/365.25];
	NSString *round3 = [NSString stringWithFormat:@"%.2f", [difference3 day]/365.25];
	NSString *round4 = [NSString stringWithFormat:@"%.2f", [difference4 day]/365.25];
	NSString *round5 = [NSString stringWithFormat:@"%.2f", [difference5 day]/365.25];
	NSString *round6 = [NSString stringWithFormat:@"%.2f", [difference6 day]/365.25];
	
	
	//YearDiff2023 = round([round2 doubleValue]);
	//YearDiff2025 = round([round3 doubleValue]);
	//YearDiff2028 = round([round4 doubleValue]);
	//YearDiff2030 = round([round5 doubleValue]);
	//YearDiff2035 = round([round6 doubleValue]);
	
	YearDiff2023 = ceil([round2 doubleValue]);
	YearDiff2025 = ceil([round3 doubleValue]);
	YearDiff2028 = ceil([round4 doubleValue]);
	YearDiff2030 = ceil([round5 doubleValue]);
	YearDiff2035 = ceil([round6 doubleValue]);
	
	FundTermPrev2023 = YearDiff2023 - 1;
	FundTerm2023 = YearDiff2023;
	FundTermPrev2025 = YearDiff2025 - 1;
	FundTerm2025 = YearDiff2025;
	FundTermPrev2028 = YearDiff2028 - 1;
	FundTerm2028 = YearDiff2028;
	FundTermPrev2030 = YearDiff2030 - 1;
	FundTerm2030 = YearDiff2030;
	FundTermPrev2035 = YearDiff2035 - 1;
	FundTerm2035 = YearDiff2035;
	
	MonthDiff2023 = ceil(([round2 doubleValue ] - (YearDiff2023 - 1))/(1.00/12.00));
	MonthDiff2025 = ceil(([round3 doubleValue ] - (YearDiff2025 - 1))/(1.00/12.00));
	MonthDiff2028 = ceil(([round4 doubleValue ] - (YearDiff2028 - 1))/(1.00/12.00));
	MonthDiff2030 = ceil(([round5 doubleValue ] - (YearDiff2030 - 1))/(1.00/12.00));
	MonthDiff2035 = ceil(([round6 doubleValue ] - (YearDiff2035 - 1))/(1.00/12.00));
	
	NSLog(@"yeardiff2023:%d, yeardiff2025:%d, yeardiff2028:%d, yeardiff2030:%d,yeardiff2035:%d ", YearDiff2023,YearDiff2025,
		  YearDiff2028, YearDiff2030, YearDiff2035);
	
	
	if (MonthDiff2023 == 12) {
		Allo2023 = YearDiff2023 + 1;
	}
	else{
		Allo2023 = YearDiff2023;
	}
	
	if (MonthDiff2025 == 12) {
		Allo2025 = YearDiff2025 + 1;
	}
	else{
		Allo2025 = YearDiff2025;
	}
	
	if (MonthDiff2028 == 12) {
		Allo2028 = YearDiff2028 + 1;
	}
	else{
		Allo2028 = YearDiff2028;
	}
	
	if (MonthDiff2030 == 12) {
		Allo2030 = YearDiff2030 + 1;
	}
	else{
		Allo2030 = YearDiff2030;
	}
	
	if (MonthDiff2035 == 12) {
		Allo2035 = YearDiff2035 + 1;
	}
	else{
		Allo2035 = YearDiff2035;
	}
	
	
	NSDate* aa = [df dateFromString:getPlanCommDate];
	NSDateComponents* components2 = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
												fromDate:aa];
	CommMonth = [components2 month];
}

-(double)ReturnModeRate: (NSString *)MOP{
	if ([MOP isEqualToString:@"A"]) {
		return 0.85;
	}
	else if ([MOP isEqualToString:@"S"]){
		return 0.9;
	}
	else if ([MOP isEqualToString:@"Q"]){
		return 0.9;
	}
	else{
		return 0.95;
	}
}

-(double)ReturnExcessPrem: (int)aaPolicyYear{
	if ([strRTUPAmount isEqualToString:@""]) {
		return 0;
	}
	else {
		if (aaPolicyYear >= [strRTUPFrom intValue ] && aaPolicyYear <= [strRTUPFrom intValue] + [strRTUPFor intValue] ) {
			return [strRTUPAmount doubleValue ];
		}
		else{
			return 0;
		}
	}
}

-(double)ReturnDivideMode{
	if ([strBumpMode isEqualToString:@"A"]) {
		return 1.00;
	}
	else if ([strBumpMode isEqualToString:@"S"]) {
		return 2.00;
	}
	else if ([strBumpMode isEqualToString:@"Q"]) {
		return 4.00;
	}
	else{
		return 12.00;
	}
}

-(double)ReturnPremAllocation: (int)aaPolYear{
	if (aaPolYear == 1) {
		if ([strBasicPremium doubleValue ] >= 12000 && [strBasicPremium doubleValue ] < 24000 ) {
			return 0.45 + 0.02;
		}
		else if ([strBasicPremium doubleValue ] >= 24000){
			return 0.45 + 0.04;
		}
		else{
			return 0.45;
		}
	}
	else if (aaPolYear == 2){
		if ([strBasicPremium doubleValue ] >= 12000 && [strBasicPremium doubleValue ] < 24000 ) {
			return 0.5 + 0.02;
		}
		else if ([strBasicPremium doubleValue ] >= 24000){
			return 0.5 + 0.04;
		}
		else{
			return 0.5;
		}
		
	}
	else if (aaPolYear == 3){
		return 0.76;
	}
	else if (aaPolYear == 4){
		return 0.76;
	}
	else if (aaPolYear >=5 && aaPolYear < 7){
		return 0.9;
	}
	else{
		return 1.00;
	}
}

-(double)ReturnPremAllocation_V: (int)aaPolYear{
	if (aaPolYear == 1) {
		if ([strBasicPremium doubleValue ] >= 12000 && [strBasicPremium doubleValue ] < 24000 ) {
			return 0.4 + 0.02;
		}
		else if ([strBasicPremium doubleValue ] >= 24000){
			return 0.4 + 0.04;
		}
		else{
			return 0.4;
		}
	}
	else if (aaPolYear == 2){
		if ([strBasicPremium doubleValue ] >= 12000 && [strBasicPremium doubleValue ] < 24000 ) {
			return 0.52 + 0.02;
		}
		else if ([strBasicPremium doubleValue ] >= 24000){
			return 0.52 + 0.04;
		}
		else{
			return 0.52;
		}
		
	}
	else if (aaPolYear == 3){
		return 0.785;
	}
	else if (aaPolYear == 4){
		return 0.835;
	}
	else if (aaPolYear >=5 && aaPolYear < 7){
		return 0.925;
	}
	else{
		return 1.00;
	}
}


-(double)ReturnBasicMort: (int)zzAge{
	NSString *MortRate;
	sqlite3_stmt *statement;
	NSString *querySQL;
	
	querySQL = [NSString stringWithFormat:@"Select Rate From ES_Sys_Basic_Mort WHERE PlanCode = 'UV' AND Sex = '%@' AND Age='%d' AND Smoker ='%@' "
				, getSexLA, zzAge, getSmokerLA];
	
	//NSLog(@"%@", querySQL);
	if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				MortRate = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
	return [MortRate doubleValue];
}

-(int)GetMortDate{
	
	
	if (![getPlanCommDate isEqualToString:@""] && ![getDOB isEqualToString:@""]  ) {
		
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
     	NSDate* d = [[df dateFromString:getDOB] dateByAddingTimeInterval:8*60*60 - 1800 ];
		NSDate* d2 = [[df dateFromString:getPlanCommDate]dateByAddingTimeInterval:8*60*60  ];
		
		NSCalendar* calendar = [NSCalendar currentCalendar];
		NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
												   fromDate:d];
		NSDateComponents* components2 = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
													fromDate:d2];
		
		if ([components month] == [components2 month] && [components day] == [components2 day]) {
			return 12;
		}
		else{
			return 12 - ([self monthsBetweenDate:d andDate:d2])%12;
			
		}
	}
	else{
		NSLog(@"error, no DOB and plan Comm date");
		return -1;
	}
}

- (NSUInteger)monthsBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
	
    NSCalendar *calendar = [NSCalendar currentCalendar];
	//NSLog(@"%@ %@", fromDateTime, toDateTime);
	
    [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&fromDate
				 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&toDate
				 interval:NULL forDate:toDateTime];
	
    NSDateComponents *difference = [calendar components:NSMonthCalendarUnit
											   fromDate:fromDate toDate:toDate options:0];
	

	//NSLog(@"%d", [difference month]);
    return [difference month];
}

- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
	
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
				 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
				 interval:NULL forDate:toDateTime];
	
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
											   fromDate:fromDate toDate:toDate options:0];

    return [difference day];
}

-(NSInteger)roundUp :(double)aaDouble{
	return round(ceil(aaDouble));
}

-(NSInteger)roundDown :(double)aaDouble{
	return round(floor(aaDouble));
}

-(double)ReturnJuvenilienFactor :(int)aaAge{
	if (aaAge >= 0 && aaAge <= 1 ) {
		return 0.2;
	}
	else if (aaAge == 2 ) {
		return 0.4;
	}
	else if (aaAge == 3 ) {
		return 0.6;
	}
	else if (aaAge == 4 ) {
		return 0.4;
	}
	else{
		return 1.00;
	}
}

-(void)CheckSustainForNegativeBump :(double)aaBumpValue{
	double modeRate = 0.00;
	int RTUOPremium = 0.00;
	
	
		if ([strBumpMode isEqualToString:@"A"]) {
			modeRate = 1.00;
		}
		else if ([strBumpMode isEqualToString:@"S"]) {
			modeRate = 0.9;
		}
		else if ([strBumpMode isEqualToString:@"Q"]) {
			modeRate = 0.9;
		}
		else {
			modeRate = 0.8;
		}
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		[formatter setCurrencySymbol:@""];
		[formatter setNegativeFormat:@"-"];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		int tempRTUO = ceil(ABS(aaBumpValue/(0.85 * 0.95)) * modeRate);
		RTUOPremium = 10 * (tempRTUO % 10 > 0 ? ceil(tempRTUO/10.00) : tempRTUO/10 + 1 );
		
		strGrayRTUPAmount =  [NSString stringWithFormat:@"%d", RTUOPremium + [strGrayRTUPAmount intValue] ];
		
		CurrentBump = [self CalculateBUMP];
		
		if (CurrentBump > 0 ) {
			[self UpdateUL_Details];
		}
		else{
			for (int i = 0; i < 5; i++) {
				
				tempRTUO = ceil(ABS(CurrentBump/(0.85 * 0.95)) * modeRate);
				RTUOPremium = 10 * (tempRTUO % 10 > 0 ? ceil(tempRTUO/10.00) : tempRTUO/10 );
				
				strGrayRTUPAmount = [NSString stringWithFormat:@"%d", RTUOPremium ];
				CurrentBump = [self CalculateBUMP];
				
				if (CurrentBump > 0) {
					[self UpdateUL_Details];
					break;
				}
			}
		}
		
	
	
	
	
	
	
	//NSLog(@"%@", [self ErrorMsg:@"R0" andInput1:[NSString stringWithFormat:@"%d", RTUOPremium ] andInput2:@"" andInput3:@""]);
	
}

-(void)UpdateUL_Details{
	sqlite3_stmt *statement;
	NSString *querySQL;
	
	querySQL = [NSString stringWithFormat:@"Update UL_Details SET Atu = '%@' WHERE sino = '%@' ", strGrayRTUPAmount, SINo];
	
	//NSLog(@"%@", querySQL);
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE){
				
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
}

-(double)PremRequired{
	return PremReq;
}

-(double)FromBasic:(NSString *)aaATPrem andGetHL:(NSString *)aaGetHL andGetHLPct:(NSString *)aaGetHLPct
	   andBumpMode:(NSString *)aaBumpMode andBasicSA:(NSString *)aaBasicSA
	   andRTUPFrom:(NSString *)aaRTUPFrom andRTUPFor:(NSString *)aaRTUPFor andRTUPAmount:(NSString *)aaRTUPAmount
	   andSmokerLA:(NSString *)aaSmokerLA andOccLoading:(NSString *)aaOccLoading andPlanCommDate:(NSString *)aaPlanCommDate
			andDOB:(NSString *)aaDOB andSexLA:(NSString *)aaSexLA andSino:(NSString *)aaSino andLAAge:(int)aaLAAge
		  andGrayRTUO:(double)aaGrayRTUO{
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    UL_RatesDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"UL_Rates.sqlite"]];
	
	strBasicPremium = aaATPrem;
	strBasicPremium_Bump = strBasicPremium;
	getHL = aaGetHL;
	getHLPct = aaGetHLPct;
	strBumpMode = aaBumpMode;
	strBasicSA = aaBasicSA;
	BasicSA = [aaBasicSA doubleValue];
	strRTUPFrom = aaRTUPFrom;
	strRTUPFor = aaRTUPFor;
	strRTUPAmount = aaRTUPAmount;
	getSmokerLA = aaSmokerLA;
	getOccLoading = aaOccLoading;
	getPlanCommDate = aaPlanCommDate;
	getDOB = aaDOB;
	getSexLA = aaSexLA;
	SINo = aaSino;
	Age = aaLAAge;
	strGrayRTUPAmount = [NSString stringWithFormat:@"%f", aaGrayRTUO];
	
	NSLog(@"%@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %d %f", aaATPrem, aaGetHL, aaGetHLPct, aaBumpMode, aaBasicSA, aaRTUPFrom, aaRTUPFor,
		  aaRTUPAmount, aaSmokerLA, aaOccLoading, aaPlanCommDate, aaDOB, aaSexLA, aaSino, aaLAAge, aaGrayRTUO);
	SimpleOrDetail = @"Simple";
	[self PopulateData];
	
	return [self CalculateBUMP];
}

-(NSString *)ErrorMsg :(NSString *)aaCode andInput1:(NSString *)aaInput1 andInput2:(NSString *)aaInput2 andInput3:(NSString *)aaInput3 {
	if ([aaCode isEqual:@"X1"]) {
		return  [NSString stringWithFormat:@"%@The Rider Unit Account is projected to be able to sustain up to %@th policy year only based on BULL scenario.",aaCode, aaInput1 ];
	}
	else if([aaCode isEqual:@"X2"]){
		return  [NSString stringWithFormat:@"%@The Basic Unit Account is projected to be able to sustain up to %@th policy year only based on BULL scenario",aaCode,aaInput1 ];
	}
	else if([aaCode isEqual:@"X3"]){
		return  [NSString stringWithFormat:@"%@The Basic Unit Account and Rider Unit Account are projected to be able to sustain up to %@th and %@th policy year only respectively,"
				 "based on BULL scenario.",aaCode,aaInput1, aaInput2];
	}
	else if([aaCode isEqual:@"Y1"]){
		return  [NSString stringWithFormat:@"%@The Rider Unit Account is projected to be able to sustain up to %@th policy year only based on BULL scenario. "
				 "Generation of SI & PDS is not allowed if Rider Unit Account lapse before 10th policy year. You may increase your Rider Unit Account sustainability year by:\n"
				 "1. Reinvesting your matured fund value fully partially (option at fund maturity).\n"
				 "2. Adding Rider Regular Top Up.",aaCode, aaInput1 ];
	}
	else if([aaCode isEqual:@"Y2"]){
		return  [NSString stringWithFormat:@"%@The Basic Unit Account is projected to be able to sustain up to %@th policy year only based on BULL scenario. "
				 "Generation of SI & PDS is not allowed if Basic Unit Account lapse before 10th policy year. You may increase your Basic Unit Account sustainability year by:\n"
				 "1. Reinvesting your matured fund value fully/partially (option at fund maturity).\n"
				 "2. Reducing regular withdrawal if you have opted for regular withdrawal.\n"
				 "3. Reducing your BSA if the BSA is higher than minimum allowable BSA.\n"
				 "4. Adding Basic Plan Regular Top Up.",aaCode, aaInput1];
	}
	else if([aaCode isEqual:@"Y3"]){
		return  [NSString stringWithFormat:@"%@The Basic Unit Account and Rider Unit Account are projected to be able to sustain up to %@th and %@th policy year only respectively, "
				 "based on BULL scenario. Generation of SI & PDS is not allowed if either Basic Unit Account or Rider Unit Account lapse before 10th policy year. "
				 "You may increase your Basic Unit Account or Rider Unit Account sustainability year by:\n"
				 "1. Reinvesting your matured fund value fully/partially (option at fund maturity).\n"
				 "2. Reducing regular withdrawal if you opted for regular withdrawal.\n"
				 "3. Reducing your BSA if the BSA is higher than minimum allowable BSA.\n"
				 "4. Adding Basic Plan/ Rider Regular Top Up.",aaCode, aaInput1, aaInput2];
	}
	else if([aaCode isEqual:@"Z1"]){
		return  [NSString stringWithFormat:@"%@Regular Top Up Premium will be revised to RM%@. However, the Basic Unit Account and Rider Unit Account are projected to be able to "
				 "sustain up to %@th and %@th policy year only respectively, based on BULL scenario. Generation of SI & PDS is not allowed if either "
				 "Basic Unit Account or Rider Unit Account lapse before 10th policy year. You may increase your Basic Unit Account or Rider Unit Account sustainability year by:\n"
				 "1. Reinvesting your matured fund value fully/partially (option at fund maturity).\n"
				 "2. Reducing regular withdrawal if you opted for regular withdrawal\n."
				 "3. Reducing your BSA if the BSA is higher than minimum allowable BSA.\n"
				 "4. Adding Basic Plan/ Rider Regular Top Up.",aaCode, aaInput1, aaInput2, aaInput3];
	}
	else if([aaCode isEqual:@"Z2"]){
		return  [NSString stringWithFormat:@"%@Regular Top Up Premium will be revised to RM%@. However, the Basic Unit Account and Rider Unit Account are projected to be able to "
				 "sustain up to %@th and %@th policy year only respectively, based on BULL scenario. You may increase your Basic Unit Account or Rider Unit Account sustainability year by:\n"
				 "Reducing withdrawal amount of matured fund (option at fund maturity) and/or regular withdrawal if you opt for any withdrawal.\n"
				 "1. Reinvesting your matured fund value fully/partially (option at fund maturity).\n"
				 "2. Reducing regular withdrawal if you opted for regular withdrawal\n."
				 "3. Reducing your BSA if the BSA higher than minimum allowable BSA.\n"
				 "4. Adding Basic Plan/ Rider Regular Top Up.",aaCode, aaInput1, aaInput2, aaInput3];
	}
	else if ([aaCode isEqual:@"A1"]) {
		return  [NSString stringWithFormat:@"%@Reinvest your matured fund value fully/partially (option at fund maturity) to increase policy sustainability year.",aaCode];
	}
	else if ([aaCode isEqual:@"A2"]) {
		return  [NSString stringWithFormat:@"%@a. Reinvest your matured fund value fully/partially (option at fund maturity); or\n "
											  "b. Reduce regular withdrawal if you have opted for regular withdrawal, to increase policy sustainability year.",aaCode];
	}
	else if ([aaCode isEqual:@"A3"]) {
		return  [NSString stringWithFormat:@"%@a. Reinvest your matured fund value fully/partially (option at fund maturity); or\n "
											  "b. Reduce regular withdrawal if you have opted for regular withdrawal, to increase policy sustainability year.",aaCode];
	}
	else if ([aaCode isEqual:@"B0"]) {
		return  [NSString stringWithFormat:@"%@Reduce policy sustainability year.",aaCode];
	}
	else if ([aaCode isEqual:@"C1"]) {
		return  [NSString stringWithFormat:@"%@Add Rider Regular Top Up to increase policy sustainability year.",aaCode];
	}
	else if ([aaCode isEqual:@"C2"]) {
		return  [NSString stringWithFormat:@"%@Add Basic Plan Regular Top Up to increase policy sustainability year.",aaCode];
	}
	else if ([aaCode isEqual:@"C3"]) {
		return  [NSString stringWithFormat:@"%@Add Basic Plan/ Rider Regular Top Up to increase policy sustainability year.",aaCode];
	}
	else if ([aaCode isEqual:@"D0"]) {
		return  [NSString stringWithFormat:@"%@Reduce Basic Sum Assured to increase policy sustainability year.",aaCode];
	}
	else if([aaCode isEqual:@"R0"]){
		return  [NSString stringWithFormat:@"%@Regular Top Up Premium will be revised to RM%@",aaCode, strGrayRTUPAmount];
	}
	else if([aaCode isEqual:@"R1"]){
		return  [NSString stringWithFormat:@"%@The Fund Value is insufficient to convert the policy to reduced paid up plan. To convert, the BSA shall be revised to RM%@",aaCode, aaInput1];

	}
	else if([aaCode isEqual:@"R2"]){
		return  [NSString stringWithFormat:@"%@Reset the conversion year and Sum Assured",aaCode];
	}
	else if([aaCode isEqual:@"R3"]){
		return  [NSString stringWithFormat:@"%@The Fund Value at %@th policy anniversart is insufficient to convert the policy to reduced paid up plan even with minimum BSA."
				 "To convert, the conversion year shall be %@th policy anniversary with minimum BSA of RM%@",aaCode, aaInput1, aaInput2, aaInput3];
	}
	else if([aaCode isEqual:@"R4"]){
		return  [NSString stringWithFormat:@"%@Based on projection, the Fund Value at %@th up to %@th policy anniversary is insufficient to convert the policy to reduced paid up plan even with minimum BSA.",aaCode, aaInput1, aaInput2];

	}
	else if([aaCode isEqual:@"T1"]){
		return  [NSString stringWithFormat:@"%@Based on projection, the policy will lapse. Please increase Basic Premium to RM%@",aaCode, aaInput1];
	}
	else if([aaCode isEqual:@"T2"]){
		return  [NSString stringWithFormat:@"%@Based on projection, the policy will lapse. Please reduce Basic Sum Assured.",aaCode];
		
	}
	else if([aaCode isEqual:@"00"]){ //not allow quotation
		return  [NSString stringWithFormat:@"%@OK",aaCode];
		
	}
	else if([aaCode isEqual:@"01"]){ //not allow quotation
		return  [NSString stringWithFormat:@"%@OK",aaCode];
		
	}
	else{
		return @"";
	}
}

#pragma mark - Sustainability

-(BOOL)CalculateRPUO_WithMinSA{
	PaidOpCharge2023_H = 0;
	PaidOpCharge2025_H = 0;
	PaidOpCharge2028_H = 0;
	PaidOpCharge2030_H = 0;
	PaidOpCharge2035_H = 0;
	PaidOpChargeRet_H = 0;
	PaidOpChargeDana_H = 0;
	PaidOpCharge2023_M = 0;
	PaidOpCharge2025_M = 0;
	PaidOpCharge2028_M = 0;
	PaidOpCharge2030_M = 0;
	PaidOpCharge2035_M = 0;
	PaidOpChargeRet_M = 0;
	PaidOpChargeDana_M = 0;
	PaidOpCharge2023_L = 0;
	PaidOpCharge2025_L = 0;
	PaidOpCharge2028_L = 0;
	PaidOpCharge2030_L = 0;
	PaidOpCharge2035_L = 0;
	PaidOpChargeRet_L = 0;
	PaidOpChargeDana_L = 0;
	PaidOpChargeCash_H = 0;
	PaidOpChargeCash_M = 0;
	PaidOpChargeCash_L = 0;
	PaidOpChargeSum_H = 0;
	PaidOpChargeSum_M = 0;
	PaidOpChargeSum_L = 0;
	ProjDeduction2023_H = 0;
	ProjDeduction2025_H = 0;
	ProjDeduction2028_H = 0;
	ProjDeduction2030_H = 0;
	ProjDeduction2035_H = 0;
	ProjDeductionRet_H = 0;
	ProjDeductionDana_H = 0;
	ProjDeductionCash_H = 0;
	ProjDeductionSum_H = 0;
	ProjDeduction2023_M = 0;
	ProjDeduction2025_M = 0;
	ProjDeduction2028_M = 0;
	ProjDeduction2030_M = 0;
	ProjDeduction2035_M = 0;
	ProjDeductionRet_M = 0;
	ProjDeductionDana_M = 0;
	ProjDeductionCash_M = 0;
	ProjDeductionSum_M = 0;
	ProjDeduction2023_L = 0;
	ProjDeduction2025_L = 0;
	ProjDeduction2028_L = 0;
	ProjDeduction2030_L = 0;
	ProjDeduction2035_L = 0;
	ProjDeductionRet_L = 0;
	ProjDeductionDana_L = 0;
	ProjDeductionCash_L = 0;
	ProjDeductionSum_L = 0;
	ReinvestCashFund2023_H = 0;
	ReinvestCashFund2025_H = 0;
	ReinvestCashFund2028_H = 0;
	ReinvestCashFund2030_H = 0;
	ReinvestCashFund2035_H = 0;
	ReinvestCashFundRet_H = 0;
	ReinvestCashFundDana_H = 0;
	ReinvestCashFund2023_M = 0;
	ReinvestCashFund2025_M = 0;
	ReinvestCashFund2028_M = 0;
	ReinvestCashFund2030_M = 0;
	ReinvestCashFund2035_M = 0;
	ReinvestCashFundRet_M = 0;
	ReinvestCashFundDana_M = 0;
	ReinvestCashFund2023_L = 0;
	ReinvestCashFund2025_L = 0;
	ReinvestCashFund2028_L = 0;
	ReinvestCashFund2030_L = 0;
	ReinvestCashFund2035_L = 0;
	ReinvestCashFundRet_L = 0;
	ReinvestCashFundDana_L = 0;
	ReinvestCashFundCase_H = 0;
	ReinvestCashFundCase_M = 0;
	ReinvestCashFundCase_L = 0;
	ReinvestCashFundSum_H = 0;
	ReinvestCashFundSum_M = 0;
	ReinvestCashFundSum_L = 0;
	ProjValAfterReinvestSum_H = 0;
	ProjValAfterReinvestSum_M = 0;
	ProjValAfterReinvestSum_L = 0;
	ProjValAfterReinvest2023_H = 0;
	ProjValAfterReinvest2025_H = 0;
	ProjValAfterReinvest2028_H = 0;
	ProjValAfterReinvest2030_H = 0;
	ProjValAfterReinvest2035_H = 0;
	ProjValAfterReinvestRet_H = 0;
	ProjValAfterReinvestDana_H = 0;
	ProjValAfterReinvestCash_H = 0;
	ProjValAfterReinvestSum_H = 0;
	ProjValAfterReinvest2023_M = 0;
	ProjValAfterReinvest2025_M = 0;
	ProjValAfterReinvest2028_M = 0;
	ProjValAfterReinvest2030_M = 0;
	ProjValAfterReinvest2035_M = 0;
	ProjValAfterReinvestRet_M = 0;
	ProjValAfterReinvestDana_M = 0;
	ProjValAfterReinvestCash_M = 0;
	ProjValAfterReinvestSum_M = 0;
	ProjValAfterReinvest2023_L = 0;
	ProjValAfterReinvest2025_L = 0;
	ProjValAfterReinvest2028_L = 0;
	ProjValAfterReinvest2030_L = 0;
	ProjValAfterReinvest2035_L = 0;
	ProjValAfterReinvestRet_L = 0;
	ProjValAfterReinvestDana_L = 0;
	ProjValAfterReinvestCash_L = 0;
	ProjValAfterReinvestSum_L = 0;
	PrevPaidUpOptionTable_2023_High = 0;
	PrevPaidUpOptionTable_2025_High = 0;
	PrevPaidUpOptionTable_2028_High = 0;
	PrevPaidUpOptionTable_2030_High = 0;
	PrevPaidUpOptionTable_2035_High = 0;
	PrevPaidUpOptionTable_Cash_High = 0;
	PrevPaidUpOptionTable_Ret_High = 0;
	PrevPaidUpOptionTable_Dana_High = 0;
	PrevPaidUpOptionTable_2023_Median = 0;
	PrevPaidUpOptionTable_2025_Median = 0;
	PrevPaidUpOptionTable_2028_Median = 0;
	PrevPaidUpOptionTable_2030_Median = 0;
	PrevPaidUpOptionTable_2035_Median = 0;
	PrevPaidUpOptionTable_Cash_Median = 0;
	PrevPaidUpOptionTable_Ret_Median = 0;
	PrevPaidUpOptionTable_Dana_Median = 0;
	PrevPaidUpOptionTable_2023_Low = 0;
	PrevPaidUpOptionTable_2025_Low = 0;
	PrevPaidUpOptionTable_2028_Low = 0;
	PrevPaidUpOptionTable_2030_Low = 0;
	PrevPaidUpOptionTable_2035_Low = 0;
	PrevPaidUpOptionTable_Cash_Low = 0;
	PrevPaidUpOptionTable_Ret_Low = 0;
	PrevPaidUpOptionTable_Dana_Low = 0;
	ProjValueMaturity2023_H= 0,ProjValueMaturity2023_M= 0,ProjValueMaturity2023_L= 0,ProjValueMaturity2025_H= 0,ProjValueMaturity2025_M= 0,ProjValueMaturity2025_L= 0;
	ProjValueMaturity2028_H= 0,ProjValueMaturity2028_M= 0,ProjValueMaturity2028_L= 0,ProjValueMaturity2030_H= 0,ProjValueMaturity2030_M= 0,ProjValueMaturity2030_L= 0;
	ProjValueMaturity2035_H= 0,ProjValueMaturity2035_M= 0,ProjValueMaturity2035_L= 0,ProjValueMaturityRet_H= 0,ProjValueMaturityRet_M= 0,ProjValueMaturityRet_L= 0;
	ProjValueMaturityCash_H= 0,ProjValueMaturityCash_M= 0,ProjValueMaturityCash_L= 0,ProjValueMaturityDana_H= 0,ProjValueMaturityDana_M= 0,ProjValueMaturityDana_L= 0;
	ProjWithdraw2023_H = 0,ProjWithdraw2023_M= 0,ProjWithdraw2023_L= 0,ProjWithdraw2025_H= 0,ProjWithdraw2025_M= 0,ProjWithdraw2025_L= 0;
	ProjWithdraw2028_H= 0,ProjWithdraw2028_M= 0,ProjWithdraw2028_L= 0,ProjWithdraw2030_H= 0,ProjWithdraw2030_M= 0,ProjWithdraw2030_L= 0;
	ProjWithdraw2035_H= 0,ProjWithdraw2035_M= 0,ProjWithdraw2035_L= 0,ProjWithdrawRet_H= 0,ProjWithdrawRet_M= 0,ProjWithdrawRet_L= 0;
	ProjWithdrawCash_H= 0,ProjWithdrawCash_M= 0,ProjWithdrawCash_L= 0,ProjWithdrawDana_H= 0,ProjWithdrawDana_M= 0,ProjWithdrawDana_L= 0;
	ProjReinvest2023_H= 0,ProjReinvest2023_M= 0,ProjReinvest2023_L= 0,ProjReinvest2025_H= 0,ProjReinvest2025_M= 0,ProjReinvest2025_L= 0;
	ProjReinvest2028_H= 0,ProjReinvest2028_M= 0,ProjReinvest2028_L= 0,ProjReinvest2030_H= 0,ProjReinvest2030_M= 0,ProjReinvest2030_L= 0;
	ProjReinvest2035_H= 0,ProjReinvest2035_M= 0,ProjReinvest2035_L= 0,ProjReinvestRet_H= 0,ProjReinvestRet_M= 0,ProjReinvestRet_L= 0;
	ProjReinvestCash_H= 0,ProjReinvestCash_M= 0,ProjReinvestCash_L= 0,ProjReinvestDana_H= 0,ProjReinvestDana_M= 0,ProjReinvestDana_L= 0;
	ReinvestAmount2023to2025_H= 0, ReinvestAmount2023to2028_H= 0,ReinvestAmount2023to2030_H= 0,ReinvestAmount2023to2035_H= 0,ReinvestAmount2023toRet_H= 0,ReinvestAmount2023toCash_H= 0,ReinvestAmount2023toDana_H= 0;
	ReinvestAmount2025to2028_H= 0,ReinvestAmount2025to2030_H= 0,ReinvestAmount2025to2035_H= 0,ReinvestAmount2025toRet_H= 0,ReinvestAmount2025toCash_H= 0,ReinvestAmount2025toDana_H= 0;
	ReinvestAmount2028to2030_H= 0,ReinvestAmount2028to2035_H= 0,ReinvestAmount2028toRet_H= 0,ReinvestAmount2028toCash_H= 0,ReinvestAmount2028toDana_H= 0;
	ReinvestAmount2030to2035_H= 0,ReinvestAmount2030toRet_H= 0,ReinvestAmount2030toCash_H= 0,ReinvestAmount2030toDana_H= 0;
	ReinvestAmount2035toRet_H= 0,ReinvestAmount2035toCash_H= 0,ReinvestAmount2035toDana_H= 0;
	ReinvestAmount2023to2025_M= 0, ReinvestAmount2023to2028_M= 0,ReinvestAmount2023to2030_M= 0,ReinvestAmount2023to2035_M= 0,ReinvestAmount2023toRet_M= 0,ReinvestAmount2023toCash_M= 0,ReinvestAmount2023toDana_M= 0;
	ReinvestAmount2025to2028_M= 0,ReinvestAmount2025to2030_M= 0,ReinvestAmount2025to2035_M= 0,ReinvestAmount2025toRet_M= 0,ReinvestAmount2025toCash_M= 0,ReinvestAmount2025toDana_M= 0;
	ReinvestAmount2028to2030_M= 0,ReinvestAmount2028to2035_M= 0,ReinvestAmount2028toRet_M= 0,ReinvestAmount2028toCash_M= 0,ReinvestAmount2028toDana_M= 0;
	ReinvestAmount2030to2035_M= 0,ReinvestAmount2030toRet_M= 0,ReinvestAmount2030toCash_M= 0,ReinvestAmount2030toDana_M= 0;
	ReinvestAmount2035toRet_M= 0,ReinvestAmount2035toCash_M= 0,ReinvestAmount2035toDana_M= 0;
	ReinvestAmount2023to2025_L= 0, ReinvestAmount2023to2028_L= 0,ReinvestAmount2023to2030_L= 0,ReinvestAmount2023to2035_L= 0,ReinvestAmount2023toRet_L= 0,ReinvestAmount2023toCash_L= 0,ReinvestAmount2023toDana_L= 0;
	ReinvestAmount2025to2028_L= 0,ReinvestAmount2025to2030_L= 0,ReinvestAmount2025to2035_L= 0,ReinvestAmount2025toRet_L= 0,ReinvestAmount2025toCash_L= 0,ReinvestAmount2025toDana_L= 0;
	ReinvestAmount2028to2030_L= 0,ReinvestAmount2028to2035_L= 0,ReinvestAmount2028toRet_L= 0,ReinvestAmount2028toCash_L= 0,ReinvestAmount2028toDana_L= 0;
	ReinvestAmount2030to2035_L= 0,ReinvestAmount2030toRet_L= 0,ReinvestAmount2030toCash_L= 0,ReinvestAmount2030toDana_L= 0;
	ReinvestAmount2035toRet_L= 0,ReinvestAmount2035toCash_L= 0,ReinvestAmount2035toDana_L= 0;

	
//
	PaidOpCharge2023_H = [self Calc_PaidUpOptionCharges:VU2023ValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	PaidOpCharge2025_H = [self Calc_PaidUpOptionCharges:VU2025ValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	PaidOpCharge2028_H = [self Calc_PaidUpOptionCharges:VU2028ValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	PaidOpCharge2030_H = [self Calc_PaidUpOptionCharges:VU2030ValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	PaidOpCharge2035_H = [self Calc_PaidUpOptionCharges:VU2035ValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	PaidOpChargeRet_H = [self Calc_PaidUpOptionCharges:VURetValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	PaidOpChargeDana_H = [self Calc_PaidUpOptionCharges:VUDanaValueHigh andVUCash:VUCashValueHigh andHighMedLow:@"High"];
	
	PaidOpCharge2023_M = [self Calc_PaidUpOptionCharges:VU2023ValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	PaidOpCharge2025_M = [self Calc_PaidUpOptionCharges:VU2025ValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	PaidOpCharge2028_M = [self Calc_PaidUpOptionCharges:VU2028ValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	PaidOpCharge2030_M = [self Calc_PaidUpOptionCharges:VU2030ValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	PaidOpCharge2035_M = [self Calc_PaidUpOptionCharges:VU2035ValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	PaidOpChargeRet_M = [self Calc_PaidUpOptionCharges:VURetValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	PaidOpChargeDana_M = [self Calc_PaidUpOptionCharges:VUDanaValueMedian andVUCash:VUCashValueMedian andHighMedLow:@"Med"];
	
	PaidOpCharge2023_L = [self Calc_PaidUpOptionCharges:VU2023ValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	PaidOpCharge2025_L = [self Calc_PaidUpOptionCharges:VU2025ValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	PaidOpCharge2028_L = [self Calc_PaidUpOptionCharges:VU2028ValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	PaidOpCharge2030_L = [self Calc_PaidUpOptionCharges:VU2030ValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	PaidOpCharge2035_L = [self Calc_PaidUpOptionCharges:VU2035ValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	PaidOpChargeRet_L = [self Calc_PaidUpOptionCharges:VURetValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	PaidOpChargeDana_L = [self Calc_PaidUpOptionCharges:VUDanaValueLow andVUCash:VUCashValueLow andHighMedLow:@"Low"];
	
	PaidOpChargeCash_H = VUCashValueHigh >= OneTimePayOut ? OneTimePayOut:VUCashValueHigh;
	PaidOpChargeCash_M = VUCashValueMedian >= OneTimePayOut ? OneTimePayOut:VUCashValueMedian;
	PaidOpChargeCash_L = VUCashValueLow >= OneTimePayOut ? OneTimePayOut:VUCashValueLow;
	
	PaidOpChargeSum_H = PaidOpCharge2023_H + PaidOpCharge2025_H + PaidOpCharge2028_H + PaidOpCharge2030_H + PaidOpCharge2035_H + PaidOpChargeRet_H + PaidOpChargeDana_H + PaidOpChargeCash_H;
	PaidOpChargeSum_M = PaidOpCharge2023_M + PaidOpCharge2025_M + PaidOpCharge2028_M + PaidOpCharge2030_M + PaidOpCharge2035_M + PaidOpChargeRet_M + PaidOpChargeDana_M + PaidOpChargeCash_M;
	PaidOpChargeSum_L = PaidOpCharge2023_L + PaidOpCharge2025_L + PaidOpCharge2028_L + PaidOpCharge2030_L + PaidOpCharge2035_L + PaidOpChargeRet_L + PaidOpChargeDana_L + PaidOpChargeCash_L;
	
	ProjDeduction2023_H = VU2023ValueHigh - PaidOpCharge2023_H;
	ProjDeduction2025_H = VU2025ValueHigh - PaidOpCharge2025_H;
	ProjDeduction2028_H = VU2028ValueHigh - PaidOpCharge2028_H;
	ProjDeduction2030_H = VU2030ValueHigh - PaidOpCharge2030_H;
	ProjDeduction2035_H = VU2035ValueHigh - PaidOpCharge2035_H;
	ProjDeductionRet_H = VURetValueHigh - PaidOpChargeRet_H;
	ProjDeductionDana_H = VUDanaValueHigh - PaidOpChargeDana_H;
	ProjDeductionCash_H = VUCashValueHigh - PaidOpChargeCash_H;
	ProjDeductionSum_H = ProjDeduction2023_H + ProjDeduction2025_H + ProjDeduction2028_H + ProjDeduction2030_H + ProjDeduction2035_H + ProjDeductionCash_H + ProjDeductionRet_H + ProjDeductionDana_H;
	
	ProjDeduction2023_M = VU2023ValueMedian - PaidOpCharge2023_M;
	ProjDeduction2025_M = VU2025ValueMedian - PaidOpCharge2025_M;
	ProjDeduction2028_M = VU2028ValueMedian - PaidOpCharge2028_M;
	ProjDeduction2030_M = VU2030ValueMedian - PaidOpCharge2030_M;
	ProjDeduction2035_M = VU2035ValueMedian - PaidOpCharge2035_M;
	ProjDeductionRet_M = VURetValueMedian - PaidOpChargeRet_M;
	ProjDeductionDana_M = VUDanaValueMedian - PaidOpChargeDana_M;
	ProjDeductionCash_M = VUCashValueMedian - PaidOpChargeCash_M;
	ProjDeductionSum_M = ProjDeduction2023_M + ProjDeduction2025_M + ProjDeduction2028_M + ProjDeduction2030_M + ProjDeduction2035_M + ProjDeductionCash_M + ProjDeductionRet_M + ProjDeductionDana_M;
	
	ProjDeduction2023_L = VU2023ValueLow - PaidOpCharge2023_L;
	ProjDeduction2025_L = VU2025ValueLow - PaidOpCharge2025_L;
	ProjDeduction2028_L = VU2028ValueLow - PaidOpCharge2028_L;
	ProjDeduction2030_L = VU2030ValueLow - PaidOpCharge2030_L;
	ProjDeduction2035_L = VU2035ValueLow - PaidOpCharge2035_L;
	ProjDeductionRet_L = VURetValueLow - PaidOpChargeRet_L;
	ProjDeductionDana_L = VUDanaValueLow - PaidOpChargeDana_L;
	ProjDeductionCash_L = VUCashValueLow - PaidOpChargeCash_L;
	ProjDeductionSum_L = ProjDeduction2023_L + ProjDeduction2025_L + ProjDeduction2028_L + ProjDeduction2030_L + ProjDeduction2035_L + ProjDeductionCash_L + ProjDeductionRet_L + ProjDeductionDana_L;
	
	if(ProjDeductionSum_H < 0 || ProjDeductionSum_M < 0 || ProjDeductionSum_L < 0 ){
		//NSLog(@"%f %f %f", ProjDeductionSum_H, ProjDeductionSum_M, ProjDeductionSum_L);
		return FALSE;
	}
	//-----------------------------
	ReinvestCashFund2023_H = [self Calc_CashFundReinvest:VU2023ValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	ReinvestCashFund2025_H = [self Calc_CashFundReinvest:VU2025ValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	ReinvestCashFund2028_H = [self Calc_CashFundReinvest:VU2028ValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	ReinvestCashFund2030_H = [self Calc_CashFundReinvest:VU2030ValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	ReinvestCashFund2035_H = [self Calc_CashFundReinvest:VU2035ValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	ReinvestCashFundRet_H = [self Calc_CashFundReinvest:VURetValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	ReinvestCashFundDana_H = [self Calc_CashFundReinvest:VUCashValueHigh andVUCash:ProjDeductionCash_H andHighMedLow:@"High"];
	
	ReinvestCashFund2023_M = [self Calc_CashFundReinvest:VU2023ValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	ReinvestCashFund2025_M = [self Calc_CashFundReinvest:VU2025ValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	ReinvestCashFund2028_M = [self Calc_CashFundReinvest:VU2028ValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	ReinvestCashFund2030_M = [self Calc_CashFundReinvest:VU2030ValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	ReinvestCashFund2035_M = [self Calc_CashFundReinvest:VU2035ValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	ReinvestCashFundRet_M = [self Calc_CashFundReinvest:VURetValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	ReinvestCashFundDana_M = [self Calc_CashFundReinvest:VUCashValueMedian andVUCash:ProjDeductionCash_M andHighMedLow:@"Med"];
	
	ReinvestCashFund2023_L = [self Calc_CashFundReinvest:VU2023ValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	ReinvestCashFund2025_L = [self Calc_CashFundReinvest:VU2025ValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	ReinvestCashFund2028_L = [self Calc_CashFundReinvest:VU2028ValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	ReinvestCashFund2030_L = [self Calc_CashFundReinvest:VU2030ValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	ReinvestCashFund2035_L = [self Calc_CashFundReinvest:VU2035ValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	ReinvestCashFundRet_L = [self Calc_CashFundReinvest:VURetValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	ReinvestCashFundDana_L = [self Calc_CashFundReinvest:VUCashValueLow andVUCash:ProjDeductionCash_L andHighMedLow:@"Low"];
	
	if (ReinvestCashFund2023_H + ReinvestCashFund2025_H + ReinvestCashFund2028_H + ReinvestCashFund2030_H + ReinvestCashFund2035_H + ReinvestCashFundRet_H + ReinvestCashFundDana_H == 0 ) {
		ReinvestCashFundCase_H = ProjDeductionCash_H;
	}
	else{
		if (ProjDeductionCash_H > 0) {
			ReinvestCashFundCase_H = -ProjDeductionCash_H;
		}
		else{
			ReinvestCashFundCase_H = 0;
		}
	}
	
	if (ReinvestCashFund2023_M + ReinvestCashFund2025_M + ReinvestCashFund2028_M + ReinvestCashFund2030_M + ReinvestCashFund2035_M + ReinvestCashFundRet_M + ReinvestCashFundDana_M == 0 ) {
		ReinvestCashFundCase_M = ProjDeductionCash_M;
	}
	else{
		if (ProjDeductionCash_M > 0) {
			ReinvestCashFundCase_M = -ProjDeductionCash_M;
		}
		else{
			ReinvestCashFundCase_M = 0;
		}
	}
	
	if (ReinvestCashFund2023_L + ReinvestCashFund2025_L + ReinvestCashFund2028_L + ReinvestCashFund2030_L + ReinvestCashFund2035_L + ReinvestCashFundRet_L + ReinvestCashFundDana_L == 0 ) {
		ReinvestCashFundCase_L = ProjDeductionCash_L;
	}
	else{
		if (ProjDeductionCash_L > 0) {
			ReinvestCashFundCase_L = -ProjDeductionCash_L;
		}
		else{
			ReinvestCashFundCase_L = 0;
		}
	}
	
	ReinvestCashFundSum_H = ReinvestCashFund2023_H + ReinvestCashFund2025_H + ReinvestCashFund2028_H + ReinvestCashFund2030_H + ReinvestCashFund2035_H + ReinvestCashFundRet_H + ReinvestCashFundDana_H + ReinvestCashFundCase_H;
	ReinvestCashFundSum_M = ReinvestCashFund2023_M + ReinvestCashFund2025_M + ReinvestCashFund2028_M + ReinvestCashFund2030_M + ReinvestCashFund2035_M + ReinvestCashFundRet_M + ReinvestCashFundDana_M + ReinvestCashFundCase_M;
	ReinvestCashFundSum_L = ReinvestCashFund2023_L + ReinvestCashFund2025_L + ReinvestCashFund2028_L + ReinvestCashFund2030_L + ReinvestCashFund2035_L + ReinvestCashFundRet_L + ReinvestCashFundDana_L + ReinvestCashFundCase_L;
	
	if (VUCash_FundAllo_Percen == 100) {
		ProjValAfterReinvestCash_H = ProjDeductionCash_H;
		ProjValAfterReinvestCash_M = ProjDeductionCash_M;
		ProjValAfterReinvestCash_L = ProjDeductionCash_L;
		
		ProjValAfterReinvestSum_H = ProjDeductionCash_H;
		ProjValAfterReinvestSum_M = ProjDeductionCash_M;
		ProjValAfterReinvestSum_L = ProjDeductionCash_L;
	}
	else{
		ProjValAfterReinvest2023_H = ProjDeduction2023_H + ReinvestCashFund2023_H;
		ProjValAfterReinvest2025_H = ProjDeduction2025_H + ReinvestCashFund2025_H;
		ProjValAfterReinvest2028_H = ProjDeduction2028_H + ReinvestCashFund2028_H;
		ProjValAfterReinvest2030_H = ProjDeduction2030_H + ReinvestCashFund2030_H;
		ProjValAfterReinvest2035_H = ProjDeduction2035_H + ReinvestCashFund2035_H;
		ProjValAfterReinvestRet_H = ProjDeductionRet_H + ReinvestCashFundRet_H;
		ProjValAfterReinvestDana_H = ProjDeductionDana_H + ReinvestCashFundDana_H;
		ProjValAfterReinvestCash_H = ReinvestCashFundSum_H;
		ProjValAfterReinvestSum_H = ProjValAfterReinvest2023_H + ProjValAfterReinvest2025_H + ProjValAfterReinvest2028_H + ProjValAfterReinvest2030_H + ProjValAfterReinvest2035_H + ProjValAfterReinvestRet_H +
		ProjValAfterReinvestDana_H  ;
		
		ProjValAfterReinvest2023_M = ProjDeduction2023_M + ReinvestCashFund2023_M;
		ProjValAfterReinvest2025_M = ProjDeduction2025_M + ReinvestCashFund2025_M;
		ProjValAfterReinvest2028_M = ProjDeduction2028_M + ReinvestCashFund2028_M;
		ProjValAfterReinvest2030_M = ProjDeduction2030_M + ReinvestCashFund2030_M;
		ProjValAfterReinvest2035_M = ProjDeduction2035_M + ReinvestCashFund2035_M;
		ProjValAfterReinvestRet_M = ProjDeductionRet_M + ReinvestCashFundRet_M;
		ProjValAfterReinvestDana_M = ProjDeductionDana_M + ReinvestCashFundDana_M;
		ProjValAfterReinvestCash_M = ReinvestCashFundSum_M;
		ProjValAfterReinvestSum_M = ProjValAfterReinvest2023_M + ProjValAfterReinvest2025_M + ProjValAfterReinvest2028_M + ProjValAfterReinvest2030_M + ProjValAfterReinvest2035_M + ProjValAfterReinvestRet_M +
		ProjValAfterReinvestDana_M  ;
		
		ProjValAfterReinvest2023_L = ProjDeduction2023_L + ReinvestCashFund2023_L;
		ProjValAfterReinvest2025_L = ProjDeduction2025_L + ReinvestCashFund2025_L;
		ProjValAfterReinvest2028_L = ProjDeduction2028_L + ReinvestCashFund2028_L;
		ProjValAfterReinvest2030_L = ProjDeduction2030_L + ReinvestCashFund2030_L;
		ProjValAfterReinvest2035_L = ProjDeduction2035_L + ReinvestCashFund2035_L;
		ProjValAfterReinvestRet_L = ProjDeductionRet_L + ReinvestCashFundRet_L;
		ProjValAfterReinvestDana_L = ProjDeductionDana_L + ReinvestCashFundDana_L;
		ProjValAfterReinvestCash_L = ReinvestCashFundSum_L;
		ProjValAfterReinvestSum_L = ProjValAfterReinvest2023_L + ProjValAfterReinvest2025_L + ProjValAfterReinvest2028_L + ProjValAfterReinvest2030_L + ProjValAfterReinvest2035_L + ProjValAfterReinvestRet_L +
		ProjValAfterReinvestDana_L  ;
	}
	//-------------------
	
	PrevPaidUpOptionTable_2023_High = ProjValAfterReinvest2023_H;
	PrevPaidUpOptionTable_2025_High = ProjValAfterReinvest2025_H;
	PrevPaidUpOptionTable_2028_High = ProjValAfterReinvest2028_H;
	PrevPaidUpOptionTable_2030_High = ProjValAfterReinvest2030_H;
	PrevPaidUpOptionTable_2035_High = ProjValAfterReinvest2035_H;
	PrevPaidUpOptionTable_Cash_High = ProjValAfterReinvestCash_H;
	PrevPaidUpOptionTable_Ret_High = ProjValAfterReinvestRet_H;
	PrevPaidUpOptionTable_Dana_High = ProjValAfterReinvestDana_H;
	
	PrevPaidUpOptionTable_2023_Median = ProjValAfterReinvest2023_M;
	PrevPaidUpOptionTable_2025_Median = ProjValAfterReinvest2025_M;
	PrevPaidUpOptionTable_2028_Median = ProjValAfterReinvest2028_M;
	PrevPaidUpOptionTable_2030_Median = ProjValAfterReinvest2030_M;
	PrevPaidUpOptionTable_2035_Median = ProjValAfterReinvest2035_M;
	PrevPaidUpOptionTable_Cash_Median = ProjValAfterReinvestCash_M;
	PrevPaidUpOptionTable_Ret_Median = ProjValAfterReinvestRet_M;
	PrevPaidUpOptionTable_Dana_Median = ProjValAfterReinvestDana_M;
	
	PrevPaidUpOptionTable_2023_Low = ProjValAfterReinvest2023_L;
	PrevPaidUpOptionTable_2025_Low = ProjValAfterReinvest2025_L;
	PrevPaidUpOptionTable_2028_Low = ProjValAfterReinvest2028_L;
	PrevPaidUpOptionTable_2030_Low = ProjValAfterReinvest2030_L;
	PrevPaidUpOptionTable_2035_Low = ProjValAfterReinvest2035_L;
	PrevPaidUpOptionTable_Cash_Low = ProjValAfterReinvestCash_L;
	PrevPaidUpOptionTable_Ret_Low = ProjValAfterReinvestRet_L;
	PrevPaidUpOptionTable_Dana_Low = ProjValAfterReinvestDana_L;
	
	
	int FromYear = [RPUOYear intValue] + 1;
	int ToYear;
	if (Age > 50) {
		ToYear = 75 - Age;
	}
	else{
		ToYear = 25;
	}
	
	double ReinvestRate2023 = 0.00;
	double ReinvestRate2025 = 0.00;
	double ReinvestRate2028 = 0.00;
	double ReinvestRate2030 = 0.00;
	double ReinvestRate2035 = 0.00;
	int ReinvestRate2023to2025, ReinvestRate2023to2028,ReinvestRate2023to2030,ReinvestRate2023to2035,ReinvestRate2023toCash,ReinvestRate2023toRet,ReinvestRate2023toDana;
	int ReinvestRate2025to2028, ReinvestRate2025to2030,ReinvestRate2025to2035,ReinvestRate2025toCash,ReinvestRate2025toRet,ReinvestRate2025toDana;
	int ReinvestRate2028to2030, ReinvestRate2028to2035,ReinvestRate2028toCash,ReinvestRate2028toRet,ReinvestRate2028toDana;
	int ReinvestRate2030to2035, ReinvestRate2030toCash,ReinvestRate2030toRet,ReinvestRate2030toDana;
	int ReinvestRate2035toCash, ReinvestRate2035toRet,ReinvestRate2035toDana;
	
	for (int polYear = FromYear; polYear <= ToYear; polYear++) {
		if (polYear == FundTerm2023) {
			if (Fund2023PartialReinvest == 0) {
				ReinvestRate2023 = 100; //meaning fully reinvest
			}
			else{
				ReinvestRate2023 = 100 - Fund2023PartialReinvest;
			}
			
			if (Fund2023PartialReinvest != 100) { //meaning not withdraw
				ReinvestRate2023to2025 = Fund2023ReinvestTo2025Fac;
				ReinvestRate2023to2028 = Fund2023ReinvestTo2028Fac;
				ReinvestRate2023to2030 = Fund2023ReinvestTo2030Fac;
				ReinvestRate2023to2035 = Fund2023ReinvestTo2035Fac;
				ReinvestRate2023toCash = Fund2023ReinvestToCashFac;
				ReinvestRate2023toDana = Fund2023ReinvestToDanaFac;
				ReinvestRate2023toRet = Fund2023ReinvestToRetFac;
			}
			else{
				ReinvestRate2023to2025 = 0.00;
				ReinvestRate2023to2028 = 0.00;
				ReinvestRate2023to2030 = 0.00;
				ReinvestRate2023to2035 = 0.00;
				ReinvestRate2023toCash = 0.00;
				ReinvestRate2023toDana = 0.00;
				ReinvestRate2023toRet = 0.00;
			}
			
			
			//---- for 2023
			ProjValueMaturity2023_H = [self PaidUpOptionTable_2023_H_Balance:PrevPaidUpOptionTable_2023_High andPolicyYear:polYear];
			ProjWithdraw2023_H = ProjValueMaturity2023_H * ((100 - ReinvestRate2023)/100.00);
			ProjReinvest2023_H = ProjValueMaturity2023_H - ProjWithdraw2023_H;
			
			ProjValueMaturity2023_M = [self PaidUpOptionTable_2023_M_Balance:PrevPaidUpOptionTable_2023_Median andPolicyYear:polYear];
			ProjWithdraw2023_M = ProjValueMaturity2023_M * ((100 - ReinvestRate2023)/100.00);
			ProjReinvest2023_M = ProjValueMaturity2023_M - ProjWithdraw2023_M;
			
			ProjValueMaturity2023_L = [self PaidUpOptionTable_2023_L_Balance:PrevPaidUpOptionTable_2023_Low andPolicyYear:polYear];
			ProjWithdraw2023_L = ProjValueMaturity2023_L * ((100 - ReinvestRate2023)/100.00);
			ProjReinvest2023_L = ProjValueMaturity2023_L - ProjWithdraw2023_L;
			//-------
			
			//-- for 2025---
			ReinvestAmount2023to2025_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023to2025/100.00);
			ProjValueMaturity2025_H = [self PaidUpOptionTable_2025_High:PrevPaidUpOptionTable_2025_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2025_High = ProjValueMaturity2025_H;
			
			ReinvestAmount2023to2025_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023to2025/100.00);
			ProjValueMaturity2025_M = [self PaidUpOptionTable_2025_Median:PrevPaidUpOptionTable_2025_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2025_Median = ProjValueMaturity2025_M;
			
			ReinvestAmount2023to2025_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023to2025/100.00);
			ProjValueMaturity2025_L = [self PaidUpOptionTable_2025_Low:PrevPaidUpOptionTable_2025_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2025_Low = ProjValueMaturity2025_L;
			//------------
			
			//-- for 2028---
			ReinvestAmount2023to2028_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023to2028/100.00);
			ProjValueMaturity2028_H = [self PaidUpOptionTable_2028_High:PrevPaidUpOptionTable_2028_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2028_High = ProjValueMaturity2028_H;
			
			ReinvestAmount2023to2028_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023to2028/100.00);
			ProjValueMaturity2028_M = [self PaidUpOptionTable_2028_Median:PrevPaidUpOptionTable_2028_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2028_Median = ProjValueMaturity2028_M;
			
			ReinvestAmount2023to2028_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023to2028/100.00);
			ProjValueMaturity2028_L = [self PaidUpOptionTable_2028_Low:PrevPaidUpOptionTable_2028_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2028_Low = ProjValueMaturity2028_L;
			//------------
			
			//-- for 2030---
			ReinvestAmount2023to2030_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023to2030/100.00);
			ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
			
			ReinvestAmount2023to2030_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023to2030/100.00);
			ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
			
			ReinvestAmount2023to2030_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023to2030/100.00);
			ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
			//------------
			
			//-- for 2035---
			ReinvestAmount2023to2035_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023to2035/100.00);
			ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
			
			ReinvestAmount2023to2035_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023to2035/100.00);
			ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
			
			ReinvestAmount2023to2035_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023to2035/100.00);
			ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			//------------
			
			//-- for Secure Fund---
			ReinvestAmount2023toRet_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023toRet/100.00);
			ProjValueMaturityRet_H = [self PaidUpOptionTable_Ret_High:PrevPaidUpOptionTable_Ret_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_High = ProjValueMaturityRet_H;
			
			ReinvestAmount2023toRet_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023toRet/100.00);
			ProjValueMaturityRet_M = [self PaidUpOptionTable_Ret_Median:PrevPaidUpOptionTable_Ret_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Median = ProjValueMaturityRet_M;
			
			ReinvestAmount2023toRet_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023toRet/100.00);
			ProjValueMaturityRet_L = [self PaidUpOptionTable_Ret_Low:PrevPaidUpOptionTable_Ret_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Low = ProjValueMaturityRet_L;
			//------------
			
			//-- for Dana Fund---
			ReinvestAmount2023toDana_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023toDana/100.00);
			ProjValueMaturityDana_H = [self PaidUpOptionTable_Dana_High:PrevPaidUpOptionTable_Dana_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_High = ProjValueMaturityDana_H;
			
			ReinvestAmount2023toDana_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023toDana/100.00);
			ProjValueMaturityDana_M = [self PaidUpOptionTable_Dana_Median:PrevPaidUpOptionTable_Dana_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Median = ProjValueMaturityDana_M;
			
			ReinvestAmount2023toDana_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023toDana/100.00);
			ProjValueMaturityDana_L = [self PaidUpOptionTable_Dana_Low:PrevPaidUpOptionTable_Dana_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Low = ProjValueMaturityDana_L;
			//------------
			
			//-- for Cash Fund---
			ReinvestAmount2023toCash_H = ProjValueMaturity2023_H * (ReinvestRate2023/100.00) * (ReinvestRate2023toCash/100.00);
			ProjValueMaturityCash_H = [self PaidUpOptionTable_Cash_High:PrevPaidUpOptionTable_Cash_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_High = ProjValueMaturityCash_H;
			
			ReinvestAmount2023toCash_M = ProjValueMaturity2023_M * (ReinvestRate2023/100.00) * (ReinvestRate2023toCash/100.00);
			ProjValueMaturityCash_M = [self PaidUpOptionTable_Cash_Median:PrevPaidUpOptionTable_Cash_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Median = ProjValueMaturityCash_M;
			
			ReinvestAmount2023toCash_L = ProjValueMaturity2023_L * (ReinvestRate2023/100.00) * (ReinvestRate2023toCash/100.00);
			ProjValueMaturityCash_L = [self PaidUpOptionTable_Cash_Low:PrevPaidUpOptionTable_Cash_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Low = ProjValueMaturityCash_L;
			//------------
			
		}
		
		else if (polYear == FundTerm2025) {
			
			if (Fund2025PartialReinvest == 0) {
				ReinvestRate2025 = 100; //meaning 2025 is fully reinvest
			}
			else{
				ReinvestRate2025 = 100 - Fund2025PartialReinvest;
			}
			
			if (Fund2025PartialReinvest != 100) { //meaning 2025 is not withdraw
				ReinvestRate2025to2028 = Fund2025ReinvestTo2028Fac;
				ReinvestRate2025to2030 = Fund2025ReinvestTo2030Fac;
				ReinvestRate2025to2035 = Fund2025ReinvestTo2035Fac;
				ReinvestRate2025toCash = Fund2025ReinvestToCashFac;
				ReinvestRate2025toDana = Fund2025ReinvestToDanaFac;
				ReinvestRate2025toRet = Fund2025ReinvestToRetFac;
			}
			else{
				ReinvestRate2025to2028 = 0.00;
				ReinvestRate2025to2030 = 0.00;
				ReinvestRate2025to2035 = 0.00;
				ReinvestRate2025toCash = 0.00;
				ReinvestRate2025toDana = 0.00;
				ReinvestRate2025toRet = 0.00;
			}
			
			//---- for 2025
			ProjValueMaturity2025_H = [self PaidUpOptionTable_2025_H_Balance:PrevPaidUpOptionTable_2025_High andPolicyYear:polYear];
			ProjWithdraw2025_H = ProjValueMaturity2025_H * ((100 - ReinvestRate2025)/100.00);
			ProjReinvest2025_H = ProjValueMaturity2025_H - ProjWithdraw2025_H;
			
			ProjValueMaturity2025_M = [self PaidUpOptionTable_2025_M_Balance:PrevPaidUpOptionTable_2025_Median andPolicyYear:polYear];
			ProjWithdraw2025_M = ProjValueMaturity2025_M * ((100 - ReinvestRate2025)/100.00);
			ProjReinvest2025_M = ProjValueMaturity2025_M - ProjWithdraw2025_M;
			
			ProjValueMaturity2025_L = [self PaidUpOptionTable_2025_L_Balance:PrevPaidUpOptionTable_2025_Low andPolicyYear:polYear];
			ProjWithdraw2025_L = ProjValueMaturity2025_L * ((100 - ReinvestRate2025)/100.00);
			ProjReinvest2025_L = ProjValueMaturity2025_L - ProjWithdraw2025_L;
			//-------
			
			// ---- for 2028
			ReinvestAmount2025to2028_H = ProjValueMaturity2025_H * (ReinvestRate2025/100.00) * (ReinvestRate2025to2028/100.00);
			ProjValueMaturity2028_H = [self PaidUpOptionTable_2028_High:PrevPaidUpOptionTable_2028_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2028_High = ProjValueMaturity2028_H;
			
			ReinvestAmount2025to2028_M = ProjValueMaturity2025_M * (ReinvestRate2025/100.00) * (ReinvestRate2025to2028/100.00);
			ProjValueMaturity2028_M = [self PaidUpOptionTable_2028_Median:PrevPaidUpOptionTable_2028_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2028_Median = ProjValueMaturity2028_M;
			
			ReinvestAmount2025to2028_L = ProjValueMaturity2025_L * (ReinvestRate2025/100.00) * (ReinvestRate2025to2028/100.00);
			ProjValueMaturity2028_L = [self PaidUpOptionTable_2028_Low:PrevPaidUpOptionTable_2028_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2028_Low = ProjValueMaturity2028_L;
			// -----
			
			// ---- for 2030
			ReinvestAmount2025to2030_H = ProjValueMaturity2025_H * (ReinvestRate2025/100.00) * (ReinvestRate2025to2030/100.00);
			ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
			
			ReinvestAmount2025to2030_M = ProjValueMaturity2025_M * (ReinvestRate2025/100.00) * (ReinvestRate2025to2030/100.00);
			ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
			
			ReinvestAmount2025to2030_L = ProjValueMaturity2025_L * (ReinvestRate2025/100.00) * (ReinvestRate2025to2030/100.00);
			ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
			// -----
			
			// ---- for 2035
			ReinvestAmount2025to2035_H = ProjValueMaturity2025_H * (ReinvestRate2025/100.00) * (ReinvestRate2025to2035/100.00);
			ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
			
			ReinvestAmount2025to2035_M = ProjValueMaturity2025_M * (ReinvestRate2025/100.00) * (ReinvestRate2025to2035/100.00);
			ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
			
			ReinvestAmount2025to2035_L = ProjValueMaturity2025_L * (ReinvestRate2025/100.00) * (ReinvestRate2025to2035/100.00);
			ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			// -----
			
			//-- for Secure Fund---
			ReinvestAmount2025toRet_H = ProjValueMaturity2025_H * (ReinvestRate2025/100.00) * (ReinvestRate2025toRet/100.00);
			ProjValueMaturityRet_H = [self PaidUpOptionTable_Ret_High:PrevPaidUpOptionTable_Ret_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_High = ProjValueMaturityRet_H;
			
			ReinvestAmount2025toRet_M = ProjValueMaturity2025_M * (ReinvestRate2025/100.00) * (ReinvestRate2025toRet/100.00);
			ProjValueMaturityRet_M = [self PaidUpOptionTable_Ret_Median:PrevPaidUpOptionTable_Ret_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Median = ProjValueMaturityRet_M;
			
			ReinvestAmount2025toRet_L = ProjValueMaturity2025_L * (ReinvestRate2025/100.00) * (ReinvestRate2025toRet/100.00);
			ProjValueMaturityRet_L = [self PaidUpOptionTable_Ret_Low:PrevPaidUpOptionTable_Ret_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Low = ProjValueMaturityRet_L;
			//------------
			
			//-- for Dana Fund---
			ReinvestAmount2025toDana_H = ProjValueMaturity2025_H * (ReinvestRate2025/100.00) * (ReinvestRate2025toDana/100.00);
			ProjValueMaturityDana_H = [self PaidUpOptionTable_Dana_High:PrevPaidUpOptionTable_Dana_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_High = ProjValueMaturityDana_H;
			
			ReinvestAmount2025toDana_M = ProjValueMaturity2025_M * (ReinvestRate2025/100.00) * (ReinvestRate2025toDana/100.00);
			ProjValueMaturityDana_M = [self PaidUpOptionTable_Dana_Median:PrevPaidUpOptionTable_Dana_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Median = ProjValueMaturityDana_M;
			
			ReinvestAmount2025toDana_L = ProjValueMaturity2025_L * (ReinvestRate2025/100.00) * (ReinvestRate2025toDana/100.00);
			ProjValueMaturityDana_L = [self PaidUpOptionTable_Dana_Low:PrevPaidUpOptionTable_Dana_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Low = ProjValueMaturityDana_L;
			//------------
			
			//-- for Cash Fund---
			ReinvestAmount2025toCash_H = ProjValueMaturity2025_H * (ReinvestRate2025/100.00) * (ReinvestRate2025toCash/100.00);
			ProjValueMaturityCash_H = [self PaidUpOptionTable_Cash_High:PrevPaidUpOptionTable_Cash_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_High = ProjValueMaturityCash_H;
			
			ReinvestAmount2025toCash_M = ProjValueMaturity2025_M * (ReinvestRate2025/100.00) * (ReinvestRate2025toCash/100.00);
			ProjValueMaturityCash_M = [self PaidUpOptionTable_Cash_Median:PrevPaidUpOptionTable_Cash_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Median = ProjValueMaturityCash_M;
			
			ReinvestAmount2025toCash_L = ProjValueMaturity2025_L * (ReinvestRate2025/100.00) * (ReinvestRate2025toCash/100.00);
			ProjValueMaturityCash_L = [self PaidUpOptionTable_Cash_Low:PrevPaidUpOptionTable_Cash_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Low = ProjValueMaturityCash_L;
			//------------
			
		}
		else if (polYear == FundTerm2028) {
			
			if (Fund2028PartialReinvest == 0) {
				ReinvestRate2028 = 100; //meaning 2028 is fully reinvest
			}
			else{
				ReinvestRate2028 = 100 - Fund2028PartialReinvest;
			}
			
			if (Fund2028PartialReinvest != 100) { //meaning 2028 is not withdraw
				ReinvestRate2028to2030 = Fund2028ReinvestTo2030Fac;
				ReinvestRate2028to2035 = Fund2028ReinvestTo2035Fac;
				ReinvestRate2028toCash = Fund2028ReinvestToCashFac;
				ReinvestRate2028toDana = Fund2028ReinvestToDanaFac;
				ReinvestRate2028toRet = Fund2028ReinvestToRetFac;
			}
			else{
				ReinvestRate2028to2030 = 0.00;
				ReinvestRate2028to2035 = 0.00;
				ReinvestRate2028toCash = 0.00;
				ReinvestRate2028toDana = 0.00;
				ReinvestRate2028toRet = 0.00;
			}
			
			//---- for 2028
			ProjValueMaturity2028_H = [self PaidUpOptionTable_2028_H_Balance:PrevPaidUpOptionTable_2028_High andPolicyYear:polYear];
			ProjWithdraw2028_H = ProjValueMaturity2028_H * ((100 - ReinvestRate2028)/100.00);
			ProjReinvest2028_H = ProjValueMaturity2028_H - ProjWithdraw2028_H;
			
			ProjValueMaturity2028_M = [self PaidUpOptionTable_2028_M_Balance:PrevPaidUpOptionTable_2028_Median andPolicyYear:polYear];
			ProjWithdraw2028_M = ProjValueMaturity2028_M * ((100 - ReinvestRate2028)/100.00);
			ProjReinvest2028_M = ProjValueMaturity2028_M - ProjWithdraw2028_M;
			
			ProjValueMaturity2028_L = [self PaidUpOptionTable_2028_L_Balance:PrevPaidUpOptionTable_2028_Low andPolicyYear:polYear];
			ProjWithdraw2028_L = ProjValueMaturity2028_L * ((100 - ReinvestRate2028)/100.00);
			ProjReinvest2028_L = ProjValueMaturity2028_L - ProjWithdraw2028_L;
			//-------
			
			// ---- for 2030
			ReinvestAmount2028to2030_H = ProjValueMaturity2028_H * (ReinvestRate2028/100.00) * (ReinvestRate2028to2030/100.00);
			ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
			
			ReinvestAmount2028to2030_M = ProjValueMaturity2028_M * (ReinvestRate2028/100.00) * (ReinvestRate2028to2030/100.00);
			ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
			
			ReinvestAmount2028to2030_L = ProjValueMaturity2028_L * (ReinvestRate2028/100.00) * (ReinvestRate2028to2030/100.00);
			ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
			// -----
			
			// ---- for 2035
			ReinvestAmount2028to2035_H = ProjValueMaturity2028_H * (ReinvestRate2028/100.00) * (ReinvestRate2028to2035/100.00);
			ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
			
			ReinvestAmount2028to2035_M = ProjValueMaturity2028_M * (ReinvestRate2028/100.00) * (ReinvestRate2028to2035/100.00);
			ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
			
			ReinvestAmount2028to2035_L = ProjValueMaturity2028_L * (ReinvestRate2028/100.00) * (ReinvestRate2028to2035/100.00);
			ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			// -----
			
			//-- for Secure Fund---
			ReinvestAmount2028toRet_H = ProjValueMaturity2028_H * (ReinvestRate2028/100.00) * (ReinvestRate2028toRet/100.00);
			ProjValueMaturityRet_H = [self PaidUpOptionTable_Ret_High:PrevPaidUpOptionTable_Ret_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_High = ProjValueMaturityRet_H;
			
			ReinvestAmount2028toRet_M = ProjValueMaturity2028_M * (ReinvestRate2028/100.00) * (ReinvestRate2028toRet/100.00);
			ProjValueMaturityRet_M = [self PaidUpOptionTable_Ret_Median:PrevPaidUpOptionTable_Ret_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Median = ProjValueMaturityRet_M;
			
			ReinvestAmount2028toRet_L = ProjValueMaturity2028_L * (ReinvestRate2028/100.00) * (ReinvestRate2028toRet/100.00);
			ProjValueMaturityRet_L = [self PaidUpOptionTable_Ret_Low:PrevPaidUpOptionTable_Ret_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Low = ProjValueMaturityRet_L;
			//------------
			
			//-- for Dana Fund---
			ReinvestAmount2028toDana_H = ProjValueMaturity2028_H * (ReinvestRate2028/100.00) * (ReinvestRate2028toDana/100.00);
			ProjValueMaturityDana_H = [self PaidUpOptionTable_Dana_High:PrevPaidUpOptionTable_Dana_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_High = ProjValueMaturityDana_H;
			
			ReinvestAmount2028toDana_M = ProjValueMaturity2028_M * (ReinvestRate2028/100.00) * (ReinvestRate2028toDana/100.00);
			ProjValueMaturityDana_M = [self PaidUpOptionTable_Dana_Median:PrevPaidUpOptionTable_Dana_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Median = ProjValueMaturityDana_M;
			
			ReinvestAmount2028toDana_L = ProjValueMaturity2028_L * (ReinvestRate2028/100.00) * (ReinvestRate2028toDana/100.00);
			ProjValueMaturityDana_L = [self PaidUpOptionTable_Dana_Low:PrevPaidUpOptionTable_Dana_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Low = ProjValueMaturityDana_L;
			//------------
			
			//-- for Cash Fund---
			ReinvestAmount2028toCash_H = ProjValueMaturity2028_H * (ReinvestRate2028/100.00) * (ReinvestRate2028toCash/100.00);
			ProjValueMaturityCash_H = [self PaidUpOptionTable_Cash_High:PrevPaidUpOptionTable_Cash_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_High = ProjValueMaturityCash_H;
			
			ReinvestAmount2028toCash_M = ProjValueMaturity2028_M * (ReinvestRate2028/100.00) * (ReinvestRate2028toCash/100.00);
			ProjValueMaturityCash_M = [self PaidUpOptionTable_Cash_Median:PrevPaidUpOptionTable_Cash_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Median = ProjValueMaturityCash_M;
			
			ReinvestAmount2028toCash_L = ProjValueMaturity2028_L * (ReinvestRate2028/100.00) * (ReinvestRate2028toCash/100.00);
			ProjValueMaturityCash_L = [self PaidUpOptionTable_Cash_Low:PrevPaidUpOptionTable_Cash_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Low = ProjValueMaturityCash_L;
			//------------
			
		}
		else if (polYear == FundTerm2030) {
			
			if (Fund2030PartialReinvest == 0) {
				ReinvestRate2030 = 100; //meaning 2030 is fully reinvest
			}
			else{
				ReinvestRate2030 = 100 - Fund2030PartialReinvest;
			}
			
			if (Fund2030PartialReinvest != 100) { //meaning 2030 is not withdraw
				ReinvestRate2030to2035 = Fund2030ReinvestTo2035Fac;
				ReinvestRate2030toCash = Fund2030ReinvestToCashFac;
				ReinvestRate2030toDana = Fund2030ReinvestToDanaFac;
				ReinvestRate2030toRet = Fund2030ReinvestToRetFac;
			}
			else{
				ReinvestRate2030to2035 = 0.00;
				ReinvestRate2030toCash = 0.00;
				ReinvestRate2030toDana = 0.00;
				ReinvestRate2030toRet = 0.00;
			}
			
			//---- for 2030
			ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_H_Balance:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
			ProjWithdraw2030_H = ProjValueMaturity2030_H * ((100 - ReinvestRate2030)/100.00);
			ProjReinvest2030_H = ProjValueMaturity2030_H - ProjWithdraw2030_H;
			
			ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_M_Balance:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
			ProjWithdraw2030_M = ProjValueMaturity2030_M * ((100 - ReinvestRate2030)/100.00);
			ProjReinvest2030_M = ProjValueMaturity2030_M - ProjWithdraw2030_M;
			
			ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_L_Balance:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
			ProjWithdraw2030_L = ProjValueMaturity2030_L * ((100 - ReinvestRate2030)/100.00);
			ProjReinvest2030_L = ProjValueMaturity2030_L - ProjWithdraw2030_L;
			//-------
			
			// ---- for 2035
			ReinvestAmount2030to2035_H = ProjValueMaturity2030_H * (ReinvestRate2030/100.00) * (ReinvestRate2030to2035/100.00);
			ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
			
			ReinvestAmount2030to2035_M = ProjValueMaturity2030_M * (ReinvestRate2030/100.00) * (ReinvestRate2030to2035/100.00);
			ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
			
			ReinvestAmount2030to2035_L = ProjValueMaturity2030_L * (ReinvestRate2030/100.00) * (ReinvestRate2030to2035/100.00);
			ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			// -----
			
			//-- for Secure Fund---
			ReinvestAmount2030toRet_H = ProjValueMaturity2030_H * (ReinvestRate2030/100.00) * (ReinvestRate2030toRet/100.00);
			ProjValueMaturityRet_H = [self PaidUpOptionTable_Ret_High:PrevPaidUpOptionTable_Ret_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_High = ProjValueMaturityRet_H;
			
			ReinvestAmount2030toRet_M = ProjValueMaturity2030_M * (ReinvestRate2030/100.00) * (ReinvestRate2030toRet/100.00);
			ProjValueMaturityRet_M = [self PaidUpOptionTable_Ret_Median:PrevPaidUpOptionTable_Ret_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Median = ProjValueMaturityRet_M;
			
			ReinvestAmount2030toRet_L = ProjValueMaturity2030_L * (ReinvestRate2030/100.00) * (ReinvestRate2030toRet/100.00);
			ProjValueMaturityRet_L = [self PaidUpOptionTable_Ret_Low:PrevPaidUpOptionTable_Ret_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Low = ProjValueMaturityRet_L;
			//------------
			
			//-- for Dana Fund---
			ReinvestAmount2030toDana_H = ProjValueMaturity2030_H * (ReinvestRate2030/100.00) * (ReinvestRate2030toDana/100.00);
			ProjValueMaturityDana_H = [self PaidUpOptionTable_Dana_High:PrevPaidUpOptionTable_Dana_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_High = ProjValueMaturityDana_H;
			
			ReinvestAmount2030toDana_M = ProjValueMaturity2030_M * (ReinvestRate2030/100.00) * (ReinvestRate2030toDana/100.00);
			ProjValueMaturityDana_M = [self PaidUpOptionTable_Dana_Median:PrevPaidUpOptionTable_Dana_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Median = ProjValueMaturityDana_M;
			
			ReinvestAmount2030toDana_L = ProjValueMaturity2030_L * (ReinvestRate2030/100.00) * (ReinvestRate2030toDana/100.00);
			ProjValueMaturityDana_L = [self PaidUpOptionTable_Dana_Low:PrevPaidUpOptionTable_Dana_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Low = ProjValueMaturityDana_L;
			//------------
			
			//-- for Cash Fund---
			ReinvestAmount2030toCash_H = ProjValueMaturity2030_H * (ReinvestRate2030/100.00) * (ReinvestRate2030toCash/100.00);
			ProjValueMaturityCash_H = [self PaidUpOptionTable_Cash_High:PrevPaidUpOptionTable_Cash_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_High = ProjValueMaturityCash_H;
			
			ReinvestAmount2030toCash_M = ProjValueMaturity2030_M * (ReinvestRate2030/100.00) * (ReinvestRate2030toCash/100.00);
			ProjValueMaturityCash_M = [self PaidUpOptionTable_Cash_Median:PrevPaidUpOptionTable_Cash_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Median = ProjValueMaturityCash_M;
			
			ReinvestAmount2030toCash_L = ProjValueMaturity2030_L * (ReinvestRate2030/100.00) * (ReinvestRate2030toCash/100.00);
			ProjValueMaturityCash_L = [self PaidUpOptionTable_Cash_Low:PrevPaidUpOptionTable_Cash_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Low = ProjValueMaturityCash_L;
			//------------
			
		}
		else if (polYear == FundTerm2035) {
			
			if (Fund2035PartialReinvest == 0) {
				ReinvestRate2035 = 100; //meaning 2035 is fully reinvest
			}
			else{
				ReinvestRate2035 = 100 - Fund2035PartialReinvest;
			}
			
			if (Fund2035PartialReinvest != 100) { //meaning 2035 is not withdraw
				ReinvestRate2035toCash = Fund2035ReinvestToCashFac;
				ReinvestRate2035toDana = Fund2035ReinvestToDanaFac;
				ReinvestRate2035toRet = Fund2035ReinvestToRetFac;
			}
			else{
				ReinvestRate2035toCash = 0.00;
				ReinvestRate2035toDana = 0.00;
				ReinvestRate2035toRet = 0.00;
			}
			
			//---- for 2035
			ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_H_Balance:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
			ProjWithdraw2035_H = ProjValueMaturity2035_H * ((100 - ReinvestRate2035)/100.00);
			ProjReinvest2035_H = ProjValueMaturity2035_H - ProjWithdraw2035_H;
			
			ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_M_Balance:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
			ProjWithdraw2035_M = ProjValueMaturity2035_M * ((100 - ReinvestRate2035)/100.00);
			ProjReinvest2035_M = ProjValueMaturity2035_M - ProjWithdraw2035_M;
			
			ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_L_Balance:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
			ProjWithdraw2035_L = ProjValueMaturity2035_L * ((100 - ReinvestRate2035)/100.00);
			ProjReinvest2035_L = ProjValueMaturity2035_L - ProjWithdraw2035_L;
			//-------
			
			//-- for Secure Fund---
			ReinvestAmount2035toRet_H = ProjValueMaturity2035_H * (ReinvestRate2035/100.00) * (ReinvestRate2035toRet/100.00);
			ProjValueMaturityRet_H = [self PaidUpOptionTable_Ret_High:PrevPaidUpOptionTable_Ret_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_High = ProjValueMaturityRet_H;
			
			ReinvestAmount2035toRet_M = ProjValueMaturity2035_M * (ReinvestRate2035/100.00) * (ReinvestRate2035toRet/100.00);
			ProjValueMaturityRet_M = [self PaidUpOptionTable_Ret_Median:PrevPaidUpOptionTable_Ret_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Median = ProjValueMaturityRet_M;
			
			ReinvestAmount2035toRet_L = ProjValueMaturity2035_L * (ReinvestRate2035/100.00) * (ReinvestRate2035toRet/100.00);
			ProjValueMaturityRet_L = [self PaidUpOptionTable_Ret_Low:PrevPaidUpOptionTable_Ret_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Low = ProjValueMaturityRet_L;
			//------------
			
			//-- for Dana Fund---
			ReinvestAmount2035toDana_H = ProjValueMaturity2035_H * (ReinvestRate2035/100.00) * (ReinvestRate2035toDana/100.00);
			ProjValueMaturityDana_H = [self PaidUpOptionTable_Dana_High:PrevPaidUpOptionTable_Dana_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_High = ProjValueMaturityDana_H;
			
			ReinvestAmount2035toDana_M = ProjValueMaturity2035_M * (ReinvestRate2035/100.00) * (ReinvestRate2035toDana/100.00);
			ProjValueMaturityDana_M = [self PaidUpOptionTable_Dana_Median:PrevPaidUpOptionTable_Dana_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Median = ProjValueMaturityDana_M;
			
			ReinvestAmount2035toDana_L = ProjValueMaturity2035_L * (ReinvestRate2035/100.00) * (ReinvestRate2035toDana/100.00);
			ProjValueMaturityDana_L = [self PaidUpOptionTable_Dana_Low:PrevPaidUpOptionTable_Dana_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Low = ProjValueMaturityDana_L;
			//------------
			
			//-- for Cash Fund---
			ReinvestAmount2035toCash_H = ProjValueMaturity2035_H * (ReinvestRate2035/100.00) * (ReinvestRate2035toCash/100.00);
			ProjValueMaturityCash_H = [self PaidUpOptionTable_Cash_High:PrevPaidUpOptionTable_Cash_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_High = ProjValueMaturityCash_H;
			
			ReinvestAmount2035toCash_M = ProjValueMaturity2035_M * (ReinvestRate2035/100.00) * (ReinvestRate2035toCash/100.00);
			ProjValueMaturityCash_M = [self PaidUpOptionTable_Cash_Median:PrevPaidUpOptionTable_Cash_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Median = ProjValueMaturityCash_M;
			
			ReinvestAmount2035toCash_L = ProjValueMaturity2035_L * (ReinvestRate2035/100.00) * (ReinvestRate2035toCash/100.00);
			ProjValueMaturityCash_L = [self PaidUpOptionTable_Cash_Low:PrevPaidUpOptionTable_Cash_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Low = ProjValueMaturityCash_L;
			//------------
			
			
		}
		else{
			ProjValueMaturityRet_H = [self PaidUpOptionTable_Ret_High:PrevPaidUpOptionTable_Ret_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_High = ProjValueMaturityRet_H;
			ProjValueMaturityRet_M = [self PaidUpOptionTable_Ret_Median:PrevPaidUpOptionTable_Ret_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Median = ProjValueMaturityRet_M;
			ProjValueMaturityRet_L = [self PaidUpOptionTable_Ret_Low:PrevPaidUpOptionTable_Ret_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Ret_Low = ProjValueMaturityRet_L;
			
			ProjValueMaturityCash_H = [self PaidUpOptionTable_Cash_High:PrevPaidUpOptionTable_Cash_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_High = ProjValueMaturityCash_H;
			ProjValueMaturityCash_M = [self PaidUpOptionTable_Cash_Median:PrevPaidUpOptionTable_Cash_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Median = ProjValueMaturityCash_M;
			ProjValueMaturityCash_L = [self PaidUpOptionTable_Cash_Low:PrevPaidUpOptionTable_Cash_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Cash_Low = ProjValueMaturityCash_L;
			
			ProjValueMaturityDana_H = [self PaidUpOptionTable_Dana_High:PrevPaidUpOptionTable_Dana_High andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_High = ProjValueMaturityDana_H;
			ProjValueMaturityDana_M = [self PaidUpOptionTable_Dana_Median:PrevPaidUpOptionTable_Dana_Median andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Median = ProjValueMaturityDana_M;
			ProjValueMaturityDana_L = [self PaidUpOptionTable_Dana_Low:PrevPaidUpOptionTable_Dana_Low andPolicyYear:polYear];
			PrevPaidUpOptionTable_Dana_Low = ProjValueMaturityDana_L;
			
			
			if(polYear < FundTerm2023){
				ProjValueMaturity2023_H = [self PaidUpOptionTable_2023_High:PrevPaidUpOptionTable_2023_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2023_High = ProjValueMaturity2023_H;
				ProjValueMaturity2023_M = [self PaidUpOptionTable_2023_Median:PrevPaidUpOptionTable_2023_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2023_Median = ProjValueMaturity2023_M;
				ProjValueMaturity2023_L = [self PaidUpOptionTable_2023_Low:PrevPaidUpOptionTable_2023_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2023_Low = ProjValueMaturity2023_L;
				
				ProjValueMaturity2025_H = [self PaidUpOptionTable_2025_High:PrevPaidUpOptionTable_2025_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2025_High = ProjValueMaturity2025_H;
				ProjValueMaturity2025_M = [self PaidUpOptionTable_2025_Median:PrevPaidUpOptionTable_2025_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2025_Median = ProjValueMaturity2025_M;
				ProjValueMaturity2025_L = [self PaidUpOptionTable_2025_Low:PrevPaidUpOptionTable_2025_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2025_Low = ProjValueMaturity2025_L;
				
				ProjValueMaturity2028_H = [self PaidUpOptionTable_2028_High:PrevPaidUpOptionTable_2028_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_High = ProjValueMaturity2028_H;
				ProjValueMaturity2028_M = [self PaidUpOptionTable_2028_Median:PrevPaidUpOptionTable_2028_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_Median = ProjValueMaturity2028_M;
				ProjValueMaturity2028_L = [self PaidUpOptionTable_2028_Low:PrevPaidUpOptionTable_2028_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_Low = ProjValueMaturity2028_L;
				
				ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
				ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
				ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
				
				ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
				ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
				ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			}
			else if(polYear < FundTerm2025){
				ProjValueMaturity2025_H = [self PaidUpOptionTable_2025_High:PrevPaidUpOptionTable_2025_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2025_High = ProjValueMaturity2025_H;
				ProjValueMaturity2025_M = [self PaidUpOptionTable_2025_Median:PrevPaidUpOptionTable_2025_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2025_Median = ProjValueMaturity2025_M;
				ProjValueMaturity2025_L = [self PaidUpOptionTable_2025_Low:PrevPaidUpOptionTable_2025_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2025_Low = ProjValueMaturity2025_L;
				
				ProjValueMaturity2028_H = [self PaidUpOptionTable_2028_High:PrevPaidUpOptionTable_2028_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_High = ProjValueMaturity2028_H;
				ProjValueMaturity2028_M = [self PaidUpOptionTable_2028_Median:PrevPaidUpOptionTable_2028_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_Median = ProjValueMaturity2028_M;
				ProjValueMaturity2028_L = [self PaidUpOptionTable_2028_Low:PrevPaidUpOptionTable_2028_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_Low = ProjValueMaturity2028_L;
				
				ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
				ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
				ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
				
				ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
				ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
				ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			}
			else if(polYear < FundTerm2028){
				
				ProjValueMaturity2028_H = [self PaidUpOptionTable_2028_High:PrevPaidUpOptionTable_2028_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_High = ProjValueMaturity2028_H;
				ProjValueMaturity2028_M = [self PaidUpOptionTable_2028_Median:PrevPaidUpOptionTable_2028_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_Median = ProjValueMaturity2028_M;
				ProjValueMaturity2028_L = [self PaidUpOptionTable_2028_Low:PrevPaidUpOptionTable_2028_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2028_Low = ProjValueMaturity2028_L;
				
				ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
				ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
				ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
				
				ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
				ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
				ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			}
			else if(polYear < FundTerm2030){
				
				ProjValueMaturity2030_H = [self PaidUpOptionTable_2030_High:PrevPaidUpOptionTable_2030_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_High = ProjValueMaturity2030_H;
				ProjValueMaturity2030_M = [self PaidUpOptionTable_2030_Median:PrevPaidUpOptionTable_2030_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Median = ProjValueMaturity2030_M;
				ProjValueMaturity2030_L = [self PaidUpOptionTable_2030_Low:PrevPaidUpOptionTable_2030_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2030_Low = ProjValueMaturity2030_L;
				
				ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
				ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
				ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			}
			else if(polYear < FundTerm2035){
				
				ProjValueMaturity2035_H = [self PaidUpOptionTable_2035_High:PrevPaidUpOptionTable_2035_High andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_High = ProjValueMaturity2035_H;
				ProjValueMaturity2035_M = [self PaidUpOptionTable_2035_Median:PrevPaidUpOptionTable_2035_Median andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Median = ProjValueMaturity2035_M;
				ProjValueMaturity2035_L = [self PaidUpOptionTable_2035_Low:PrevPaidUpOptionTable_2035_Low andPolicyYear:polYear];
				PrevPaidUpOptionTable_2035_Low = ProjValueMaturity2035_L;
			}
		}
		
		//NSLog(@"%d %f %f %f", polYear, ProjValueMaturityCash_H,ProjValueMaturityCash_M,ProjValueMaturityCash_L);
	}
	
	return TRUE;

}


@end
