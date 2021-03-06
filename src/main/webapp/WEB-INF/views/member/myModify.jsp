<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>


<script>
	$(document).ready(function() {
		$("#pwPattern").hide();
		
	/* 주소 값을 합쳐서 name으로 보내기 */
        function setLocInput() {
        	var loc = $("#sample3_postcode").val() + "|" + $("#sample3_address").val() + " " +
        	$("#sample3_detailAddress").val() + $("#sample3_extraAddress").val();
        	$("#loc-input").val(loc);
        }
  
        $("#sample3_postcode").change(setLocInput);
        $("#sample3_address").change(setLocInput);
        $("#sample3_detailAddress").keyup(setLocInput);
        $("#sample3_extraAddress").change(setLocInput);
       
        
		//<!-- 이메일 주소 선택  -->
    	// ##이메일 셀렉트 선택
        $('#select').change(function() {
            if ($('#select').val() == 'directly') {
                $('#emailSelect').attr("disabled", false);
                $('#emailSelect').val("");
                $('#emailSelect').focus();
            } else {
                $('#emailSelect').val($('#select').val());
            }
        });
        
        /* 이메일 값을 합쳐서 name으로 보내기 */
        function setEmailInput() {
        	var email = $("#emailFront").val() + "@" + $("#emailSelect").val();  
        	$("#email-input").val(email);
        }
        
        $("#select").change(setEmailInput);
        $("#emailFront").keyup(setEmailInput);
        $("#emailSelect").keyup(setEmailInput);    
        
        /* 비밀번호 값을 수정하면 pattern 멘트 */
        function showPwPattern() {
        	$("#pwPattern").show();
        }
        
        $("#staticPw").keyup(showPwPattern); 
        
        function errors() {
        	if($("#errors").val() == "errors") {
        		$("#modifySubmit").attr('disabled', true);
        	}
        }
        
    });
</script>

<title>Insert title here</title>
</head>
<body>

<m:topNav />

<form method="post" action="${root }/member/myModify" >
  <div class="form-group row">
    <label for="staticId" class="col-sm-2 col-form-label">아이디</label>
    <div class="col-sm-10">
      <input type="text" readonly name="id" class="form-control-plaintext" id="staticId" value="${sessionScope.authUser.id }">
    </div>
  </div>
  <div class="form-group row">
    <label for="staticPw" class="col-sm-2 col-form-label">비밀번호</label>
    <div class="col-sm-10">
      <input type="password" name="password" class="form-control-plaintext" id="staticPw" pattern="([a-zA-Z]+\d{1}\w*)|(\d+[a-zA-Z]{1}\w*)" value="${sessionScope.authUser.password }">
      <small class="form-text" style="color: gray" id="pwPattern">
      	영문 대소문자, 숫자를 조합하여 입력하세요. (2글자 이상)
      </small>
    </div>
  </div>
  <div class="form-group row">
    <label for="staticName" class="col-sm-2 col-form-label">이름</label>
    <div class="col-sm-10">
      <input type="text" readonly name="name" class="form-control-plaintext" id="staticName" value="${sessionScope.authUser.name }">
    </div>
  </div>
  <div class="form-group row">
    <label for="staticNickname" class="col-sm-2 col-form-label">닉네임</label>
    <div class="col-sm-10">
      <input type="text" name="nickname" class="form-control-plaintext" id="staticNickname" value="${sessionScope.authUser.nickname }">
    </div>
  </div>
  <div class="form-group row">
    <label for="staticEmail" class="col-sm-2 col-form-label">이메일</label>
    <div class="col-sm-10" id="staticEmail">
   		<input type="text" id="emailFront" value="${emailDTO.emailFront }" placeholder="이메일 입력" > 
 		<span>@</span>
		 <input id="emailSelect" value="${emailDTO.emailSelect }" placeholder="이메일을 선택하세요."> 
 		<select id="select">
         	   <option value="" disabled selected>E-Mail 선택</option>
	            <option value="naver.com" id="naver.com">naver.com</option>
	            <option value="hanmail.net" id="hanmail.net">hanmail.net</option>
	            <option value="gmail.com" id="gmail.com">gmail.com</option>
	            <option value="nate.com" id="nate.com">nate.com</option>
	            <option value="directly" id="textEmail">직접 입력하기</option>
	        </select>
	    <input type="hidden" name="email" id="email-input" />
   <%--    <input type="text" name="email" class="form-control-plaintext" id="staticEmail" value="${sessionScope.authUser.email }"> --%>
    </div>
  </div>
  
  
  <div class="form-group row">
    <label for="staticLoc" class="col-sm-2 col-form-label">주소</label>
    <div class="col-sm-10">
      <input type="text" name="loc" class="form-control-plaintext" id="staticLoc" value="${authUser.loc }">
	//주소는 어떻게 나눠서 꺼내야하나,,,,,,,,,,,,,,,,,,
	<!-- //주소 api input 태그	 -->	 
	<br> 
	<input type="text" id="sample3_postcode" placeholder="우편번호">
	<input type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" id="sample3_address" placeholder="주소"><br>
	<input type="text" id="sample3_detailAddress" placeholder="상세주소" value="">
	<input type="text" id="sample3_extraAddress" placeholder="참고항목">
    <c:if test="${errors.memberLoc }">
    	<small class="form-text" style="color: tomato">
     		주소를 입력해주세요.
     	</small>
    </c:if>
    <div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
	</div>
    </div>
  </div>
  
	<c:if test="${errors }">
		<input type="hidden" value="errors" id="errors" >
	</c:if>
	<button type="submit" class="btn btn-primary" id="modifySubmit" >수정</button>

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	//우편번호 찾기 찾기 화면을 넣을 element
	var element_wrap = document.getElementById('wrap');
	
	function foldDaumPostcode() {
	    // iframe을 넣은 element를 안보이게 한다.
	    element_wrap.style.display = 'none';
	}
	
	function sample3_execDaumPostcode() {
	    // 현재 scroll 위치를 저장해놓는다.
	    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("sample3_extraAddress").value = extraAddr;
	            
	            } else {
	                document.getElementById("sample3_extraAddress").value = '';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample3_postcode').value = data.zonecode;
	            document.getElementById("sample3_address").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("sample3_detailAddress").focus();
	
	            // iframe을 넣은 element를 안보이게 한다.
	            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
	            element_wrap.style.display = 'none';
	
	            // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
	            document.body.scrollTop = currentScroll;
	        },
	        // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
	        onresize : function(size) {
	            element_wrap.style.height = size.height+'px';
	        },
	        width : '100%',
	        height : '100%'
	    }).embed(element_wrap);
	
	    // iframe을 넣은 element를 보이게 한다.
	    element_wrap.style.display = 'block';
	}
	</script>
		
</form>

</body>
</html>