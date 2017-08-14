package com.hhgx.soft.entitys;

public class OnDutyRecord {

	private String orgid;            //防火单位编号
	private String recordID;         //编号
	private String recordTime;       //时间
	private String fireControlor;    //火灾报警控制器运行情况
	private String gangcontrolor;    //联动控制器运行情况
	private String processResult;    //报警故障及处理情况
	private String controlorModel;   //火灾报警控制器型号
	private String selfcheck;        //自检
	private String eliminateVoice;   //消音
	private String reset;            //复位
	private String mainPower;        //主电源
	private String secondPower;      //备用电源
	private String faulthandling;    //故障及处理情况
	private String checkPeople;      //检查人
	private String dutySign;         //值班人签名

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public String getRecordID() {
		return recordID;
	}

	public void setRecordID(String recordID) {
		this.recordID = recordID;
	}

	public String getRecordTime() {
		return recordTime;
	}

	public void setRecordTime(String recordTime) {
		this.recordTime = recordTime;
	}

	public String getFireControlor() {
		return fireControlor;
	}

	public void setFireControlor(String fireControlor) {
		this.fireControlor = fireControlor;
	}

	public String getGangcontrolor() {
		return gangcontrolor;
	}

	public void setGangcontrolor(String gangcontrolor) {
		this.gangcontrolor = gangcontrolor;
	}

	public String getProcessResult() {
		return processResult;
	}

	public void setProcessResult(String processResult) {
		this.processResult = processResult;
	}

	public String getControlorModel() {
		return controlorModel;
	}

	public void setControlorModel(String controlorModel) {
		this.controlorModel = controlorModel;
	}

	public String getSelfcheck() {
		return selfcheck;
	}

	public void setSelfcheck(String selfcheck) {
		this.selfcheck = selfcheck;
	}

	public String getEliminateVoice() {
		return eliminateVoice;
	}

	public void setEliminateVoice(String eliminateVoice) {
		this.eliminateVoice = eliminateVoice;
	}

	public String getReset() {
		return reset;
	}

	public void setReset(String reset) {
		this.reset = reset;
	}

	public String getMainPower() {
		return mainPower;
	}

	public void setMainPower(String mainPower) {
		this.mainPower = mainPower;
	}

	public String getSecondPower() {
		return secondPower;
	}

	public void setSecondPower(String secondPower) {
		this.secondPower = secondPower;
	}

	public String getFaulthandling() {
		return faulthandling;
	}

	public void setFaulthandling(String faulthandling) {
		this.faulthandling = faulthandling;
	}

	public String getCheckPeople() {
		return checkPeople;
	}

	public void setCheckPeople(String checkPeople) {
		this.checkPeople = checkPeople;
	}

	public String getDutySign() {
		return dutySign;
	}

	public void setDutySign(String dutySign) {
		this.dutySign = dutySign;
	}

}
