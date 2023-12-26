package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.GoodsDao;
import com.example.demo.model.Goods;

@Service
public class GoodsService {
	
	@Autowired
	private GoodsDao GoodsDao;

	public int goods_reg(Goods goods) {
		return GoodsDao.goods_reg(goods);
	}
	
	

}
