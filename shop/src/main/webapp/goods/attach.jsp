<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="input-group">
	<input id="files" type="file" class="form-control" multiple="multiple"/>
	<a id="btn-attach" class="btn btn-primary">파일첨부</a>
</div>
<div id="div_attach" class="card p-3 my-3">첨부할 이미지</div>
<div id="div_attached" class="card p-3 my-3">첨부한 이미지</div>

<!-- 첨부할 파일목록 템플릿 -->
<script id="temp_attach" type="x-handlebars-template">
    <div class="row">
        {{#each .}}
            <div class="col-6 col-md-2"><img src="{{this}}" width="100%"></div>
        {{/each}}
    </div>
</script>
<!-- 첨부한 파일목록 템플릿 -->
<script id="temp_attached" type="x-handlebars-template">
    <div class="row">
        {{#each .}}
            <div class="col-6 col-md-2"><img src="{{image}}" width="100%"></div>
        {{/each}}
    </div>
</script>
<script>
	//이미지들 미리보기
	$("#files").on("change", function(e) {
		let files=[];
        for(let i=0; i<e.target.files.length; i++) {
            const file=URL.createObjectURL(e.target.files[i]);
            files.push(file);
        }
        const temp=Handlebars.compile($("#temp_attach").html());
        const html=temp(files);
        $("#div_attach").html(html);
	});
	
	//폼이 써밋된 경우
	$("#btn-attach").on("click", function(e){
		const files = $("#files")[0].files;
		if(files.length==0) {
			alert("첨부할 파일들을 선택하세요!");
		}else{
			if(confirm("선택한 파일을 업로드하실래요?")){
				const formData = new FormData();
				formData.append("gid", gid);
		        for(var i=0; i<files.length; i++){
		            formData.append("files", files[i]);
		        }
				$.ajax({
		            type:"post",
		            url: "/attach/insert",
		            data: formData,
		            processData:false,
		            contentType:false,
		            success:function(){
		            	alert("첨부파일 업로드가 성공되었습니다.");
		            }
		        });
			}
		}
	});
	
	getAttach();
	function getAttach(){
		$.ajax({
			type:"get",
			url:"/attach/list.json",
			data:{"gid": gid},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_attached").html());
				$("#div_attached").html(temp(data));
			}
		});
	}
</script>