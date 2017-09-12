package com.hhgx.soft.utils;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.xmlbeans.impl.piccolo.io.FileFormatException;
import org.springframework.web.multipart.MultipartFile;

import com.hhgx.soft.entitys.Devices;

/**
 * 读取excel数据
 * 
 * @author win
 *
 */

public class ReadExcel {
	
	// 总行数
	private int totalRows = 0;
	// 总条数
	private int totalCells = 0;
	// 错误信息接收器
	private String errorMsg;

	// 构造方法
	public ReadExcel() {
	}

	// 获取总行数
	public int getTotalRows() {
		return totalRows;
	}

	// 获取总列数
	public int getTotalCells() {
		return totalCells;
	}

	// 获取错误信息
	public String getErrorInfo() {
		return errorMsg;
	}

	/**
	 * 读EXCEL文件，获取信息集合
	 * 
	 * @param fielName
	 * @return
	 */
	public List<Devices> getExcelInfo(MultipartFile mFile) {
		String fileName = mFile.getOriginalFilename();// 获取文件名
		List<Devices> devicesList = null;
		try {
			if (!validateExcel(fileName)) {// 验证文件名是否合格
				return null;
			}
			boolean isExcel2003 = true;// 根据文件名判断文件是2003版本还是2007版本
			if (isExcel2007(fileName)) {
				isExcel2003 = false;
			}
			devicesList = readExcel(mFile.getInputStream(), isExcel2003);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return devicesList;
	}
	/** 
	* 查看一个字符串是否可以转换为数字 
	* @param str 字符串 
	* @return true 可以; false 不可以 
	*/  
	public static boolean isStr2Num(String str) { 
		/*try {  
		    Integer.parseInt(str);  
		    return true;  
		} catch (NumberFormatException e) {  
		    return false;  
		}  */
		Pattern pattern = Pattern.compile("^[0-9]*.[0-9]*$");  
		Matcher matcher = pattern.matcher(str);  
		return matcher.matches();  

	}
	/**
	 * 读取excel文件内容
	 * 
	 * @param filePath
	 * @throws FileNotFoundException
	 * @throws FileFormatException
	 */
	public List<Devices> readExcel(InputStream is, boolean isExcel2003)
			throws FileNotFoundException, FileFormatException {
		// 获取workbook对象
		Workbook workbook = null;
		List<Devices> devicesLists = new ArrayList<>();
		try {
			if (isExcel2003) {// 当excel是2003时,创建excel2003
				workbook = new HSSFWorkbook(is);
			} else {// 当excel是2007时,创建excel2007
				workbook = new XSSFWorkbook(is);
			}
			Sheet sheet = workbook.getSheetAt(0);
			System.out.println("=======================" + sheet.getSheetName() + "=========================");
			int firstRowIndex = sheet.getFirstRowNum();
			int lastRowIndex = sheet.getLastRowNum();
			// 读取数据行
			for (int rowIndex = firstRowIndex + 1; rowIndex <= lastRowIndex; rowIndex++) {
				Row currentRow = sheet.getRow(rowIndex);// 当前行
				int firstColumnIndex = currentRow.getFirstCellNum(); // 首列
				//int lastColumnIndex = currentRow.getLastCellNum();// 最后一列
				Devices devices = new Devices();
				String sequence=".0";
				
				String deviceNo = this.getCellValue(currentRow.getCell(firstColumnIndex), false);
				if(isStr2Num(deviceNo) && deviceNo.endsWith(sequence))
					deviceNo=deviceNo.substring(0, deviceNo.lastIndexOf("."));
				
				String gatewayaddress = this.getCellValue(currentRow.getCell(firstColumnIndex + 1), false);
				if(isStr2Num(gatewayaddress) &&gatewayaddress.endsWith(sequence))
				gatewayaddress=gatewayaddress.substring(0, gatewayaddress.lastIndexOf("."));
				
				String sysaddress = this.getCellValue(currentRow.getCell(firstColumnIndex + 2), false);
				if(isStr2Num(sysaddress) && sysaddress.endsWith(sequence))
					sysaddress=sysaddress.substring(0, sysaddress.lastIndexOf("."));
				
				String road = this.getCellValue(currentRow.getCell(firstColumnIndex + 3), false);
				if(isStr2Num(road) && road.endsWith(sequence))
					road=road.substring(0, road.lastIndexOf("."));
				
				String address = this.getCellValue(currentRow.getCell(firstColumnIndex + 4), false);
				if(address.endsWith(sequence))
					address=address.substring(0, address.lastIndexOf("."));

				String iDeviceTypeName = this.getCellValue(currentRow.getCell(firstColumnIndex + 5), false);
				String location = this.getCellValue(currentRow.getCell(firstColumnIndex + 6), false);
				String manufacture = this.getCellValue(currentRow.getCell(firstColumnIndex+7), false);
				String deviceaddress = road + "." + address;
				devices.setDeviceNo(Integer.parseInt(deviceNo));
				devices.setDeviceaddress(deviceaddress);
				devices.setSysaddress(Integer.parseInt(sysaddress));
				devices.setGatewayaddress(gatewayaddress);
				devices.setRoad(road);
				devices.setAddress(address);
				devices.setiDeviceType(iDeviceTypeName);
				devices.setLocation(location);
				devices.setManufacture(manufacture);
				devicesLists.add(devices);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (workbook != null) {
				try {
					workbook.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return devicesLists;
	}

	
	/**
	 * 取单元格的值
	 * 
	 * @param cell
	 *            单元格对象
	 * @param treatAsStr
	 *          为true时，当做文本来取值 (取到的是文本，不会把“1”取成“1.0”)
	 *          CELL_TYPE_NUMERIC 数值型 0
				CELL_TYPE_STRING 字符串型 1
				CELL_TYPE_FORMULA 公式型 2
				CELL_TYPE_BLANK 空值 3
				CELL_TYPE_BOOLEAN 布尔型 4
				CELL_TYPE_ERROR 错误 5
	 * @return
	 */
	@SuppressWarnings("deprecation")
	private String getCellValue(Cell cell, boolean treatAsStr) {
		if (cell == null) {
			return "";
		}
		if (treatAsStr) {
			cell.setCellType(Cell.CELL_TYPE_STRING);
		}
		if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
			return String.valueOf(cell.getBooleanCellValue());
		} else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
			return String.valueOf(cell.getNumericCellValue());
		} else {
			//return result.substring(0, result.lastIndexOf("."));
			return String.valueOf(cell.getStringCellValue());
		}
	}


	/**
	 * 验证EXCEL文件
	 * 
	 * @param filePath
	 * @return
	 */
	public boolean validateExcel(String filePath) {
		if (filePath == null || !(isExcel2003(filePath) || isExcel2007(filePath))) {
			errorMsg = "文件名不是excel格式";
			return false;
		}
		return true;
	}

	// @描述：是否是2003的excel，返回true是2003
	public static boolean isExcel2003(String filePath) {
		return filePath.matches("^.+\\.(?i)(xls)$");
	}

	// @描述：是否是2007的excel，返回true是2007
	public static boolean isExcel2007(String filePath) {
		return filePath.matches("^.+\\.(?i)(xlsx)$");
	}
}