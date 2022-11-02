package com.spring.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.domain.BoardVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	@Autowired
	private BoardService service;
	
	@Test
	public void testPrint() {
		log.info(service);
	}
	
	@Test
	public void testRegister() {
		BoardVO vo = new BoardVO();
		vo.setTitle("Test 테스트");
		vo.setContent("Content 테스트");
		vo.setWriter("tester");
		service.register(vo);
		log.info("testRegister : " + vo.getBno());
	}
	
	@Test
	public void testGet() {
		BoardVO vo = new BoardVO();
		vo.setBno(21L);
		log.info("testGEt : " + service.get(vo.getBno()));
	}
	
	@Test
	public void testModify() {
		BoardVO vo = new BoardVO();
		vo.setBno(22L);
		vo.setTitle("업데이트제목");
		vo.setContent("업데이트내용");
		vo.setWriter("업데이트작성자");
		log.info("testModify : " + service.modify(vo));
	}
	
	@Test
	public void testRemove() {
		BoardVO vo = new BoardVO();
		vo.setBno(24L);
		log.info("testRemove : " + service.remove(vo.getBno()));
	}
	
	@Test
	public void testGetList() {
		log.info("======================");
		service.getList();
	}
}
