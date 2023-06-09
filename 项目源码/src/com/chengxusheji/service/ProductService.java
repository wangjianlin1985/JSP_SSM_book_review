package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.ProductClass;
import com.chengxusheji.po.Product;

import com.chengxusheji.mapper.ProductMapper;
@Service
public class ProductService {

	@Resource ProductMapper productMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加图书记录*/
    public void addProduct(Product product) throws Exception {
    	productMapper.addProduct(product);
    }

    /*按照查询条件分页查询图书记录*/
    public ArrayList<Product> queryProduct(String productName,String author,String publish,String publishDate,String recommandFlag,String addTime,ProductClass productClassObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!productName.equals("")) where = where + " and t_product.productName like '%" + productName + "%'";
    	if(!author.equals("")) where = where + " and t_product.author like '%" + author + "%'";
    	if(!publish.equals("")) where = where + " and t_product.publish like '%" + publish + "%'";
    	if(!publishDate.equals("")) where = where + " and t_product.publishDate like '%" + publishDate + "%'";
    	if(!recommandFlag.equals("")) where = where + " and t_product.recommandFlag like '%" + recommandFlag + "%'";
    	if(!addTime.equals("")) where = where + " and t_product.addTime like '%" + addTime + "%'";
    	if(null != productClassObj && productClassObj.getProductClassId()!= null && productClassObj.getProductClassId()!= 0)  where += " and t_product.productClassObj=" + productClassObj.getProductClassId();
    	int startIndex = (currentPage-1) * this.rows;
    	return productMapper.queryProduct(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Product> queryProduct(String productName,String author,String publish,String publishDate,String recommandFlag,String addTime,ProductClass productClassObj) throws Exception  { 
     	String where = "where 1=1";
    	if(!productName.equals("")) where = where + " and t_product.productName like '%" + productName + "%'";
    	if(!author.equals("")) where = where + " and t_product.author like '%" + author + "%'";
    	if(!publish.equals("")) where = where + " and t_product.publish like '%" + publish + "%'";
    	if(!publishDate.equals("")) where = where + " and t_product.publishDate like '%" + publishDate + "%'";
    	if(!recommandFlag.equals("")) where = where + " and t_product.recommandFlag like '%" + recommandFlag + "%'";
    	if(!addTime.equals("")) where = where + " and t_product.addTime like '%" + addTime + "%'";
    	if(null != productClassObj && productClassObj.getProductClassId()!= null && productClassObj.getProductClassId()!= 0)  where += " and t_product.productClassObj=" + productClassObj.getProductClassId();
    	return productMapper.queryProductList(where);
    }

    /*查询所有图书记录*/
    public ArrayList<Product> queryAllProduct()  throws Exception {
        return productMapper.queryProductList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String productName,String author,String publish,String publishDate,String recommandFlag,String addTime,ProductClass productClassObj) throws Exception {
     	String where = "where 1=1";
    	if(!productName.equals("")) where = where + " and t_product.productName like '%" + productName + "%'";
    	if(!author.equals("")) where = where + " and t_product.author like '%" + author + "%'";
    	if(!publish.equals("")) where = where + " and t_product.publish like '%" + publish + "%'";
    	if(!publishDate.equals("")) where = where + " and t_product.publishDate like '%" + publishDate + "%'";
    	if(!recommandFlag.equals("")) where = where + " and t_product.recommandFlag like '%" + recommandFlag + "%'";
    	if(!addTime.equals("")) where = where + " and t_product.addTime like '%" + addTime + "%'";
    	if(null != productClassObj && productClassObj.getProductClassId()!= null && productClassObj.getProductClassId()!= 0)  where += " and t_product.productClassObj=" + productClassObj.getProductClassId();
        recordNumber = productMapper.queryProductCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取图书记录*/
    public Product getProduct(int productId) throws Exception  {
        Product product = productMapper.getProduct(productId);
        return product;
    }

    /*更新图书记录*/
    public void updateProduct(Product product) throws Exception {
        productMapper.updateProduct(product);
    }

    /*删除一条图书记录*/
    public void deleteProduct (int productId) throws Exception {
        productMapper.deleteProduct(productId);
    }

    /*删除多条图书信息*/
    public int deleteProducts (String productIds) throws Exception {
    	String _productIds[] = productIds.split(",");
    	for(String _productId: _productIds) {
    		productMapper.deleteProduct(Integer.parseInt(_productId));
    	}
    	return _productIds.length;
    }
}
