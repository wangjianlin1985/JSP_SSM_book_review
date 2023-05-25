package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.ProductCommentService;
import com.chengxusheji.service.ProductService;
import com.chengxusheji.po.Product;
import com.chengxusheji.po.ProductComment;
import com.chengxusheji.service.ProductClassService;
import com.chengxusheji.po.ProductClass;

//Product管理控制层
@Controller
@RequestMapping("/Product")
public class ProductController extends BaseController {

    /*业务层对象*/
    @Resource ProductService productService;
    @Resource ProductCommentService productCommentService;
    @Resource ProductClassService productClassService;
	@InitBinder("productClassObj")
	public void initBinderproductClassObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("productClassObj.");
	}
	@InitBinder("product")
	public void initBinderProduct(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("product.");
	}
	/*跳转到添加Product视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Product());
		/*查询所有的ProductClass信息*/
		List<ProductClass> productClassList = productClassService.queryAllProductClass();
		request.setAttribute("productClassList", productClassList);
		return "Product_add";
	}

	/*客户端ajax方式提交添加图书信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Product product, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			product.setProductPhoto(this.handlePhotoUpload(request, "productPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
		product.setProductFile(this.handleFileUpload(request, "productFileFile"));
        productService.addProduct(product);
        message = "图书添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询图书信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String productName,String author,String publish,String publishDate,String recommandFlag,String addTime,@ModelAttribute("productClassObj") ProductClass productClassObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (productName == null) productName = "";
		if (author == null) author = "";
		if (publish == null) publish = "";
		if (publishDate == null) publishDate = "";
		if (recommandFlag == null) recommandFlag = "";
		if (addTime == null) addTime = "";
		if(rows != 0)productService.setRows(rows);
		List<Product> productList = productService.queryProduct(productName, author, publish, publishDate, recommandFlag, addTime, productClassObj, page);
	    /*计算总的页数和总的记录数*/
	    productService.queryTotalPageAndRecordNumber(productName, author, publish, publishDate, recommandFlag, addTime, productClassObj);
	    /*获取到总的页码数目*/
	    int totalPage = productService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = productService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Product product:productList) {
			JSONObject jsonProduct = product.getJsonObject();
			jsonArray.put(jsonProduct);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询图书信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Product> productList = productService.queryAllProduct();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Product product:productList) {
			JSONObject jsonProduct = new JSONObject();
			jsonProduct.accumulate("productId", product.getProductId());
			jsonProduct.accumulate("productName", product.getProductName());
			jsonArray.put(jsonProduct);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询图书信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String productName,String author,String publish,String publishDate,String recommandFlag,String addTime,@ModelAttribute("productClassObj") ProductClass productClassObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (productName == null) productName = "";
		if (author == null) author = "";
		if (publish == null) publish = "";
		if (publishDate == null) publishDate = "";
		if (recommandFlag == null) recommandFlag = "";
		if (addTime == null) addTime = "";
		List<Product> productList = productService.queryProduct(productName, author, publish, publishDate, recommandFlag, addTime, productClassObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    productService.queryTotalPageAndRecordNumber(productName, author, publish, publishDate, recommandFlag, addTime, productClassObj);
	    /*获取到总的页码数目*/
	    int totalPage = productService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = productService.getRecordNumber();
	    request.setAttribute("productList",  productList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("productName", productName);
	    request.setAttribute("author", author);
	    request.setAttribute("publish", publish);
	    request.setAttribute("publishDate", publishDate);
	    request.setAttribute("recommandFlag", recommandFlag);
	    request.setAttribute("addTime", addTime);
	    request.setAttribute("productClassObj", productClassObj);
	    List<ProductClass> productClassList = productClassService.queryAllProductClass();
	    request.setAttribute("productClassList", productClassList);
		return "Product/product_frontquery_result"; 
	}

     /*前台查询Product信息*/
	@RequestMapping(value="/{productId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer productId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键productId获取Product对象*/
        Product product = productService.getProduct(productId);
        ArrayList<ProductComment> commentList = productCommentService.queryProductComment(product, null, "");
        List<ProductClass> productClassList = productClassService.queryAllProductClass();
        request.setAttribute("productClassList", productClassList);
        request.setAttribute("product",  product);
        request.setAttribute("commentList",  commentList);
        return "Product/product_frontshow";
	}

	/*ajax方式显示图书修改jsp视图页*/
	@RequestMapping(value="/{productId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer productId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键productId获取Product对象*/
        Product product = productService.getProduct(productId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonProduct = product.getJsonObject();
		out.println(jsonProduct.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新图书信息*/
	@RequestMapping(value = "/{productId}/update", method = RequestMethod.POST)
	public void update(@Validated Product product, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String productPhotoFileName = this.handlePhotoUpload(request, "productPhotoFile");
		if(!productPhotoFileName.equals("upload/NoImage.jpg"))product.setProductPhoto(productPhotoFileName); 


		String productFileFileName = this.handleFileUpload(request, "productFileFile");
		if(!productFileFileName.equals(""))product.setProductFile(productFileFileName);
		try {
			productService.updateProduct(product);
			message = "图书更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "图书更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除图书信息*/
	@RequestMapping(value="/{productId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer productId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  productService.deleteProduct(productId);
	            request.setAttribute("message", "图书删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "图书删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条图书记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String productIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = productService.deleteProducts(productIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出图书信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String productName,String author,String publish,String publishDate,String recommandFlag,String addTime,@ModelAttribute("productClassObj") ProductClass productClassObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(productName == null) productName = "";
        if(author == null) author = "";
        if(publish == null) publish = "";
        if(publishDate == null) publishDate = "";
        if(recommandFlag == null) recommandFlag = "";
        if(addTime == null) addTime = "";
        List<Product> productList = productService.queryProduct(productName,author,publish,publishDate,recommandFlag,addTime,productClassObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Product信息记录"; 
        String[] headers = { "图书id","图书分类","图书名称","图书图片","作者","出版社","出版日期","页数","字数","ISBN","图书定价","是否推荐","图书评分","添加时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<productList.size();i++) {
        	Product product = productList.get(i); 
        	dataset.add(new String[]{product.getProductId() + "",product.getProductClassObj().getProductName(),product.getProductName(),product.getProductPhoto(),product.getAuthor(),product.getPublish(),product.getPublishDate(),product.getPageNum() + "",product.getWordNum(),product.getIsbn(),product.getProductPrice() + "",product.getRecommandFlag(),product.getProductScore() + "",product.getAddTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Product.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
