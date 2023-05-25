package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Product {
    /*图书id*/
    private Integer productId;
    public Integer getProductId(){
        return productId;
    }
    public void setProductId(Integer productId){
        this.productId = productId;
    }

    /*图书分类*/
    private ProductClass productClassObj;
    public ProductClass getProductClassObj() {
        return productClassObj;
    }
    public void setProductClassObj(ProductClass productClassObj) {
        this.productClassObj = productClassObj;
    }

    /*图书名称*/
    @NotEmpty(message="图书名称不能为空")
    private String productName;
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /*图书图片*/
    private String productPhoto;
    public String getProductPhoto() {
        return productPhoto;
    }
    public void setProductPhoto(String productPhoto) {
        this.productPhoto = productPhoto;
    }

    /*作者*/
    @NotEmpty(message="作者不能为空")
    private String author;
    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }

    /*出版社*/
    @NotEmpty(message="出版社不能为空")
    private String publish;
    public String getPublish() {
        return publish;
    }
    public void setPublish(String publish) {
        this.publish = publish;
    }

    /*出版日期*/
    @NotEmpty(message="出版日期不能为空")
    private String publishDate;
    public String getPublishDate() {
        return publishDate;
    }
    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    /*页数*/
    @NotNull(message="必须输入页数")
    private Integer pageNum;
    public Integer getPageNum() {
        return pageNum;
    }
    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    /*字数*/
    @NotEmpty(message="字数不能为空")
    private String wordNum;
    public String getWordNum() {
        return wordNum;
    }
    public void setWordNum(String wordNum) {
        this.wordNum = wordNum;
    }

    /*ISBN*/
    @NotEmpty(message="ISBN不能为空")
    private String isbn;
    public String getIsbn() {
        return isbn;
    }
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    /*图书定价*/
    @NotNull(message="必须输入图书定价")
    private Float productPrice;
    public Float getProductPrice() {
        return productPrice;
    }
    public void setProductPrice(Float productPrice) {
        this.productPrice = productPrice;
    }

    /*图书简介*/
    @NotEmpty(message="图书简介不能为空")
    private String productDesc;
    public String getProductDesc() {
        return productDesc;
    }
    public void setProductDesc(String productDesc) {
        this.productDesc = productDesc;
    }

    /*图书文件*/
    private String productFile;
    public String getProductFile() {
        return productFile;
    }
    public void setProductFile(String productFile) {
        this.productFile = productFile;
    }

    /*是否推荐*/
    @NotEmpty(message="是否推荐不能为空")
    private String recommandFlag;
    public String getRecommandFlag() {
        return recommandFlag;
    }
    public void setRecommandFlag(String recommandFlag) {
        this.recommandFlag = recommandFlag;
    }

    /*图书评分*/
    @NotNull(message="必须输入图书评分")
    private Float productScore;
    public Float getProductScore() {
        return productScore;
    }
    public void setProductScore(Float productScore) {
        this.productScore = productScore;
    }

    /*添加时间*/
    @NotEmpty(message="添加时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonProduct=new JSONObject(); 
		jsonProduct.accumulate("productId", this.getProductId());
		jsonProduct.accumulate("productClassObj", this.getProductClassObj().getProductName());
		jsonProduct.accumulate("productClassObjPri", this.getProductClassObj().getProductClassId());
		jsonProduct.accumulate("productName", this.getProductName());
		jsonProduct.accumulate("productPhoto", this.getProductPhoto());
		jsonProduct.accumulate("author", this.getAuthor());
		jsonProduct.accumulate("publish", this.getPublish());
		jsonProduct.accumulate("publishDate", this.getPublishDate().length()>19?this.getPublishDate().substring(0,19):this.getPublishDate());
		jsonProduct.accumulate("pageNum", this.getPageNum());
		jsonProduct.accumulate("wordNum", this.getWordNum());
		jsonProduct.accumulate("isbn", this.getIsbn());
		jsonProduct.accumulate("productPrice", this.getProductPrice());
		jsonProduct.accumulate("productDesc", this.getProductDesc());
		jsonProduct.accumulate("productFile", this.getProductFile());
		jsonProduct.accumulate("recommandFlag", this.getRecommandFlag());
		jsonProduct.accumulate("productScore", this.getProductScore());
		jsonProduct.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonProduct;
    }}