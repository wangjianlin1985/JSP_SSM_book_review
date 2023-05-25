package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ProductClass {
    /*图书分类id*/
    private Integer productClassId;
    public Integer getProductClassId(){
        return productClassId;
    }
    public void setProductClassId(Integer productClassId){
        this.productClassId = productClassId;
    }

    /*图书分类名称*/
    @NotEmpty(message="图书分类名称不能为空")
    private String productName;
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonProductClass=new JSONObject(); 
		jsonProductClass.accumulate("productClassId", this.getProductClassId());
		jsonProductClass.accumulate("productName", this.getProductName());
		return jsonProductClass;
    }}