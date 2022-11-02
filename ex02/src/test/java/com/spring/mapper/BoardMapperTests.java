package com.spring.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Autowired
	private BoardMapper mapper;
	
	@Test
	public void testGetBoard() {
		log.info("-------------------");
		mapper.getList();
	}
	
	@Test
	public void testPaging() {
		log.info("-------------------");
		mapper.getListWithPaging(new Criteria(1, 10));
	}
	
	@Test
	public void testSearch() {
		log.info("-------------------");
		Criteria cri = new Criteria();
		cri.setKeyword("ㅇㅅ");
		cri.setType("WTC");
		mapper.getListWithPaging(cri);
	}
	
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새글");
		board.setContent("새내용");
		board.setWriter("newbie");
		mapper.insert(board);
		log.info("after insert: " + board.getBno());
	}
	
	@Test
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("새글");
		board.setContent("새내용");
		board.setWriter("newbie");
		mapper.insertSelectKey(board);
		log.info("after InsertSelectKey: " + board.getBno());
	}
	
	@Test
	public void testRead() {
		BoardVO board = mapper.read(21L);
		log.info(board);
	}
	
	@Test
	public void testDelete() {
		int count = mapper.delete(1L);
		log.info("=============" + count);
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setBno(21L);
		board.setTitle("updated title");
		board.setContent("updated content");
		board.setWriter("user02");
		log.info("testUpdate = " + mapper.update(board));
	}
}
