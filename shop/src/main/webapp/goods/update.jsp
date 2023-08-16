<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
<script>
	const gid="${vo.gid}";
</script>
<div class="row my-5 justify-content-center">
	<div class="col-md-10 col-lg-8">
		<h1 class="text-center mb-5">상품정보수정</h1>
		<form name="frm" class="card p-3" method="post" enctype="multipart/form-data">
			<div class="input-group mb-3">
				<span class="input-group-text">상품코드</span>
				<input name="gid" class="form-control" value="${vo.gid}" readonly>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">상품이름</span>
				<input name="title" class="form-control" value="${vo.title}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">상품가격</span>
				<input name="price" class="form-control" oninput="isNumber(this)" value="${vo.price}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">제&nbsp;조&nbsp;사&nbsp;</span>
				<input name="maker" class="form-control" value="${vo.maker}">
			</div>
			<div class="my-3">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
				  <li class="nav-item" role="presentation">
				    <button class="nav-link active" id="image-tab" data-bs-toggle="tab" data-bs-target="#image-tab-pane" type="button" role="tab" aria-controls="image-tab-pane" aria-selected="true">
				    	대표이미지
				    </button>
				  </li>
				  <li class="nav-item" role="presentation">
				    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#detail-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">
				    	상세설명
				    </button>
				  </li>
				  <li class="nav-item" role="presentation">
				    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#attach-tab-pane" type="button" role="tab" aria-controls="contact-tab-pane" aria-selected="false">
				    	첨부이미지
				    </button>
				  </li>
				</ul>
				<div class="tab-content pt-3" id="myTabContent">
					<!-- 대표이밎 -->
					<div class="tab-pane fade show active" id="image-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">
						<div class="input-group mb-3">
							<input name="image" type="file" class="form-control" accept="image/*">
							<input name="oldImage" value="${vo.image}" type="hidden">
						</div>
						<div>
							<img src="${vo.image}" width="30%" id="image">
						</div>
					</div>	
					<!-- 상세설명 -->
					<div class="tab-pane fade" id="detail-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
						<textarea id="editor" name="content" rows=15 class="form-control">${vo.content}</textarea>
					</div>
					<!-- 첨부이미지 -->
					<div class="tab-pane fade" id="attach-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">
						<jsp:include page="attach.jsp"/>
					</div>
				</div>
			</div>
			<hr>
			<div class="text-center my-3">
				<input type="submit" value="상품수정" class="btn btn-primary">
				<input type="reset" value="수정취소" class="btn btn-secondary">
			</div>
		</form>
	</div>
</div>
<script>
	const oldImage="${vo.image}";
	//const gid="${vo.gid}";
	
	const ckeditor_config = {
	        resize_enable : false,  //editor 사이즈를 변경하지 못한다.
	        enterMode : CKEDITOR.ENTER_BR,
	        shiftEnterMode : CKEDITOR.ENTER_P,
	        filebrowserUploadUrl : "/goods/ckupload?gid=" + gid,
	        height: 300
	    };
	CKEDITOR.replace('editor', ckeditor_config)
	    
	$(frm).on("submit", function(e){
		e.preventDefault();
		const title=$(frm.title).val();
		const price=$(frm.price).val();
		if(title=="" || price=="") {
			alert("상품이름,상품가격를 입력하세요!");
			$(frm.title).focus();
		}else{
			if(confirm("상품정보를 수정하실래요?")){
				//수정하기
				frm.submit();
			}
		}
	});
	
	function isNumber(item){
		item.value = item.value.replace(/[^0-9]/g, '');
	}
	
	//이미지미리보기
	$(frm.image).on("change", function(e){
		$("#image").attr("src", URL.createObjectURL(e.target.files[0]));
	});
	
	//리셋인 경우
	$(frm).on("reset", function(){
		$("#image").attr("src", oldImage);
	})
</script>
