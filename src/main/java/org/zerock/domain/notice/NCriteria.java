package org.zerock.domain.notice;

import lombok.Data;

@Data// setter가 필요함!!!!!
public class NCriteria {
	private int curPage;
	private int amount;
	
	private String keyword;
	
	public NCriteria() {
		this(1, 10);
	}
	
	public NCriteria(int curPage, int amount) {
		this.curPage = curPage;
		this.amount = amount;
	}
}
